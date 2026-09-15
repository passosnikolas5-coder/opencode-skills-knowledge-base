--[[
    Egg Empire - Base Building System
    Gerencia construção e defesa de bases
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- ============================================
-- CONFIGURAÇÃO
-- ============================================
local BASE_CONFIG = {
    -- Níveis da Base
    Levels = {
        [1] = {
            Name = "Cabana",
            Cost = 0,
            MaxPieces = 5,
            Unlocks = {}
        },
        [2] = {
            Name = "Casa",
            Cost = 500,
            MaxPieces = 10,
            Unlocks = {"Alarm", "Watchtower"}
        },
        [3] = {
            Name = "Forte",
            Cost = 2000,
            MaxPieces = 20,
            Unlocks = {"Cannon", "ForceField"}
        },
        [4] = {
            Name = "Castelo",
            Cost = 10000,
            MaxPieces = 40,
            Unlocks = {"LightTower", "StealthPad"}
        },
        [5] = {
            Name = "Fortaleza",
            Cost = 50000,
            MaxPieces = 80,
            Unlocks = {"ShieldGenerator", "Teleporter"}
        }
    },
    
    -- Peças Disponíveis
    Pieces = {
        -- Defesas
        Wall = {
            Name = "Parede",
            Cost = 50,
            Health = 100,
            Category = "Defense",
            Size = Vector3.new(4, 8, 1),
            Color = Color3.fromRGB(139, 90, 43)
        },
        
        Watchtower = {
            Name = "Torre de Vigia",
            Cost = 200,
            Health = 150,
            Category = "Defense",
            Size = Vector3.new(4, 16, 4),
            Color = Color3.fromRGB(100, 100, 100),
            Effect = "DetectIntruders",
            Range = 50
        },
        
        Cannon = {
            Name = "Canhão",
            Cost = 500,
            Health = 200,
            Category = "Defense",
            Size = Vector3.new(6, 4, 6),
            Color = Color3.fromRGB(50, 50, 50),
            Effect = "ShootIntruders",
            Damage = 25,
            Range = 100
        },
        
        ForceField = {
            Name = "Campo de Força",
            Cost = 1000,
            Health = 500,
            Category = "Defense",
            Size = Vector3.new(10, 10, 10),
            Color = Color3.fromRGB(0, 200, 255),
            Effect = "BlockIntruders",
            Duration = 5
        },
        
        LightTower = {
            Name = "Torre de Luz",
            Cost = 2000,
            Health = 300,
            Category = "Defense",
            Size = Vector3.new(4, 20, 4),
            Color = Color3.fromRGB(255, 255, 0),
            Effect = "RevealStealth",
            Range = 75
        },
        
        ShieldGenerator = {
            Name = "Gerador de Escudo",
            Cost = 5000,
            Health = 400,
            Category = "Defense",
            Size = Vector3.new(6, 8, 6),
            Color = Color3.fromRGB(0, 255, 0),
            Effect = "ShieldBase",
            Duration = 10
        },
        
        -- Utilidades
        EggNest = {
            Name = "Ninho de Ovos",
            Cost = 100,
            Health = 50,
            Category = "Utility",
            Size = Vector3.new(4, 2, 4),
            Color = Color3.fromRGB(139, 69, 19),
            Effect = "StoreEggs",
            Capacity = 10
        },
        
        Vault = {
            Name = "Cofre",
            Cost = 300,
            Health = 300,
            Category = "Utility",
            Size = Vector3.new(4, 4, 4),
            Color = Color3.fromRGB(100, 100, 100),
            Effect = "ProtectEggs",
            Capacity = 50
        },
        
        Generator = {
            Name = "Gerador",
            Cost = 400,
            Health = 100,
            Category = "Utility",
            Size = Vector3.new(4, 4, 4),
            Color = Color3.fromRGB(255, 165, 0),
            Effect = "PowerDefenses"
        },
        
        Teleporter = {
            Name = "Teletransportador",
            Cost = 5000,
            Health = 200,
            Category = "Utility",
            Size = Vector3.new(6, 8, 6),
            Color = Color3.fromRGB(150, 0, 255),
            Effect = "Teleport",
            MaxLinks = 3
        },
        
        -- Armadilhas
        SpikeTrap = {
            Name = "Armadilha de Espinhos",
            Cost = 100,
            Health = 30,
            Category = "Trap",
            Size = Vector3.new(4, 1, 4),
            Color = Color3.fromRGB(200, 0, 0),
            Effect = "DamageIntruder",
            Damage = 20,
            Duration = 3
        },
        
        SlowTrap = {
            Name = "Armadilha de Lentidão",
            Cost = 120,
            Health = 30,
            Category = "Trap",
            Size = Vector3.new(4, 1, 4),
            Color = Color3.fromRGB(0, 100, 200),
            Effect = "SlowIntruder",
            SlowFactor = 0.5,
            Duration = 5
        },
        
        BombTrap = {
            Name = "Armadilha Bomba",
            Cost = 200,
            Health = 30,
            Category = "Trap",
            Size = Vector3.new(4, 1, 4),
            Color = Color3.fromRGB(255, 100, 0),
            Effect = "ExplodeIntruder",
            Damage = 50,
            Radius = 15
        }
    },
    
    -- Limites
    MaxBasesPerPlayer = 1,
    BaseRadius = 100,
    BuildHeight = 50
}

-- ============================================
-- MÓDULO BaseBuildingSystem
-- ============================================
local BaseBuildingSystem = {}
BaseBuildingSystem.__index = BaseBuildingSystem

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function BaseBuildingSystem.new(dataStoreManager, currencyManager)
    local self = setmetatable({}, BaseBuildingSystem)
    
    self.dataStoreManager = dataStoreManager
    self.currencyManager = currencyManager
    
    -- Bases dos jogadores
    self.playerBases = {}
    
    -- Conectar eventos
    self:ConnectEvents()
    
    print("[BaseBuildingSystem] Inicializado com sucesso!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function BaseBuildingSystem:ConnectEvents()
    Players.PlayerAdded:Connect(function(player)
        self:InitPlayerBase(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:SavePlayerBase(player)
    end)
end

-- ============================================
-- INICIALIZAR BASE
-- ============================================
function BaseBuildingSystem:InitPlayerBase(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    if not data then return end
    
    -- Carregar base existente ou criar nova
    self.playerBases[player.UserId] = {
        Level = data.Base.Level,
        Pieces = data.Base.Pieces or {},
        Layout = data.Base.Layout or {},
        Health = self:GetMaxBaseHealth(data.Base.Level),
        MaxHealth = self:GetMaxBaseHealth(data.Base.Level),
        ActiveEffects = {}
    }
    
    -- Criar base física
    self:CreateBasePhysical(player)
    
    print("[BaseBuildingSystem] Base inicializada para " .. player.Name)
end

-- ============================================
-- CRIAR BASE FÍSICA
-- ============================================
function BaseBuildingSystem:CreateBasePhysical(player)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return end
    
    -- Criar pasta da base
    local baseFolder = Instance.new("Folder")
    baseFolder.Name = "Base_" .. player.UserId
    baseFolder.Parent = workspace
    
    -- Criar chão da base
    local ground = Instance.new("Part")
    ground.Name = "BaseGround"
    ground.Size = Vector3.new(50, 1, 50)
    ground.Position = Vector3.new(0, -0.5, 0)
    ground.Anchored = true
    ground.BrickColor = BrickColor.new("Bright green")
    ground.Material = Enum.Material.Grass
    ground.Parent = baseFolder
    
    -- Criar peças salvas
    for pieceId, pieceData in pairs(baseData.Pieces) do
        self:CreatePiecePhysical(player, pieceId, pieceData)
    end
    
    -- Criar marker de base
    local marker = Instance.new("Part")
    marker.Name = "BaseMarker"
    marker.Size = Vector3.new(2, 2, 2)
    marker.Position = Vector3.new(0, 2, 0)
    marker.Anchored = true
    marker.CanCollide = false
    marker.BrickColor = BrickColor.new("Bright blue")
    marker.Material = Enum.Material.Neon
    marker.Parent = baseFolder
    
    -- BillboardGui com nome do jogador
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(4, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = marker
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name .. "'s Base"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Parent = billboard
end

-- ============================================
-- ADICIONAR PEÇA
-- ============================================
function BaseBuildingSystem:AddPiece(player, pieceType, position, rotation)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return false end
    
    local pieceDef = BASE_CONFIG.Pieces[pieceType]
    if not pieceDef then
        warn("[BaseBuildingSystem] Peça não encontrada: " .. pieceType)
        return false
    end
    
    -- Verificar nível
    if not self:CanBuildPiece(player, pieceType) then
        warn("[BaseBuildingSystem] " .. player.Name .. " não pode construir " .. pieceDef.Name)
        return false
    end
    
    -- Verificar limite de peças
    local pieceCount = self:GetPieceCount(player)
    local maxPieces = BASE_CONFIG.Levels[baseData.Level].MaxPieces
    
    if pieceCount >= maxPieces then
        warn("[BaseBuildingSystem] Limite de peças atingido para " .. player.Name)
        return false
    end
    
    -- Verificar moedas
    if self.currencyManager:GetCoins(player) < pieceDef.Cost then
        warn("[BaseBuildingSystem] " .. player.Name .. " não tem moedas para " .. pieceDef.Name)
        return false
    end
    
    -- Verificar posição
    if not self:IsValidPosition(player, position) then
        warn("[BaseBuildingSystem] Posição inválida para peça")
        return false
    end
    
    -- Criar ID da peça
    local pieceId = pieceType .. "_" .. tick()
    
    -- Salvar peça
    baseData.Pieces[pieceId] = {
        Type = pieceType,
        Position = position,
        Rotation = rotation or 0,
        Health = pieceDef.Health,
        MaxHealth = pieceDef.Health,
        IsActive = true,
        CreatedAt = os.time()
    }
    
    -- Remover moedas
    self.currencyManager:RemoveCoins(player, pieceDef.Cost, "BuildPiece")
    
    -- Criar peça física
    self:CreatePiecePhysical(player, pieceId, baseData.Pieces[pieceId])
    
    -- Notificar
    self:NotifyPieceAdded(player, pieceId, pieceType)
    
    print("[BaseBuildingSystem] " .. player.Name .. " construiu " .. pieceDef.Name)
    
    return true
end

-- ============================================
-- CRIAR PEÇA FÍSICA
-- ============================================
function BaseBuildingSystem:CreatePiecePhysical(player, pieceId, pieceData)
    local pieceDef = BASE_CONFIG.Pieces[pieceData.Type]
    if not pieceDef then return end
    
    local baseFolder = workspace:FindFirstChild("Base_" .. player.UserId)
    if not baseFolder then return end
    
    -- Criar peça
    local piece = Instance.new("Part")
    piece.Name = pieceId
    piece.Size = pieceDef.Size
    piece.Position = pieceData.Position
    piece.Anchored = true
    piece.CanCollide = true
    piece.BrickColor = BrickColor.new(pieceDef.Color)
    piece.Material = Enum.Material.SmoothPlastic
    piece.Parent = baseFolder
    
    -- Aplicar rotação
    if pieceData.Rotation then
        piece.CFrame = CFrame.new(pieceData.Position) * CFrame.Angles(0, math.rad(pieceData.Rotation), 0)
    end
    
    -- Adicionar BillboardGui com nome
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(2, 0, 0.5, 0)
    billboard.StudsOffset = Vector3.new(0, pieceDef.Size.Y / 2 + 1, 0)
    billboard.Parent = piece
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = pieceDef.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Parent = billboard
    
    -- Adicionar barra de vida
    local healthBar = Instance.new("BillboardGui")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(2, 0, 0.3, 0)
    healthBar.StudsOffset = Vector3.new(0, pieceDef.Size.Y / 2 + 0.5, 0)
    healthBar.Parent = piece
    
    local healthBackground = Instance.new("Frame")
    healthBackground.Size = UDim2.new(1, 0, 1, 0)
    healthBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBackground.BorderSizePixel = 0
    healthBackground.Parent = healthBar
    
    local healthFill = Instance.new("Frame")
    healthFill.Name = "Fill"
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBackground
    
    -- Aplicar efeitos baseados no tipo
    self:ApplyPieceEffects(player, pieceId, piece, pieceData.Type)
end

-- ============================================
-- APLICAR EFEITOS
-- ============================================
function BaseBuildingSystem:ApplyPieceEffects(player, pieceId, piece, pieceType)
    local pieceDef = BASE_CONFIG.Pieces[pieceType]
    
    if pieceType == "Watchtower" then
        -- Torre de vigia detecta intrusores
        self:CreateDetectionEffect(piece, pieceDef.Range)
        
    elseif pieceType == "Cannon" then
        -- Canhão atira em intrusores
        self:CreateCannonEffect(piece, pieceDef.Damage, pieceDef.Range)
        
    elseif pieceType == "ForceField" then
        -- Campo de força bloqueia intrusores
        self:CreateForceFieldEffect(piece, pieceDef.Duration)
        
    elseif pieceType == "LightTower" then
        -- Torre de luz revela invisíveis
        self:CreateLightTowerEffect(piece, pieceDef.Range)
        
    elseif pieceType == "ShieldGenerator" then
        -- Gerador de escudo protege base
        self:CreateShieldGeneratorEffect(piece, pieceDef.Duration)
        
    elseif pieceType == "SpikeTrap" then
        -- Armadilha de espinhos
        self:CreateSpikeTrapEffect(piece, pieceDef.Damage, pieceDef.Duration)
        
    elseif pieceType == "SlowTrap" then
        -- Armadilha de lentidão
        self:CreateSlowTrapEffect(piece, pieceDef.SlowFactor, pieceDef.Duration)
        
    elseif pieceType == "BombTrap" then
        -- Armadilha bomba
        self:CreateBombTrapEffect(piece, pieceDef.Damage, pieceDef.Radius)
    end
end

-- ============================================
-- EFEITOS ESPECÍFICOS
-- ============================================
function BaseBuildingSystem:CreateDetectionEffect(piece, range)
    -- Criar detector de intrusões
    local detectionZone = Instance.new("Part")
    detectionZone.Name = "DetectionZone"
    detectionZone.Size = Vector3.new(range * 2, 20, range * 2)
    detectionZone.Position = piece.Position
    detectionZone.Anchored = true
    detectionZone.CanCollide = false
    detectionZone.Transparency = 1
    detectionZone.Parent = piece
    
    -- Detectar jogadores
    detectionZone.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            -- Verificar se é intruso
            if not self:IsBaseOwner(player, piece) then
                self:OnIntruderDetected(player, piece)
            end
        end
    end)
end

function BaseBuildingSystem:CreateCannonEffect(piece, damage, range)
    -- Criar canhão que atira
    spawn(function()
        while piece and piece.Parent do
            wait(2) -- Atira a cada 2 segundos
            
            -- Encontrar jogador mais próximo
            local closestPlayer = nil
            local closestDistance = range
            
            for _, player in pairs(Players:GetPlayers()) do
                if not self:IsBaseOwner(player, piece) then
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local distance = (rootPart.Position - piece.Position).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
            
            -- Atirar
            if closestPlayer then
                self:FireCannon(piece, closestPlayer, damage)
            end
        end
    end)
end

function BaseBuildingSystem:FireCannon(piece, target, damage)
    -- Criar projétil
    local projectile = Instance.new("Part")
    projectile.Name = "Cannonball"
    projectile.Size = Vector3.new(1, 1, 1)
    projectile.Position = piece.Position + Vector3.new(0, 5, 0)
    projectile.Anchored = false
    projectile.CanCollide = false
    projectile.BrickColor = BrickColor.new("Really black")
    projectile.Parent = workspace
    
    -- Mover em direção ao alvo
    local targetPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if targetPart then
        local direction = (targetPart.Position - projectile.Position).Unit
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * 100
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = projectile
        
        -- Colisão
        projectile.Touched:Connect(function(hit)
            local hitPlayer = Players:GetPlayerFromCharacter(hit.Parent)
            if hitPlayer and hitPlayer == target then
                -- Aplicar dano
                local humanoid = hit.Parent:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(damage)
                end
                projectile:Destroy()
            end
        end)
        
        -- Destruir após 5 segundos
        game:GetService("Debris"):AddItem(projectile, 5)
    end
end

function BaseBuildingSystem:CreateForceFieldEffect(piece, duration)
    -- Criar campo de força visual
    local forceField = Instance.new("Part")
    forceField.Name = "ForceField"
    forceField.Size = piece.Size * 1.2
    forceField.Position = piece.Position
    forceField.Anchored = true
    forceField.CanCollide = false
    forceField.Transparency = 0.5
    forceField.BrickColor = BrickColor.new("Bright blue")
    forceField.Material = Enum.Material.ForceField
    forceField.Parent = piece
    
    -- Bloquear intrusores periodicamente
    spawn(function()
        while piece and piece.Parent do
            wait(duration)
            self:ActivateForceField(forceField, duration)
        end
    end)
end

function BaseBuildingSystem:ActivateForceField(forceField, duration)
    forceField.Transparency = 0.3
    
    -- Detectar colisões
    forceField.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player and not self:IsBaseOwner(player, forceField) then
            -- Empurrar jogador para fora
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local direction = (rootPart.Position - forceField.Position).Unit
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = direction * 50
                    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyVelocity.Parent = rootPart
                    game:GetService("Debris"):AddItem(bodyVelocity, 0.2)
                end
            end
        end
    end)
    
    wait(duration)
    forceField.Transparency = 0.5
end

function BaseBuildingSystem:CreateLightTowerEffect(piece, range)
    -- Criar luz
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 255, 200)
    light.Brightness = 2
    light.Range = range
    light.Parent = piece
    
    -- Revelar jogadores invisíveis
    spawn(function()
        while piece and piece.Parent do
            wait(1)
            
            for _, player in pairs(Players:GetPlayers()) do
                if not self:IsBaseOwner(player, piece) then
                    local character = player.Character
                    if character then
                        local distance = (character:GetPrimaryPartCFrame().p - piece.Position).Magnitude
                        if distance <= range then
                            -- Revelar jogador
                            self:RevealPlayer(player)
                        end
                    end
                end
            end
        end
    end)
end

function BaseBuildingSystem:RevealPlayer(player)
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end

function BaseBuildingSystem:CreateShieldGeneratorEffect(piece, duration)
    spawn(function()
        while piece and piece.Parent do
            wait(duration)
            self:ActivateShieldGenerator(piece.Position, duration)
        end
    end)
end

function BaseBuildingSystem:ActivateShieldGenerator(position, duration)
    -- Criar escudo visual
    local shield = Instance.new("Part")
    shield.Name = "BaseShield"
    shield.Shape = Enum.PartType.Ball
    shield.Size = Vector3.new(100, 100, 100)
    shield.Position = position
    shield.Anchored = true
    shield.CanCollide = false
    shield.Transparency = 0.7
    shield.BrickColor = BrickColor.new("Bright green")
    shield.Material = Enum.Material.ForceField
    shield.Parent = workspace
    
    -- Proteger base
    shield.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player and not self:IsBaseOwner(player, shield) then
            -- Bloquear intruso
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local direction = (rootPart.Position - shield.Position).Unit
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = direction * 100
                    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyVelocity.Parent = rootPart
                    game:GetService("Debris"):AddItem(bodyVelocity, 0.2)
                end
            end
        end
    end)
    
    wait(duration)
    shield:Destroy()
end

function BaseBuildingSystem:CreateSpikeTrapEffect(piece, damage, duration)
    piece.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player and not self:IsBaseOwner(player, piece) then
            -- Aplicar dano
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(damage)
                end
            end
            
            -- Efeito visual
            piece.BrickColor = BrickColor.new("Bright red")
            wait(0.2)
            piece.BrickColor = BrickColor.new("Bright yellow")
        end
    end)
end

function BaseBuildingSystem:CreateSlowTrapEffect(piece, slowFactor, duration)
    piece.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player and not self:IsBaseOwner(player, piece) then
            -- Reduzir velocidade
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    local originalSpeed = humanoid.WalkSpeed
                    humanoid.WalkSpeed = originalSpeed * slowFactor
                    
                    -- Restaurar após duração
                    wait(duration)
                    if humanoid and humanoid.Parent then
                        humanoid.WalkSpeed = originalSpeed
                    end
                end
            end
        end
    end)
