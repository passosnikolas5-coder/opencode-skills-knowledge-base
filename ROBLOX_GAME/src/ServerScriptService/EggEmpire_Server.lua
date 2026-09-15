--[[
    Egg Empire - Main Server Script
    Script principal que orquestra todos os sistemas
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

-- ============================================
-- IMPORTAR MÓDULOS
-- ============================================
local DataStoreManager = require(script.Parent.DataStoreManager)
local CurrencyManager = require(script.Parent.CurrencyManager)
local InventoryManager = require(script.Parent.InventoryManager)
local CombatSystem = require(script.Parent.CombatSystem)
local BaseBuildingSystem = require(script.Parent.BaseBuildingSystem)

-- ============================================
-- MÓDULO principal
-- ============================================
local EggEmpire = {}
EggEmpire.__index = EggEmpire

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function EggEmpire.new()
    local self = setmetatable({}, EggEmpire)
    
    -- Inicializar sistemas
    self.dataStoreManager = DataStoreManager
    self.currencyManager = CurrencyManager.new(self.dataStoreManager)
    self.inventoryManager = InventoryManager.new(self.dataStoreManager, self.currencyManager)
    self.combatSystem = CombatSystem.new(self.dataStoreManager, self.currencyManager)
    self.baseBuildingSystem = BaseBuildingSystem.new(self.dataStoreManager, self.currencyManager)
    
    -- Inicializar sistemas que precisam de inicialização
    self.currencyManager:Initialize()
    self.inventoryManager:Initialize()
    self.combatSystem:Initialize()
    self.baseBuildingSystem:Initialize()
    
    -- Conectar eventos
    self:ConnectEvents()
    
    -- Criar RemoteEvents globais
    self:CreateGlobalRemoteEvents()
    
    -- Iniciar loop do jogo
    self:StartGameLoop()
    
    print("[EggEmpire] ========================================")
    print("[EggEmpire]      EGG EMPIRE INICIALIZADO!        ")
    print("[EggEmpire] ========================================")
    
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function EggEmpire:ConnectEvents()
    -- Quando jogador entra
    Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)
    
    -- Quando jogador sai
    Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoving(player)
    end)
    
    -- Quando jogo fecha
    game:BindToClose(function()
        self:OnGameClose()
    end)
    
    print("[EggEmpire] Eventos conectados!")
end

-- ============================================
-- JOGADOR ENTROU
-- ============================================
function EggEmpire:OnPlayerAdded(player)
    print("[EggEmpire] " .. player.Name .. " entrou no jogo!")
    
    -- Criar character
    player:LoadCharacter()
    
    -- Notificar outros jogadores
    self:NotifyPlayerJoined(player)
    
    -- Iniciar missões diárias
    self:InitDailyMissions(player)
    
    -- Dar bônus de boas-vindas para novos jogadores
    local data = self.dataStoreManager:GetPlayerData(player)
    if data and data.CreatedAt == 0 then
        self:GiveWelcomeBonus(player)
    end
end

-- ============================================
-- JOGADOR SAIU
-- ============================================
function EggEmpire:OnPlayerRemoving(player)
    print("[EggEmpire] " .. player.Name .. " saiu do jogo!")
    
    -- Salvar dados
    self.dataStoreManager:SavePlayerData(player)
    self.currencyManager:SavePlayerCurrency(player)
    self.inventoryManager:SavePlayerInventory(player)
    self.baseBuildingSystem:SavePlayerBase(player)
    
    -- Notificar outros jogadores
    self:NotifyPlayerLeft(player)
    
    -- Limpar base
    self.baseBuildingSystem:ClearBase(player)
end

-- ============================================
-- JOGO FECHANDO
-- ============================================
function EggEmpire:OnGameClose()
    print("[EggEmpire] Jogo fechando, salvando todos os jogadores...")
    
    for _, player in pairs(Players:GetPlayers()) do
        self.dataStoreManager:SavePlayerData(player)
        self.currencyManager:SavePlayerCurrency(player)
        self.inventoryManager:SavePlayerInventory(player)
        self.baseBuildingSystem:SavePlayerBase(player)
    end
    
    print("[EggEmpire] Todos os dados salvos!")
end

-- ============================================
-- BÔNUS DE BOAS-VINDAS
-- ============================================
function EggEmpire:GiveWelcomeBonus(player)
    -- Dar moedas iniciais
    self.currencyManager:AddCoins(player, 500, "WelcomeBonus")
    
    -- Dar itens iniciais
    self.inventoryManager:AddItem(player, "SpeedPotion", 3)
    self.inventoryManager:AddItem(player, "ShieldPotion", 2)
    self.inventoryManager:AddItem(player, "SpikeTrap", 3)
    
    -- Notificar
    self:NotifyWelcomeBonus(player)
    
    print("[EggEmpire] Bônus de boas-vindas dado para " .. player.Name)
end

