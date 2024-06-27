local remoteEvent = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"))
remoteEvent.Name = "BallOwner"

local billboardGui
local textLabel

remoteEvent.OnServerEvent:Connect(function(player, target, nameString, action)
    if action == "add" then
        billboardGui = Instance.new("BillboardGui")
        billboardGui.Parent = target
        billboardGui.AlwaysOnTop = true
        billboardGui.Size = UDim2.new(4, 0, 1, 0)
        billboardGui.StudsOffset = Vector3.new(0, 2.2, 0)

        textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboardGui
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.TextScaled = true
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(255, 255, 255)
        textLabel.Text = nameString
        textLabel.TextStrokeTransparency = 0
    elseif action == "remove" then
        if billboardGui then
            billboardGui:Destroy()
        end
        if textLabel then
            textLabel:Destroy()
        end
        billboardGui = nil
        textLabel = nil
    end
end)