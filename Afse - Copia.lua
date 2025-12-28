--// =======================
--// AFS Endless | FourHub
--// Version: 1.3
--// =======================

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

--// Player
local player = Players.LocalPlayer

--// Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local TrainRemote = Remotes:WaitForChild("RemoteEvent")

--// UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Window
local Window = Rayfield:CreateWindow({
	Name = "AFS Endless | FourHub",
	LoadingTitle = "FourHub Script 1.7",
	LoadingSubtitle = "Auto Train • Teleports",
	Theme = "Dark",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "FourHub",
		FileName = "AFS_Endless"
	}
})

--// Tabs
local HomeTab  = Window:CreateTab("🏠 Home")
local CodesTab  = Window:CreateTab("🎮 Codes")
local TrainTab = Window:CreateTab("💪 Auto Train")
local TeleportTab = Window:CreateTab("🚀 Teleports")
local UtilTab  = Window:CreateTab("🛠 Utilities")
local WebTab   = Window:CreateTab("🌐 Webhook")
local InfoTab  = Window:CreateTab("ℹ Info")

--// Variables
local SavedCFrame
local AutoTP = false
local AntiAFK = false
local WebhookURL = ""
local WebhookEnabled = false
local WebhookInterval = 1800
local TRAIN_DELAY = 0.25
local AutoTrainEnabled = {}

--// Stats ID
local STAT_ID = {
	Strength   = 1,
	Durability = 2,
	Chakra     = 3,
	Sword      = 4,
	Agility    = 5,
	Speed      = 6
}

--// Utility Functions
local function getHRP()
	return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function isAlive()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	return hum and hum.Health > 0
end

local function getStat(stat)
	local stats = player:FindFirstChild("Stats")
	if not stats then return 0 end
	local v = stats:FindFirstChild(tostring(STAT_ID[stat]))
	return v and v.Value or 0
end

local function formatNumber(n)
	n = tonumber(n) or 0
	if n >= 1e12 then return math.floor(n/1e12).."t"
	elseif n >= 1e9 then return math.floor(n/1e9).."b"
	elseif n >= 1e6 then return math.floor(n/1e6).."m"
	elseif n >= 1e3 then return math.floor(n/1e3).."k"
	else return tostring(n) end
end

--// =======================
--// HOME - LIVE STATS
--// =======================
HomeTab:CreateSection("📊 Live Stats")

local StatParagraphs = {}

for stat in pairs(STAT_ID) do
	StatParagraphs[stat] = HomeTab:CreateParagraph({
		Title = stat,
		Content = "Loading..."
	})
end

task.spawn(function()
	while task.wait(1) do
		for stat, paragraph in pairs(StatParagraphs) do
			paragraph:Set({
				Title = stat,
				Content = formatNumber(getStat(stat))
			})
		end
	end
end)

--// =======================
--// AUTO TRAIN
--// =======================
TrainTab:CreateSection("⚙ Training Settings")

for stat in pairs(STAT_ID) do
	AutoTrainEnabled[stat] = false
	TrainTab:CreateToggle({
		Name = "Auto "..stat,
		Flag = "Train_"..stat,
		Callback = function(v)
			AutoTrainEnabled[stat] = v
		end
	})
end

task.spawn(function()
	while task.wait(TRAIN_DELAY) do
		if isAlive() then
			for stat, enabled in pairs(AutoTrainEnabled) do
				if enabled then
					pcall(function()
						TrainRemote:FireServer("Train", STAT_ID[stat])
					end)
				end
			end
		end
	end
end)

--// =======================
--// UTILITIES
--// =======================
UtilTab:CreateSection("🛠 Player Utilities")

UtilTab:CreateButton({
	Name = "📍 Save Current Position",
	Callback = function()
		local hrp = getHRP()
		if hrp then
			SavedCFrame = hrp.CFrame
			Rayfield:Notify({
				Title = "Position Saved",
				Content = "Your position was saved successfully",
				Duration = 3
			})
		end
	end
})

UtilTab:CreateToggle({
	Name = "Auto TP After Death",
	Flag = "AutoTP",
	Callback = function(v)
		AutoTP = v
	end
})