end

function BaseBuildingSystem:CreateBombTrapEffect(piece, damage, radius)
    piece.Touched:Connect(function(hit)
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        if player and not self:IsBaseOwner(player, piece) then
            -- Explodir
            self:ExplodeBombTrap(piece.Position, damage, radius)
            piece:Destroy()
        end
    end)
end

function BaseBuildingSystem:ExplodeBombTrap(position, damage, radius)
    -- Criar efeito visual
    local explosion = Instance.new("Part")
    explosion.Name = "TrapExplosion"
    explosion.Shape = Enum.PartType.Ball
    explosion.Size = Vector3.new(1, 1, 1)
    explosion.Position = position
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Material = Enum.Material.Neon
    explosion.BrickColor = BrickColor.new("Bright orange")
    explosion.Parent = workspace
    
    -- Animar
    spawn(function()
        for i = 1, 20 do
            explosion.Size = Vector3.new(i * 2, i * 2, i * 2)
            explosion.Transparency = i / 20
            wait(0.05)
        end
        explosion:Destroy()
    end)
    
    -- Aplicar dano
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if not self:IsBaseOwner(otherPlayer, explosion) then
            local character = otherPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local distance = (position - rootPart.Position).Magnitude
                    if distance <= radius then
                        local damageMultiplier = 1 - (distance / radius)
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:TakeDamage(damage * damageMultiplier)
                        end
                    end
                end
            end
        end
    end
