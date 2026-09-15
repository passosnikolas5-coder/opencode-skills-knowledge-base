--[[
    Egg Empire - Inventory Manager
    Gerencia inventário, itens e skins do jogador
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================
-- CONFIGURAÇÃO DE ITENS
-- ============================================
local ITEMS = {
    -- Poções
    SpeedPotion = {
        Name = "Poção de Velocidade",
        Description = "Aumenta velocidade em 50% por 30 segundos",
        Type = "Consumable",
        Category = "Potion",
        Price = 50,
        Duration = 30,
        Effect = {Type = "Speed", Value = 1.5},
        Rarity = "Common",
        Stackable = true,
        MaxStack = 10
    },
    
    StrengthPotion = {
        Name = "Poção de Força",
        Description = "Aumenta dano em 100% por 30 segundos",
        Type = "Consumable",
        Category = "Potion",
        Price = 75,
        Duration = 30,
        Effect = {Type = "Damage", Value = 2.0},
        Rarity = "Common",
        Stackable = true,
        MaxStack = 10
    },
    
    InvisibilityPotion = {
        Name = "Poção de Invisibilidade",
        Description = "Fica invisível por 15 segundos",
        Type = "Consumable",
        Category = "Potion",
        Price = 100,
        Duration = 15,
        Effect = {Type = "Invisibility", Value = true},
        Rarity = "Uncommon",
        Stackable = true,
        MaxStack = 5
    },
    
    ShieldPotion = {
        Name = "Poção de Escudo",
        Description = "Bloqueia 50% do dano por 20 segundos",
        Type = "Consumable",
        Category = "Potion",
        Price = 80,
        Duration = 20,
        Effect = {Type = "DamageReduction", Value = 0.5},
        Rarity = "Common",
        Stackable = true,
        MaxStack = 10
    },
    
    -- Utilidades
    RepairKit = {
        Name = "Kit de Reparo",
        Description = "Conserta toda a base do jogador",
        Type = "Consumable",
        Category = "Utility",
        Price = 150,
        Effect = {Type = "Repair", Value = 1.0},
        Rarity = "Uncommon",
        Stackable = true,
        MaxStack = 3
    },
    
    TeleportScroll = {
        Name = "Pergaminho de Teletransporte",
        Description = "Teletransporta para qualquer ponto do mapa",
        Type = "Consumable",
        Category = "Utility",
        Price = 200,
        Effect = {Type = "Teleport", Value = true},
        Rarity = "Uncommon",
        Stackable = true,
        MaxStack = 5
    },
    
    EggMagnet = {
        Name = "Ímã de Ovos",
        Description = "Atrai todos os ovos num raio de 50 studs",
        Type = "Consumable",
        Category = "Utility",
        Price = 300,
        Effect = {Type = "Magnet", Value = 50},
        Rarity = "Rare",
        Stackable = true,
        MaxStack = 3
    },
    
    -- Armadilhas
    SpikeTrap = {
        Name = "Armadilha de Espinhos",
        Description = "Prende e causa dano a invasores",
        Type = "Trap",
        Category = "Defense",
        Price = 100,
        Damage = 20,
        Duration = 5,
        Rarity = "Common",
        Stackable = true,
        MaxStack = 5
    },
    
    SlowTrap = {
        Name = "Armadilha de Lentidão",
        Description = "Reduz velocidade do invasor em 50%",
        Type = "Trap",
        Category = "Defense",
        Price = 120,
        Effect = {Type = "Slow", Value = 0.5},
        Duration = 8,
        Rarity = "Common",
        Stackable = true,
        MaxStack = 5
    },
    
    BombTrap = {
        Name = "Armadilha Bomba",
        Description = "Explode causando dano em área",
        Type = "Trap",
        Category = "Defense",
        Price = 200,
        Damage = 50,
        Radius = 20,
        Rarity = "Uncommon",
        Stackable = true,
        MaxStack = 3
    },
    
    -- Armas
    Sword = {
        Name = "Espada",
        Description = "Arma básica para combate",
        Type = "Weapon",
        Category = "Melee",
        Price = 100,
        Damage = 15,
        Cooldown = 0.5,
        Rarity = "Common",
        Stackable = false
    },
    
    Dagger = {
        Name = "Adaga",
        Description = "Ataque rápido mas com menos dano",
        Type = "Weapon",
        Category = "Melee",
        Price = 150,
        Damage = 10,
        Cooldown = 0.3,
        Rarity = "Common",
        Stackable = false
    },
    
    Shield = {
        Name = "Escudo",
        Description = "Bloqueia 70% do dano",
        Type = "Weapon",
        Category = "Defense",
        Price = 200,
        DamageReduction = 0.7,
        Rarity = "Uncommon",
        Stackable = false
    },
    
    Bow = {
        Name = "Arco",
        Description = "Ataque à distância",
        Type = "Weapon",
        Category = "Ranged",
        Price = 300,
        Damage = 20,
        Range = 100,
        Cooldown = 1.0,
        Rarity = "Uncommon",
        Stackable = false
    }
}

-- ============================================
-- CONFIGURAÇÃO DE SKINS
-- ============================================
local SKINS = {
    Default = {
        Name = "Padrão",
        Description = "Aparência padrão",
        Price = 0,
        Rarity = "Common",
        EggColor = Color3.fromRGB(255, 255, 255),
        PlayerColor = Color3.fromRGB(100, 100, 100)
    },
    
    GoldenEgg = {
        Name = "Ovo de Ouro",
        Description = "Brilho dourado",
        Price = 500,
        Rarity = "Uncommon",
        EggColor = Color3.fromRGB(255, 215, 0),
        PlayerColor = Color3.fromRGB(255, 215, 0)
    },
    
    CrystalEgg = {
        Name = "Ovo de Cristal",
        Description = "Translúcido e brilhante",
        Price = 1000,
        Rarity = "Rare",
        EggColor = Color3.fromRGB(100, 200, 255),
        PlayerColor = Color3.fromRGB(100, 200, 255)
    },
    
    FireEgg = {
        Name = "Ovo de Fogo",
        Description = "Chamas eternas",
        Price = 2000,
        Rarity = "Epic",
        EggColor = Color3.fromRGB(255, 100, 0),
        PlayerColor = Color3.fromRGB(255, 50, 0)
    },
    
    IceEgg = {
        Name = "Ovo de Gelo",
        Description = "Cristais de gelo",
        Price = 2000,
        Rarity = "Epic",
        EggColor = Color3.fromRGB(0, 200, 255),
        PlayerColor = Color3.fromRGB(0, 150, 255)
    },
    
    CosmicEgg = {
        Name = "Ovo Cósmico",
        Description = "Estrelas e galáxias",
        Price = 5000,
        Rarity = "Legendary",
        EggColor = Color3.fromRGB(100, 0, 200),
        PlayerColor = Color3.fromRGB(50, 0, 100)
    },
    
    NeonEgg = {
        Name = "Ovo Neon",
        Description = "Brilho neon intenso",
        Price = 3000,
        Rarity = "Epic",
        EggColor = Color3.fromRGB(0, 255, 0),
        PlayerColor = Color3.fromRGB(0, 200, 0)
    },
    
    ShadowEgg = {
        Name = "Ovo Sombra",
        Description = "Esconde nas sombras",
        Price = 4000,
        Rarity = "Epic",
        EggColor = Color3.fromRGB(30, 30, 30),
        PlayerColor = Color3.fromRGB(20, 20, 20)
    }
}

-- ============================================
-- MÓDULO InventoryManager
-- ============================================
local InventoryManager = {}
InventoryManager.__index = InventoryManager

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function InventoryManager.new(dataStoreManager, currencyManager)
    local self = setmetatable({}, InventoryManager)
    
    self.dataStoreManager = dataStoreManager
    self.currencyManager = currencyManager
    self.playerInventories = {}
    
    -- Conectar eventos
    self:ConnectEvents()
    
    print("[InventoryManager] Inicializado com sucesso!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function InventoryManager:ConnectEvents()
    Players.PlayerAdded:Connect(function(player)
        self:InitPlayerInventory(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:SavePlayerInventory(player)
    end)
end

-- ============================================
-- INICIALIZAR INVENTÁRIO
-- ============================================
function InventoryManager:InitPlayerInventory(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    if not data then return end
    
    self.playerInventories[player.UserId] = {
        Items = data.Inventory.Items or {},
        Skins = data.Inventory.Skins or {"Default"},
        ActiveSkin = data.Inventory.ActiveSkin or "Default",
        EquippedItems = data.Inventory.EquippedItems or {}
    }
    
    print("[InventoryManager] Inventário inicializado para " .. player.Name)
end

-- ============================================
-- OBTER ITENS
-- ============================================
function InventoryManager:GetItems(player)
    local userId = player.UserId
    if self.playerInventories[userId] then
        return self.playerInventories[userId].Items
    end
    return {}
end

function InventoryManager:GetSkins(player)
    local userId = player.UserId
    if self.playerInventories[userId] then
        return self.playerInventories[userId].Skins
    end
    return {"Default"}
end

function InventoryManager:GetActiveSkin(player)
    local userId = player.UserId
    if self.playerInventories[userId] then
        return self.playerInventories[userId].ActiveSkin
    end
    return "Default"
end

function InventoryManager:GetItemCount(player, itemId)
    local items = self:GetItems(player)
    return items[itemId] or 0
end

-- ============================================
-- ADICIONAR ITENS
-- ============================================
function InventoryManager:AddItem(player, itemId, amount)
    amount = amount or 1
    
    local itemDef = ITEMS[itemId]
    if not itemDef then
        warn("[InventoryManager] Item não encontrado: " .. itemId)
        return false
    end
    
    local items = self:GetItems(player)
    local currentCount = items[itemId] or 0
    
    -- Verificar limite de stack
    if itemDef.Stackable then
        local maxStack = itemDef.MaxStack or 99
        if currentCount + amount > maxStack then
            amount = maxStack - currentCount
            if amount <= 0 then
                warn("[InventoryManager] Stack cheio para " .. itemDef.Name)
                return false
            end
        end
    else
        if currentCount > 0 then
            warn("[InventoryManager] " .. itemDef.Name .. " não é empilhável")
            return false
        end
    end
    
    -- Adicionar item
    items[itemId] = currentCount + amount
    self.playerInventories[player.UserId].Items = items
    
    -- Salvar
    local data = self.dataStoreManager:GetPlayerData(player)
    if data then
        data.Inventory.Items = items
    end
    
    -- Notificar cliente
    self:NotifyItemAdded(player, itemId, amount)
    
    print("[InventoryManager] " .. player.Name .. " recebeu " .. amount .. "x " .. itemDef.Name)
    
    return true
end

-- ============================================
-- REMOVER ITENS
-- ============================================
function InventoryManager:RemoveItem(player, itemId, amount)
    amount = amount or 1
    
    local items = self:GetItems(player)
    local currentCount = items[itemId] or 0
    
    if currentCount < amount then
        return false
    end
    
    items[itemId] = currentCount - amount
    
    -- Remover do inventário se quantidade zero
    if items[itemId] <= 0 then
        items[itemId] = nil
    end
    
    self.playerInventories[player.UserId].Items = items
    
    -- Salvar
    local data = self.dataStoreManager:GetPlayerData(player)
    if data then
        data.Inventory.Items = items
    end
    
    -- Notificar cliente
    self:NotifyItemRemoved(player, itemId, amount)
    
    return true
end

-- ============================================
-- USAR ITENS
-- ============================================
function InventoryManager:UseItem(player, itemId)
    local itemDef = ITEMS[itemId]
    if not itemDef then return false end
    
    if itemDef.Type ~= "Consumable" then
        return false
    end
    
    -- Verificar se tem o item
    if self:GetItemCount(player, itemId) <= 0 then
        return false
    end
    
    -- Remover item
    self:RemoveItem(player, itemId, 1)
    
    -- Aplicar efeito
    self:ApplyItemEffect(player, itemDef)
    
    return true
end

function InventoryManager:ApplyItemEffect(player, itemDef)
    local effect = itemDef.Effect
    
    if effect.Type == "Speed" then
        -- Aumentar velocidade
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local originalSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = originalSpeed * effect.Value
                
                -- Restaurar após duração
                wait(itemDef.Duration)
                if humanoid and humanoid.Parent then
                    humanoid.WalkSpeed = originalSpeed
                end
            end
        end
        
    elseif effect.Type == "Damage" then
        -- Aumentar dano (implementar no sistema de combate)
        print("[InventoryManager] Dano aumentado para " .. player.Name)
        
    elseif effect.Type == "Invisibility" then
        -- Tornar invisível
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
            
            wait(itemDef.Duration)
            
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                end
            end
        end
        
    elseif effect.Type == "DamageReduction" then
        -- Reduzir dano (implementar no sistema de combate)
        print("[InventoryManager] Redução de dano para " .. player.Name)
        
    elseif effect.Type == "Repair" then
        -- Consertar base
        print("[InventoryManager] Base consertada para " .. player.Name)
        
    elseif effect.Type == "Teleport" then
        -- Teletransportar (implementar com UI)
        print("[InventoryManager] Teleporte disponível para " .. player.Name)
        
    elseif effect.Type == "Magnet" then
        -- Atrair ovos (implementar no sistema de ovos)
        print("[InventoryManager] Ímã ativado para " .. player.Name)
    end
end

-- ============================================
-- COLAR SKINS
-- ============================================
function InventoryManager:AddSkin(player, skinId)
    if not SKINS[skinId] then
        return false
    end
    
    local skins = self:GetSkins(player)
    
    -- Verificar se já tem
    for _, skin in pairs(skins) do
        if skin == skinId then
            return false
        end
    end
    
    -- Adicionar skin
    table.insert(skins, skinId)
    self.playerInventories[player.UserId].Skins = skins
    
    -- Salvar
    local data = self.dataStoreManager:GetPlayerData(player)
    if data then
        data.Inventory.Skins = skins
    end
    
    -- Notificar cliente
    self:NotifySkinAdded(player, skinId)
    
    return true
end

function InventoryManager:SetActiveSkin(player, skinId)
    local skins = self:GetSkins(player)
    
    -- Verificar se tem a skin
    local hasSkin = false
    for _, skin in pairs(skins) do
        if skin == skinId then
            hasSkin = true
            break
        end
    end
    
    if not hasSkin then
        return false
    end
    
    self.playerInventories[player.UserId].ActiveSkin = skinId
    
    -- Salvar
    local data = self.dataStoreManager:GetPlayerData(player)
    if data then
        data.Inventory.ActiveSkin = skinId
    end
    
    -- Notificar cliente
    self:NotifySkinChanged(player, skinId)
    
    return true
end

-- ============================================
-- COMPRAR ITENS
-- ============================================
function InventoryManager:BuyItem(player, itemId, amount)
    amount = amount or 1
    
    local itemDef = ITEMS[itemId]
    if not itemDef then return false end
    
    local totalCost = itemDef.Price * amount
    
    -- Verificar se tem moedas
    if self.currencyManager:GetCoins(player) < totalCost then
        warn("[InventoryManager] " .. player.Name .. " não tem moedas suficientes")
        return false
    end
    
    -- Remover moedas
    self.currencyManager:RemoveCoins(player, totalCost, "BuyItem")
    
    -- Adicionar item
    local success = self:AddItem(player, itemId, amount)
    
    if not success then
        -- Devolver moedas se falhar
        self.currencyManager:AddCoins(player, totalCost, "Refund")
        return false
    end
    
    return true
end

function InventoryManager:BuySkin(player, skinId)
    local skinDef = SKINS[skinId]
    if not skinDef then return false end
    
    -- Verificar se já tem
    local skins = self:GetSkins(player)
    for _, skin in pairs(skins) do
        if skin == skinId then
            return false
        end
    end
    
    -- Verificar moedas
    if self.currencyManager:GetCoins(player) < skinDef.Price then
        return false
    end
    
    -- Remover moedas
    self.currencyManager:RemoveCoins(player, skinDef.Price, "BuySkin")
    
    -- Adicionar skin
    local success = self:AddSkin(player, skinId)
    
    if not success then
        self.currencyManager:AddCoins(player, skinDef.Price, "Refund")
        return false
    end
    
    return true
end

-- ============================================
-- OBTER DEFINIÇÕES
-- ============================================
function InventoryManager:GetItemDefinition(itemId)
    return ITEMS[itemId]
end

function InventoryManager:GetSkinDefinition(skinId)
    return SKINS[skinId]
end

function InventoryManager:GetAllItems()
    return ITEMS
end

function InventoryManager:GetAllSkins()
    return SKINS
end

function InventoryManager:GetItemsByCategory(category)
    local result = {}
    for itemId, itemDef in pairs(ITEMS) do
        if itemDef.Category == category then
            result[itemId] = itemDef
        end
    end
    return result
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function InventoryManager:NotifyItemAdded(player, itemId, amount)
    local event = ReplicatedStorage:FindFirstChild("InventoryEvents")
    if event then
        local addItemEvent = event:FindFirstChild("ItemAdded")
        if addItemEvent then
            addItemEvent:FireClient(player, {
                ItemId = itemId,
                Amount = amount,
                Definition = ITEMS[itemId]
            })
        end
    end
end

function InventoryManager:NotifyItemRemoved(player, itemId, amount)
    local event = ReplicatedStorage:FindFirstChild("InventoryEvents")
    if event then
        local removeItemEvent = event:FindFirstChild("ItemRemoved")
        if removeItemEvent then
            removeItemEvent:FireClient(player, {
                ItemId = itemId,
                Amount = amount
            })
        end
    end
end

function InventoryManager:NotifySkinAdded(player, skinId)
    local event = ReplicatedStorage:FindFirstChild("InventoryEvents")
    if event then
        local addSkinEvent = event:FindFirstChild("SkinAdded")
        if addSkinEvent then
            addSkinEvent:FireClient(player, {
                SkinId = skinId,
                Definition = SKINS[skinId]
            })
        end
    end
end

function InventoryManager:NotifySkinChanged(player, skinId)
    local event = ReplicatedStorage:FindFirstChild("InventoryEvents")
    if event then
        local changeSkinEvent = event:FindFirstChild("SkinChanged")
        if changeSkinEvent then
            changeSkinEvent:FireClient(player, {
                SkinId = skinId,
                Definition = SKINS[skinId]
            })
        end
    end
end

-- ============================================
-- REMOTE EVENTS
-- ============================================
function InventoryManager:CreateRemoteEvents()
    local eventFolder = Instance.new("Folder")
    eventFolder.Name = "InventoryEvents"
    eventFolder.Parent = ReplicatedStorage
    
    -- Eventos
    local events = {
        "ItemAdded",
        "ItemRemoved",
        "ItemUsed",
        "SkinAdded",
        "SkinChanged"
    }
    
    for _, eventName in pairs(events) do
        local event = Instance.new("RemoteEvent")
        event.Name = eventName
        event.Parent = eventFolder
    end
    
    -- RemoteFunctions
    local buyItemFunction = Instance.new("RemoteFunction")
    buyItemFunction.Name = "BuyItem"
    buyItemFunction.Parent = eventFolder
    
    buyItemFunction.OnServerInvoke = function(player, action, ...)
        if action == "BuyItem" then
            return self:BuyItem(player, ...)
        elseif action == "BuySkin" then
            return self:BuySkin(player, ...)
        elseif action == "UseItem" then
            return self:UseItem(player, ...)
        elseif action == "EquipSkin" then
            return self:SetActiveSkin(player, ...)
        end
        return false
    end
end

-- ============================================
-- SALVAR INVENTÁRIO
-- ============================================
function InventoryManager:SavePlayerInventory(player)
    local userId = player.UserId
    if self.playerInventories[userId] then
        local data = self.dataStoreManager:GetPlayerData(player)
        if data then
            data.Inventory.Items = self.playerInventories[userId].Items
            data.Inventory.Skins = self.playerInventories[userId].Skins
            data.Inventory.ActiveSkin = self.playerInventories[userId].ActiveSkin
        end
    end
end

-- ============================================
-- INICIALIZAR
-- ============================================
function InventoryManager:Initialize()
    self:CreateRemoteEvents()
end

return InventoryManager
