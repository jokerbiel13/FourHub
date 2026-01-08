--// =========================
--// FourHub | AFS Endless
--// UI: ORION (Compatível)
--// =========================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

--// Orion UI
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/shlexware/Orion/main/source"
))()

local Window = OrionLib:MakeWindow({
    Name = "FourHub | AFS Endless",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "FourHub"
})

--// Tabs
local Tabs = {
    Home = Window:MakeTab({ Name = "Home", Icon = "rbxassetid://4483345998" }),
    Train = Window:MakeTab({ Name = "Auto Train", Icon = "rbxassetid://4483345998" }),
    Visual = Window:MakeTab({ Name = "Visuals", Icon = "rbxassetid://4483345998" }),
    TP = Window:MakeTab({ Name = "Teleports", Icon = "rbxassetid://4483345998" }),
}

--// Variables
local AutoTrain = {}
local ESPEnabled = false
local AntiAFK = false
local SavedCFrame
local AutoTP = false

local STAT_ID = {
    Strength = 1,
    Durability = 2,
    Chakra = 3,
    Sword = 4,
    Agility = 5,
    Speed = 6
}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local TrainRemote = Remotes:WaitForChild("RemoteEvent")

--// =========================
--// HOME
--// =========================
Tabs.Home:AddParagraph("Status", "FourHub Loaded Successfully 🚀")

Tabs.Home:AddToggle({
    Name = "Anti AFK",
    Default = false,
    Callback = function(v)
        AntiAFK = v
    end
})

player.Idled:Connect(function()
    if AntiAFK then
        VirtualUser:CaptureFocus()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

--// =========================
--// AUTO TRAIN
--// =========================
for stat in pairs(STAT_ID) do
    AutoTrain[stat] = false

    Tabs.Train:AddToggle({
        Name = "Auto "..stat,
        Default = false,
        Callback = function(v)
            AutoTrain[stat] = v
        end
    })
end

task.spawn(function()
    while task.wait(0.25) do
        for stat, enabled in pairs(AutoTrain) do
            if enabled then
                pcall(function()
                    TrainRemote:FireServer("Train", STAT_ID[stat])
                end)
            end
        end
    end
end)

--// =========================
--// ESP
--// =========================
Tabs.Visual:AddToggle({
    Name = "Player ESP (Name/Dist)",
    Default = false,
    Callback = function(v)
        ESPEnabled = v
    end
})

--// =========================
--// TELEPORT
--// =========================
local function TP(name, pos)
    Tabs.TP:AddButton({
        Name = name,
        Callback = function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(pos) end
        end
    })
end

TP("Class Shop", Vector3.new(16,80,3))
TP("Champion", Vector3.new(31,105,30))
TP("Pain Boss", Vector3.new(1250,141,-970))

--// Init
OrionLib:Init()
