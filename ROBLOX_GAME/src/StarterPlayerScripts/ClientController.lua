--[[
    Egg Empire - Client Controller
    Script principal do cliente
    Autor: Egg Empire Team
    Versão: 1.0
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- ============================================
-- MÓDULO ClientController
-- ============================================
local ClientController = {}
ClientController.__index = ClientController

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
function ClientController.new()
    local self = setmetatable({}, ClientController)
    
    -- Dados do jogador
    self.playerData = nil
    self.currencyData = {
        Coins = 0,
        Gems = 0
    }
    
    -- Estado do jogo
    self.gameState = {
        IsPlaying = false,
        IsInMenu = true,
        CurrentScreen = "MainMenu"
    }
    
    -- Conectar eventos
    self:ConnectEvents()
    
    -- Inicializar UI
    self:InitUI()
    
    print("[ClientController] Inicializado!")
    return self
end

-- ============================================
-- EVENTOS
-- ============================================
function ClientController:ConnectEvents()
    -- Receber dados do servidor
    self:ConnectServerEvents()
    
    -- Input do jogador
    self:ConnectInputEvents()
    
    -- RunService para atualizações
    RunService.Heartbeat:Connect(function()
        self:OnUpdate()
    end)
end

-- ============================================
-- EVENTOS DO SERVIDOR
-- ============================================
function ClientController:ConnectServerEvents()
    -- Esperar RemoteEvents
    local gameEvents = ReplicatedStorage:WaitForChild("GameEvents", 10)
    local dataStoreRemote = ReplicatedStorage:WaitForChild("DataStoreRemote", 10)
    local currencyEvents = ReplicatedStorage:WaitForChild("CurrencyEvents", 10)
    local inventoryEvents = ReplicatedStorage:WaitForChild("InventoryEvents", 10)
    local combatEvents = ReplicatedStorage:WaitForChild("CombatEvents", 10)
    local baseEvents = ReplicatedStorage:WaitForChild("BaseEvents", 10)
    
    if gameEvents then
        -- Dados iniciais
        local sendData = dataStoreRemote:FindFirstChild("SendPlayerData")
        if sendData then
            sendData.OnClientEvent:Connect(function(data)
                self:OnPlayerDataReceived(data)
            end)
        end
        
        -- Bônus de boas-vindas
        local welcomeBonus = gameEvents:FindFirstChild("WelcomeBonus")
        if welcomeBonus then
            welcomeBonus.OnClientEvent:Connect(function(data)
                self:OnWelcomeBonus(data)
            end)
        end
        
        -- Missões diárias
        local newMissions = gameEvents:FindFirstChild("NewMissions")
        if newMissions then
            newMissions.OnClientEvent:Connect(function(data)
                self:OnNewMissions(data)
            end)
        end
        
        -- Ranking
        local rankingUpdate = gameEvents:FindFirstChild("RankingUpdate")
        if rankingUpdate then
            rankingUpdate.OnClientEvent:Connect(function(data)
                self:OnRankingUpdate(data)
            end)
        end
        
        -- Evento global
        local globalEvent = gameEvents:FindFirstChild("GlobalEventStarted")
        if globalEvent then
            globalEvent.OnClientEvent:Connect(function(data)
                self:OnGlobalEventStarted(data)
            end)
        end
        
        -- Stats
        local statsUpdate = gameEvents:FindFirstChild("StatsUpdate")
        if statsUpdate then
            statsUpdate.OnClientEvent:Connect(function(data)
                self:OnStatsUpdate(data)
            end)
        end
        
        -- Notificações
        local notification = gameEvents:FindFirstChild("Notification")
        if notification then
            notification.OnClientEvent:Connect(function(data)
                self:OnNotification(data)
            end)
        end
    end
    
    if currencyEvents then
        -- Mudança de moeda
        local currencyChanged = currencyEvents:FindFirstChild("CurrencyChanged")
        if currencyChanged then
            currencyChanged.OnClientEvent:Connect(function(data)
                self:OnCurrencyChanged(data)
            end)
        end
        
        -- Ovo coletado
        local eggCollected = currencyEvents:FindFirstChild("EggCollected")
        if eggCollected then
            eggCollected.OnClientEvent:Connect(function(data)
                self:OnEggCollected(data)
            end)
        end
    end
    
    if combatEvents then
        -- Ataque
        local playerAttacked = combatEvents:FindFirstChild("PlayerAttacked")
        if playerAttacked then
            playerAttacked.OnClientEvent:Connect(function(data)
                self:OnPlayerAttacked(data)
            end)
        end
        
        -- Kill
        local playerKilled = combatEvents:FindFirstChild("PlayerKilled")
        if playerKilled then
            playerKilled.OnClientEvent:Connect(function(data)
                self:OnPlayerKilled(data)
            end)
        end
        
        -- Power-up
        local powerUpActivated = combatEvents:FindFirstChild("PowerUpActivated")
        if powerUpActivated then
            powerUpActivated.OnClientEvent:Connect(function(data)
                self:OnPowerUpActivated(data)
            end)
        end
    end
    
    if baseEvents then
        -- Peça adicionada
        local pieceAdded = baseEvents:FindFirstChild("PieceAdded")
        if pieceAdded then
            pieceAdded.OnClientEvent:Connect(function(data)
                self:OnPieceAdded(data)
            end)
        end
        
        -- Base upgradada
        local baseUpgraded = baseEvents:FindFirstChild("BaseUpgraded")
        if baseUpgraded then
            baseUpgraded.OnClientEvent:Connect(function(data)
                self:OnBaseUpgraded(data)
            end)
        end
        
        -- Intruso detectado
        local intruderDetected = baseEvents:FindFirstChild("IntruderDetected")
        if intruderDetected then
            intruderDetected.OnClientEvent:Connect(function(data)
                self:OnIntruderDetected(data)
            end)
        end
    end
end

-- ============================================
-- EVENTOS DE INPUT
-- ============================================
function ClientController:ConnectInputEvents()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Teclas de habilidade
        if input.KeyCode == Enum.KeyCode.One then
            self:UseAbility("Attack")
        elseif input.KeyCode == Enum.KeyCode.Two then
            self:UseAbility("Dash")
        elseif input.KeyCode == Enum.KeyCode.Three then
            self:UseAbility("Shield")
        elseif input.KeyCode == Enum.KeyCode.Four then
            self:UseAbility("Bomb")
        elseif input.KeyCode == Enum.KeyCode.Five then
            self:UseAbility("Stealth")
        end
        
        -- Teclas de ação
        if input.KeyCode == Enum.KeyCode.E then
            self:Interact()
        elseif input.KeyCode == Enum.KeyCode.B then
            self:ToggleBuildMode()
        elseif input.KeyCode == Enum.KeyCode.Tab then
            self:ToggleInventory()
        elseif input.KeyCode == Enum.KeyCode.M then
            self:ToggleMinimap()
        end
        
        -- Escape para menu
        if input.KeyCode == Enum.KeyCode.Escape then
            self:TogglePauseMenu()
        end
    end)
end

-- ============================================
-- ATUALIZAÇÃO
-- ============================================
function ClientController:OnUpdate()
    -- Atualizar HUD
    self:UpdateHUD()
    
    -- Atualizar minimapa
    self:UpdateMinimap()
end

-- ============================================
-- CALLBACKS DO SERVIDOR
-- ============================================
function ClientController:OnPlayerDataReceived(data)
    self.playerData = data
    self.currencyData.Coins = data.Coins
    self.currencyData.Gems = data.Gems
    
    print("[ClientController] Dados recebidos!")
    self:UpdateHUD()
end

function ClientController:OnWelcomeBonus(data)
    -- Mostrar notificação de bônus
    self:ShowNotification("Bônus de Boas-Vindas!", 
        "Você recebeu " .. data.Coins .. " moedas e itens especiais!")
end

function ClientController:OnNewMissions(data)
    -- Atualizar missões na UI
    self:UpdateMissionsUI(data.Missions)
end

function ClientController:OnRankingUpdate(data)
    -- Atualizar ranking na UI
    self:UpdateRankingUI(data.Rankings)
end

function ClientController:OnGlobalEventStarted(data)
    -- Mostrar banner de evento
    self:ShowEventBanner(data)
end

function ClientController:OnStatsUpdate(data)
    -- Atualizar stats na UI
    self:UpdateStatsUI(data)
end

function ClientController:OnNotification(data)
    -- Mostrar notificação
    self:ShowNotification("Aviso", data.Message)
end

function ClientController:OnCurrencyChanged(data)
    -- Atualizar moedas
    if data.Type == "Coins" then
        self.currencyData.Coins = data.Total
    elseif data.Type == "Gems" then
        self.currencyData.Gems = data.Total
    end
    
    -- Mostrar notificação
    local prefix = data.Amount > 0 and "+" or ""
    self:ShowCurrencyChange(data.Type, prefix .. data.Amount)
    
    -- Atualizar HUD
    self:UpdateHUD()
end

function ClientController:OnEggCollected(data)
    -- Mostrar coleta de ovo
    self:ShowEggCollected(data.Type, data.Value)
end

function ClientController:OnPlayerAttacked(data)
    -- Mostrar indicador de ataque
    self:ShowAttackIndicator(data.Attacker, data.Damage)
end

function ClientController:OnPlayerKilled(data)
    -- Mostrar notificação de kill
    self:ShowKillFeed(data.Killer, data.Victim)
end

function ClientController:OnPowerUpActivated(data)
    -- Mostrar power-up ativo
    self:ShowPowerUpActive(data.Type)
end

function ClientController:OnPieceAdded(data)
    -- Mostrar peça construída
    self:ShowBuildNotification(data.PieceType)
end

function ClientController:OnBaseUpgraded(data)
    -- Mostrar upgrade
    self:ShowNotification("Base Upgradada!", 
        "Sua base agora é nível " .. data.NewLevel .. "!")
end

function ClientController:OnIntruderDetected(data)
    -- Mostrar alerta
    self:ShowAlert("INTRUSO DETECTADO!", data.Intruder .. " está na sua base!")
end

-- ============================================
-- AÇÕES DO JOGADOR
-- ============================================
function ClientController:UseAbility(abilityName)
    local combatFunction = ReplicatedStorage:FindFirstChild("CombatEvents")
    if combatFunction then
        local func = combatFunction:FindFirstChild("CombatAction")
        if func then
            func:InvokeServer(abilityName)
        end
    end
end

function ClientController:Interact()
    -- Interagir com objeto mais próximo
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Raycast para encontrar interação
            local ray = workspace:Raycast(rootPart.Position, rootPart.CFrame.LookVector * 10)
            if ray then
                local hit = ray.Instance
                -- Processar interação
                print("[ClientController] Interagindo com: " .. hit.Name)
            end
        end
    end
end

function ClientController:ToggleBuildMode()
    self.gameState.IsBuilding = not self.gameState.IsBuilding
    
    if self.gameState.IsBuilding then
        self:ShowBuildMenu()
    else
        self:HideBuildMenu()
    end
end

function ClientController:ToggleInventory()
    -- Toggle inventário na UI
    print("[ClientController] Toggle inventário")
end

function ClientController:ToggleMinimap()
    -- Toggle minimapa
    print("[ClientController] Toggle minimapa")
end

function ClientController:TogglePauseMenu()
    -- Toggle menu de pausa
    print("[ClientController] Toggle menu de pausa")
end

-- ============================================
-- UI
-- ============================================
function ClientController:InitUI()
    -- Criar ScreenGui principal
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EggEmpireUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Criar HUD
    self:CreateHUD(screenGui)
    
    -- Criar menu principal
    self:CreateMainMenu(screenGui)
    
    -- Criar minimapa
    self:CreateMinimap(screenGui)
    
    -- Criar crosshair
    self:CreateCrosshair(screenGui)
end

function ClientController:CreateHUD(parent)
    local hud = Instance.new("Frame")
    hud.Name = "HUD"
    hud.Size = UDim2.new(1, 0, 1, 0)
    hud.BackgroundTransparency = 1
    hud.Parent = parent
    
    -- Top bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    topBar.BackgroundTransparency = 0.5
    topBar.Parent = hud
    
    -- Moedas
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Name = "CoinsLabel"
    coinsLabel.Size = UDim2.new(0, 150, 1, 0)
    coinsLabel.Position = UDim2.new(0, 10, 0, 0)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Text = "💰 0"
    coinsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    coinsLabel.TextScaled = true
    coinsLabel.Parent = topBar
    
    -- Gemas
    local gemsLabel = Instance.new("TextLabel")
    gemsLabel.Name = "GemsLabel"
    gemsLabel.Size = UDim2.new(0, 150, 1, 0)
    gemsLabel.Position = UDim2.new(0, 170, 0, 0)
    gemsLabel.BackgroundTransparency = 1
    gemsLabel.Text = "💎 0"
    gemsLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    gemsLabel.TextScaled = true
    gemsLabel.Parent = topBar
    
    -- Nível
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(0, 100, 1, 0)
    levelLabel.Position = UDim2.new(0, 330, 0, 0)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "Nv. 1"
    levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    levelLabel.TextScaled = true
    levelLabel.Parent = topBar
    
    -- Bottom bar (habilidades)
    local bottomBar = Instance.new("Frame")
    bottomBar.Name = "BottomBar"
    bottomBar.Size = UDim2.new(0, 400, 0, 80)
    bottomBar.Position = UDim2.new(0.5, -200, 1, -100)
    bottomBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bottomBar.BackgroundTransparency = 0.5
    bottomBar.Parent = hud
    
    -- Slots de habilidade
    local abilities = {"⚔️", "💨", "🛡️", "💣", "👻"}
    local abilityNames = {"Ataque", "Dash", "Escudo", "Bomba", "Stealth"}
    
    for i, ability in ipairs(abilities) do
        local slot = Instance.new("Frame")
        slot.Name = "AbilitySlot" .. i
        slot.Size = UDim2.new(0, 70, 0, 70)
        slot.Position = UDim2.new(0, (i-1) * 80 + 5, 0, 5)
        slot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        slot.BorderSizePixel = 2
        slot.Parent = bottomBar
        
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(1, 0, 0.7, 0)
        icon.BackgroundTransparency = 1
        icon.Text = ability
        icon.TextScaled = true
        icon.Parent = slot
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0.3, 0)
        label.Position = UDim2.new(0, 0, 0.7, 0)
        label.BackgroundTransparency = 1
        label.Text = abilityNames[i]
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextScaled = true
        label.Parent = slot
        
        local keybind = Instance.new("TextLabel")
        keybind.Size = UDim2.new(0, 20, 0, 20)
        keybind.Position = UDim2.new(1, -25, 0, 5)
        keybind.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        keybind.Text = tostring(i)
        keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
        keybind.TextScaled = true
        keybind.Parent = slot
    end
    
    -- Health bar
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(0, 200, 0, 20)
    healthBar.Position = UDim2.new(0.5, -100, 1, -120)
    healthBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBar.Parent = hud
    
    local healthFill = Instance.new("Frame")
    healthFill.Name = "Fill"
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.Parent = healthBar
    
    local healthText = Instance.new("TextLabel")
    healthText.Name = "HealthText"
    healthText.Size = UDim2.new(1, 0, 1, 0)
    healthText.BackgroundTransparency = 1
    healthText.Text = "100/100"
    healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthText.TextScaled = true
    healthText.Parent = healthBar
