-- Balls module
local Balls = {}

Balls.List = {
    {
        Name = "Red",
        Color = BrickColor.new("Really red"),
        Material = Enum.Material.Plastic,
        Value = 10,
        Currency = "Rubies",
        Rarity = 2
    },
    {
        Name = "Blue",
        Color = BrickColor.new("Cyan"),
        Material = Enum.Material.Plastic,
        Value = 15,
        Currency = "Rubies",
        Rarity = 5
    },
    {
        Name = "Yellow",
        Color = BrickColor.new("New Yeller"),
        Material = Enum.Material.Plastic,
        Value = 3,
        Currency = "Sapphires",
        Rarity = 9
    },
}

-- GET BALL BY NAME
Balls.ByName = {}
for _, ball in ipairs(Balls.List) do
    Balls.ByName[ball.Name] = ball
end

-- GET RANDOM BALL BASED ON RARITY
function Balls.GetRandomBall()
    -- Calculate the total inverse weight
    local totalInverseWeight = 0
    for _, ball in ipairs(Balls.List) do
        totalInverseWeight = totalInverseWeight + (1 / ball.Rarity)
    end
    
    -- Generate a random number within the total inverse weight
    local randomWeight = math.random() * totalInverseWeight
    
    -- Iterate through the list and select a ball based on the random number
    local cumulativeInverseWeight = 0
    for _, ball in ipairs(Balls.List) do
        cumulativeInverseWeight = cumulativeInverseWeight + (1 / ball.Rarity)
        if randomWeight <= cumulativeInverseWeight then
            return ball
        end
    end
end

return Balls