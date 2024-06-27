local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function onMouseDown(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = player:GetMouse()
        local target = mouse.Target
        
        if target and target.Name == "Ball" then
            -- Create the attachment points
            local handAttachment = Instance.new("Attachment")
            handAttachment.Name = "HandAttachment"
            handAttachment.Parent = character:WaitForChild("RightHand")
            
            local ballAttachment = Instance.new("Attachment")
            ballAttachment.Name = "BallAttachment"
            ballAttachment.Parent = target
            
            -- Create the rope constraint
            local ropeConstraint = Instance.new("RopeConstraint")
            ropeConstraint.Name = "HandToBallRope"
            ropeConstraint.Parent = character:WaitForChild("RightHand")
            ropeConstraint.Attachment0 = handAttachment
            ropeConstraint.Attachment1 = ballAttachment
            ropeConstraint.Length = (character.RightHand.Position - target.Position).Magnitude
        end
    end
end

UserInputService.InputBegan:Connect(onMouseDown)