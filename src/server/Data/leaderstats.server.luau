local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("leaderstats")

local function savePlayerData(userId, data)
    local success, errorMessage = pcall(function()
        playerDataStore:SetAsync(userId, data)
    end)
    if not success then
        warn("Failed to save data for userId: " .. userId .. " Error: " .. errorMessage)
    end
end

local function onPlayerRemoving(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local trophies = leaderstats:FindFirstChild("Trophies")
        if trophies then
            local data = {
                Trophies = trophies.Value
            }
            savePlayerData(player.UserId, data)
        end
    end
end

local function onPlayerAdded(player)
    -- LEADERSTATS FOLDER
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- TROPHIES INTVALUE
    local trophies = Instance.new("IntValue")
    trophies.Name = "Trophies"
    trophies.Parent = leaderstats

    -- Attempt to load the player's data
    local success, playerData = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)
    if success and playerData then
        trophies.Value = playerData.Trophies or 0
    else
        trophies.Value = 0
    end
end

-- Connect functions to the appropriate events
game.Players.PlayerAdded:Connect(onPlayerAdded)
game.Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Ensure data is saved for players already in the game when the script runs (e.g., in Studio)
for _, player in ipairs(game.Players:GetPlayers()) do
    onPlayerAdded(player)
end