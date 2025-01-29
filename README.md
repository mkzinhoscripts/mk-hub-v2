-- Defina a chave que você quer usar
local correctKey = "mkzinho stores123131sd" -- Substitua "SUA_CHAVE_AQUI" pela chave desejada

-- Solicita a chave do usuário
local userInput = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("TextBox").Text

-- Função para verificar se a chave está correta
function verifyKey(inputKey)
    if inputKey == correctKey then
        return true
    else
        return false
    end
end

-- Espera o jogo carregar completamente
repeat wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local backpack = player.Backpack

-- Função de Auto Farm
function autoFarm()
    local maxDistance = 50 -- Distância máxima para buscar os inimigos
    while wait(1) do
        local closestMob = nil
        local shortestDistance = maxDistance
        
        -- Procura por mobs próximos
        for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local distance = (hrp.Position - mob.HumanoidRootPart.Position).magnitude
                if distance < shortestDistance then
                    closestMob = mob
                    shortestDistance = distance
                end
            end
        end

        -- Se encontrar um mob, vai até ele e ataca
        if closestMob then
            hrp.CFrame = closestMob.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    end
end

-- Função para Auto TTK
function autoTTK()
    local swords = {"Shisui", "Wando", "Saddi"}
    local owned = 0
    -- Verifica se o jogador tem as 3 espadas
    for _, sword in ipairs(swords) do
        if backpack:FindFirstChild(sword) or char:FindFirstChild(sword) then
            owned = owned + 1
        end
    end

    -- Se tiver as 3 espadas, vai até o NPC e pega a TTK
    if owned == 3 then
        hrp.CFrame = CFrame.new(-4732, 872, -1932)  -- Coordenadas do NPC para pegar TTK
        wait(2)
        fireclickdetector(game.Workspace.NPCs["TTK Dealer"].ClickDetector)
    end
end

-- Função para Auto Haki
function autoHaki()
    hrp.CFrame = CFrame.new(-958, 38, 5543)  -- Coordenadas do NPC para pegar Haki
    wait(2)
    fireclickdetector(game.Workspace.NPCs["Haki Master"].ClickDetector)
end

-- Função para Auto Farm de Frutas
function autoFarmFruits()
    while wait(2) do
        for _, fruit in pairs(game:GetService("Workspace").Fruits:GetChildren()) do
            if fruit:IsA("Model") and fruit:FindFirstChild("Fruit") then
                hrp.CFrame = fruit.HumanoidRootPart.CFrame
                wait(1)
                fireclickdetector(fruit.ClickDetector)
            end
        end
    end
end

-- Função para Auto Leveling
function autoLeveling()
    local hakiEquipped = false

    -- Verifica se o Haki está equipado e ativa se necessário
    if backpack:FindFirstChild("Haki") then
        local haki = backpack.Haki
        if haki:FindFirstChild("Activate") then
            haki.Activate:FireServer()  -- Ativa o Haki se estiver equipado
            hakiEquipped = true
        end
    end

    -- Se o Haki estiver ativado, começa o processo de leveling
    if hakiEquipped then
        autoFarm()  -- Começa o auto farm com Haki ativado
    end
end

-- Função de Auto Compra de Itens
function autoBuyItems()
    local shopNPC = game.Workspace.NPCs:FindFirstChild("Shop NPC")
    if shopNPC then
        hrp.CFrame = shopNPC.HumanoidRootPart.CFrame
        wait(2)
        fireclickdetector(shopNPC.ClickDetector)
    end
end

-- Função para pegar frutinha especial, se tiver um evento de fruta especial
function specialFruitEvent()
    local eventFruit = game.Workspace.Fruits:FindFirstChild("SpecialFruit")
    if eventFruit then
        hrp.CFrame = eventFruit.HumanoidRootPart.CFrame
        wait(1)
        fireclickdetector(eventFruit.ClickDetector)
    end
end

-- Verifica a chave antes de continuar
if verifyKey(userInput) then
    -- Rodando as funções em paralelo
    spawn(autoFarm)
    spawn(autoTTK)
    spawn(autoHaki)
    spawn(autoFarmFruits)
    spawn(autoLeveling)
    spawn(autoBuyItems)
    spawn(specialFruitEvent)
    print("Chave correta! Todos os scripts de farm, TTK, Haki e outros estão ativos!")
else
    print("Chave incorreta. O script não pode ser executado.")
end
