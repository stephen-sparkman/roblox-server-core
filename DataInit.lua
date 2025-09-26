-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- ProfileStore
local ProfileStore = require(ServerScriptService.Libraries.ProfileStore)

local function GetStoreName()
	return RunService:IsStudio() and "Test" or "Live"
end

local Template = require(ServerScriptService.Data.Template)
local DataManager = require(ServerScriptService.Data.DataManager)
local ProductManager = require(ServerScriptService.Data.ProductManager)

-- Access profile store
local PlayerStore = ProfileStore.New(GetStoreName(), Template)


-- Add leaderstats and syncronize player data
local function Initialize(player: PLayer, profile: typeof(PlayerStore:StartSessionAsync()))
	
	-- Leaderstats
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	
	local Candy = Instance.new("NumberValue", leaderstats)
	Candy.Name = "Candy"
	Candy.Value = profile.Data.Candy
	
	local Gems = Instance.new("NumberValue", leaderstats)
	Gems.Name = "Gems"
	Gems.Value = profile.Data.Gems
	
	
	-- Sync player data
	ReplicatedStorage.UpdateCandy:FireClient(player, profile.Data.Candy)
	ReplicatedStorage.UpdateGems:FireClient(player, profile.Data.Gems)
	
end


-- Creates and stores a profile
local function PlayerAdded(player: Player)

	-- Start a new profile session
	local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})
	
	-- Sanity check to ensure profile exists
	if profile ~= nil then
		
		profile:AddUserId(player.UserId)  -- GDPR complaince
		profile:Reconcile() -- Fill in missing data variables from template
	
		-- Handles session locking
		profile.OnSessionEnd:Connect(function()
			DataManager.Profiles[player] = nil
			player:Kick("Data error occured. Please rejoin.")
		end)
		
		-- Save profile for later use
		if player.Parent == Players then
			
			DataManager.Profiles[player] = profile
			Initialize(player, profile)
			
		else
			profile:EndSession()
			
		end
	
	
	else
		-- Server shuts down while the player is joining
		player:Kick("Data error occured. Please rejoin")
	end
	
end

-- Early joiners
for _, player in Players:GetPlayers() do
	task.spawn(PlayerAdded, player)
end
Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	profile:EndSession()
	DataManager.Profiles[player] = nil
end)