end

function ClientController:CreateMainMenu(parent)
    local mainMenu = Instance.new("Frame")
    mainMenu.Name = "MainMenu"
    mainMenu.Size = UDim2.new(1, 0, 1, 0)
    mainMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    mainMenu.Parent = parent
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.8, 0, 0.2, 0)
    title.Position = UDim2.new(0.1, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Text = "🥚 EGG EMPIRE 🥚"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainMenu
    
    -- Botão Jogar
    local playButton = Instance.new("TextButton")
    playButton.Name = "PlayButton"
    playButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    playButton.Position = UDim2.new(0.35, 0, 0.4, 0)
    playButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    playButton.Text = "▶ JOGAR"
    playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    playButton.TextScaled = true
    playButton.Font = Enum.Font.GothamBold
    playButton.Parent = mainMenu
    
    playButton.MouseButton1Click:Connect(function()
        self:OnPlayButtonClicked()
    end)
    
    -- Botão Loja
    local shopButton = Instance.new("TextButton")
    shopButton.Name = "ShopButton"
    shopButton.Size = UDim2.new(0.3, 0, 0.08, 0)
    shopButton.Position = UDim2.new(0.35, 0, 0.55, 0)
    shopButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    shopButton.Text = "🛒 LOJA"
    shopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    shopButton.TextScaled = true
    shopButton.Font = Enum.Font.GothamBold
    shopButton.Parent = mainMenu
    
    shopButton.MouseButton1Click:Connect(function()
        self:OnShopButtonClicked()
    end)
    
    -- Botão Configurações
    local settingsButton = Instance.new("TextButton")
    settingsButton.Name = "SettingsButton"
    settingsButton.Size = UDim2.new(0.3, 0, 0.08, 0)
    settingsButton.Position = UDim2.new(0.35, 0, 0.68, 0)
    settingsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    settingsButton.Text = "⚙️ CONFIGURAÇÕES"
    settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsButton.TextScaled = true
    settingsButton.Font = Enum.Font.GothamBold
    settingsButton.Parent = mainMenu
    
    settingsButton.MouseButton1Click:Connect(function()
        self:OnSettingsButtonClicked()
    end)
    
    -- Stats
    local statsFrame = Instance.new("Frame")
    statsFrame.Name = "StatsFrame"
    statsFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
    statsFrame.Position = UDim2.new(0.75, 0, 0.6, 0)
    statsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    statsFrame.BackgroundTransparency = 0.3
    statsFrame.Parent = mainMenu
    
    local statsTitle = Instance.new("TextLabel")
    statsTitle.Size = UDim2.new(1, 0, 0.2, 0)
    statsTitle.BackgroundTransparency = 1
    statsTitle.Text = "📊 ESTATÍSTICAS"
    statsTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    statsTitle.TextScaled = true
    statsTitle.Parent = statsFrame
    
    -- Esconder menu ao jogar
    mainMenu.Visible = true
end

function ClientController:CreateMinimap(parent)
    local minimap = Instance.new("Frame")
    minimap.Name = "Minimap"
    minimap.Size = UDim2.new(0, 200, 0, 200)
    minimap.Position = UDim2.new(1, -210, 0, 60)
    minimap.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
    minimap.BackgroundTransparency = 0.3
    minimap.BorderSizePixel = 2
    minimap.Parent = parent
    
    -- Título do minimapa
    local minimapTitle = Instance.new("TextLabel")
    minimapTitle.Size = UDim2.new(1, 0, 0, 20)
    minimapTitle.BackgroundTransparency = 1
    minimapTitle.Text = "🗺️ MAPA"
    minimapTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimapTitle.TextScaled = true
    minimapTitle.Parent = minimap
    
    -- Centro do mapa
    local center = Instance.new("Frame")
    center.Name = "Center"
    center.Size = UDim2.new(0, 10, 0, 10)
    center.Position = UDim2.new(0.5, -5, 0.5, -5)
    center.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    center.Parent = minimap
end

function ClientController:CreateCrosshair(parent)
    local crosshair = Instance.new("Frame")
    crosshair.Name = "Crosshair"
    crosshair.Size = UDim2.new(0, 20, 0, 20)
    crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
    crosshair.BackgroundTransparency = 1
    crosshair.Parent = parent
    
    -- Linha horizontal
    local horizontal = Instance.new("Frame")
    horizontal.Size = UDim2.new(1, 0, 0, 2)
    horizontal.Position = UDim2.new(0, 0, 0.5, -1)
    horizontal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    horizontal.Parent = crosshair
    
    -- Linha vertical
    local vertical = Instance.new("Frame")
    vertical.Size = UDim2.new(0, 2, 1, 0)
    vertical.Position = UDim2.new(0.5, -1, 0, 0)
    vertical.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vertical.Parent = crosshair
end

-- ============================================
-- ATUALIZAR UI
-- ============================================
function ClientController:UpdateHUD()
    if not self.playerData then return end
    
    -- Atualizar moedas
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("EggEmpireUI")
    if screenGui then
        local hud = screenGui:FindFirstChild("HUD")
        if hud then
            local topBar = hud:FindFirstChild("TopBar")
            if topBar then
                local coinsLabel = topBar:FindFirstChild("CoinsLabel")
                if coinsLabel then
                    coinsLabel.Text = "💰 " .. tostring(self.currencyData.Coins)
                end
                
                local gemsLabel = topBar:FindFirstChild("GemsLabel")
                if gemsLabel then
                    gemsLabel.Text = "💎 " .. tostring(self.currencyData.Gems)
                end
                
                local levelLabel = topBar:FindFirstChild("LevelLabel")
                if levelLabel then
                    levelLabel.Text = "Nv. " .. tostring(self.playerData.Level)
                end
            end
        end
    end
end

function ClientController:UpdateMinimap()
    -- Atualizar posição no minimapa
end

-- ============================================
-- AÇÕES DE UI
-- ============================================
function ClientController:OnPlayButtonClicked()
    -- Esconder menu principal
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("EggEmpireUI")
    if screenGui then
        local mainMenu = screenGui:FindFirstChild("MainMenu")
        if mainMenu then
            mainMenu.Visible = false
        end
    end
    
    self.gameState.IsInMenu = false
    self.gameState.IsPlaying = true
    
    -- Notificar servidor
    print("[ClientController] Jogador começou a jogar!")
end

function ClientController:OnShopButtonClicked()
    print("[ClientController] Abrindo loja...")
end

function ClientController:OnSettingsButtonClicked()
    print("[ClientController] Abrindo configurações...")
end

-- ============================================
-- NOTIFICAÇÕES
-- ============================================
function ClientController:ShowNotification(title, message)
    -- Criar notificação flutuante
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("EggEmpireUI")
    
    if screenGui then
        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Size = UDim2.new(0, 300, 0, 80)
        notification.Position = UDim2.new(0.5, -150, 0, -100)
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BackgroundTransparency = 0.2
        notification.BorderSizePixel = 0
        notification.Parent = screenGui
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0.4, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        titleLabel.TextScaled = true
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Parent = notification
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Size = UDim2.new(1, -20, 0.5, 0)
        messageLabel.Position = UDim2.new(0, 10, 0.5, 0)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Text = message
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        messageLabel.TextScaled = true
        messageLabel.Parent = notification
        
        -- Animar entrada
        spawn(function()
            for i = 0, 1, 0.1 do
                notification.Position = UDim2.new(0.5, -150, i * 0.3, 0)
                wait(0.02)
            end
            
            wait(3)
            
            for i = 1, 0, -0.1 do
                notification.Position = UDim2.new(0.5, -150, i * 0.3, 0)
                wait(0.02)
            end
            
            notification:Destroy()
        end)
    end
end

function ClientController:ShowCurrencyChange(type, amount)
    local prefix = type == "Coins" and "💰" or "💎"
    self:ShowNotification(prefix .. " " .. type, amount)
end

function ClientController:ShowEggCollected(eggType, value)
    local emoji = "⚪"
    if eggType == "Golden" then emoji = "🟡"
    elseif eggType == "Silver" then emoji = "⚪"
    elseif eggType == "Crystal" then emoji = "🔵"
    elseif eggType == "Fire" then emoji = "🔴"
    end
    
    self:ShowNotification(emoji .. " Ovo Coletado!", "+" .. value .. " moedas")
end

function ClientController:ShowAttackIndicator(attacker, damage)
    self:ShowNotification("⚔️ Ataque!", attacker .. " causou " .. damage .. " de dano!")
end

function ClientController:ShowKillFeed(killer, victim)
    self:ShowNotification("💀 Kill!", killer .. " eliminou " .. victim)
end

function ClientController:ShowPowerUpActive(powerUpType)
    self:ShowNotification("✨ Power-up!", powerUpType .. " ativado!")
end

function ClientController:ShowBuildNotification(pieceType)
    self:ShowNotification("🏗️ Construído!", pieceType .. " adicionado à base!")
end

function ClientController:ShowAlert(title, message)
    self:ShowNotification("🚨 " .. title, message)
end

function ClientController:UpdateMissionsUI(missions)
    print("[ClientController] Missões atualizadas:", missions)
end

function ClientController:UpdateRankingUI(rankings)
    print("[ClientController] Ranking atualizado:", rankings)
end

function ClientController:UpdateStatsUI(stats)
    print("[ClientController] Stats atualizados:", stats)
end

function ClientController:ShowBuildMenu()
    print("[ClientController] Mostrando menu de construção...")
end

function ClientController:HideBuildMenu()
    print("[ClientController] Escondendo menu de construção...")
end

-- ============================================
-- INICIALIZAR
-- ============================================
local controller = ClientController.new()

return controller
