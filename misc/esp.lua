-- yeah this was ai I cannot be bothered to create a ESP module
--// ESP Library
--// Uses Roblox Highlight instances
--// Supports :Load() and :Unload()

local ESP = {}
ESP.__index = ESP

-- settings
ESP.Enabled = false
ESP.Objects = {}
ESP.Connections = {}

ESP.Settings = {
	FillColor = Color3.fromRGB(255, 0, 0),
	OutlineColor = Color3.fromRGB(255, 255, 255),
	FillTransparency = 0.5,
	OutlineTransparency = 0,
}

-- creates highlight for a model
local function createHighlight(model, settings)
	if not model:IsA("Model") then return end
	if not model:FindFirstChild("HumanoidRootPart") then return end

	local h = Instance.new("Highlight")
	h.Name = "ESP_Highlight"
	h.Adornee = model
	h.FillColor = settings.FillColor
	h.OutlineColor = settings.OutlineColor
	h.FillTransparency = settings.FillTransparency
	h.OutlineTransparency = settings.OutlineTransparency
	h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	h.Parent = model

	return h
end

-- remove highlight
local function removeHighlight(model)
	local h = model:FindFirstChild("ESP_Highlight")
	if h then
		h:Destroy()
	end
end

-- enable esp
function ESP:Load()
	if self.Enabled then return end
	self.Enabled = true

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	-- add existing players
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			createHighlight(plr.Character, self.Settings)
		end
	end

	-- character added
	self.Connections.CharAdded = Players.PlayerAdded:Connect(function(plr)
		self.Connections["Char_" .. plr.Name] = plr.CharacterAdded:Connect(function(char)
			if self.Enabled then
				createHighlight(char, self.Settings)
			end
		end)
	end)

	-- character respawn
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			self.Connections["Respawn_" .. plr.Name] = plr.CharacterAdded:Connect(function(char)
				if self.Enabled then
					createHighlight(char, self.Settings)
				end
			end)
		end
	end
end

-- disable esp
function ESP:Unload()
	if not self.Enabled then return end
	self.Enabled = false

	local Players = game:GetService("Players")

	-- remove all highlights
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			removeHighlight(plr.Character)
		end
	end

	-- disconnect everything
	for _, conn in pairs(self.Connections) do
		if typeof(conn) == "RBXScriptConnection" then
			conn:Disconnect()
		end
	end

	table.clear(self.Connections)
end

return ESP