-- ============================================
-- MISSÕES DIÁRIAS
-- ============================================
function EggEmpire:InitDailyMissions(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    if not data then return end
    
    -- Verificar se já tem missões de hoje
    local lastMissionDay = data.LastMissionDay or 0
    local today = math.floor(os.time() / 86400)
    
    if lastMissionDay < today then
        -- Criar novas missões diárias
        data.DailyMissions = self:GenerateDailyMissions()
        data.LastMissionDay = today
        
        -- Notificar
        self:NotifyNewMissions(player)
    end
end

function EggEmpire:GenerateDailyMissions()
    local missions = {
        {
            Id = "CollectEggs",
            Description = "Coletar 50 ovos",
            Target = 50,
            Progress = 0,
            Reward = {Coins = 200, XP = 100}
        },
        {
            Id = "StealEggs",
            Description = "Roubar 10 ovos de outros jogadores",
            Target = 10,
            Progress = 0,
            Reward = {Coins = 300, XP = 150}
        },
        {
            Id = "BuildBase",
            Description = "Construir 5 peças na base",
            Target = 5,
            Progress = 0,
            Reward = {Coins = 150, XP = 75}
        },
        {
            Id = "WinMatches",
            Description = "Vencer 3 partidas",
            Target = 3,
            Progress = 0,
            Reward = {Coins = 500, XP = 250}
        }
    }
    
    return missions
end

-- ============================================
-- LOOP DO JOGO
-- ============================================
function EggEmpire:StartGameLoop()
    spawn(function()
        while true do
            wait(60) -- A cada minuto
            
            -- Atualizar rankings
            self:UpdateRankings()
            
            -- Verificar eventos globais
            self:CheckGlobalEvents()
            
            -- Atualizar estatísticas
            self:UpdateStats()
        end
    end)
end

-- ============================================
-- RANKINGS
-- ============================================
function EggEmpire:UpdateRankings()
    local rankings = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        local data = self.dataStoreManager:GetPlayerData(player)
        if data then
            table.insert(rankings, {
                Player = player.Name,
                Level = data.Level,
                Coins = data.Coins,
                TotalEggs = data.Stats.TotalEggsCollected
            })
        end
    end
    
    -- Ordenar por nível
    table.sort(rankings, function(a, b)
        return a.Level > b.Level
    end)
    
    -- Notificar clientes
    for _, player in pairs(Players:GetPlayers()) do
        self:NotifyRankingUpdate(player, rankings)
    end
end

-- ============================================
-- EVENTOS GLOBAIS
-- ============================================
function EggEmpire:CheckGlobalEvents()
    local hour = os.date("*t").hour
    
    -- Evento de ovos de Páscoa (Domingo 14h-16h)
    if os.date("*t").wday == 1 and hour >= 14 and hour < 16 then
        if not self.activeEvent then
            self:StartGlobalEvent("EasterEggs", "Ovos de Páscoa", 5)
        end
    end
    
    -- Evento de noite de roubo (Segunda 19h-22h)
    if os.date("*t").wday == 2 and hour >= 19 and hour < 22 then
        if not self.activeEvent then
            self:StartGlobalEvent("RobberyNight", "Noite de Roubo", 3)
        end
    end
    
    -- Verificar se evento acabou
    if self.activeEvent and self.activeEvent.EndTime < os.time() then
        self:EndGlobalEvent()
    end
end

function EggEmpire:StartGlobalEvent(eventId, eventName, multiplier)
    self.activeEvent = {
        Id = eventId,
        Name = eventName,
        Multiplier = multiplier,
        StartTime = os.time(),
        EndTime = os.time() + 7200 -- 2 horas
    }
    
    -- Notificar todos os jogadores
    for _, player in pairs(Players:GetPlayers()) do
        self:NotifyGlobalEventStarted(player, self.activeEvent)
    end
    
    print("[EggEmpire] Evento global iniciado: " .. eventName)
end

function EggEmpire:EndGlobalEvent()
    -- Notificar todos os jogadores
    for _, player in pairs(Players:GetPlayers()) do
        self:NotifyGlobalEventEnded(player, self.activeEvent)
    end
    
    print("[EggEmpire] Evento global encerrado: " .. self.activeEvent.Name)
    self.activeEvent = nil
end

-- ============================================
-- ESTATÍSTICAS
-- ============================================
function EggEmpire:UpdateStats()
    local stats = {
        PlayersOnline = #Players:GetPlayers(),
        TotalPlayers = 0,
        ActiveBases = 0
    }
    
    -- Contar jogadores
    for _ in pairs(Players:GetPlayers()) do
        stats.TotalPlayers = stats.TotalPlayers + 1
    end
    
    -- Contar bases ativas
    for _, player in pairs(Players:GetPlayers()) do
        if self.baseBuildingSystem.playerBases[player.UserId] then
            stats.ActiveBases = stats.ActiveBases + 1
        end
    end
    
    -- Notificar clientes
    for _, player in pairs(Players:GetPlayers()) do
        self:NotifyStatsUpdate(player, stats)
    end
end

-- ============================================
-- REMOTE EVENTS GLOBAIS
-- ============================================
function EggEmpire:CreateGlobalRemoteEvents()
    local eventFolder = Instance.new("Folder")
    eventFolder.Name = "GameEvents"
    eventFolder.Parent = ReplicatedStorage
    
    -- Eventos
    local events = {
        "PlayerJoined",
        "PlayerLeft",
        "WelcomeBonus",
        "NewMissions",
        "RankingUpdate",
        "GlobalEventStarted",
        "GlobalEventEnded",
        "StatsUpdate",
        "Notification"
    }
    
    for _, eventName in pairs(events) do
        local event = Instance.new("RemoteEvent")
        event.Name = eventName
        event.Parent = eventFolder
    end
    
    -- RemoteFunction para informações do jogo
    local gameInfoFunction = Instance.new("RemoteFunction")
    gameInfoFunction.Name = "GetGameInfo"
    gameInfoFunction.Parent = eventFolder
    
    gameInfoFunction.OnServerInvoke = function(player)
        return self:GetGameInfo(player)
    end
end

-- ============================================
-- OBTER INFORMAÇÕES DO JOGO
-- ============================================
function EggEmpire:GetGameInfo(player)
    local data = self.dataStoreManager:GetPlayerData(player)
    
    return {
        PlayerData = data,
        ActiveEvent = self.activeEvent,
        PlayersOnline = #Players:GetPlayers(),
        ServerTime = os.time()
    }
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function EggEmpire:NotifyPlayerJoined(player)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local joinEvent = event:FindFirstChild("PlayerJoined")
        if joinEvent then
            joinEvent:FireAllClients({
                PlayerName = player.Name,
                PlayerId = player.UserId
            })
        end
    end
end

function EggEmpire:NotifyPlayerLeft(player)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local leaveEvent = event:FindFirstChild("PlayerLeft")
        if leaveEvent then
            leaveEvent:FireAllClients({
                PlayerName = player.Name,
                PlayerId = player.UserId
            })
        end
    end
end

function EggEmpire:NotifyWelcomeBonus(player)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local bonusEvent = event:FindFirstChild("WelcomeBonus")
        if bonusEvent then
            bonusEvent:FireClient(player, {
                Coins = 500,
                Items = {"SpeedPotion x3", "ShieldPotion x2", "SpikeTrap x3"}
            })
        end
    end
end

function EggEmpire:NotifyNewMissions(player)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local missionEvent = event:FindFirstChild("NewMissions")
        if missionEvent then
            missionEvent:FireClient(player, {
                Missions = self.dataStoreManager:GetPlayerData(player).DailyMissions
            })
        end
    end
end

function EggEmpire:NotifyRankingUpdate(player, rankings)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local rankingEvent = event:FindFirstChild("RankingUpdate")
        if rankingEvent then
            rankingEvent:FireClient(player, {
                Rankings = rankings
            })
        end
    end
end

function EggEmpire:NotifyGlobalEventStarted(player, eventData)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local startEvent = event:FindFirstChild("GlobalEventStarted")
        if startEvent then
            startEvent:FireClient(player, eventData)
        end
    end
end

function EggEmpire:NotifyGlobalEventEnded(player, eventData)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local endEvent = event:FindFirstChild("GlobalEventEnded")
        if endEvent then
            endEvent:FireClient(player, eventData)
        end
    end
end

function EggEmpire:NotifyStatsUpdate(player, stats)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local statsEvent = event:FindFirstChild("StatsUpdate")
        if statsEvent then
            statsEvent:FireClient(player, stats)
        end
    end
end

function EggEmpire:NotifyGlobalMessage(message, data)
    local event = ReplicatedStorage:FindFirstChild("GameEvents")
    if event then
        local notifEvent = event:FindFirstChild("Notification")
        if notifEvent then
            notifEvent:FireAllClients({
                Message = message,
                Data = data
            })
        end
    end
end

-- ============================================
-- SISTEMA DE EVENTOS GLOBAIS (NÃO USADO)
-- ============================================
function EggEmpire:StartGlobalEvent(eventType, duration)
    self.activeEvent = {
        Type = eventType,
        StartTime = os.time(),
        EndTime = os.time() + duration,
        Multiplier = self:GetEventMultiplier(eventType)
    }
    
    -- Notificar jogadores
    self:NotifyGlobalMessage("Evento Global Iniciado: " .. eventType, self.activeEvent)
end

function EggEmpire:GetEventMultiplier(eventType)
    local multipliers = {
        EasterEggs = 5,
        RobberyNight = 3,
        BuildingFrenzy = 2,
        BattleRoyale = 4
    }
    return multipliers[eventType] or 1
end

-- ============================================
-- UTILIDADES
-- ============================================
function EggEmpire:GetPlayerManager()
    return self.dataStoreManager
end

function EggEmpire:GetCurrencyManager()
    return self.currencyManager
end

function EggEmpire:GetInventoryManager()
    return self.inventoryManager
end

function EggEmpire:GetCombatSystem()
    return self.combatSystem
end

function EggEmpire:GetBaseBuildingSystem()
    return self.baseBuildingSystem
end

-- ============================================
-- INICIALIZAR O JOGO
-- ============================================
local gameInstance = EggEmpire.new()

-- Exportar para outros scripts
return gameInstance