end

-- ============================================
-- VERIFICAÇÕES
-- ============================================
function BaseBuildingSystem:CanBuildPiece(player, pieceType)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return false end
    
    local pieceDef = BASE_CONFIG.Pieces[pieceType]
    if not pieceDef then return false end
    
    -- Verificar nível
    local levelData = BASE_CONFIG.Levels[baseData.Level]
    if not levelData then return false end
    
    -- Verificar se está desbloqueado
    if pieceDef.Category == "Defense" then
        local unlocked = false
        for _, unlock in pairs(levelData.Unlocks) do
            if unlock == pieceType then
                unlocked = true
                break
            end
        end
        
        -- Peças básicas sempre desbloqueadas
        if pieceType == "Wall" then
            unlocked = true
        end
        
        if not unlocked then
            return false
        end
    end
    
    return true
end

function BaseBuildingSystem:IsValidPosition(player, position)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return false end
    
    -- Verificar distância da base
    local basePosition = self:GetBasePosition(player)
    local distance = (Vector3.new(position.X, 0, position.Z) - Vector3.new(basePosition.X, 0, basePosition.Z)).Magnitude
    
    if distance > BASE_CONFIG.BaseRadius then
        return false
    end
    
    -- Verificar altura
    if position.Y < 0 or position.Y > BASE_CONFIG.BuildHeight then
        return false
    end
    
    return true