UtilTab:CreateToggle({
	Name = "Anti AFK",
	Flag = "AntiAFK",
	Callback = function(v)
		AntiAFK = v
	end
})

--// Anti AFK Logic
task.spawn(function()
	while task.wait(30) do -- a cada 30 segundos
		if AntiAFK then
			pcall(function()
				VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
				task.wait(0.1)
				VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			end)
		end
	end
end)


--// Auto TP
player.CharacterAdded:Connect(function()
	task.wait(2)
	if AutoTP and SavedCFrame then
		local hrp = getHRP()
		if hrp then hrp.CFrame = SavedCFrame end
	end
end)

--// =======================
--// WEBHOOK
--// =======================
WebTab:CreateSection("🌐 Discord Webhook")

WebTab:CreateInput({
	Name = "Webhook URL",
	PlaceholderText = "https://discord.com/api/webhooks/...",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		WebhookURL = text
	end
})

WebTab:CreateToggle({
	Name = "Enable Webhook",
	Flag = "WebhookEnabled",
	Callback = function(v)
		WebhookEnabled = v
	end
})

WebTab:CreateSlider({
	Name = "Webhook Interval",
	Range = {5, 120},
	Increment = 5,
	Suffix = "min",
	CurrentValue = 30,
	Callback = function(v)
		WebhookInterval = v * 60
	end
})

task.spawn(function()
	while task.wait(WebhookInterval) do
		if WebhookEnabled and WebhookURL ~= "" then
			pcall(function()
				HttpService:PostAsync(
					WebhookURL,
					HttpService:JSONEncode({
						username = player.Name,
						embeds = {{
							title = "AFS Endless Stats",
							color = 65280,
							fields = {
								{name="Strength",value=formatNumber(getStat("Strength")),inline=true},
								{name="Durability",value=formatNumber(getStat("Durability")),inline=true},
								{name="Chakra",value=formatNumber(getStat("Chakra")),inline=true},
								{name="Sword",value=formatNumber(getStat("Sword")),inline=true},
								{name="Agility",value=formatNumber(getStat("Agility")),inline=true},
								{name="Speed",value=formatNumber(getStat("Speed")),inline=true},
							}
						}}
					}),
					Enum.HttpContentType.ApplicationJson
				)
			end)
		end
	end
end)

--// =======================
--// INFO / DISCORD / UPDATES
--// =======================
InfoTab:CreateSection("🌐 Discord Community")

InfoTab:CreateParagraph({
	Title = "Join our Discord",
	Content = [[
• Script updates
• Support & bug reports
• Sneak peeks
• Community chat

Stay connected with FourHub!
]]
})

InfoTab:CreateButton({
	Name = "🔗 Join Discord Server",
	Callback = function()
		setclipboard("https://discord.gg/cUwR4tUJv3")
		Rayfield:Notify({
			Title = "Discord Invite",
			Content = "Invite link copied to clipboard!",
			Duration = 3
		})
	end
})

InfoTab:CreateSection("🆕 Script Updates")

InfoTab:CreateParagraph({
	Title = "Version 1.7",
	Content = [[
⏩ • Now the teleport list is in order
⏩ • Anti Afk Fixed
]]
})

--// =======================
--// FINISH
--// =======================
Rayfield:Notify({
	Title = "FourHub Loaded",
	Content = "AFS Endless is ready. Good grind!",
	Duration = 4
})
--// =======================
--// TELEPORTS
--// ======================= 

local function CreateTeleportSection(tab, sectionName, icon, teleportList)
	tab:CreateSection(sectionName)

	for _, tp in ipairs(teleportList) do
		tab:CreateButton({
			Name = icon.." "..tp.Name,
			Callback = function()
				local hrp = getHRP()
				if hrp then
					hrp.CFrame = CFrame.new(tp.Pos)
					Rayfield:Notify({
						Title = "Teleport",
						Content = "Teleportado para "..tp.Name,
						Duration = 3
					})
				end
			end
		})
	end
end
 
