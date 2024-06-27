local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("currencies")

local function savePlayerData(userId, data)
    local success, errorMessage = pcall(function()
        playerDataStore:SetAsync(userId, data)
    end)
    if not success then
        warn("Failed to save data for userId: " .. userId .. " Error: " .. errorMessage)
    end
end

local function onPlayerRemoving(player)
    local currencies = player:FindFirstChild("currencies")
    if currencies then
        local Rubies = currencies:FindFirstChild("Rubies")
        local Sapphires = currencies:FindFirstChild("Sapphires")
        if Rubies and Sapphires then
            local data = {
                Rubies = Rubies.Value,
                Sapphires = Sapphires.Value
            }
            savePlayerData(player.UserId, data)
        end
    end
end

local function onPlayerAdded(player)
    -- CURRENCIES FOLDER
    local currencies = Instance.new("Folder")
    currencies.Name = "currencies"
    currencies.Parent = player

    -- RUBIES INTVALUE
    local Rubies = Instance.new("IntValue")
    Rubies.Name = "Rubies"
    Rubies.Parent = currencies

    -- SAPPHIRES INTVALUE
    local Sapphires = Instance.new("IntValue")
    Sapphires.Name = "Sapphires"
    Sapphires.Parent = currencies

    -- Attempt to load the player's data
    local success, playerData = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)
    if success and playerData then
        Rubies.Value = playerData.Rubies or 0 
        Sapphires.Value = playerData.Sapphires or 0 
    else
        Rubies.Value = 0
        Sapphires.Value = 0
    end
end

-- Connect functions to the appropriate events
game.Players.PlayerAdded:Connect(onPlayerAdded)
game.Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Ensure data is saved for players already in the game when the script runs (e.g., in Studio)
for _, player in ipairs(game.Players:GetPlayers()) do
    onPlayerAdded(player)
end