end

function BaseBuildingSystem:IsBaseOwner(player, piece)
    local baseFolder = workspace:FindFirstChild("Base_" .. player.UserId)
    if baseFolder then
        return piece:IsDescendantOf(baseFolder)
    end
    return false
end

-- ============================================
-- OBTER INFORMAÇÕES
-- ============================================
function BaseBuildingSystem:GetBasePosition(player)
    local baseFolder = workspace:FindFirstChild("Base_" .. player.UserId)
    if baseFolder then
        local ground = baseFolder:FindFirstChild("BaseGround")
        if ground then
            return ground.Position
        end
    end
    return Vector3.new(0, 0, 0)
end

function BaseBuildingSystem:GetPieceCount(player)
    local baseData = self.playerBases[player.UserId]
    if baseData then
        local count = 0
        for _ in pairs(baseData.Pieces) do
            count = count + 1
        end
        return count
    end
    return 0
end

function BaseBuildingSystem:GetMaxBaseHealth(level)
    local levelData = BASE_CONFIG.Levels[level]
    if levelData then
        return levelData.MaxPieces * 50 -- 50 HP por peça possível
    end
    return 100
end

function BaseBuildingSystem:UpgradeBase(player)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return false end
    
    local nextLevel = baseData.Level + 1
    local levelData = BASE_CONFIG.Levels[nextLevel]
    
    if not levelData then
        warn("[BaseBuildingSystem] Nível máximo atingido")
        return false
    end
    
    -- Verificar moedas
    if self.currencyManager:GetCoins(player) < levelData.Cost then
        return false
    end
    
    -- Remover moedas
    self.currencyManager:RemoveCoins(player, levelData.Cost, "UpgradeBase")
    
    -- Atualizar nível
    baseData.Level = nextLevel
    baseData.MaxHealth = self:GetMaxBaseHealth(nextLevel)
    
    -- Salvar
    local data = self.dataStoreManager:GetPlayerData(player)
    if data then
        data.Base.Level = nextLevel
    end
    
    -- Notificar
    self:NotifyBaseUpgraded(player, nextLevel)
    
    return true
