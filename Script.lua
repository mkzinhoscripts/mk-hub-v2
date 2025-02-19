 print("🔹 MK Hub Iniciado...")
print("🔹 Auto Farm Ativado...")

local player = game.Players.LocalPlayer

game:GetService("RunService").Heartbeat:Connect(function()
    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) -- Move para perto do inimigo
            game.ReplicatedStorage.Remotes.Combat:FireServer("Attack") -- Simula um ataque
        end
    end
end)
