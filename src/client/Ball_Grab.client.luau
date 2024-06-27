local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local MAX_GRAB_DISTANCE = 15

local attachedBall = nil
local ropeConstraint = nil
local handAttachment = nil

local function calculateDistance(point1, point2)
    return (point1 - point2).Magnitude
end

local function detachRope()
    if ropeConstraint then
        ropeConstraint:Destroy()
    end
    if handAttachment then
        handAttachment:Destroy()
    end
    if attachedBall then
        ReplicatedStorage:WaitForChild("BallOwner"):FireServer(attachedBall, player.DisplayName, "remove")
        local ballGrabbed = attachedBall:FindFirstChild("IsGrabbed")
        if ballGrabbed then
            ballGrabbed:Destroy()
        end
        attachedBall = nil
    end
    ropeConstraint = nil
    handAttachment = nil
end

local function onMouseDown(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mouse = player:GetMouse()
        local target = mouse.Target

        if target and target:FindFirstChild("Grabbable") then
            -- Check distance from player to the target ball
            local ballPosition = target.Position
            local playerPosition = character.HumanoidRootPart.Position
            local distance = calculateDistance(ballPosition, playerPosition)

            if distance <= MAX_GRAB_DISTANCE then
                -- Check if the ball is already grabbed
                local ballGrabbed = target:FindFirstChild("IsGrabbed")
                if ballGrabbed and ballGrabbed.Value then
                    -- Ball is already grabbed, do not proceed
                    return
                end

                -- Mark the ball as grabbed
                local ballGrabbedValue = Instance.new("BoolValue")
                ballGrabbedValue.Name = "IsGrabbed"
                ballGrabbedValue.Value = true
                ballGrabbedValue.Parent = target

                -- Perform the grab operation
                if attachedBall == target then
                    -- If the ball is already attached, remove the rope
                    detachRope()
                else
                    -- If the ball is not already attached, attach the rope
                    detachRope()

                    -- Create the attachment points
                    handAttachment = Instance.new("Attachment")
                    handAttachment.Name = "HandAttachment"
                    handAttachment.Parent = character:WaitForChild("RightHand")

                    local ballAttachment = Instance.new("Attachment")
                    ballAttachment.Name = "BallAttachment"
                    ballAttachment.Parent = target

                    -- Create the rope constraint
                    ropeConstraint = Instance.new("RopeConstraint")
                    ropeConstraint.Name = "HandToBallRope"
                    ropeConstraint.Parent = character:WaitForChild("RightHand")
                    ropeConstraint.Attachment0 = handAttachment
                    ropeConstraint.Attachment1 = ballAttachment
                    ropeConstraint.Length = (character.RightHand.Position - target.Position).Magnitude
                    ropeConstraint.Thickness = 0.2
                    ropeConstraint.Visible = true

                    ReplicatedStorage:WaitForChild("BallOwner"):FireServer(target, player.DisplayName, "add")

                    attachedBall = target
                end
            else
                print("You are too far away to grab the ball.")
            end
        end
    end
end

local function onCharacterAdded(newCharacter)
    character = newCharacter
    detachRope()
end

player.CharacterAdded:Connect(onCharacterAdded)
UserInputService.InputBegan:Connect(onMouseDown)

if player.Character then
    onCharacterAdded(player.Character)
end