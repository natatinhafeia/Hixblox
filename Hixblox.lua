local introText = "BY HIXDOW"
local gui = Instance.new("ScreenGui")
gui.Name = "CustomGUI"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Função para mostrar a animação de introdução
local function showIntro()
    local introLabel = Instance.new("TextLabel")
    introLabel.Text = introText
    introLabel.Font = Enum.Font.GothamBold
    introLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    introLabel.BackgroundTransparency = 1
    introLabel.Size = UDim2.new(0, 500, 0, 100)
    introLabel.Position = UDim2.new(0.5, -250, 0.5, -50)
    introLabel.Parent = gui

    -- Animação
    for i = 1, 3 do
        introLabel.TextColor3 = Color3.fromRGB(255, math.random(0, 255), math.random(0, 255))
        wait(0.5)
    end
    introLabel:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), "Out", "Sine", 1, true)
    wait(1)
    introLabel:Destroy()
end

-- Chama a função de introdução ao iniciar
showIntro()

-- INICIO: GUI com funções

-- Função para criar botões
local function createButton(name, position, size, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = name
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.Font = Enum.Font.Gotham
    button.Parent = gui

    button.MouseButton1Click:Connect(callback)
    return button
end

-- Função para tornar a GUI móvel
local function makeGuiDraggable()
    local dragging = false
    local dragInput, mousePos, framePos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragInput = input
            mousePos = input.Position
            framePos = gui.Position
        end
    end)

    gui.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - mousePos
            gui.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    gui.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging = false
        end
    end)
end

-- Função de Teleporte para Ilha
local function teleportToIsland(islandName)
    -- Dicionário de ilhas e suas posições
    local islands = {
        ["Starter Island"] = CFrame.new(100, 50, 100),  -- Exemplo de coordenadas
        ["Blox Fruits Island"] = CFrame.new(200, 50, 200),  -- Exemplo de coordenadas
        ["Sky Island"] = CFrame.new(300, 50, 300),  -- Exemplo de coordenadas
        ["Frozen Island"] = CFrame.new(400, 50, 400),  -- Exemplo de coordenadas
        ["Magma Island"] = CFrame.new(500, 50, 500),  -- Exemplo de coordenadas
    }

    if islands[islandName] then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(islands[islandName])
        print("Teleportando para " .. islandName)
    else
        print("Ilha não encontrada.")
    end
end

-- Função de Auto Kill Boss
local function autoKillBoss()
    autoKillBossEnabled = not autoKillBossEnabled
    local button = script.Parent:FindFirstChild("Auto Kill Boss")
    button.BackgroundColor3 = autoKillBossEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoKillBossEnabled then
        -- Lógica de Auto Kill Boss
        while autoKillBossEnabled do
            local boss = game.Workspace:FindFirstChild("Boss_Name") -- Troque "Boss_Name" pelo nome do boss
            if boss then
                -- Se o boss for encontrado, move até ele e começa a lutar
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo(boss.Position)
                -- Ataque repetido até derrotar o boss
                repeat
                    -- Implementação de dano
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):TakeDamage(10) -- Exemplo de dano
                    wait(1)
                until not boss.Parent
            end
            wait(1)
        end
    else
        print("Auto Kill Boss Desativado")
    end
end

-- Função de Auto Farm
local function autoFarm()
    autoFarmEnabled = not autoFarmEnabled
    local button = script.Parent:FindFirstChild("Auto Farm")
    button.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoFarmEnabled then
        -- Lógica para farm automático de NPCs
        while autoFarmEnabled do
            local npc = game.Workspace:FindFirstChild("NPC_Name") -- Troque "NPC_Name" pelo nome do NPC
            if npc then
                -- Se o NPC for encontrado, atacar e farmar
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo(npc.Position)
                -- Ataque repetido até derrotar o NPC
                repeat
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):TakeDamage(10) -- Exemplo de dano
                    wait(1)
                until not npc.Parent
            end
            wait(1)
        end
    else
        print("Auto Farm Desativado")
    end
end

-- Função de Auto Fruit Spin
local function autoFruitSpin()
    autoFruitSpinEnabled = not autoFruitSpinEnabled
    local button = script.Parent:FindFirstChild("Auto Fruit Spin")
    button.BackgroundColor3 = autoFruitSpinEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoFruitSpinEnabled then
        -- Lógica para girar frutas automaticamente
        while autoFruitSpinEnabled do
            game.ReplicatedStorage.Remotes.SpinFruit:FireServer()
            wait(5) -- Aguarda 5 segundos entre as tentativas de girar
        end
    else
        print("Auto Fruit Spin Desativado")
    end
end

-- Função de Auto Dash
local function autoDash()
    autoDashEnabled = not autoDashEnabled
    local button = script.Parent:FindFirstChild("Auto Dash")
    button.BackgroundColor3 = autoDashEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoDashEnabled then
        -- Lógica para dash automático
        while autoDashEnabled do
            local dash = game.Players.LocalPlayer.Character:FindFirstChild("DashSkill")
            if dash then
                dash:Activate() -- Ativa o dash
            end
            wait(5) -- Dash a cada 5 segundos ou ajustável
        end
    else
        print("Auto Dash Desativado")
    end
end

-- Função de Auto Teleport (Teleporte rápido)
local function teleportMenu()
    local islandMenu = Instance.new("Frame")
    islandMenu.Size = UDim2.new(0, 400, 0, 200)
    islandMenu.Position = UDim2.new(0.5, -200, 0.5, -100)
    islandMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    islandMenu.BackgroundTransparency = 0.5
    islandMenu.Parent = gui

    -- Botões para cada ilha
    local islands = {"Starter Island", "Blox Fruits Island", "Sky Island", "Frozen Island", "Magma Island"}

    for i, island in ipairs(islands) do
        createButton(island, UDim2.new(0.5, -150, 0, (i - 1) * 50), UDim2.new(0, 300, 0, 50), function()
            teleportToIsland(island)
        end)
    end
end

-- Função de Auto Mission
local function autoMission()
    autoMissionEnabled = not autoMissionEnabled
    local button = script.Parent:FindFirstChild("Auto Mission")
    button.BackgroundColor3 = autoMissionEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoMissionEnabled then
        -- Lógica para pegar missão automaticamente
        while autoMissionEnabled do
            local missionNPC = game.Workspace:FindFirstChild("Mission_NPC") -- Troque "Mission_NPC" pelo NPC da missão
            if missionNPC then
                -- Clicar no NPC para aceitar a missão
                missionNPC:Click()
            end
            wait(10) -- Espera 10 segundos antes de procurar uma nova missão
        end
    else
        print("Auto Mission Desativado")
    end
end

-- Criando os botões na GUI
createButton("Auto Kill Boss", UDim2.new(0.5, -150, 0.4, -25), UDim2.new(0, 300, 0, 50), autoKillBoss)
createButton("Auto Farm", UDim2.new(0.5, -150, 0.5, -25), UDim2.new(0, 300, 0, 50), autoFarm)
createButton("Auto Fruit Spin", UDim2.new(0.5, -150, 0.6, -25), UDim2.new(0, 300, 0, 50), autoFruitSpin)
createButton("Auto Dash", UDim2.new(0.5, -150, 0.7, -25), UDim2.new(0, 300, 0, 50), autoDash)
createButton("Auto Teleport", UDim2.new(0.5, -150, 0.8, -25), UDim2.new(0, 300, 0, 50), teleportMenu)
createButton("Auto Mission", UDim2.new(0.5, -150, 0.9, -25), UDim2.new(0, 300, 0, 50), autoMission)

-- Tornando a GUI móvel
makeGuiDraggable()