CreateTeleportSection(TeleportTab, "📍 Teleports", "📁", {
	{ Name = "Class Shop", Pos = Vector3.new(16.26, 80.22, 3.58) },
	{ Name = "BOOM", Pos = Vector3.new(-30.54, 80.22, 2.79) },
	{ Name = "CHAMPION", Pos = Vector3.new(31.57, 105.14, 30.06) },
	{ Name = "CHAMPION 2", Pos = Vector3.new(510.60, 62.00, -294.08) },
	{ Name = "Stand", Pos = Vector3.new(158.67, 62.40, -229.90) },
	{ Name = "NEN LEVELLING", Pos = Vector3.new(-1093.27, 61.00, -133.52) },
	{ Name = "KAGUNE", Pos = Vector3.new(1690.40, 142.00, -169.09) },
	{ Name = "GRIMORE", Pos = Vector3.new(1046.33, 238.05, -973.38) },
	{ Name = "SOUL LEVELLING", Pos = Vector3.new(314.95, -156.00, -2080.17) },
	{ Name = "SEIYEN LEVELLING", Pos = Vector3.new(-2252.15, 617.63, 507.69) },
	{ Name = "SWORD MASTER", Pos = Vector3.new(325.09, 69.58, -1990.91) },
	{ Name = "NICHIYIN LEVELLING", Pos = Vector3.new(-346.12, 122.43, -1210.09) },
	{ Name = "Reindeer", Pos = Vector3.new(-32.12, 105.15, 36.81) },
	{ Name = "Santa", Pos = Vector3.new(4323.11, 60.00, -350.31) },
})

CreateTeleportSection(TeleportTab, "👊 Physical Strength", "👊", {
	{ Name = "100", Pos = Vector3.new(-6.47, 65.00, 115.57) },
	{ Name = "10K", Pos = Vector3.new(1340.18, 153.96, -136.62) },
	{ Name = "100K", Pos = Vector3.new(-1250.88, 59.00, 482.15) },
	{ Name = "1M", Pos = Vector3.new(-904.00, 84.53, 174.76) },
	{ Name = "10M", Pos = Vector3.new(-2244.94, 617.19, 542.24) },
	{ Name = "100M", Pos = Vector3.new(-40.26, 64.29, -1309.76) },
	{ Name = "1B", Pos = Vector3.new(722.05, 150.80, 923.12) },
	{ Name = "100B", Pos = Vector3.new(1846.33, 141.20, 92.19) },
	{ Name = "5T", Pos = Vector3.new(615.73, 633.55, 388.93) },
	{ Name = "250T", Pos = Vector3.new(4273.51, 164.52, -602.42) },
	{ Name = "150QD", Pos = Vector3.new(798.06, 232.24, -1006.03) },
	{ Name = "25QN", Pos = Vector3.new(3871.32, 132.37, 873.53) },
	{ Name = "10SX", Pos = Vector3.new(3808.77, 724.77, -1185.33) },
})

CreateTeleportSection(TeleportTab, "🛡️ Durability", "🛡️", {
	{ Name = "100", Pos = Vector3.new(70.63, 69.26, 874.40) },
	{ Name = "10K", Pos = Vector3.new(-1602.10, 61.62, -542.07) },
	{ Name = "100K", Pos = Vector3.new(-78.69, 61.01, 2036.12) },
	{ Name = "1M", Pos = Vector3.new(-621.30, 179.00, 734.22) },
	{ Name = "10M", Pos = Vector3.new(-1102.78, 212.63, -957.47) },
	{ Name = "100M", Pos = Vector3.new(-336.08, 72.62, -1650.92) },
	{ Name = "1B", Pos = Vector3.new(2470.67, 1539.93, -370.09) },
	{ Name = "100B", Pos = Vector3.new(-2751.61, -227.68, 349.93) },
	{ Name = "5T", Pos = Vector3.new(2168.10, 519.17, 575.54) },
	{ Name = "250T", Pos = Vector3.new(1668.13, 492.86, -1341.04) },
	{ Name = "150QD", Pos = Vector3.new(187.52, 773.59, -705.47) },
	{ Name = "25QN", Pos = Vector3.new(2399.55, 63.23, 1489.76) },
	{ Name = "10SX", Pos = Vector3.new(1686.40, 2482.33, -34.01) },
})

