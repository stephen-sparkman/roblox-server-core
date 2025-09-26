
local DataManager = require(game:GetService("ServerScriptService").Data.DataManager)

return {
	
	-- [developer product id] = function() which awards the product
	
	-- Buy 1000 Candy
	[3414403666] = function(receiptInfo, player, profile)
		DataManager.AddCandy(player, 1000)
		
	end,
	
	-- BUy 50 Gems
	[3414403798] = function(receiptInfo, player, profile)
		DataManager.AddGems(player, 50)

	end,
	
}