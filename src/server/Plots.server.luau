local rs = game:GetService("ReplicatedStorage")
local Balls = require(rs.Shared.Balls)

for _, plot in pairs(workspace:WaitForChild("Plots"):GetChildren()) do
    local function UpdatePlot()
        while true do
            task.wait(0.1)
            if plot.Owner.Value ~= "no" then
                --plot owner is not no
                plot.RubiesChest.Lock.BillboardGui.TextLabel.Text = game.Players[plot.Owner.Value].currencies.Rubies.Value
                plot.SapphiresChest.Lock.BillboardGui.TextLabel.Text = game.Players[plot.Owner.Value].currencies.Sapphires.Value
            end
        end
    end
    task.spawn(UpdatePlot)

    local function ResetPlot()
        plot.Owner.Value = "no"
        plot.NameSign.SurfaceGui.TextLabel.Text = "[Unclaimed]"
        plot.ProximityPromptHolder.ProximityPrompt.Enabled = true
        plot.RubiesChest.Lock.BillboardGui.TextLabel.Text = "---"
        plot.SapphiresChest.Lock.BillboardGui.TextLabel.Text = "---"
    end

    plot:FindFirstChild("ProximityPromptHolder").ProximityPrompt.Triggered:Connect(function(player)
        plot.Owner.Value = player.Name
        plot.NameSign.SurfaceGui.TextLabel.Text = player.DisplayName .. " (@" .. player.Name .. ")"
        plot.ProximityPromptHolder.ProximityPrompt.Enabled = false
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        if player.Name == plot.Owner.Value then
            ResetPlot()
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