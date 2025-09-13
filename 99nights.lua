if not game:IsLoaded() then game.Loaded:Wait() end
if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end

if getgenv().RunScript == true then return end
getgenv().RunScript = true

getgenv().WebhookURL = "https://discord.com/api/webhooks/1410825478146621440/wDBg1AdUeVWRMgMCjYKn2GyJzVLnhXjPAJ0ByvLzmy8z-IIctkyRuCxqOVHLrdmahNP5"
getgenv().AutoFarm = true
getgenv().hop = "old"
loadstring(game:HttpGet("https://raw.githubusercontent.com/dyumra/kuy/refs/heads/main/F99D.lua"))()

local queueScript = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/RTaOexe1/RTaO-webhooks/main/99nights.lua"))()
]]
queue_on_teleport(queueScript)

repeat wait(0.1) until game.Players
local TimeWaitLoadGame = 0
local player = game.Players.LocalPlayer
repeat
	wait(0.1)
	TimeWaitLoadGame = TimeWaitLoadGame + 0.1
	if TimeWaitLoadGame > 3 then
		player:Kick()
		wait(0.5)
		game:GetService("TeleportService"):Teleport(126509999114328)
	end
until game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