end

-- ============================================
-- ON INTRUDER DETECTED
-- ============================================
function BaseBuildingSystem:OnIntruderDetected(intruder, piece)
    -- Notificar dono da base
    local baseOwner = self:GetBaseOwner(piece)
    if baseOwner then
        self:NotifyIntruderDetected(baseOwner, intruder)
    end
end

function BaseBuildingSystem:GetBaseOwner(piece)
    local baseFolder = piece:FindFirstAncestor("Base_" .. string.match(piece.Name, "(%d+)$"))
    if baseFolder then
        local userId = tonumber(string.match(baseFolder.Name, "(%d+)$"))
        if userId then
            return Players:GetPlayerByUserId(userId)
        end
    end
    return nil
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function BaseBuildingSystem:NotifyPieceAdded(player, pieceId, pieceType)
    local event = ReplicatedStorage:FindFirstChild("BaseEvents")
    if event then
        local addPieceEvent = event:FindFirstChild("PieceAdded")
        if addPieceEvent then
            addPieceEvent:FireClient(player, {
                PieceId = pieceId,
                PieceType = pieceType,
                Definition = BASE_CONFIG.Pieces[pieceType]
            })
        end
    end
end

function BaseBuildingSystem:NotifyBaseUpgraded(player, newLevel)
    local event = ReplicatedStorage:FindFirstChild("BaseEvents")
    if event then
        local upgradeEvent = event:FindFirstChild("BaseUpgraded")
        if upgradeEvent then
            upgradeEvent:FireClient(player, {
                NewLevel = newLevel,
                Definition = BASE_CONFIG.Levels[newLevel]
            })
        end
    end
