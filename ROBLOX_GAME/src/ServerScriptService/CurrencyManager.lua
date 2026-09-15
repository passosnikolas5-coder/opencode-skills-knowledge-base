--[[
    Egg Empire - Currency Manager
    Gerencia moedas, ovos e economia do jogo
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- ============================================
-- CONFIGURAÇÃO
-- ============================================
local EGG_VALUES = {
    White = 1,
    Golden = 10,
    Silver = 50,
    Crystal = 200,
    Fire = 1000
}

local EGG_RARITY = {
    White = 0.50,    -- 50%
    Golden = 0.25,   -- 25%
    Silver = 0.15,   -- 15%
    Crystal = 0.08,  -- 8%
    Fire = 0.02      -- 2%
}

local BONUS_MULTIPLIERS = {
    Default = 1,
    Veteran = 1.10,
    Expert = 1.15,
    Master = 1.25,
    Legend = 1.50
}

-- ============================================
-- MÓDULO CurrencyManager
-- ============================================
local CurrencyManager = {}
CurrencyManager.__index = CurrencyManager

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function CurrencyManager.new(dataStoreManager)
    local self = setmetatable({}, CurrencyManager)
    
    self.dataStoreManager = dataStoreManager
    self.playerCurrencies = {}
    
    -- Conectar eventos
    self:ConnectEvents()
    
    print("[CurrencyManager] Inicializado com sucesso!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function CurrencyManager:ConnectEvents()
    Players.PlayerAdded:Connect(function(player)
        self:InitPlayerCurrency(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:SavePlayerCurrency(player)
    end)
end

-- ============================================
-- INICIALIZAR MOEDAS DO JOGADOR
-- ============================================
function CurrencyManager:InitPlayerCurrency(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    if not data then return end
    
    self.playerCurrencies[player.UserId] = {
        Coins = data.Coins,
        Gems = data.Gems,
        Eggs = data.Eggs
    }
    
    print("[CurrencyManager] Moedas inicializadas para " .. player.Name)
end

-- ============================================
-- OBTER MOEDAS
-- ============================================
function CurrencyManager:GetCoins(player)
    local userId = player.UserId
    if self.playerCurrencies[userId] then
        return self.playerCurrencies[userId].Coins
    end
    return 0
end

function CurrencyManager:GetGems(player)
    local userId = player.UserId
    if self.playerCurrencies[userId] then
        return self.playerCurrencies[userId].Gems
    end
    return 0
end

function CurrencyManager:GetEggs(player)
    local userId = player.UserId
    if self.playerCurrencies[userId] then
        return self.playerCurrencies[userId].Eggs
    end
    return {White = 0, Golden = 0, Silver = 0, Crystal = 0, Fire = 0}
end

-- ============================================
-- ADICIONAR MOEDAS
-- ============================================
function CurrencyManager:AddCoins(player, amount, source)
    if amount <= 0 then return false end
    
    -- Aplicar bônus de ranking
    local data = self.dataStoreManager:GetPlayerData(player)
    local bonus = self:GetBonusMultiplier(data)
    local finalAmount = math.floor(amount * bonus)
    
    -- Adicionar
    self.playerCurrencies[player.UserId].Coins = 
        self.playerCurrencies[player.UserId].Coins + finalAmount
    
    -- Salvar
    data.Coins = self.playerCurrencies[player.UserId].Coins
    
    -- Notificar cliente
    self:NotifyCurrencyChange(player, "Coins", finalAmount, source)
    
    -- Log
    print("[CurrencyManager] " .. player.Name .. " ganhou " .. finalAmount .. 
          " moedas (" .. (source or "unknown") .. ")")
    
    return true
end

function CurrencyManager:AddGems(player, amount, source)
    if amount <= 0 then return false end
    
    self.playerCurrencies[player.UserId].Gems = 
        self.playerCurrencies[player.UserId].Gems + amount
    
    local data = self.dataStoreManager:GetPlayerData(player)
    data.Gems = self.playerCurrencies[player.UserId].Gems
    
    self:NotifyCurrencyChange(player, "Gems", amount, source)
    
    return true
end

function CurrencyManager:AddEgg(player, eggType, amount)
    if not EGG_VALUES[eggType] then return false end
    
    amount = amount or 1
    
    self.playerCurrencies[player.UserId].Eggs[eggType] = 
        self.playerCurrencies[player.UserId].Eggs[eggType] + amount
    
    local data = self.dataStoreManager:GetPlayerData(player)
    data.Eggs[eggType] = self.playerCurrencies[player.UserId].Eggs[eggType]
    data.Stats.TotalEggsCollected = data.Stats.TotalEggsCollected + amount
    
    -- Adicionar XP
    local xpGain = EGG_VALUES[eggType] * amount
    self.dataStoreManager:AddXP(player, xpGain)
    
    -- Notificar cliente
    self:NotifyEggCollected(player, eggType, amount)
    
    return true
end

-- ============================================
-- REMOVER MOEDAS
-- ============================================
function CurrencyManager:RemoveCoins(player, amount, reason)
    if amount <= 0 then return false end
    
    local currentCoins = self:GetCoins(player)
    if currentCoins < amount then
        warn("[CurrencyManager] " .. player.Name .. " não tem moedas suficientes")
        return false
    end
    
    self.playerCurrencies[player.UserId].Coins = currentCoins - amount
    
    local data = self.dataStoreManager:GetPlayerData(player)
    data.Coins = self.playerCurrencies[player.UserId].Coins
    
    self:NotifyCurrencyChange(player, "Coins", -amount, reason)
    
    return true
end

function CurrencyManager:RemoveGems(player, amount, reason)
    if amount <= 0 then return false end
    
    local currentGems = self:GetGems(player)
    if currentGems < amount then
        return false
    end
    
    self.playerCurrencies[player.UserId].Gems = currentGems - amount
    
    local data = self.dataStoreManager:GetPlayerData(player)
    data.Gems = self.playerCurrencies[player.UserId].Gems
    
    self:NotifyCurrencyChange(player, "Gems", -amount, reason)
    
    return true
end

function CurrencyManager:RemoveEgg(player, eggType, amount)
    if not EGG_VALUES[eggType] then return false end
    
    amount = amount or 1
    
    local currentAmount = self:GetEggs(player)[eggType]
    if currentAmount < amount then
        return false
    end
    
    self.playerCurrencies[player.UserId].Eggs[eggType] = currentAmount - amount
    
    local data = self.dataStoreManager:GetPlayerData(player)
    data.Eggs[eggType] = self.playerCurrencies[player.UserId].Eggs[eggType]
    data.Stats.TotalEggsLost = data.Stats.TotalEggsLost + amount
    
    self:NotifyEggRemoved(player, eggType, amount)
    
    return true
end

-- ============================================
-- VENDER OVOS
-- ============================================
function CurrencyManager:SellAllEggs(player)
    local eggs = self:GetEggs(player)
    local totalValue = 0
    
    for eggType, count in pairs(eggs) do
        if count > 0 then
            totalValue = totalValue + (EGG_VALUES[eggType] * count)
            self:RemoveEgg(player, eggType, count)
        end
    end
    
    if totalValue > 0 then
        self:AddCoins(player, totalValue, "SellEggs")
    end
    
    return totalValue
end

function CurrencyManager:SellEggType(player, eggType, amount)
    local eggs = self:GetEggs(player)
    local available = eggs[eggType] or 0
    
    local toSell = math.min(amount, available)
    if toSell <= 0 then return 0 end
    
    local value = EGG_VALUES[eggType] * toSell
    self:RemoveEgg(player, eggType, toSell)
    self:AddCoins(player, value, "SellEgg")
    
    return value
end

-- ============================================
-- OBTER VALOR DOS OVOS
-- ============================================
function CurrencyManager:GetEggValue(eggType)
    return EGG_VALUES[eggType] or 0
end

function CurrencyManager:GetTotalEggValue(player)
    local eggs = self:GetEggs(player)
    local total = 0
    
    for eggType, count in pairs(eggs) do
        total = total + (EGG_VALUES[eggType] * count)
    end
    
    return total
end

-- ============================================
-- RARIDADE ALEATÓRIA
-- ============================================
function CurrencyManager:GetRandomEggType()
    local random = math.random()
    local cumulative = 0
    
    for eggType, rarity in pairs(EGG_RARITY) do
        cumulative = cumulative + rarity
        if random <= cumulative then
            return eggType
        end
    end
    
    return "White" -- Fallback
end

-- ============================================
-- MULTIPLICADOR DE BÔNUS
-- ============================================
function CurrencyManager:GetBonusMultiplier(data)
    if not data then return 1 end
    
    local level = data.Level
    if level >= 50 then
        return BONUS_MULTIPLIERS.Legend
    elseif level >= 20 then
        return BONUS_MULTIPLIERS.Master
    elseif level >= 10 then
        return BONUS_MULTIPLIERS.Expert
    elseif level >= 5 then
        return BONUS_MULTIPLIERS.Veteran
    end
    
    return BONUS_MULTIPLIERS.Default
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function CurrencyManager:NotifyCurrencyChange(player, currencyType, amount, source)
    local event = ReplicatedStorage:FindFirstChild("CurrencyEvents")
    if event then
        local changeEvent = event:FindFirstChild("CurrencyChanged")
        if changeEvent then
            changeEvent:FireClient(player, {
                Type = currencyType,
                Amount = amount,
                Total = currencyType == "Coins" and self:GetCoins(player) or self:GetGems(player),
                Source = source
            })
        end
    end
end

function CurrencyManager:NotifyEggCollected(player, eggType, amount)
    local event = ReplicatedStorage:FindFirstChild("CurrencyEvents")
    if event then
        local eggEvent = event:FindFirstChild("EggCollected")
        if eggEvent then
            eggEvent:FireClient(player, {
                Type = eggType,
                Amount = amount,
                Value = EGG_VALUES[eggType] * amount
            })
        end
    end
end

function CurrencyManager:NotifyEggRemoved(player, eggType, amount)
    local event = ReplicatedStorage:FindFirstChild("CurrencyEvents")
    if event then
        local eggEvent = event:FindFirstChild("EggRemoved")
        if eggEvent then
            eggEvent:FireClient(player, {
                Type = eggType,
                Amount = amount
            })
        end
    end
end

-- ============================================
-- REMOTE EVENTS
-- ============================================
function CurrencyManager:CreateRemoteEvents()
    local eventFolder = Instance.new("Folder")
    eventFolder.Name = "CurrencyEvents"
    eventFolder.Parent = ReplicatedStorage
    
    -- Evento de mudança de moeda
    local currencyChanged = Instance.new("RemoteEvent")
    currencyChanged.Name = "CurrencyChanged"
    currencyChanged.Parent = eventFolder
    
    -- Evento de ovo coletado
    local eggCollected = Instance.new("RemoteEvent")
    eggCollected.Name = "EggCollected"
    eggCollected.Parent = eventFolder
    
    -- Evento de ovo removido
    local eggRemoved = Instance.new("RemoteEvent")
    eggRemoved.Name = "EggRemoved"
    eggRemoved.Parent = eventFolder
    
    -- RemoteFunction para vender ovos
    local sellEggsFunction = Instance.new("RemoteFunction")
    sellEggsFunction.Name = "SellEggs"
    sellEggsFunction.Parent = eventFolder
    
    sellEggsFunction.OnServerInvoke = function(player, action, ...)
        if action == "SellAll" then
            return self:SellAllEggs(player)
        elseif action == "SellType" then
            return self:SellEggType(player, ...)
        end
        return 0
    end
end

-- ============================================
-- SALVAR MOEDAS
-- ============================================
function CurrencyManager:SavePlayerCurrency(player)
    local userId = player.UserId
    if self.playerCurrencies[userId] then
        local data = self.dataStoreManager:GetPlayerData(player)
        if data then
            data.Coins = self.playerCurrencies[userId].Coins
            data.Gems = self.playerCurrencies[userId].Gems
            data.Eggs = self.playerCurrencies[userId].Eggs
        end
    end
end

-- ============================================
-- INICIALIZAR
-- ============================================
function CurrencyManager:Initialize()
    self:CreateRemoteEvents()
end

return CurrencyManager