CreateTeleportSection(TeleportTab, "🌀 Chakra", "🌀", {
	{ Name = "100", Pos = Vector3.new(-7.54, 70.29, -127.91) },
	{ Name = "10K", Pos = Vector3.new(1422.93, 147.00, -586.59) },
	{ Name = "100K", Pos = Vector3.new(918.60, 141.00, 781.66) },
	{ Name = "1M", Pos = Vector3.new(1571.50, 388.75, 678.34) },
	{ Name = "10M", Pos = Vector3.new(336.79, -147.98, -1812.01) },
	{ Name = "100M", Pos = Vector3.new(1028.59, 259.09, -623.35) },
	{ Name = "1B", Pos = Vector3.new(3054.49, 110.90, 1103.67) },
	{ Name = "100B", Pos = Vector3.new(1494.56, 342.69, 1808.98) },
	{ Name = "5T", Pos = Vector3.new(-26.53, 85.86, -483.56) },
	{ Name = "250T", Pos = Vector3.new(-395.71, 1237.07, 670.70) },
	{ Name = "150QD", Pos = Vector3.new(-751.26, 2794.05, 599.93) },
	{ Name = "25QN", Pos = Vector3.new(3245.95, -440.98, -239.60) },
	{ Name = "10SX", Pos = Vector3.new(329.54, 296.18, 1880.06) },
})


CreateTeleportSection(TeleportTab, "👣 Speed & Agility", "👣", {
	{ Name = "100 AGI", Pos = Vector3.new(49.38, 69.18, 454.04) },
	{ Name = "100 SPEED", Pos = Vector3.new(-107.40, 61.00, -505.31) },
	{ Name = "100K AGI/SPD", Pos = Vector3.new(-429.85, 121.92, -74.36) },
	{ Name = "5M AGI/SPD", Pos = Vector3.new(4109.51, 60.92, 847.91) },
})

CodesTab:CreateSection("🎮 All the Codes")

CodesTab:CreateParagraph({
	Title = "All the Chikara Codes",
	Content = [[
The New Codes are all here
]]
})

CodesTab:CreateButton({
	Name = "🔖 5k Chikaras",
	Callback = function()
		setclipboard("FreeChikara")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 10k Chikaras",
	Callback = function()
		setclipboard("FreeChikara2")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 10k Chikaras",
	Callback = function()
		setclipboard("FreeChikara3")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 75k Chikaras",
	Callback = function()
		setclipboard("MobsUpdate")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 75k Chikaras",
	Callback = function()
		setclipboard("1WeekAnniversary")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 75k Chikaras",
	Callback = function()
		setclipboard("100Favs")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 50k Chikaras",
	Callback = function()
		setclipboard("1kLikes")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 50k Chikaras",
	Callback = function()
		setclipboard("5kLikes")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 50k Chikaras",
	Callback = function()
		setclipboard("10kLikes")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 50k Chikaras",
	Callback = function()
		setclipboard("1MVisits")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🔖 Code Secret 500K",
	Callback = function()
		setclipboard("Krampus")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateSection("💴 YEN CODES")

CodesTab:CreateParagraph({
	Title = "All the Yen Codes",
	Content = [[
The New Codes are all here
]]
})
CodesTab:CreateButton({
	Name = "💴 1k Yen",
	Callback = function()
		setclipboard("YenCode")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "💴 5k Yen",
	Callback = function()
		setclipboard("10kVisits")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "💴 5k Yen",
	Callback = function()
		setclipboard("2kLikes")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "💴 1 Yen LOL",
	Callback = function()
		setclipboard("Gullible67")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateSection("🚀 BOOSTER CODES")

CodesTab:CreateParagraph({
	Title = "All the Booster Codes",
	Content = [[
The New Codes are all here
]]
})
CodesTab:CreateButton({
	Name = "🚀 1h Booster",
	Callback = function()
		setclipboard("50Likes")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🚀 1D Booster",
	Callback = function()
		setclipboard("400CCU")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🚀 1D Booster",
	Callback = function()
		setclipboard("100CCU")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🚀 1D Booster",
	Callback = function()
		setclipboard("100kVisits")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})
CodesTab:CreateButton({
	Name = "🚀 1D Booster",
	Callback = function()
		setclipboard("ChristmasTime")
		Rayfield:Notify({
			Title = "Code Copied",
			Content = "I hope you like it",
			Duration = 3
		})
	end
})