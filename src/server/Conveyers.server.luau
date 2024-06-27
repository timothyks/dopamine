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


task.spawn(updateConveyerVelocity)