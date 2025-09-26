local DataManager= {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Store profiles from ProfileStore
DataManager.Profiles = {}




function DataManager.AddGems(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	profile.Data.Gems += amount
	player.leaderstats.Gems.Value = profile.Data.Gems
	ReplicatedStorage.UpdateGems:FireClient(player, profile.Data.Gems)
end


function DataManager.AddCandy(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.Candy += amount
	player.leaderstats.Candy.Value = profile.Data.Candy
	ReplicatedStorage.UpdateCandy:FireClient(player, profile.Data.Candy)
end


return DataManager