end

function BaseBuildingSystem:NotifyIntruderDetected(owner, intruder)
    local event = ReplicatedStorage:FindFirstChild("BaseEvents")
    if event then
        local intruderEvent = event:FindFirstChild("IntruderDetected")
        if intruderEvent then
            intruderEvent:FireClient(owner, {
                Intruder = intruder.Name,
                Position = intruder.Character and intruder.Character:GetPrimaryPartCFrame().p
            })
        end
    end
end

-- ============================================
-- REMOTE EVENTS
-- ============================================
function BaseBuildingSystem:ConnectRemoteEvents()
    local eventFolder = Instance.new("Folder")
    eventFolder.Name = "BaseEvents"
    eventFolder.Parent = ReplicatedStorage
    
    -- Eventos
    local events = {
        "PieceAdded",
        "PieceRemoved",
        "BaseUpgraded",
        "IntruderDetected"
    }
    
    for _, eventName in pairs(events) do
        local event = Instance.new("RemoteEvent")
        event.Name = eventName
        event.Parent = eventFolder
    end
    
    -- RemoteFunction
    local baseFunction = Instance.new("RemoteFunction")
    baseFunction.Name = "BaseAction"
    baseFunction.Parent = eventFolder
    
    baseFunction.OnServerInvoke = function(player, action, ...)
        if action == "AddPiece" then
            return self:AddPiece(player, ...)
        elseif action == "UpgradeBase" then
            return self:UpgradeBase(player)
        elseif action == "GetPieceCount" then
            return self:GetPieceCount(player)
        elseif action == "GetAvailablePieces" then
            return self:GetAvailablePieces(player)
        end
        return false
    end
