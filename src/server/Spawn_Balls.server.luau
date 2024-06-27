local Balls = require(game.ReplicatedStorage.Shared.Balls)

while true do
    task.wait(1)
    local randomBall = Balls.GetRandomBall()
    if randomBall then
        local spawnedBall = Instance.new("Part")
        spawnedBall.Parent = workspace:WaitForChild("Spawned_Balls")
        spawnedBall.Size = Vector3.new(4, 4, 4)
        spawnedBall.Position = Vector3.new(-14.5, 3, 68.75)
        spawnedBall.Shape = Enum.PartType.Ball
        spawnedBall.Name = randomBall.Name
        spawnedBall.Material = randomBall.Material
        spawnedBall.BrickColor = randomBall.Color
        spawnedBall.TopSurface = Enum.SurfaceType.Smooth
        spawnedBall.BottomSurface = Enum.SurfaceType.Smooth
        local grabbableValue = Instance.new("BoolValue")
        grabbableValue.Value = true
        grabbableValue.Name = "Grabbable"
        grabbableValue.Parent = spawnedBall
    else
        print("No ball selected.")
    end
end