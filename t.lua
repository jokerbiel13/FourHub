--// =========================
--// AFS Endless | FourHub
--// UI: Fluent
--// =========================

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

--// Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local TrainRemote = Remotes:WaitForChild("RemoteEvent")

--// =========================
--// FLUENT UI
--// =========================
local Fluent = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Fluent.lua"
))()

local Window = Fluent:CreateWindow({
    Title = "FourHub",
    SubTitle = "AFS Endless • Premium",
    Size = UDim2.fromOffset(560, 480),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

--// Tabs
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Train = Window:AddTab({ Title = "Auto Train", Icon = "activity" }),
    Visual = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    TP = Window:AddTab({ Title = "Teleports", Icon = "map-pin" }),
    Codes = Window:AddTab({ Title = "Codes", Icon = "tag" }),
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
}

--// =========================
--// VARIABLES
--// =========================
local ESPEnabled = false
local SavedCFrame
local AutoTP = false
local AntiAFK = false

local TRAIN_DELAY = 0.25

local STAT_ID = {
    Strength   = 1,
    Durability = 2,
    Chakra     = 3,
    Sword      = 4,
    Agility    = 5,
    Speed      = 6
}

local AutoTrain = {}

--// =========================
--// FUNCTIONS
--// =========================
local function getHRP()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function isAlive()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

--// =========================
--// HOME
--// =========================
Tabs.Home:AddParagraph({
    Title = "FourHub Loaded",
    Content = "AFS Endless ready 🚀"
})

--// =========================
--// AUTO TRAIN
--// =========================
for stat in pairs(STAT_ID) do
    AutoTrain[stat] = false

    Tabs.Train:AddToggle("Auto"..stat, {
        Title = "Auto "..stat,
        Default = false,
        Callback = function(v)
            AutoTrain[stat] = v
        end
    })
end

task.spawn(function()
    while task.wait(TRAIN_DELAY) do
        if isAlive() then
            for stat, enabled in pairs(AutoTrain) do
                if enabled then
                    pcall(function()
                        TrainRemote:FireServer("Train", STAT_ID[stat])
                    end)
                end
            end
        end
    end
end)

--// =========================
--// UTILITIES
--// =========================
Tabs.Home:AddButton({
    Title = "Save Position",
    Callback = function()
        local hrp = getHRP()
        if hrp then
            SavedCFrame = hrp.CFrame
            Fluent:Notify({
                Title = "Saved",
                Content = "Position saved successfully",
                Duration = 3
            })
        end
    end
})

Tabs.Home:AddToggle("AutoTP", {
    Title = "Auto TP After Death",
    Default = false,
    Callback = function(v)
        AutoTP = v
    end
})

Tabs.Home:AddToggle("AntiAFK", {
    Title = "Anti AFK",
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

player.CharacterAdded:Connect(function()
    task.wait(2)
    if AutoTP and SavedCFrame then
        local hrp = getHRP()
        if hrp then hrp.CFrame = SavedCFrame end
    end
end)

--// =========================
--// ESP
--// =========================
local function CreateESP(p)
    if p == player then return end

    local function apply(char)
        local head = char:WaitForChild("Head")
        local gui = Instance.new("BillboardGui", head)
        gui.Name = "FourHubESP"
        gui.Size = UDim2.new(0, 120, 0, 40)
        gui.StudsOffset = Vector3.new(0, 3, 0)
        gui.AlwaysOnTop = true

        local txt = Instance.new("TextLabel", gui)
        txt.BackgroundTransparency = 1
        txt.Size = UDim2.new(1,0,1,0)
        txt.TextColor3 = Color3.new(1,1,1)
        txt.TextStrokeTransparency = 0
        txt.TextSize = 14

        task.spawn(function()
            while ESPEnabled and char and char:FindFirstChild("HumanoidRootPart") do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position -
                        char.HumanoidRootPart.Position).Magnitude
                    txt.Text = p.Name.." ["..math.floor(dist).."m]"
                end
                task.wait(0.1)
            end
            gui:Destroy()
        end)
    end

    if p.Character then apply(p.Character) end
    p.CharacterAdded:Connect(apply)
end

Tabs.Visual:AddToggle("ESP", {
    Title = "Player ESP (Name/Distance)",
    Default = false,
    Callback = function(v)
        ESPEnabled = v
        if v then
            for _,plr in pairs(Players:GetPlayers()) do
                CreateESP(plr)
            end
        end
    end
})

Players.PlayerAdded:Connect(CreateESP)

--// =========================
--// TELEPORTS
--// =========================
local function TP(name, pos)
    Tabs.TP:AddButton({
        Title = name,
        Callback = function()
            local hrp = getHRP()
            if hrp then hrp.CFrame = CFrame.new(pos) end
        end
    })
end

TP("Class Shop", Vector3.new(16,80,3))
TP("Champion", Vector3.new(31,105,30))
TP("Sword Master", Vector3.new(325,69,-1990))
TP("Pain Boss", Vector3.new(1250,141,-970))

--// =========================
--// CODES
--// =========================
Tabs.Codes:AddButton({
    Title = "Copy Code: FreeChikara",
    Callback = function()
        setclipboard("FreeChikara")
    end
})

Tabs.Codes:AddButton({
    Title = "Copy Code: MORECHIKARA",
    Callback = function()
        setclipboard("MORECHIKARA")
    end
})

--// =========================
--// INFO
--// =========================
Tabs.Info:AddParagraph({
    Title = "FourHub",
    Content = [[
• Premium Script
• Fluent UI
• Optimized
• Constant Updates
]]
})

Tabs.Info:AddButton({
    Title = "Copy Discord",
    Callback = function()
        setclipboard("https://discord.gg/cUwR4tUJv3")
    end
})

--// =========================
--// FINAL NOTIFY
--// =========================
Fluent:Notify({
    Title = "FourHub",
    Content = "AFS Endless Loaded Successfully 🚀",
    Duration = 5
})