end

-- ============================================
-- OBTER PEÇAS DISPONÍVEIS
-- ============================================
function BaseBuildingSystem:GetAvailablePieces(player)
    local baseData = self.playerBases[player.UserId]
    if not baseData then return {} end
    
    local available = {}
    local levelData = BASE_CONFIG.Levels[baseData.Level]
    
    for pieceType, pieceDef in pairs(BASE_CONFIG.Pieces) do
        local canBuild = true
        
        -- Verificar desbloqueio
        if pieceDef.Category == "Defense" then
            local unlocked = false
            for _, unlock in pairs(levelData.Unlocks) do
                if unlock == pieceType then
                    unlocked = true
                    break
                end
            end
            
            if pieceType ~= "Wall" and not unlocked then
                canBuild = false
            end
        end
        
        -- Verificar moedas
        if canBuild and self.currencyManager:GetCoins(player) < pieceDef.Cost then
            canBuild = false
        end
        
        if canBuild then
            available[pieceType] = pieceDef
        end
    end
    
    return available
end

-- ============================================
-- SALVAR BASE
-- ============================================
function BaseBuildingSystem:SavePlayerBase(player)
    local userId = player.UserId
    if self.playerBases[userId] then
        local data = self.dataStoreManager:GetPlayerData(player)
        if data then
            data.Base.Level = self.playerBases[userId].Level
            data.Base.Pieces = self.playerBases[userId].Pieces
        end
    end
end

-- ============================================
-- LIMPAR
-- ============================================
function BaseBuildingSystem:ClearBase(player)
    local baseFolder = workspace:FindFirstChild("Base_" .. player.UserId)
    if baseFolder then
        baseFolder:Destroy()
    end
    
    self.playerBases[player.UserId] = nil
end

-- ============================================
-- INICIALIZAR
-- ============================================
function BaseBuildingSystem:Initialize()
    self:ConnectRemoteEvents()
end

return BaseBuildingSystem
