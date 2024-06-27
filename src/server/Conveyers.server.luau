local function updateConveyerVelocity()
    while true do
        for _, conveyer in pairs(game.Workspace:WaitForChild("Conveyers"):GetChildren()) do
            if conveyer:IsA("Part") and conveyer.Name == "Conveyer" then
                conveyer.Velocity = conveyer.CFrame.LookVector * 20
            end
        end
        task.wait(0.1)
    end
end

for _, ballDestroyer in pairs(game.Workspace:WaitForChild("BallDestroyers"):GetChildren()) do
    ballDestroyer.Touched:Connect(function(hit)
        if hit:FindFirstChild("Grabbable") and hit.Parent.Name == "Spawned_Balls" then
            hit:Destroy()
        end
    end)
end


task.spawn(updateConveyerVelocity)