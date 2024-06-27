local rs = game:GetService("ReplicatedStorage")
local Balls = require(rs.Shared.Balls)

for _, plot in pairs(workspace:WaitForChild("Plots"):GetChildren()) do
    plot:FindFirstChild("ProximityPromptHolder").ProximityPrompt.Triggered:Connect(function(player)
        plot.Owner.Value = player.Name
        plot.NameSign.SurfaceGui.TextLabel.Text = player.DisplayName .. " (@" .. player.Name .. ")"
        plot.ProximityPromptHolder.ProximityPrompt.Enabled = false
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        if player.Name == plot.Owner.Value then
            plot.Owner.Value = "no"
            plot.NameSign.SurfaceGui.TextLabel.Text = "[Unclaimed]"
            plot.ProximityPromptHolder.ProximityPrompt.Enabled = true
        end
    end)

    plot:FindFirstChild("Sell").Touched:Connect(function(hit)
        if hit.Parent.Name == "Spawned_Balls" and hit.Parent:IsA("Folder") and hit:FindFirstChild("Owner") then
            if hit.Owner.Value == plot.Owner.Value then
                game.Players[plot.Owner.Value]:FindFirstChild("currencies")[Balls.ByName[hit.Name].Currency].Value += Balls.ByName[hit.Name].Value
                hit:Destroy()
            end
        end
    end)
end