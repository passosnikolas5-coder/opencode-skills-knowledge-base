--[[
    Egg Empire - DataStore Manager
    Gerencia persistência de dados do jogador
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- ============================================
-- CONFIGURAÇÃO
-- ============================================
local DATA_STORE_NAME = "EggEmpire_PlayerData_v1"
local AUTO_SAVE_INTERVAL = 300 -- 5 minutos
local MAX_RETRY_ATTEMPTS = 3
local RETRY_DELAY = 2

-- ============================================
-- MÓDULO DataStoreManager
-- ============================================
local DataStoreManager = {}
DataStoreManager.__index = DataStoreManager

-- ============================================
-- ESTRUTURA DE DADOS DO JOGADOR
-- ============================================
local DEFAULT_PLAYER_DATA = {
    -- Moedas
    Coins = 0,
    Gems = 0,
    
    -- Ovos
    Eggs = {
        White = 0,
        Golden = 0,
        Silver = 0,
        Crystal = 0,
        Fire = 0
    },
    
    -- Inventário
    Inventory = {
        Items = {},
        Skins = {"Default"},
        PowerUps = {}
    },
    
    -- Progressão
    Level = 1,
    XP = 0,
    TotalXP = 0,
    
    -- Base
    Base = {
        Level = 1,
        Pieces = {},
        Layout = {}
    },
    
    -- Estatísticas
    Stats = {
        TotalEggsCollected = 0,
        TotalEggsStolen = 0,
        TotalEggsLost = 0,
        TotalBasesRobbed = 0,
        TotalBasesDefended = 0,
        TotalPlayTime = 0,
        TotalMatches = 0,
        Wins = 0,
        Losses = 0,
        KillCount = 0,
        DeathCount = 0,
        HighestStreak = 0
    },
    
    -- Configurações
    Settings = {
        MusicVolume = 0.5,
        SFXVolume = 0.7,
        GraphicsQuality = "Medium",
        AutoCollect = false,
        ShowMinimap = true,
        ShowDamageNumbers = true
    },
    
    -- Meta
    CreatedAt = 0,
    LastPlayed = 0,
    LastSave = 0,
    Version = 1
}

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function DataStoreManager.new()
    local self = setmetatable({}, DataStoreManager)
    
    self.dataStore = DataStoreService:GetDataStore(DATA_STORE_NAME)
    self.playerData = {}
    self.isSaving = {}
    self.isLoaded = {}
    
    -- Conectar eventos
    self:ConnectEvents()
    
    -- Iniciar auto-save
    self:StartAutoSave()
    
    print("[DataStoreManager] Inicializado com sucesso!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function DataStoreManager:ConnectEvents()
    -- Quando jogador entra
    Players.PlayerAdded:Connect(function(player)
        self:LoadPlayerData(player)
    end)
    
    -- Quando jogador sai
    Players.PlayerRemoving:Connect(function(player)
        self:SavePlayerData(player)
    end)
    
    -- Quando jogo fecha
    game:BindToClose(function()
        for _, player in pairs(Players:GetPlayers()) do
            self:SavePlayerData(player)
        end
    end)
end

-- ============================================
-- CARREGAR DADOS
-- ============================================
function DataStoreManager:LoadPlayerData(player)
    local userId = player.UserId
    local key = "Player_" .. userId
    
    -- Marcar como carregando
    self.isLoaded[userId] = false
    
    -- Tentar carregar dados
    local success, data = pcall(function()
        return self.dataStore:GetAsync(key)
    end)
    
    if success and data then
        -- Dados encontrados, mesclar com padrões
        self.playerData[userId] = self:MergeData(DEFAULT_PLAYER_DATA, data)
        print("[DataStoreManager] Dados carregados para " .. player.Name)
    else
        -- Novo jogador, usar dados padrão
        self.playerData[userId] = self:DeepCopy(DEFAULT_PLAYER_DATA)
        self.playerData[userId].CreatedAt = os.time()
        print("[DataStoreManager] Novo jogador: " .. player.Name)
    end
    
    -- Atualizar último login
    self.playerData[userId].LastPlayed = os.time()
    
    -- Marcar como carregado
    self.isLoaded[userId] = true
    
    -- Criar RemoteEvents para comunicação
    self:CreateRemoteEvents(player)
    
    -- Enviar dados iniciais
    self:SendDataToClient(player)
    
    return self.playerData[userId]
end

-- ============================================
-- SALVAR DADOS
-- ============================================
function DataStoreManager:SavePlayerData(player)
    local userId = player.UserId
    
    -- Verificar se já está salvando
    if self.isSaving[userId] then
        return false
    end
    
    -- Verificar se dados existem
    if not self.playerData[userId] then
        return false
    end
    
    -- Marcar como salvando
    self.isSaving[userId] = true
    
    -- Atualizar timestamp
    self.playerData[userId].LastSave = os.time()
    
    -- Tentar salvar com retry
    local key = "Player_" .. userId
    local success = false
    local attempts = 0
    
    while not success and attempts < MAX_RETRY_ATTEMPTS do
        attempts = attempts + 1
        
        success = pcall(function()
            self.dataStore:SetAsync(key, self.playerData[userId])
        end)
        
        if not success then
            warn("[DataStoreManager] Tentativa " .. attempts .. " falhou para " .. player.Name)
            wait(RETRY_DELAY)
        end
    end
    
    if success then
        print("[DataStoreManager] Dados salvos para " .. player.Name)
    else
        warn("[DataStoreManager] FALHA ao salvar dados para " .. player.Name)
    end
    
    -- Marcar como não salvando
    self.isSaving[userId] = false
    
    return success
end

-- ============================================
-- AUTO SAVE
-- ============================================
function DataStoreManager:StartAutoSave()
    spawn(function()
        while true do
            wait(AUTO_SAVE_INTERVAL)
            
            for _, player in pairs(Players:GetPlayers()) do
                spawn(function()
                    self:SavePlayerData(player)
                end)
            end
            
            print("[DataStoreManager] Auto-save concluído")
        end
    end)
end

-- ============================================
-- OBTER DADOS DO JOGADOR
-- ============================================
function DataStoreManager:GetPlayerData(player)
    local userId = player.UserId
    
    if not self.isLoaded[userId] then
        warn("[DataStoreManager] Dados ainda não carregados para " .. player.Name)
        return nil
    end
    
    return self.playerData[userId]
end

-- ============================================
-- MODIFICAR DADOS
-- ============================================
function DataStoreManager:AddCoins(player, amount)
    local data = self:GetPlayerData(player)
    if data then
        data.Coins = data.Coins + amount
        self:SendDataToClient(player)
        return true
    end
    return false
end

function DataStoreManager:RemoveCoins(player, amount)
    local data = self:GetPlayerData(player)
    if data and data.Coins >= amount then
        data.Coins = data.Coins - amount
        self:SendDataToClient(player)
        return true
    end
    return false
end

function DataStoreManager:AddEgg(player, eggType, amount)
    local data = self:GetPlayerData(player)
    if data and data.Eggs[eggType] then
        data.Eggs[eggType] = data.Eggs[eggType] + (amount or 1)
        data.Stats.TotalEggsCollected = data.Stats.TotalEggsCollected + (amount or 1)
        self:SendDataToClient(player)
        return true
    end
    return false
end

function DataStoreManager:RemoveEgg(player, eggType, amount)
    local data = self:GetPlayerData(player)
    if data and data.Eggs[eggType] and data.Eggs[eggType] >= (amount or 1) then
        data.Eggs[eggType] = data.Eggs[eggType] - (amount or 1)
        data.Stats.TotalEggsLost = data.Stats.TotalEggsLost + (amount or 1)
        self:SendDataToClient(player)
        return true
    end
    return false
end

function DataStoreManager:AddXP(player, amount)
    local data = self:GetPlayerData(player)
    if data then
        data.XP = data.XP + amount
        data.TotalXP = data.TotalXP + amount
        
        -- Verificar level up
        self:CheckLevelUp(player)
        
        self:SendDataToClient(player)
        return true
    end
    return false
end

function DataStoreManager:CheckLevelUp(player)
    local data = self:GetPlayerData(player)
    if not data then return end
    
    local xpNeeded = self:GetXPForLevel(data.Level + 1)
    
    while data.XP >= xpNeeded do
        data.XP = data.XP - xpNeeded
        data.Level = data.Level + 1
        xpNeeded = self:GetXPForLevel(data.Level + 1)
        
        -- Notificar level up
        self:NotifyLevelUp(player, data.Level)
        
        print("[DataStoreManager] " .. player.Name .. " subiu para nível " .. data.Level)
    end
end

function DataStoreManager:GetXPForLevel(level)
    -- Fórmula exponencial: 100 * (1.5 ^ (level - 1))
    return math.floor(100 * (1.5 ^ (level - 1)))
end

function DataStoreManager:NotifyLevelUp(player, newLevel)
    -- Criar evento para notificar o cliente
    local levelUpEvent = ReplicatedStorage:FindFirstChild("LevelUpEvent")
    if levelUpEvent then
        levelUpEvent:FireClient(player, newLevel)
    end
end

-- ============================================
-- REMOTE EVENTS
-- ============================================
function DataStoreManager:CreateRemoteEvents(player)
    -- Verificar se já existem
    if ReplicatedStorage:FindFirstChild("DataStoreRemote") then
        return
    end
    
    -- Criar pasta de RemoteEvents
    local remoteFolder = Instance.new("Folder")
    remoteFolder.Name = "DataStoreRemote"
    remoteFolder.Parent = ReplicatedStorage
    
    -- RemoteEvent para dados iniciais
    local sendDataEvent = Instance.new("RemoteEvent")
    sendDataEvent.Name = "SendPlayerData"
    sendDataEvent.Parent = remoteFolder
    
    -- RemoteEvent para solicitar dados
    local requestDataEvent = Instance.new("RemoteEvent")
    requestDataEvent.Name = "RequestPlayerData"
    requestDataEvent.Parent = remoteFolder
    
    -- RemoteFunction para modificar dados
    local modifyDataFunction = Instance.new("RemoteFunction")
    modifyDataFunction.Name = "ModifyPlayerData"
    modifyDataFunction.Parent = remoteFolder
    
    -- RemoteEvent para level up
    local levelUpEvent = Instance.new("RemoteEvent")
    levelUpEvent.Name = "LevelUpEvent"
    levelUpEvent.Parent = ReplicatedStorage
    
    -- Conectar evento de solicitação
    requestDataEvent.OnServerEvent:Connect(function(player)
        self:SendDataToClient(player)
    end)
    
    -- Conectar função de modificação
    modifyDataFunction.OnServerInvoke = function(player, action, ...)
        return self:HandleDataModification(player, action, ...)
    end
end

-- ============================================
-- ENVIAR DADOS AO CLIENTE
-- ============================================
function DataStoreManager:SendDataToClient(player)
    local data = self:GetPlayerData(player)
    if not data then return end
    
    local sendDataEvent = ReplicatedStorage:FindFirstChild("DataStoreRemote")
    if sendDataEvent then
        local sendEvent = sendDataEvent:FindFirstChild("SendPlayerData")
        if sendEvent then
            sendEvent:FireClient(player, data)
        end
    end
end

-- ============================================
-- MODIFICAÇÃO DE DADOS
-- ============================================
function DataStoreManager:HandleDataModification(player, action, ...)
    local args = {...}
    
    if action == "AddCoins" then
        return self:AddCoins(player, args[1])
    elseif action == "RemoveCoins" then
        return self:RemoveCoins(player, args[1])
    elseif action == "AddEgg" then
        return self:AddEgg(player, args[1], args[2])
    elseif action == "RemoveEgg" then
        return self:RemoveEgg(player, args[1], args[2])
    elseif action == "AddXP" then
        return self:AddXP(player, args[1])
    elseif action == "UpdateSettings" then
        local data = self:GetPlayerData(player)
        if data then
            data.Settings[args[1]] = args[2]
            self:SendDataToClient(player)
            return true
        end
    end
    
    return false
end

-- ============================================
-- UTILITÁRIOS
-- ============================================
function DataStoreManager:DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = self:DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function DataStoreManager:MergeData(default, saved)
    local result = self:DeepCopy(default)
    
    for k, v in pairs(saved) do
        if type(v) == "table" and type(result[k]) == "table" then
            result[k] = self:MergeData(result[k], v)
        else
            result[k] = v
        end
    end
    
    return result
end

-- ============================================
-- INICIALIZAR
-- ============================================
local instance = DataStoreManager.new()

return instance
