-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GUI = script.Parent

GUI.Shop.Scroll.Buy1000Candy.ImageButton.MouseButton1Click:Connect(function()
	ReplicatedStorage.Request1000CandyProduct:FireServer()
end)

GUI.Shop.Scroll.Buy50Gems.ImageButton.MouseButton1Click:Connect(function()
	ReplicatedStorage.Request50GemsProduct:FireServer()
end)