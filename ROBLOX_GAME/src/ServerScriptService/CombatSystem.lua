--[[
    Egg Empire - Combat System
    Gerencia combate, habilidades e power-ups
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- ============================================
-- CONFIGURAÇÃO
-- ============================================
local COMBAT_CONFIG = {
    -- Habilidades Base
    BaseAttack = {
        Damage = 10,
        Cooldown = 0.5,
        Range = 10,
        Type = "Melee"
    },
    
    Dash = {
        Distance = 30,
        Cooldown = 3,
        Speed = 100
    },
    
    -- Habilidades Desbloqueáveis
    Shield = {
        Cost = 50,
        DamageReduction = 0.5,
        Duration = 10,
        Cooldown = 15
    },
    
    Bomb = {
        Cost = 100,
        Damage = 30,
        Radius = 20,
        Cooldown = 20
    },
    
    Stealth = {
        Cost = 200,
        Duration = 15,
        Cooldown = 30
    },
    
    -- Power-ups
    PowerUps = {
        SpeedBoost = {
            Duration = 10,
            Multiplier = 1.5
        },
        DamageBoost = {
            Duration = 10,
            Multiplier = 2.0
        },
        ShieldBoost = {
            Duration = 5,
            Immune = true
        },
        Radar = {
            Duration = 15,
            Range = 500
        }
    }
}

-- ============================================
-- MÓDULO CombatSystem
-- ============================================
local CombatSystem = {}
CombatSystem.__index = CombatSystem

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function CombatSystem.new(dataStoreManager, currencyManager)
    local self = setmetatable({}, CombatSystem)
    
    self.dataStoreManager = dataStoreManager
    self.currencyManager = currencyManager
    
    -- Estado dos jogadores
    self.playerStates = {}
    
    -- Cooldowns
    self.cooldowns = {}
    
    -- Conectar eventos
    self:ConnectEvents()
    
    print("[CombatSystem] Inicializado com sucesso!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function CombatSystem:ConnectEvents()
    Players.PlayerAdded:Connect(function(player)
        self:InitPlayerState(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:ClearPlayerState(player)
    end)
    
    -- Conectar RemoteEvents
    self:ConnectRemoteEvents()
end

-- ============================================
-- INICIALIZAR ESTADO
-- ============================================
function CombatSystem:InitPlayerState(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    
    self.playerStates[player.UserId] = {
        Health = 100,
        MaxHealth = 100,
        IsAlive = true,
        IsStealthed = false,
        IsShielded = false,
        ActivePowerUps = {},
        KillStreak = 0,
        LastAttacker = nil,
        RespawnTime = 0
    }
    
    self.cooldowns[player.UserId] = {}
    
    -- CriarCharacter se não existir
    if not player.Character then
        player:LoadCharacter()
    end
    
    -- Conectar evento de dano
    self:ConnectDamageEvents(player)
    
    print("[CombatSystem] Estado inicializado para " .. player.Name)
end

-- ============================================
-- CONectar EVENTOS DE DANO
-- ============================================
function CombatSystem:ConnectDamageEvents(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.HealthChanged:Connect(function(newHealth)
            local oldHealth = humanoid.MaxHealth
            local damage = oldHealth - newHealth
            
            if damage > 0 then
                self:OnPlayerDamaged(player, damage)
            end
        end)
        
        humanoid.Died:Connect(function()
            self:OnPlayerDied(player)
        end)
    end)
end

-- ============================================
-- ATACAR
-- ============================================
function CombatSystem:Attack(attacker, target)
    -- Verificar cooldown
    if self:IsOnCooldown(attacker, "Attack") then
        return false
    end
    
    -- Verificar distância
    local attackerChar = attacker.Character
    local targetChar = target.Character
    
    if not attackerChar or not targetChar then
        return false
    end
    
    local attackerRoot = attackerChar:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    
    if not attackerRoot or not targetRoot then
        return false
    end
    
    local distance = (attackerRoot.Position - targetRoot.Position).Magnitude
    if distance > COMBAT_CONFIG.BaseAttack.Range then
        return false
    end
    
    -- Calcular dano
    local damage = COMBAT_CONFIG.BaseAttack.Damage
    
    -- Aplicar bônus de power-up
    if self:HasPowerUp(attacker, "DamageBoost") then
        damage = damage * COMBAT_CONFIG.PowerUps.DamageBoost.Multiplier
    end
    
    -- Aplicar bônus de nível
    local data = self.dataStoreManager:GetPlayerData(attacker)
    if data then
        damage = damage + math.floor(data.Level * 0.5)
    end
    
    -- Aplicar dano
    self:DealDamage(attacker, target, damage)
    
    -- Definir cooldown
    self:SetCooldown(attacker, "Attack", COMBAT_CONFIG.BaseAttack.Cooldown)
    
    -- Notificar
    self:NotifyAttack(attacker, target, damage)
    
    return true
end

-- ============================================
-- DASH
-- ============================================
function CombatSystem:Dash(player)
    -- Verificar cooldown
    if self:IsOnCooldown(player, "Dash") then
        return false
    end
    
    local character = player.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    -- Calcular direção
    local direction = humanoidRootPart.CFrame.LookVector
    local targetPosition = humanoidRootPart.Position + direction * COMBAT_CONFIG.Dash.Distance
    
    -- Criar efeito visual
    self:CreateDashEffect(player)
    
    -- Mover jogador
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = direction * COMBAT_CONFIG.Dash.Speed
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = humanoidRootPart
    
    Debris:AddItem(bodyVelocity, 0.2)
    
    -- Definir cooldown
    self:SetCooldown(player, "Dash", COMBAT_CONFIG.Dash.Cooldown)
    
    return true
end

-- ============================================
-- ESCUDO
-- ============================================
function CombatSystem:ActivateShield(player)
    -- Verificar cooldown
    if self:IsOnCooldown(player, "Shield") then
        return false
    end
    
    -- Verificar se já tem escudo
    if self.playerStates[player.UserId].IsShielded then
        return false
    end
    
    -- Ativar escudo
    self.playerStates[player.UserId].IsShielded = true
    
    -- Criar efeito visual
    self:CreateShieldEffect(player)
    
    -- Definir duração
    spawn(function()
        wait(COMBAT_CONFIG.Shield.Duration)
        self:DeactivateShield(player)
    end)
    
    -- Definir cooldown
    self:SetCooldown(player, "Shield", COMBAT_CONFIG.Shield.Cooldown)
    
    return true
end

function CombatSystem:DeactivateShield(player)
    if self.playerStates[player.UserId] then
        self.playerStates[player.UserId].IsShielded = false
        self:RemoveShieldEffect(player)
    end
end

-- ============================================
-- BOMBA
-- ============================================
function CombatSystem:ThrowBomb(player)
    -- Verificar cooldown
    if self:IsOnCooldown(player, "Bomb") then
        return false
    end
    
    local character = player.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    -- Criar bomba
    local bomb = self:CreateBomb(player)
    bomb.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -5)
    
    -- Explodir após 2 segundos
    spawn(function()
        wait(2)
        self:ExplodeBomb(player, bomb)
    end)
    
    -- Definir cooldown
    self:SetCooldown(player, "Bomb", COMBAT_CONFIG.Bomb.Cooldown)
    
    return true
end

function CombatSystem:ExplodeBomb(player, bomb)
    local position = bomb.Position
    local radius = COMBAT_CONFIG.Bomb.Radius
    local damage = COMBAT_CONFIG.Bomb.Damage
    
    -- Criar efeito de explosão
    self:CreateExplosionEffect(position)
    
    -- Aplicar dano em área
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherChar = otherPlayer.Character
            if otherChar then
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local distance = (position - otherRoot.Position).Magnitude
                    if distance <= radius then
                        local damageMultiplier = 1 - (distance / radius)
                        self:DealDamage(player, otherPlayer, damage * damageMultiplier)
                    end
                end
            end
        end
    end
    
    -- Destruir bomba
    bomb:Destroy()
end

-- ============================================
-- STEALTH
-- ============================================
function CombatSystem:ActivateStealth(player)
    -- Verificar cooldown
    if self:IsOnCooldown(player, "Stealth") then
        return false
    end
    
    -- Verificar se já está invisível
    if self.playerStates[player.UserId].IsStealthed then
        return false
    end
    
    -- Ativar stealth
    self.playerStates[player.UserId].IsStealthed = true
    
    -- Tornar jogador invisível
    self:MakeInvisible(player, true)
    
    -- Criar efeito visual
    self:CreateStealthEffect(player)
    
    -- Definir duração
    spawn(function()
        wait(COMBAT_CONFIG.Stealth.Duration)
        self:DeactivateStealth(player)
    end)
    
    -- Definir cooldown
    self:SetCooldown(player, "Stealth", COMBAT_CONFIG.Stealth.Cooldown)
    
    return true
end

function CombatSystem:DeactivateStealth(player)
    if self.playerStates[player.UserId] then
        self.playerStates[player.UserId].IsStealthed = false
        self:MakeInvisible(player, false)
        self:RemoveStealthEffect(player)
    end
end

-- ============================================
-- POWER-UPS
-- ============================================
function CombatSystem:ActivatePowerUp(player, powerUpType)
    local config = COMBAT_CONFIG.PowerUps[powerUpType]
    if not config then return false end
    
    -- Verificar se já tem o power-up
    if self:HasPowerUp(player, powerUpType) then
        return false
    end
    
    -- Ativar power-up
    self.playerStates[player.UserId].ActivePowerUps[powerUpType] = {
        StartTime = tick(),
        Duration = config.Duration
    }
    
    -- Aplicar efeito
    self:ApplyPowerUpEffect(player, powerUpType, true)
    
    -- Definir duração
    spawn(function()
        wait(config.Duration)
        self:DeactivatePowerUp(player, powerUpType)
    end)
    
    -- Notificar
    self:NotifyPowerUpActivated(player, powerUpType)
    
    return true
end

function CombatSystem:DeactivatePowerUp(player, powerUpType)
    if self.playerStates[player.UserId] then
        self.playerStates[player.UserId].ActivePowerUps[powerUpType] = nil
        self:ApplyPowerUpEffect(player, powerUpType, false)
        self:NotifyPowerUpDeactivated(player, powerUpType)
    end
end

function CombatSystem:HasPowerUp(player, powerUpType)
    return self.playerStates[player.UserId] and 
           self.playerStates[player.UserId].ActivePowerUps[powerUpType] ~= nil
end

function CombatSystem:ApplyPowerUpEffect(player, powerUpType, activate)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if powerUpType == "SpeedBoost" then
        if activate then
            humanoid.WalkSpeed = humanoid.WalkSpeed * COMBAT_CONFIG.PowerUps.SpeedBoost.Multiplier
        else
            humanoid.WalkSpeed = humanoid.WalkSpeed / COMBAT_CONFIG.PowerUps.SpeedBoost.Multiplier
        end
        
    elseif powerUpType == "DamageBoost" then
        -- Implementar no sistema de combate
        
    elseif powerUpType == "ShieldBoost" then
        self.playerStates[player.UserId].IsShielded = activate
        
    elseif powerUpType == "Radar" then
        -- Implementar no minimapa
    end
end

-- ============================================
-- SISTEMA DE DANO
-- ============================================
function CombatSystem:DealDamage(attacker, target, damage)
    local targetState = self.playerStates[target.UserId]
    if not targetState or not targetState.IsAlive then
        return false
    end
    
    -- Verificar escudo
    if targetState.IsShielded then
        damage = damage * (1 - COMBAT_CONFIG.Shield.DamageReduction)
    end
    
    -- Aplicar dano
    local character = target.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:TakeDamage(damage)
            
            -- Registrar atacante
            targetState.LastAttacker = attacker
            
            -- Notificar
            self:NotifyDamageDealt(attacker, target, damage)
            
            return true
        end
    end
    
    return false
end

-- ============================================
-- MORTE
-- ============================================
function CombatSystem:OnPlayerDied(player)
    local state = self.playerStates[player.UserId]
    if not state then return end
    
    state.IsAlive = false
    state.KillStreak = 0
    
    -- Dar kill ao atacante
    if state.LastAttacker then
        self:OnPlayerKill(state.LastAttacker, player)
    end
    
    -- Perder ovos
    self:DropEggs(player)
    
    -- Respawn após delay
    spawn(function()
        wait(5)
        self:RespawnPlayer(player)
    end)
end

function CombatSystem:OnPlayerKill(killer, victim)
    -- Atualizar.kill streak
    local killerState = self.playerStates[killer.UserId]
    if killerState then
        killerState.KillStreak = killerState.KillStreak + 1
    end
    
    -- Dar XP
    self.dataStoreManager:AddXP(killer, 50)
    
    -- Dar moedas baseado no streak
    local bonus = math.min(killerState.KillStreak, 5) * 10
    self.currencyManager:AddCoins(killer, 100 + bonus, "Kill")
    
    -- Notificar
    self:NotifyKill(killer, victim)
end

function CombatSystem:OnPlayerDamaged(player, damage)
    -- Efeito visual de dano
    self:CreateDamageEffect(player, damage)
end

-- ============================================
-- RESPAWN
-- ============================================
function CombatSystem:RespawnPlayer(player)
    player:LoadCharacter()
    
    -- Resetar estado
    local state = self.playerStates[player.UserId]
    if state then
        state.IsAlive = true
        state.Health = state.MaxHealth
        state.IsStealthed = false
        state.IsShielded = false
        state.ActivePowerUps = {}
        state.LastAttacker = nil
    end
    
    -- Invulnerabilidade temporária
    spawn(function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = state.MaxHealth
                humanoid.Health = state.MaxHealth
            end
        end
        
        wait(3) -- 3 segundos de invulnerabilidade
    end)
end

-- ============================================
-- PERDER OVOS
-- ============================================
function CombatSystem:DropEggs(player)
    local eggs = self.currencyManager:GetEggs(player)
    local totalDropped = 0
    
    for eggType, count in pairs(eggs) do
        if count > 0 then
            local toDrop = math.ceil(count * 0.5) -- Perde 50%
            self.currencyManager:RemoveEgg(player, eggType, toDrop)
            totalDropped = totalDropped + toDrop
            
            -- Criar ovos no mundo
            self:CreateDroppedEggs(player, eggType, toDrop)
        end
    end
    
    if totalDropped > 0 then
        self:NotifyEggsDropped(player, totalDropped)
    end
end

function CombatSystem:CreateDroppedEggs(player, eggType, amount)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Criar ovos físicos
    for i = 1, math.min(amount, 10) do
        local egg = Instance.new("Part")
        egg.Name = "DroppedEgg_" .. eggType
        egg.Shape = Enum.PartType.Ball
        egg.Size = Vector3.new(2, 2, 2)
        egg.Position = humanoidRootPart.Position + Vector3.new(
            math.random(-5, 5),
            2,
            math.random(-5, 5)
        )
        egg.Anchored = false
        egg.CanCollide = true
        egg.Parent = workspace
        
        -- Adicionar brilho
        local sparkle = Instance.new("Sparkles")
        sparkle.Parent = egg
        
        -- Adicionar valor
        local eggValue = Instance.new("IntValue")
        eggValue.Name = "EggValue"
        eggValue.Value = 1
        eggValue.Parent = egg
        
        local eggTypeValue = Instance.new("StringValue")
        eggTypeValue.Name = "EggType"
        eggTypeValue.Value = eggType
        eggTypeValue.Parent = egg
        
        -- Destruir após 30 segundos
        Debris:AddItem(egg, 30)
        
        -- Conectar coleta
        egg.Touched:Connect(function(hit)
            local hitPlayer = Players:GetPlayerFromCharacter(hit.Parent)
            if hitPlayer and hitPlayer ~= player then
                -- Coletar ovo
                self.currencyManager:AddEgg(hitPlayer, eggType, 1)
                egg:Destroy()
            end
        end)
    end
end

-- ============================================
-- COOLDOWNS
-- ============================================
function CombatSystem:SetCooldown(player, abilityName, duration)
    self.cooldowns[player.UserId][abilityName] = tick() + duration
end

function CombatSystem:IsOnCooldown(player, abilityName)
    local cooldowns = self.cooldowns[player.UserId]
    if cooldowns and cooldowns[abilityName] then
        return tick() < cooldowns[abilityName]
    end
    return false
end

function CombatSystem:GetCooldownRemaining(player, abilityName)
    local cooldowns = self.cooldowns[player.UserId]
    if cooldowns and cooldowns[abilityName] then
        local remaining = cooldowns[abilityName] - tick()
        return math.max(0, remaining)
    end
    return 0
end

-- ============================================
-- EFEITOS VISUAIS
-- ============================================
function CombatSystem:CreateDashEffect(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Criar trail
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = humanoidRootPart
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = humanoidRootPart
    
    local trail = Instance.new("Trail")
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Color = ColorSequence.new(Color3.fromRGB(0, 200, 255))
    trail.Lifetime = 0.5
    trail.Parent = humanoidRootPart
    
    Debris:AddItem(trail, 0.5)
end

function CombatSystem:CreateShieldEffect(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Criar escudo visual
    local shield = Instance.new("Part")
    shield.Name = "ShieldEffect"
    shield.Shape = Enum.PartType.Ball
    shield.Size = Vector3.new(8, 8, 8)
    shield.Position = humanoidRootPart.Position
    shield.Anchored = true
    shield.CanCollide = false
    shield.Transparency = 0.5
    shield.BrickColor = BrickColor.new("Bright blue")
    shield.Parent = character
    
    -- Adicionar billboard gui
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(4, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = shield
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "ESCUDO ATIVO"
    label.TextColor3 = Color3.fromRGB(0, 200, 255)
    label.TextScaled = true
    label.Parent = billboard
end

function CombatSystem:RemoveShieldEffect(player)
    local character = player.Character
    if character then
        local shield = character:FindFirstChild("ShieldEffect")
        if shield then
            shield:Destroy()
        end
    end
end

function CombatSystem:CreateStealthEffect(player)
    -- Implementar efeito de invisibilidade
end

function CombatSystem:RemoveStealthEffect(player)
    -- Remover efeito de invisibilidade
end

function CombatSystem:MakeInvisible(player, invisible)
    local character = player.Character
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if invisible then
                part.Transparency = 1
            else
                if part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                end
            end
        elseif part:IsA("Decal") then
            part.Transparency = invisible and 1 or 0
        end
    end
end

function CombatSystem:CreateExplosionEffect(position)
    -- Criar efeito visual de explosão
    local explosion = Instance.new("Part")
    explosion.Name = "Explosion"
    explosion.Shape = Enum.PartType.Ball
    explosion.Size = Vector3.new(1, 1, 1)
    explosion.Position = position
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Material = Enum.Material.Neon
    explosion.BrickColor = BrickColor.new("Bright orange")
    explosion.Parent = workspace
    
    -- Animar expansão
    spawn(function()
        for i = 1, 20 do
            explosion.Size = Vector3.new(i * 2, i * 2, i * 2)
            explosion.Transparency = i / 20
            wait(0.05)
        end
        explosion:Destroy()
    end)
end

function CombatSystem:CreateDamageEffect(player, damage)
    -- Criar número de dano flutuante
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(2, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(math.random(-2, 2), 3, 0)
    billboard.Parent = humanoidRootPart
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "-" .. math.floor(damage)
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextScaled = true
    label.Parent = billboard
    
    Debris:AddItem(billboard, 1)
end

function CombatSystem:CreateBomb(player)
    local bomb = Instance.new("Part")
    bomb.Name = "Bomb"
    bomb.Shape = Enum.PartType.Ball
    bomb.Size = Vector3.new(2, 2, 2)
    bomb.BrickColor = BrickColor.new("Really red")
    bomb.Material = Enum.Material.Metal
    bomb.Parent = workspace
    
    return bomb
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function CombatSystem:NotifyAttack(attacker, target, damage)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local attackEvent = event:FindFirstChild("PlayerAttacked")
        if attackEvent then
            attackEvent:FireAllClients({
                Attacker = attacker.Name,
                Target = target.Name,
                Damage = damage
            })
        end
    end
end

function CombatSystem:NotifyDamageDealt(attacker, target, damage)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local damageEvent = event:FindFirstChild("DamageDealt")
        if damageEvent then
            damageEvent:FireClient(target, {
                Attacker = attacker.Name,
                Damage = damage
            })
        end
    end
end

function CombatSystem:NotifyKill(killer, victim)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local killEvent = event:FindFirstChild("PlayerKilled")
        if killEvent then
            killEvent:FireAllClients({
                Killer = killer.Name,
                Victim = victim.Name
            })
        end
    end
end

function CombatSystem:NotifyEggsDropped(player, amount)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local dropEvent = event:FindFirstChild("EggsDropped")
        if dropEvent then
            dropEvent:FireClient(player, {
                Amount = amount
            })
        end
    end
end

function CombatSystem:NotifyPowerUpActivated(player, powerUpType)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local powerUpEvent = event:FindFirstChild("PowerUpActivated")
        if powerUpEvent then
            powerUpEvent:FireClient(player, {
                Type = powerUpType
            })
        end
    end
end

function CombatSystem:NotifyPowerUpDeactivated(player, powerUpType)
    local event = ReplicatedStorage:FindFirstChild("CombatEvents")
    if event then
        local powerUpEvent = event:FindFirstChild("PowerUpDeactivated")
        if powerUpEvent then
            powerUpEvent:FireClient(player, {
                Type = powerUpType
            })
        end
    end
end

-- ============================================
-- REMOTE EVENTS
-- ============================================
function CombatSystem:ConnectRemoteEvents()
    -- Criar pasta de eventos
    local eventFolder = Instance.new("Folder")
    eventFolder.Name = "CombatEvents"
    eventFolder.Parent = ReplicatedStorage
    
    -- Eventos
    local events = {
        "PlayerAttacked",
        "DamageDealt",
        "PlayerKilled",
        "EggsDropped",
        "PowerUpActivated",
        "PowerUpDeactivated"
    }
    
    for _, eventName in pairs(events) do
        local event = Instance.new("RemoteEvent")
        event.Name = eventName
        event.Parent = eventFolder
    end
    
    -- RemoteFunction para ações
    local combatFunction = Instance.new("RemoteFunction")
    combatFunction.Name = "CombatAction"
    combatFunction.Parent = eventFolder
    
    combatFunction.OnServerInvoke = function(player, action, ...)
        if action == "Attack" then
            local target = ...
            return self:Attack(player, target)
        elseif action == "Dash" then
            return self:Dash(player)
        elseif action == "Shield" then
            return self:ActivateShield(player)
        elseif action == "Bomb" then
            return self:ThrowBomb(player)
        elseif action == "Stealth" then
            return self:ActivateStealth(player)
        elseif action == "PowerUp" then
            local powerUpType = ...
            return self:ActivatePowerUp(player, powerUpType)
        end
        return false
    end
end

-- ============================================
-- LIMPAR ESTADO
-- ============================================
function CombatSystem:ClearPlayerState(player)
    self.playerStates[player.UserId] = nil
    self.cooldowns[player.UserId] = nil
end

-- ============================================
-- OBTER ESTADO
-- ============================================
function CombatSystem:GetPlayerState(player)
    return self.playerStates[player.UserId]
end

function CombatSystem:IsAlive(player)
    local state = self.playerStates[player.UserId]
    return state and state.IsAlive
end

-- ============================================
-- INICIALIZAR
-- ============================================
function CombatSystem:Initialize()
    self:ConnectRemoteEvents()
end

return CombatSystem
