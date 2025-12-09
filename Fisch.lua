
if getgenv().LoadedFisch then
    return
end

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/tgfgrrf/Fisch/refs/heads/main/Fisch.lua"))()

getgenv().LoadedFisch = true

print("Fisch Script Loaded Version 21")
local AutoAurora = false
local AutoKickSer = false
_G.Settings = {
    Farm = {
        Position = {},
        Mode = "Save Position",--"Trash","Level","Enchant Relic","Save Position","Freez"
        SelectBoat = "",
        EnableBoat = false,
        Enable = false,

        Cast = {
            Mode = "Perfect", -- Perfect,Random
            Enable = true
        },

        Shake = {
            Delay = 0.1,
            Enable = true
        },

        Reel = {
            Bar = "Center", -- Center , Large
            Mode = "Fast[Risk]",-- Center, Large ,Safe 80,Fast[Risk]
            ReelBarprogress = 0.67,
            Enable = true
        },

        Rod = {
            Admin_Event = "Flimsy Rod",
            FarmRod = "Flimsy Rod",
            ScyllaRod = "Flimsy Rod",
            MossjawRod = "Flimsy Rod"
        },
    },

    Boss = {
        SelectBoss = {},
        Mode = "With Farm",--with Farm ,Re Day
        Enable = false
    },

    Fish = {
        SellAll = true
    },

    Daily_Shop = {
        SelectItem = {},
        Enable = true
    },
}

function ClickMiddle()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2,0,true,a,1)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2,0,false,a,1)    
end 

function ClickCamera()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
end
function Click()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

print(game:GetService("Players").LocalPlayer.PlayerGui.loading.Enabled)




repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
repeat wait() until plr.Character:FindFirstChild("HumanoidRootPart")
repeat wait() until plr.Character:FindFirstChild("Humanoid")
repeat wait() ClickMiddle() until game:GetService("Players").LocalPlayer.PlayerGui.loading.Enabled == false 


task.wait(3)

getgenv().Load = function()
    print("Loaded!")
	if readfile and writefile and isfile and isfolder then
		if not isfolder("Hypexz V2") then
			makefolder("Hypexz V2")
		end
		if not isfolder("Hypexz V2/Fisch/") then
			makefolder("Hypexz V2/Fisch/")
		end
		if not isfile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json") then
			writefile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(_G.Settings))
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json"))
			for i,v in pairs(Decode) do
				_G.Settings[i] = v
			end
		end
	else
		return warn("Status : Undetected Executor")
	end
end

getgenv().SaveSetting = function()
    -- print("Save!")
	if readfile and writefile and isfile and isfolder then
		if not isfile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json") then
			getgenv().Load()
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json"))
			local Array = {}
			for i,v in pairs(_G.Settings) do
				Array[i] = v
			end
			writefile("Hypexz V2/Fisch/US_" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(Array))
		end
	else
		return warn("Status : Undetected Executor")
	end
end

getgenv().Load()


local DeviceType = game:GetService("UserInputService").TouchEnabled and "Mobile" or "PC"
if DeviceType == "Mobile" then
    local ClickButton = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")
    local TextButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")

    ClickButton.Name = "ClickButton"
    ClickButton.Parent = game.CoreGui
    ClickButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ClickButton
    MainFrame.AnchorPoint = Vector2.new(1, 0)
    MainFrame.BackgroundTransparency = 0.8
    MainFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38) 
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(1, -60, 0, 10)
    MainFrame.Size = UDim2.new(0, 45, 0, 45)

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = MainFrame

    UICorner_2.CornerRadius = UDim.new(0, 10)
    UICorner_2.Parent = ImageLabel

    ImageLabel.Parent = MainFrame
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(0, 45, 0, 45)
    ImageLabel.Image = "rbxassetid://"

    TextButton.Parent = MainFrame
    TextButton.BackgroundColor3 = Color3.new(1, 1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.BorderSizePixel = 0
    TextButton.Position = UDim2.new(0, 0, 0, 0)
    TextButton.Size = UDim2.new(0, 45, 0, 45)
    TextButton.AutoButtonColor = false
    TextButton.Font = Enum.Font.SourceSans
    TextButton.Text = "Open"
    TextButton.TextColor3 = Color3.new(220, 125, 255)
    TextButton.TextSize = 20

    TextButton.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftControl", false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftControl", false, game)
    end)
end


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Offset 
if DeviceType == "Mobile" then
    Offset = UDim2.fromOffset(464, 368) -- 580 * 0.8 = 464, 460 * 0.8 = 368
elseif DeviceType == "PC" then
    Offset = UDim2.fromOffset(580, 460)
end

local Window = Fluent:CreateWindow({
    Title = "Hypexz V2 ",
    SubTitle = "by dawid",
    TabWidth = 120,
    Size = Offset,--UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- local savedPosition = nil
-- if _G.Settings.Farm.Position then
-- 	local sp = _G.Settings.Farm.Position
-- 	if sp.X and sp.Y and sp.Z and sp.Yaw then
-- 		local pos = Vector3.new(sp.X, sp.Y, sp.Z)
-- 		local yawRad = math.rad(sp.Yaw)
-- 		savedPosition = CFrame.new(pos) * CFrame.Angles(0, yawRad, 0)
-- 	end
-- end

local savedPosition = nil
if _G.Settings.Farm.Position then
    local sp = _G.Settings.Farm.Position
    if sp.X and sp.Y and sp.Z and sp.Yaw then
        local pos = Vector3.new(sp.X, sp.Y, sp.Z)
        local yawRad = sp.Yaw
        savedPosition = CFrame.new(pos) * CFrame.Angles(0, yawRad, 0)
        print("Loaded saved position:", savedPosition)
    end
end


game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


spawn(function()
    while wait(1) do
        local args = {
            [1] = false
        }

        game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("afk"):FireServer(unpack(args))
    end
end)


local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end


task.spawn(function()
    while wait() do
        game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                Teleport()
            end
        end)
    end
end)



local Autokick = tick()
local TS = game:GetService("TeleportService")
local PL = game:GetService("Players")
spawn(function()
    while task.wait(1) do
        if AutoKickSer and (tick() - Autokick > 1800) then
            local ok, err = pcall(function()
               Teleport()
            end)
            if not ok then
                warn("TPReturner error:", err)
            else
                Autokick = tick() -- reset timestamp after a successful attempt to avoid spamming
            end
        end
    end
end)


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

getgenv().Ready = false

local PlayerName = LocalPlayer.Name

local Signals = {
    "Activated",
    "MouseButton1Down",
    "MouseButton2Down",
    "MouseButton1Click",
    "MouseButton2Click"
}
getgenv().rememberPosition = nil
print(getgenv().rememberPosition)


local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local function TPB(...)
    local args = {...}
    local target = args[1]
    local RealTarget

    -- === INPUT PARSING ===
    if typeof(target) == "Vector3" then
        RealTarget = CFrame.new(target)
    elseif typeof(target) == "CFrame" then
        RealTarget = target
    elseif typeof(target) == "Instance" and target:IsA("BasePart") then
        RealTarget = target.CFrame
    elseif typeof(target) == "number" and #args >= 3 then
        RealTarget = CFrame.new(args[1], args[2], args[3])
    end

end

local function TP(...)
    local args = {...}
    local targetPos = args[1]
    local RealTarget

    -- Handle different input types
    if typeof(targetPos) == "Vector3" then
        RealTarget = CFrame.new(targetPos)
    elseif typeof(targetPos) == "CFrame" then
        RealTarget = targetPos
    elseif typeof(targetPos) == "Instance" and targetPos:IsA("BasePart") then
        RealTarget = targetPos.CFrame
    elseif typeof(targetPos) == "number" then
        RealTarget = CFrame.new(unpack(args))  -- {x, y, z}
    else
        warn("TP: Invalid target type")
        return
    end

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")

    -- Death/respawn handler (no tween cancel needed)
    if humanoid.Health <= 0 then
        repeat task.wait() until humanoid.Health > 0
        task.wait(0.2)  -- Small buffer after respawn
        character = player.Character
        humanoid = character:WaitForChild("Humanoid")
        root = character:WaitForChild("HumanoidRootPart")
    end

    -- Instant player teleport
    root.CFrame = RealTarget
end

local autocast_running = false
local originalCastAsync = {}
local autoreel_running = false


local function GetProgressBarScale()
    local ok, result = pcall(function()
        local gui = PlayerGui
        if not gui then return nil end
        local reel = gui:FindFirstChild("reel")
        if not reel then return nil end
        local bar = reel:FindFirstChild("bar")
        if not bar then return nil end
        local progress = bar:FindFirstChild("progress")
        if not progress then return nil end
        local inner = progress:FindFirstChild("bar")
        if not inner then return nil end
        if inner.Size and inner.Size.X and type(inner.Size.X.Scale) == "number" then
            return inner.Size.X.Scale
        end
        return nil
    end)
    if ok then
        return result
    else
        return nil
    end
end


local Rellconnect

local function Reel()
    local RodState = workspace:WaitForChild("PlayerStats")[PlayerName].T[PlayerName].Stats.rod.Value
    local Mode = _G.Settings.Farm.Reel.Mode
    local Bar = _G.Settings.Farm.Reel.Bar
    local BareelProgress = _G.Settings.Farm.Reel.ReelBarprogress
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    
    if playerGui then
        local reel = playerGui:FindFirstChild("reel")
        if reel then
            local bar = reel:FindFirstChild("bar")
            if bar then
                local fish = bar:FindFirstChild("fish")
                local playerbar = bar:FindFirstChild("playerbar")
                
                if fish and playerbar and fish:IsA("GuiObject") and playerbar:IsA("GuiObject") then
                    if _G.Settings.Farm.Reel.Enable then
                        if Bar == "Center" then
                            spawn(function()
                                Rellconnect = game:GetService("RunService").Heartbeat:Connect(function()
                                    pcall(function()
                                        playerbar.Position = UDim2.new(fish.Position.X.Scale, 0, playerbar.Position.Y.Scale, 0)
                                    end)
                                end)
                                if Mode == "Safe 80" then
                                    local prog = GetProgressBarScale()
                                    if prog and prog >= 0.80 then
                                        pcall(function()
                                            ReplicatedStorage.events.reelfinished:FireServer(100, true)
                                            task.wait(0.5)
                                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(RodState).events.reset:FireServer()
                                        end)
                                    end
                                elseif Mode == "Fast[Risk]" then
                                    local prog = GetProgressBarScale()
                                    if prog and prog >= tonumber(BareelProgress) then
                                        pcall(function()
                                            ReplicatedStorage.events.reelfinished:FireServer(100, true)
                                            task.wait(0.5)
                                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(RodState).events.reset:FireServer()
                                        end)
                                    end
                                end
                            end)
                        elseif Bar == "Large" then
                            spawn(function()
                                pcall(function()
                                    playerbar.Size = UDim2.fromScale(1,1)
                                end)
                            end)

                            if Mode == "Safe 80" then
                                local prog = GetProgressBarScale()
                                if prog and prog >= 0.80 then
                                    pcall(function()
                                        ReplicatedStorage.events.reelfinished:FireServer(100, true)
                                        task.wait(0.5)
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(RodState).events.reset:FireServer()
                                    end)
                                end
                            elseif Mode == "Fast[Risk]" then
                                local prog = GetProgressBarScale()
                                if prog and prog > tonumber(BareelProgress) then
                                    pcall(function()
                                        ReplicatedStorage.events.reelfinished:FireServer(100, true)
                                        task.wait(0.5)
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(RodState).events.reset:FireServer()
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end





task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            --[World 1]
            if _G.Settings.Farm.Enable
            then
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                        local BodyVelocity = Instance.new("BodyVelocity")
                        BodyVelocity.Name = "BodyVelocity1"
                        BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                        BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name ~= "bobber" and v.Name ~= "handle" then
                            v.CanCollide = false    
                        end
                    end
                    for _,v in pairs(workspace.active.boats[PlayerName][_G.Settings.Farm.SelectBoat]:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false    
                            v.Anchored = false
                        end
                    end
                end
            else
                if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy();
                end
            end
        end)
    end)
end)


local function CheckBoatSpawn()
    for i,v in pairs(workspace.active.boats:GetChildren()) do
        if v.Name == (game.Players.LocalPlayer.Name) then
            return true
        end
    end
    return false
end


if not workspace:FindFirstChild("Platform") then
    local part = Instance.new("MeshPart")
    part.Name = "Platform" -- Changed to a more appropriate name
    part.Parent = game.Workspace
    part.Anchored = true
    part.Transparency = 0
    part.Size = Vector3.new(10, 0.5, 10)
end


-- spawn(function()
--     while task.wait() do 
--         pcall(function()
--             workspace:FindFirstChild("Platform").CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y -3.15,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
--         end)
--     end
-- end)



local function rememberPosition()
    spawn(function()
        local initialCFrame = HumanoidRootPart.CFrame
 
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = HumanoidRootPart
 
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.D = 100
        bodyGyro.P = 10000
        bodyGyro.CFrame = initialCFrame
        bodyGyro.Parent = HumanoidRootPart
 
        while AutoFreeze do
            HumanoidRootPart.CFrame = initialCFrame
            task.wait(0.01)
        end
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
        if bodyGyro then
            bodyGyro:Destroy()
        end
    end)
end


--Hypexz provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Rod = Window:AddTab({ Title = "Red Settings",Icon = "glass-water"}),
    Teleport = Window:AddTab{Title = "Teleport",Icon = "map"},
    Shop = Window:AddTab({Title = "Shop",Icon = "shopping-cart"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



local FarmSection = Tabs.Main:AddSection("Status")


local tmme = Tabs.Main:AddParagraph({
    Title = ""
})


spawn(function()
    while wait() do
        pcall(function()
            local scripttime = game.Workspace.DistributedGameTime
            local seconds = scripttime%60
            local minutes = math.floor(scripttime/60%60)
            local hours = math.floor(scripttime/3600)
            local tempo = string.format("%.0f Hour , %.0f Minute , %.0f Second", hours ,minutes, seconds)
            tmme:SetTitle(tempo)
        end)
    end
end)

local Status = Tabs.Main:AddParagraph({
    Title = "Status : N/A"
})

local tmsme = Tabs.Main:AddParagraph({
    Title = "Status Ready : N/A"
})

spawn(function()
    while wait(1) do
        pcall(function()
            if getgenv().Ready then
                tmsme:SetTitle("Status Ready : True")
            else
                tmsme:SetTitle("Status Ready : False")
            end
        end)
    end
end)

local tmssme = Tabs.Main:AddParagraph({
    Title = "Status Farm : N/A"
})






local FarmSection = Tabs.Main:AddSection("Main")



Tabs.Main:AddButton({
    Title = "Set Position Farm",
    Callback = function()
        Window:Dialog({
            Title = "Save Notify",
            Content = "Confirm For Save Position",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        if HumanoidRootPart then
                            _G.Settings.Farm.Position = {
                                X = HumanoidRootPart.CFrame.X,
                                Y = HumanoidRootPart.CFrame.Y,
                                Z = HumanoidRootPart.CFrame.Z,
                                Yaw = HumanoidRootPart.CFrame:ToEulerAnglesYXZ()
                            }
                            getgenv().SaveSetting()
                            savedPosition = HumanoidRootPart.CFrame
                            print("Position Saved!")
                        else
                            print("HumanoidRootPart not found!")
                        end
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancle Succ")
                    end
                }
            }
        })
    end
})

local StartFarmTogle = Tabs.Main:AddToggle("StartFarmTogle", {Title = "Enable Farm", Default = _G.Settings.Farm.Enable })
StartFarmTogle:OnChanged(function(value)
    _G.Settings.Farm.Enable = value
    getgenv().SaveSetting()
end)

local BossFarmTogle = Tabs.Main:AddToggle("BossFarmTogle", {Title = "Enable Boss Farm", Default = _G.Settings.Boss.Enable })
BossFarmTogle:OnChanged(function(value)
   _G.Settings.Boss.Enable = value
    getgenv().SaveSetting()
end)


local SellallTogle = Tabs.Main:AddToggle("SellallTogle", {Title = "Auto Sell [All]", Default = _G.Settings.Fish.SellAll })
SellallTogle:OnChanged(function(value)
    _G.Settings.Fish.SellAll = value
    getgenv().SaveSetting()
end)


local SellAllEvent = ReplicatedStorage:WaitForChild("events"):WaitForChild("SellAll")

-- Initialize sell timer
local Selltime = tick()

-- Start the auto-sell loop
spawn(function()
    while task.wait() do
        if not _G.Settings.Fish.SellAll then return end
        if tick() - Selltime >= 600 then
            local success, err = pcall(function()
                SellAllEvent:InvokeServer()
            end)
            if success then
                Selltime = tick() -- Reset timer only on success
                print("Sold all fish!",tick())
            else
                warn("Failed to sell: " .. tostring(err))
            end
        end
    end
end)


local function ChangRod(rodName)
    repeat task.wait() 
        game:GetService("ReplicatedStorage").packages.Net["RF/Rod/Equip"]:InvokeServer(rodName)
    until LocalPlayer.Backpack:FindFirstChild(rodName) or Character:FindFirstChild(rodName)
    print("Changed Rod : ",rodName)
end



local function ensureRod(rodName)
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    if not Backpack:FindFirstChild(rodName) and not Character:FindFirstChild(rodName) then
        print("Ensure : ",rodName)
        repeat task.wait() 
            game:GetService("ReplicatedStorage").packages.Net["RF/Rod/Equip"]:InvokeServer(rodName)
        until LocalPlayer.Backpack:FindFirstChild(rodName) or Character:FindFirstChild(rodName)
        print("Change Rod Success",rodName)
        return
    end
end

local function ActivateTotem()
    local Equiped = Character:FindFirstChild("Sundial Totem")
    if Equiped then
        Equiped:Activate()
        return true
    end
    return false
end


local function TeleportMode()
    local Mode = _G.Settings.Farm.Mode
    if Mode == "Trash" then
        Status:SetTitle("Status : Farm Trash")
        return CFrame.new(-1143.84082, 134.632812, -1080.47131, 0.986154318, 7.84733611e-09, -0.165830299, -1.20236212e-08, 1, -2.4180201e-08, 0.165830299, 2.58392898e-08, 0.986154318)
    elseif Mode == "Money" then
        Status:SetTitle("Status : Farm Money")
        return CFrame.new(-715.607483, -864.453674, -121.647392, -0.722895741, 7.16114954e-08, 0.690957129, 3.09414503e-08, 1, -7.12693264e-08, -0.690957129, -3.01410772e-08, -0.722895741)
    elseif Mode == "Level" then
        Status:SetTitle("Status : Farm Level")
        return CFrame.new(1376.12842, -603.603577, 2337.55347, 0.945005476, -3.90646875e-08, -0.32705453, 4.45639081e-08, 1, 9.32092448e-09, 0.32705453, -2.33831532e-08, 0.945005476)
    elseif Mode == "Enchant Relic" then
        Status:SetTitle("Status : Farm Enchant Relic")
        return CFrame.new(990.893005, -737.973633, 1465.72644, -0.978376806, -8.6212566e-09, 0.206830382, -8.02586353e-09, 1, 3.71772391e-09, -0.206830382, 1.97734251e-09, -0.978376806)
    elseif Mode == "Save Position" then
        Status:SetTitle("Status : Farm Save Position")
        return savedPosition
    end
end

local function ResetrodWhennotFound(name)
    local playerStats = workspace.PlayerStats[PlayerName]
    local rodValue = playerStats.T[PlayerName].Stats.rod.Value
    local RodChar = Character:FindFirstChild(rodValue)
    local bober = RodChar and RodChar:FindFirstChild("bobber")
    local value = RodChar and RodChar:FindFirstChild("values")
    local bite = value and value:FindFirstChild("bite")
    if bober and bite.Value == true then
        for i,v in pairs(bober:GetDescendants()) do
            if v.Name == name and v:IsA("Model") then
                return true
            end
        end
    end
    return false
end



local function GetSelfDistance(Position)
    local RootPart = HumanoidRootPart
    return (RootPart.Position - Position).Magnitude
end
local function handleBossTarget(name, targetCFrame, distanceThreshold, platformStand)
    local distance = GetSelfDistance(targetCFrame.Position)
    if distance > distanceThreshold then
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    end

    TP(targetCFrame)

    if platformStand then
        -- game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
    end

    if distance < distanceThreshold then
        getgenv().Ready = true
    end
end

local function handleBossTargetB(name, targetCFrame, distanceThreshold, platformStand)
    local distance = GetSelfDistance(targetCFrame.Position)
    if distance > distanceThreshold then
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    end

    TPB(targetCFrame)

    -- if name == "Forsaken Veil - Scylla" then
    --     if ResetrodWhennotFound("Scylla") == false then
    --         game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    --     end
    -- end

    if platformStand then
        -- game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
    end

    if distance < distanceThreshold then
        getgenv().Ready = true
    end
end

local function CheckBoss()
    local Zone = workspace.zones
    local fish = Zone:FindFirstChild("Fishing")
    local SelectedTable = _G.Settings.Boss.SelectBoss
    if type(SelectedTable) ~= "table" then return nil end

    local bossEventNames = {}
    for name in pairs(SelectedTable) do
        bossEventNames[name] = true
    end

    for _, obj in ipairs(workspace.zones.fishing:GetChildren()) do
        if obj:IsA("Part") then
            if bossEventNames[obj.Name] then
                return obj.Name --, "zone"
            end
        end
    end

    return nil 
end


local function CheckBoss2()
    local bossList = _G.Settings.Boss.SelectBoss
    local players = game:GetService("Players")

    if type(bossList) ~= "table" then return nil end

    -- Convert bossList keys to a lookup set for faster access
    local bossNames = {}
    for name in pairs(bossList) do
        bossNames[name] = true
    end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and not players:GetPlayerFromCharacter(obj) then
            if bossNames[obj.Name] then
                return obj.Name
            end
        end
    end

    return nil
    
end


local function CheckAuroraTotem()
    AuroraTotem = LocalPlayer.Backpack:FindFirstChild("Aurora Totem") or Character:FindFirstChild("Aurora Totem")
    if AuroraTotem then
        return true
    else
        return false
    end
end

local function Checkweather()
    local WorldFolder = ReplicatedStorage:WaitForChild("world")
    local WeatherValue = WorldFolder:WaitForChild("weather").Value
    if WeatherValue:match("Aurora") then
        return true
    else
        return false
    end
end

local function CheckDayNight()
    local WorldFolder = ReplicatedStorage:WaitForChild("world")
    local CycleValue = WorldFolder:WaitForChild("cycle").Value
    if CycleValue == "Day" then
        return "Day"
    elseif CycleValue == "Night" then
        return "Night"
    else
        return "Dusk"
    end
end



spawn(function()

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")

    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    local Humanoid = Character:WaitForChild("Humanoid")


    local BOSS_TARGETS = {
        ["Elder Mossjaw"] = {
            cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
            threshold = 10
        },
        ["MossjawHunt"] = {
            cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
            threshold = 10
        },
        ["Forsaken Veil - Scylla"] = {
            cframe = CFrame.new(-2508.34229, -11224.4805, 6893.28467, -0.0316809788, -3.53211824e-08, -0.99949801, 2.09912301e-08, 1, -3.60042769e-08, 0.99949801, -2.21213448e-08, -0.0316809788),
            threshold = 10
        },
        ["Megalodon Default"] = {
            offset = Vector3.new(0, 20, 0),
            zone = "Megalodon Default",
            threshold = 10,
            platformStand = true
        },
        ["Megalodon Ancient"] = {
            offset = Vector3.new(0, 20, 0),
            zone = "Megalodon Ancient",
            threshold = 10,
            platformStand = true
        },
        ["The Kraken Pool"] = {
            offset = Vector3.new(0, 70, 0),
            zone = "The Kraken Pool",
            threshold = 10,
            platformStand = true
        },
        ["Ancient Kraken Pool"] = {
            offset = Vector3.new(0, 70, 0),
            zone = "Ancient Kraken Pool",
            threshold = 10,
            platformStand = true
        },
        ["Orcas Pool"] = {
            offset = Vector3.new(0, 90, 0),
            zone = "Orcas Pool",
            threshold = 10,
            platformStand = true
        },
        ["Ancient Orcas Pool"] = {
            offset = Vector3.new(0, 90, 0),
            zone = "Ancient Orcas Pool",
            threshold = 10,
            platformStand = true
        },
        ["FischFright25"] = {
            offset = Vector3.new(0, 80, 0),
            zone = "FischFright25",
            threshold = 10,
            platformStand = true
        },
        ["Whales Pool"] = {
            offset = Vector3.new(0, 80, 0),
            zone = "Whales Pool",
            threshold = 10,
            platformStand = true
        },
        ["Colossal Blue Dragon"] = {
            offset = Vector3.new(0, -10, 0),
            zone = "Colossal Blue Dragon",
            threshold = 10,
            platformStand = true
        },
        ["Colossal Ethereal Dragon"] = {
            offset = Vector3.new(0, -10, 0),
            zone = "Colossal Ethereal Dragon",
            threshold = 10,
            platformStand = true
        },
        ["Colossal Ancient Dragon"] = {
            offset = Vector3.new(0, -10, 0),
            zone = "Colossal Ancient Dragon",
            threshold = 10,
            platformStand = true
        },
    }

    local ZonesFolder = Workspace:WaitForChild("zones"):WaitForChild("fishing")
    local function getBossTargetCFrame(info)
        if info.cframe then
            return info.cframe
        elseif info.zone then
            local zone = ZonesFolder:FindFirstChild(info.zone)
            if zone then
                return zone.CFrame * CFrame.new(info.offset or Vector3.zero)
            end
        end
        return nil
    end


    RunService.Heartbeat:Connect(function()
        if not _G.Settings.Farm.Enable then
            getgenv().Ready = false
            return
        end

        xpcall(function()

            local WorldFolder = ReplicatedStorage:WaitForChild("world")
            local WeatherValue = WorldFolder:WaitForChild("weather").Value
            local CycleValue = WorldFolder:WaitForChild("cycle").Value
            local ZonesFolder = Workspace:WaitForChild("zones"):WaitForChild("fishing")

            local ROD_SCYLLA = _G.Settings.Farm.Rod.ScyllaRod or "Rod Of The Zenith"
            local ROD_MOSSJAW = _G.Settings.Farm.Rod.MossjawRod or "Elder Mossripper"
            local ROD_MAIN = _G.Settings.Farm.Rod.FarmRod or "Tryhard Rod"

            local Settings = _G.Settings
            local Farm = Settings.Farm
            local Boss = Settings.Boss
            local ModeFarm = Farm.Mode

            local Totem = Backpack:FindFirstChild("Sundial Totem")
            local EquippedTotem = Character:FindFirstChild("Sundial Totem")
            local BossSpawn = CheckBoss() or CheckBoss2()
            local BossInfo = BossSpawn and BOSS_TARGETS[BossSpawn]

           
    
            if Farm.EnableBoat then
                if CheckBoatSpawn() == false then
                    print("Buy Boat ",_G.Settings.Farm.SelectBoat)
                    TP(CFrame.new(357.625305, 133.644257, 257.625977, 0.0732683763, -5.62927838e-09, 0.997312248, 1.60819891e-09, 1, 5.52630119e-09, -0.997312248, 1.19897337e-09, 0.0732683763))
                    local args = {
                        [1] = {
                            ["voice"] = 8,
                            ["idle"] = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Moosewood Shipwright"):WaitForChild("description"):WaitForChild("idle"),
                            ["npc"] = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Moosewood Shipwright")
                        }
                    }

                    workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Moosewood Shipwright"):WaitForChild("shipwright"):WaitForChild("giveUI"):InvokeServer(unpack(args))
                    local args = {
                            [1] = _G.Settings.Farm.SelectBoat
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net"):WaitForChild("RF/Boats/Spawn"):InvokeServer(unpack(args))
                    repeat task.wait()
                    until CheckBoatSpawn() == true
                    if game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.shipwright.Visible == true then
                        game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.shipwright.Visible = false
                    end
                elseif CheckBoatSpawn() then
                    if Character.Humanoid.Sit == false then
                        for _,x in pairs(workspace.active.boats:GetChildren()) do
                            if x.Name == game.Players.LocalPlayer.Name then
                                local CBoat = x:FindFirstChild(_G.Settings.Farm.SelectBoat)
                                if CBoat then
                                    for i,v in pairs(CBoat:GetDescendants()) do
                                        if v:IsA("ProximityPrompt") and v.Name == "sitprompt" then
                                            fireproximityprompt(v)
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if Boss.Enable then
                            if BossSpawn and BossInfo then
                                AutoFreeze = false
                                if BossSpawn == "Forsaken Veil - Scylla" then
                                    ensureRod(ROD_SCYLLA)
                                elseif BossSpawn == "Elder Mossjaw" or BossSpawn == "MossjawHunt" then
                                    ensureRod(ROD_MOSSJAW)
                                else 
                                    ensureRod(ROD_MAIN)
                                end

                                local targetCFrame = getBossTargetCFrame(BossInfo)
                                if targetCFrame then
                                    Status:SetTitle("Status : Farm "..BossSpawn)
                                    handleBossTargetB(BossSpawn, targetCFrame, BossInfo.threshold, BossInfo.platformStand)
                                    return
                                end
                            end


                            if Boss.Mode == "Re Day" then
                                Status:SetTitle("Status : Re Day Find Boss")
                                if not WeatherValue:match("Aurora") then
                                    if EquippedTotem then
                                        local currentCycle = CycleValue
                                        if currentCycle == "Day" or currentCycle == "Night" then
                                            task.wait(1)
                                            ClickCamera()
                                            repeat task.wait() until not Settings.Farm.Enable or Boss.Mode ~= "Re Day" or WorldFolder:WaitForChild("cycle").Value ~= currentCycle
                                        end
                                    else
                                        Humanoid:EquipTool(Totem)
                                    end
                                else
                                    ensureRod(ROD_MAIN)
                                    if ModeFarm == "Save Position" then
                                        AutoFreeze = false
                                        Status:SetTitle("Status : Position")
                                        TPB(savedPosition)
                                    else
                                        Status:SetTitle("Status : Non Position")
                                        rememberPosition()
                                        AutoFreeze = true
                                    end
                                    getgenv().Ready = true
                                end
                            else
                                ensureRod(ROD_MAIN)
                                if ModeFarm == "Save Position" then
                                    AutoFreeze = false
                                    Status:SetTitle("Status : Position")
                                    TPB(savedPosition)
                                else
                                    Status:SetTitle("Status : Non Position")
                                    rememberPosition()
                                    AutoFreeze = true
                                end
                                getgenv().Ready = true
                            end
                        else
                            ensureRod(ROD_MAIN)
                            if ModeFarm == "Save Position" then
                                AutoFreeze = false
                                Status:SetTitle("Status : Position")
                                TPB(savedPosition)
                            else
                                Status:SetTitle("Status : Non Position")
                                rememberPosition()
                                AutoFreeze = true
                            end
                            getgenv().Ready = true
                        end
                    end
                end
            else
                if Boss.Enable then
                    if BossSpawn and BossInfo then
                        AutoFreeze = false
                        -- if BossSpawn == "Forsaken Veil - Scylla" then
                        --     ensureRod(ROD_SCYLLA)
                        -- elseif BossSpawn == "Elder Mossjaw" or BossSpawn == "MossjawHunt" then
                        --     ensureRod(ROD_MOSSJAW)
                        -- else 
                        --     ensureRod(ROD_MAIN)
                        -- end

                        

                        local targetCFrame = getBossTargetCFrame(BossInfo)
                        if targetCFrame then
                            Status:SetTitle("Status : Farm "..tostring(BossSpawn))
                            handleBossTarget(BossSpawn, targetCFrame, BossInfo.threshold, BossInfo.platformStand)
                            return
                        end
                    end


                    if Boss.Mode == "Re Day" then
                        Status:SetTitle("Status : Re Day Find Boss")
                        if not WeatherValue:match("Aurora") then
                            if EquippedTotem then
                                local currentCycle = CycleValue
                                EquippedTotem:Activate()
                                repeat task.wait(1)
                                    CycleValue = WorldFolder:WaitForChild("cycle").Value
                                until CycleValue ~= currentCycle or not Settings.Farm.Enable or Boss.Mode ~= "Re Day"
                            else
                                Humanoid:EquipTool(Totem)
                            end
                        else
                            -- ensureRod(ROD_MAIN)
                            TP(TeleportMode())
                            getgenv().Ready = true
                        end
                    else
                        -- ensureRod(ROD_MAIN)
                        TP(TeleportMode())
                        getgenv().Ready = true
                    end
                else
                    -- ensureRod(ROD_MAIN)
                    TP(TeleportMode())
                    getgenv().Ready = true
                end
            end
        end, warn)
    end)
end)

local function CheckSundialTotem()
    SundialTotem = LocalPlayer.Backpack:FindFirstChild("Sundial Totem") or Character:FindFirstChild("Sundial Totem")
    if SundialTotem then
        return true
    else
        return false
    end
end

local function CheckRainBow()
    local WorldFolder = ReplicatedStorage:WaitForChild("world")
    local WeatherValue = WorldFolder:WaitForChild("weather").Value
    if WeatherValue:match("Rainbow") then
        return true
    else
        return false
    end
end

local function equipTool(toolName)
	local backpack = LocalPlayer:WaitForChild("Backpack")
	for _, item in pairs(backpack:GetChildren()) do
		if item:IsA("Tool") and item.Name == toolName then
			item.Parent = LocalPlayer.Character
			print(toolName .. " equipped.")
			return item
		end
	end
	print(toolName .. " not found in backpack!")
	return nil
end

local function unequipTool(toolName)
	local char = LocalPlayer.Character
	if char then
		for _, item in pairs(char:GetChildren()) do
			if item:IsA("Tool") and item.Name == toolName then
				item.Parent = LocalPlayer.Backpack
				print(toolName .. " unequipped.")
			end
		end
	end
end

local function useTool(tool)
	if tool and tool:IsA("Tool") then
		task.wait(0.3)
		tool:Activate()
		print(tool.Name .. " used.")
	end
end

local world = ReplicatedStorage:WaitForChild("world")
local cycle = world:WaitForChild("cycle")
local weather = world:WaitForChild("weather")


local function CheckInventory(itemName)
    local character = LocalPlayer.Character
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack") -- LocalPlayer:FindFirstChild("Backpack")
    if not character:FindFirstChild(itemName) and not backpack:FindFirstChild(itemName) then 
        return false 
    end
    return true
end


-- local lastCheck = 0
-- local RESET_TIME = 10
-- local LastReel = tick()
-- spawn(function()
--     while RunService.Heartbeat:Wait() do
--         if getgenv().Ready then 

--             local BOSS_TARGETS = {
--                 ["Elder Mossjaw"] = {
--                     cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
--                     threshold = 10
--                 },
--                 ["MossjawHunt"] = {
--                     cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
--                     threshold = 10
--                 },
--                 ["Forsaken Veil - Scylla"] = {
--                     cframe = CFrame.new(-2508.34229, -11224.4805, 6893.28467, -0.0316809788, -3.53211824e-08, -0.99949801, 2.09912301e-08, 1, -3.60042769e-08, 0.99949801, -2.21213448e-08, -0.0316809788),
--                     threshold = 10
--                 },
--                 ["Megalodon Default"] = {
--                     offset = Vector3.new(0, 20, 0),
--                     zone = "Megalodon Default",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Megalodon Ancient"] = {
--                     offset = Vector3.new(0, 20, 0),
--                     zone = "Megalodon Ancient",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["The Kraken Pool"] = {
--                     offset = Vector3.new(0, 70, 0),
--                     zone = "The Kraken Pool",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Ancient Kraken Pool"] = {
--                     offset = Vector3.new(0, 70, 0),
--                     zone = "Ancient Kraken Pool",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Orcas Pool"] = {
--                     offset = Vector3.new(0, 90, 0),
--                     zone = "Orcas Pool",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Ancient Orcas Pool"] = {
--                     offset = Vector3.new(0, 90, 0),
--                     zone = "Ancient Orcas Pool",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["FischFright25"] = {
--                     offset = Vector3.new(0, 80, 0),
--                     zone = "FischFright25",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Whales Pool"] = {
--                     offset = Vector3.new(0, 80, 0),
--                     zone = "Whales Pool",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Colossal Blue Dragon"] = {
--                     offset = Vector3.new(0, -10, 0),
--                     zone = "Colossal Blue Dragon",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Colossal Ethereal Dragon"] = {
--                     offset = Vector3.new(0, -10, 0),
--                     zone = "Colossal Ethereal Dragon",
--                     threshold = 10,
--                     platformStand = true
--                 },
--                 ["Colossal Ancient Dragon"] = {
--                     offset = Vector3.new(0, -10, 0),
--                     zone = "Colossal Ancient Dragon",
--                     threshold = 10,
--                     platformStand = true
--                 },
--             }
            
--             local function equipAndUseSundial()
--                 unequipTool("Aurora Totem")
--                 local sundial = equipTool("Sundial Totem")
--                 if sundial then
--                     useTool(sundial)
--                 end
--             end

--             local function equipAndUseAurora()
--                 unequipTool("Sundial Totem")
--                 local aurora = equipTool("Aurora Totem")
--                 if aurora then
--                     useTool(aurora)
--                 end
--             end

--             local success, result = pcall(function()
--                 local playerStats = workspace.PlayerStats[PlayerName]
--                 local rodValue = playerStats.T[PlayerName].Stats.rod.Value
--                 local rodCharacter = Character:FindFirstChild(rodValue)
--                 local rodTool = LocalPlayer.Backpack:FindFirstChild(rodValue)
--                 local ShakeDelay = _G.Settings.Farm.Shake.Delay
--                 local CastMode = _G.Settings.Farm.Cast.Mode
--                 local AuroraTotem, SundialTotem = Character:FindFirstChild("Aurora Totem"), Character:FindFirstChild("Sundial Totem")

--                 tmssme:SetTitle("Status Farm : True")


--                 if AutoAurora and CheckAuroraTotem() and CheckSundialTotem() and not Checkweather() and not CheckRainBow() then
--                     if cycle.Value == "Day" then
--                         equipAndUseSundial()
--                         local connection
--                         connection = cycle:GetPropertyChangedSignal("Value"):Connect(function()
--                             if cycle.Value == "Night" then
--                                 connection:Disconnect()
--                                 equipAndUseAurora()
--                                 if weather.Value ~= "Aurora_Borealis" then
--                                     weather:GetPropertyChangedSignal("Value"):Wait()
--                                 end
--                             end
--                         end)
--                     elseif cycle.Value == "Night" then
--                         equipAndUseAurora()
--                         local connection1
--                         connection1 = cycle:GetPropertyChangedSignal("Value"):Connect(function()
--                             if cycle.Value == "Day" then
--                                 connection1:Disconnect()
--                                 equipAndUseSundial()
--                                 local connection2
--                                 connection2 = cycle:GetPropertyChangedSignal("Value"):Connect(function()
--                                     if cycle.Value == "Night" then
--                                         connection2:Disconnect()
--                                         equipAndUseAurora()
--                                         if weather.Value ~= "Aurora_Borealis" then
--                                             weather:GetPropertyChangedSignal("Value"):Wait()
--                                         end
--                                     end
--                                 end)
--                             end
--                         end)
--                     end
--                 end


--                 local ROD_SCYLLA = _G.Settings.Farm.Rod.ScyllaRod or "Rod Of The Zenith"
--                 local ROD_MOSSJAW = _G.Settings.Farm.Rod.MossjawRod or "Elder Mossripper"
--                 local ROD_MAIN = _G.Settings.Farm.Rod.FarmRod or "Tryhard Rod"
--                 local Rod_Event = _G.Settings.Farm.Rod.Admin_Event or "Cerulean Fang Rod"


--                 local Settings = _G.Settings
--                 local Farm = Settings.Farm
--                 local Boss = Settings.Boss
--                 local ModeFarm = Farm.Mode
--                 local BossSpawn = CheckBoss() or CheckBoss2()
--                 local EventState = game:GetService("ReplicatedStorage").world.admin_event.Value


--                 local RodSelect
--                 if EventState ~= "None" then
--                     if not CheckInventory(Rod_Event) then
--                         print(Rod_Event.." not found in inventory")
--                         ChangRod(Rod_Event)
--                         RodSelect = Rod_Event
--                     else
--                         RodSelect = Rod_Event
--                     end
--                 elseif Boss.Enable then
--                     if BossSpawn then
--                         if BossSpawn == "Forsaken Veil - Scylla" then
--                             if not CheckInventory(ROD_SCYLLA) then
--                                 print(ROD_SCYLLA.." not found in inventory")
--                                 ChangRod(ROD_SCYLLA)
--                                 RodSelect = ROD_SCYLLA
--                             else
--                                 RodSelect = ROD_SCYLLA
--                             end
--                         elseif BossSpawn == "Elder Mossjaw" or BossSpawn == "MossjawHunt" then
--                             if not CheckInventory(ROD_MOSSJAW) then
--                                 print(ROD_MOSSJAW.." not found in inventory")
--                                 ChangRod(ROD_MOSSJAW)
--                                 RodSelect = ROD_MOSSJAW
--                             else
--                                 RodSelect = ROD_MOSSJAW
--                             end
--                         else 
--                             if not CheckInventory(ROD_MAIN) then
--                                 print(ROD_MAIN.." not found in inventory")
--                                 ChangRod(ROD_MAIN)
--                                 RodSelect = ROD_MAIN
--                             else
--                                 RodSelect = ROD_MAIN
--                             end
--                         end
--                     else
--                         if not CheckInventory(ROD_MAIN) then
--                             print(ROD_MAIN.." not found in inventory")
--                             ChangRod(ROD_MAIN)
--                             RodSelect = ROD_MAIN
--                         else
--                             RodSelect = ROD_MAIN
--                         end
--                     end
--                 else
--                     if not CheckInventory(ROD_MAIN) then
--                         print(ROD_MAIN.." not found in inventory")
--                         ChangRod(ROD_MAIN)
--                         RodSelect = ROD_MAIN
--                     else
--                         RodSelect = ROD_MAIN
--                     end
--                 end


                
--                 if not Character:FindFirstChild(RodSelect) then
--                     print("wait for equip tool ",RodSelect)
--                     repeat RunService.Heartbeat:Wait() until LocalPlayer.Backpack:FindFirstChild(RodSelect) or not getgenv().Ready
--                     if LocalPlayer.Backpack:FindFirstChild(RodSelect) then
--                         print("Equip Tool ",RodSelect)
--                         LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(RodSelect))
--                     end
--                     rodCharacter = Character:FindFirstChild(RodSelect)
--                     print("wait for rod ",RodSelect)
--                     repeat RunService.Heartbeat:Wait() 
--                         rodCharacter = Character:FindFirstChild(RodSelect)
--                     until rodCharacter or not getgenv().Ready
--                     print("Found rod ",RodSelect)
--                 else
--                     repeat RunService.Heartbeat:Wait()
--                         -- print("fishing...")
--                         local rodCharacter = Character:FindFirstChild(RodSelect)
--                         local bobber = rodCharacter:FindFirstChild("bobber")
--                         local shakeUi = PlayerGui:FindFirstChild("shakeui")
--                         local reelUi = PlayerGui:FindFirstChild("reel")
--                         if not bobber and _G.Settings.Farm.Cast.Enable then
--                             print("cast")
--                             local castPower = (_G.Settings.Farm.Cast.Mode == "Perfect" and 100) or (_G.Settings.Farm.Cast.Mode == "Random" and math.random(75,100)) or 100
--                             rodCharacter.events.castAsync:InvokeServer(castPower, 1)
--                             repeat wait() until rodCharacter:FindFirstChild("bobber") or not getgenv().Ready or not Character:FindFirstChild(RodSelect)
--                         elseif shakeUi and _G.Settings.Farm.Shake.Enable then
--                             print("shake")
--                             repeat RunService.Heartbeat:Wait(ShakeDelay)
--                                 local safezone = shakeUi:FindFirstChild("safezone")
--                                 local button = safezone and safezone:FindFirstChild("button")
--                                 if button then
--                                     GuiService.SelectedObject = button
--                                     if GuiService.SelectedObject == button then
--                                         VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
--                                         VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
--                                     end
--                                 end
--                                 shakeUi = PlayerGui:FindFirstChild("shakeui")
--                             until not shakeUi or not getgenv().Ready or not Character:FindFirstChild(RodSelect)
--                         elseif reelUi and _G.Settings.Farm.Reel.Enable then
--                             print("reel")
--                             local RodState = workspace:WaitForChild("PlayerStats")[PlayerName].T[PlayerName].Stats.rod.Value
--                             local Mode = _G.Settings.Farm.Reel.Mode
--                             local Bar = _G.Settings.Farm.Reel.Bar
--                             local BareelProgress = _G.Settings.Farm.Reel.ReelBarprogress
--                             local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

--                             -- repeat RunService.Heartbeat:Wait()
--                                 local reel = PlayerGui:FindFirstChild("reel")
--                                 local bar = reel and reel:FindFirstChild("bar")
--                                 local playerbar = bar and bar:FindFirstChild("playerbar")
--                                 playerbar:GetPropertyChangedSignal('Position'):Wait()
--                                 task.wait(1)
--                                 pcall(function()
--                                     game.ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished"):FireServer(100, true)
--                                 end)
--                                 repeat wait() until not PlayerGui:FindFirstChild("reel") or not getgenv().Ready or not Character:FindFirstChild(RodSelect)
--                                 print("Reel Finished")
--                                 -- until not playerbar or not getgenv().Ready or not Character:FindFirstChild(RodSelect)
--                         end
--                     until not getgenv().Ready or not Character:FindFirstChild(RodSelect)
--                 end
--             end)
            
--             if not success then
--                 warn("Error:", result)
--             end
--         else
--             tmssme:SetTitle("Status Farm : False")
--         end
--     end
-- end)

task.spawn(function()
    while task.wait() do
        if getgenv().Ready then
            local BOSS_TARGETS = {
                ["Elder Mossjaw"] = {
                    cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
                    threshold = 10
                },
                ["MossjawHunt"] = {
                    cframe = CFrame.new(-4861.78271, -1793.96008, -10126.1406, 0.999018729, 9.09287579e-08, -0.0442892015, -9.21281185e-08, 1, -2.50390126e-08, 0.0442892015, 2.90947231e-08, 0.999018729),
                    threshold = 10
                },
                ["Forsaken Veil - Scylla"] = {
                    cframe = CFrame.new(-2508.34229, -11224.4805, 6893.28467, -0.0316809788, -3.53211824e-08, -0.99949801, 2.09912301e-08, 1, -3.60042769e-08, 0.99949801, -2.21213448e-08, -0.0316809788),
                    threshold = 10
                },
                ["Megalodon Default"] = {
                    offset = Vector3.new(0, 20, 0),
                    zone = "Megalodon Default",
                    threshold = 10,
                    platformStand = true
                },
                ["Megalodon Ancient"] = {
                    offset = Vector3.new(0, 20, 0),
                    zone = "Megalodon Ancient",
                    threshold = 10,
                    platformStand = true
                },
                ["The Kraken Pool"] = {
                    offset = Vector3.new(0, 70, 0),
                    zone = "The Kraken Pool",
                    threshold = 10,
                    platformStand = true
                },
                ["Ancient Kraken Pool"] = {
                    offset = Vector3.new(0, 70, 0),
                    zone = "Ancient Kraken Pool",
                    threshold = 10,
                    platformStand = true
                },
                ["Orcas Pool"] = {
                    offset = Vector3.new(0, 90, 0),
                    zone = "Orcas Pool",
                    threshold = 10,
                    platformStand = true
                },
                ["Ancient Orcas Pool"] = {
                    offset = Vector3.new(0, 90, 0),
                    zone = "Ancient Orcas Pool",
                    threshold = 10,
                    platformStand = true
                },
                ["FischFright25"] = {
                    offset = Vector3.new(0, 80, 0),
                    zone = "FischFright25",
                    threshold = 10,
                    platformStand = true
                },
                ["Whales Pool"] = {
                    offset = Vector3.new(0, 80, 0),
                    zone = "Whales Pool",
                    threshold = 10,
                    platformStand = true
                },
                ["Colossal Blue Dragon"] = {
                    offset = Vector3.new(0, -10, 0),
                    zone = "Colossal Blue Dragon",
                    threshold = 10,
                    platformStand = true
                },
                ["Colossal Ethereal Dragon"] = {
                    offset = Vector3.new(0, -10, 0),
                    zone = "Colossal Ethereal Dragon",
                    threshold = 10,
                    platformStand = true
                },
                ["Colossal Ancient Dragon"] = {
                    offset = Vector3.new(0, -10, 0),
                    zone = "Colossal Ancient Dragon",
                    threshold = 10,
                    platformStand = true
                },
            }


            local suc , err = pcall(function()
                tmssme:SetTitle("Status Farm : True")
                local ShakeDelay = _G.Settings.Farm.Shake.Delay
                local CastMode = _G.Settings.Farm.Cast.Mode
                -----------------------------
                local ROD_SCYLLA = _G.Settings.Farm.Rod.ScyllaRod or "Rod Of The Zenith"
                local ROD_MOSSJAW = _G.Settings.Farm.Rod.MossjawRod or "Elder Mossripper"
                local ROD_MAIN = _G.Settings.Farm.Rod.FarmRod or "Tryhard Rod"
                local Rod_Event = _G.Settings.Farm.Rod.Admin_Event or "Cerulean Fang Rod"
                -----------------------------
                local Settings = _G.Settings
                local Farm = Settings.Farm
                local Boss = Settings.Boss
                local ModeFarm = Farm.Mode
                local BossSpawn = CheckBoss() or CheckBoss2()
                local EventState = game:GetService("ReplicatedStorage").world.admin_event.Value


                _G.RodSelect = nil
                if EventState ~= "None" then
                    _G.RodSelect = Rod_Event
                elseif Boss.Enable then
                    if BossSpawn then
                        if BossSpawn == "Forsaken Veil - Scylla" then
                            _G.RodSelect = ROD_SCYLLA
                        elseif BossSpawn == "Elder Mossjaw" or BossSpawn == "MossjawHunt" then
                            _G.RodSelect = ROD_MOSSJAW
                        else 
                            _G.RodSelect = ROD_MAIN
                        end
                    else
                        _G.RodSelect = ROD_MAIN
                    end
                else
                    _G.RodSelect = ROD_MAIN
                end



                if not Character:FindFirstChild(_G.RodSelect) then
                    if not LocalPlayer.Backpack:FindFirstChild(_G.RodSelect) then
                        ChangRod(_G.RodSelect)
                        -- print("Changing Rod to : ",_G.RodSelect)
                    end
                    print("wait for equip tool : ",_G.RodSelect)
                    repeat RunService.Heartbeat:Wait(1) until LocalPlayer.Backpack:FindFirstChild(_G.RodSelect) or not getgenv().Ready
                    if LocalPlayer.Backpack:FindFirstChild(_G.RodSelect) then
                        print("Equip Tool : ",_G.RodSelect)
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(_G.RodSelect))
                    end
                    repeat RunService.Heartbeat:Wait(1) until Character:FindFirstChild(_G.RodSelect) or not getgenv().Ready
                    print("Equiped Rod : ",_G.RodSelect)
                end

                local rodCharacter = Character:FindFirstChild(_G.RodSelect)
                local bobber = rodCharacter:FindFirstChild("bobber")
                local ShakeUi = PlayerGui:FindFirstChild("shakeui")
                local ReelUi = PlayerGui:FindFirstChild("reel")

                if not bobber and _G.Settings.Farm.Cast.Enable then
                    print("cast")
                    local castPower = (_G.Settings.Farm.Cast.Mode == "Perfect" and 100) or (_G.Settings.Farm.Cast.Mode == "Random" and math.random(75,100)) or 100
                    rodCharacter.events.castAsync:InvokeServer(castPower, math.huge)
                    task.wait(0.5)
                end

                if ShakeUi and _G.Settings.Farm.Shake.Enable then
                    print("shake")
                    repeat 
                        RunService.Heartbeat:Wait(ShakeDelay)
                        local safezone = ShakeUi:FindFirstChild("safezone")
                        local button = safezone and safezone:FindFirstChild("button")
                        if button then
                            GuiService.SelectedObject = button
                            if GuiService.SelectedObject == button then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                            end
                        end
                        ShakeUi = PlayerGui:FindFirstChild("shakeui")
                    until not ShakeUi or not getgenv().Ready or not Character:FindFirstChild(_G.RodSelect)
                end

                if ReelUi and _G.Settings.Farm.Reel.Enable then
                    print("reel")
                    pcall(function()
                        local reel = PlayerGui:FindFirstChild("reel")
                        local bar = reel and reel:FindFirstChild("bar")
                        local playerbar = bar and bar:FindFirstChild("playerbar")
                        playerbar:GetPropertyChangedSignal('Position'):Wait()
                        print("Reel Position Changed")
                        task.wait(0.8)
                        game.ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished"):FireServer(100, true)
                    end)
                    repeat task.wait() until not PlayerGui:FindFirstChild("reel") or not getgenv().Ready or not Character:FindFirstChild(_G.RodSelect)
                    print("Reel Finished")
                end
            end)

            if not suc then
                warn("Error:", err)
            end
        end
    end
end)

local FarmSection = Tabs.Main:AddSection("Setting Farm")

local Mfv = Tabs.Main:AddDropdown("Mfv", {
    Title = "Select Mode Farm",
    Values = {"Money","Trash","Level","Enchant Relic","Save Position","Freez"},
    Multi = false,
    Default = _G.Settings.Farm.Mode,
})

Mfv:OnChanged(function(Value)
    _G.Settings.Farm.Mode = Value
    getgenv().SaveSetting()
end)


local CMV = Tabs.Main:AddDropdown("CMV", {
    Title = "Select Mode Cast",
    Values = {"Perfect","Random"},
    Multi = false,
    Default = _G.Settings.Farm.Cast.Mode,
})

CMV:OnChanged(function(Value)
    _G.Settings.Farm.Cast.Mode = Value
    getgenv().SaveSetting()
end)



local SSDL = Tabs.Main:AddInput("SSDL", {
    Title = "Set Shake Delay",
    Default = _G.Settings.Farm.Shake["Delay"],
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        _G.Settings.Farm.Shake["Delay"] = Value
        getgenv().SaveSetting()
    end
})

-- local SRBPDL = Tabs.Main:AddInput("SRBPDL", {
--     Title = "Set Reel Barprogress[Fast Mode only]",
--     Default = _G.Settings.Farm.Reel.ReelBarprogress,
--     Numeric = true, -- Only allows numbers
--     Finished = true, -- Only calls callback when you press enter
--     Callback = function(Value)
--         _G.Settings.Farm.Reel.ReelBarprogress = Value
--         getgenv().SaveSetting()
--     end
-- })

-- local RMV = Tabs.Main:AddDropdown("RMV", {
--     Title = "Select Bar Reel",
--     Values = {"Center","Large"},
--     Multi = false,
--     Default = _G.Settings.Farm.Reel.Bar,
-- })

-- RMV:OnChanged(function(Value)
--     _G.Settings.Farm.Reel.Bar = Value
--     getgenv().SaveSetting()
-- end)

-- local RMV = Tabs.Main:AddDropdown("RMV", {
--     Title = "Select Mode Reel",
--     Values = {"Safe 80","Fast[Risk]"},
--     Multi = false,
--     Default = _G.Settings.Farm.Reel.Mode,
-- })

-- RMV:OnChanged(function(Value)
--     _G.Settings.Farm.Reel.Mode = Value
--     getgenv().SaveSetting()
-- end)

local Myboat = {}
local PlayersStats = workspace.PlayerStats[PlayerName].T[PlayerName].Boats
for i,v in pairs(PlayersStats:GetChildren()) do
    table.insert(Myboat,v.Name)
end

table.sort(Myboat,function(a,b) return a:lower() < b:lower() end)

local Selectb = Tabs.Main:AddDropdown("Selectb", {
    Title = "Select Boat",
    Values = Myboat,
    Multi = false,
    Default = _G.Settings.Farm.SelectBoat,
})

Selectb:OnChanged(function(Value)
    _G.Settings.Farm.SelectBoat = Value
    getgenv().SaveSetting()
end)


local FarmSection = Tabs.Main:AddSection("Boss")

bosslist = {
    "FischFright25",
    "Elder Mossjaw",
    "MossjawHunt",
    "Forsaken Veil - Scylla",
    "Megalodon Default",
    "Megalodon Ancient",
    "The Kraken Pool",
    "Ancient Kraken Pool",
    "Orcas Pool",
    "Whales Pool",
    "Ancient Orcas Pool",
    "Colossal Blue Dragon",
    "Colossal Ethereal Dragon",
    "Colossal Ancient Dragon"
}

local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
    Title = "Select Boss",
    Description = "Select Boss Farm",
    Values = bosslist,
    Multi = true,
    Default = _G.Settings.Boss.SelectBoss,
})


MultiDropdown:OnChanged(function(Value)
    _G.Settings.Boss.SelectBoss = Value
    getgenv().SaveSetting()
end)


local SelectModeFarmBoss = Tabs.Main:AddDropdown("SelectModeFarmBoss", {
    Title = "Select Mode Farm Boss",
    Description = "Select Mode Farm Boss",
    Values = {"With Farm","Re Day"},
    Multi = false,
    Default =  _G.Settings.Boss.Mode,
})


SelectModeFarmBoss:OnChanged(function(Value)
    _G.Settings.Boss.Mode = Value
    getgenv().SaveSetting()
end)


local FarmSection = Tabs.Main:AddSection("Crab Cage")



local PlaceCrabcage = Tabs.Main:AddToggle("PlaceCrabcage", {Title = "Auto Place Crab Cage", Default = false })

PlaceCrabcage:OnChanged(function(value)
    startAutoPlace = value
end)

spawn(function()
    while task.wait() do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local crabCage = character:FindFirstChild("Crab Cage")
        pcall(function()
            if startAutoPlace then
                local events = game:GetService("ReplicatedStorage"):FindFirstChild("events")
                if events then
                    local cancelEmote = events:FindFirstChild("CancelEmote")
                    if cancelEmote then
                        cancelEmote:FireServer()
                    end
                end
                if LocalPlayer.Backpack:FindFirstChild("Crab Cage") then
                    Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Crab Cage"))
                elseif Character:FindFirstChild("Crab Cage") then
                    if crabCage and crabCage:FindFirstChild("Deploy") then
                        -- -- local args = {
                        -- --     [1] = CFrame.new(character.HumanoidRootPart.Position)
                        -- -- }
                        -- crabCage.Deploy:FireServer(CFrame.new(character.HumanoidRootPart.Position))
                    Character:FindFirstChild("Crab Cage").Deploy:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                    end
                    task.wait(0.1)
                else
                    Fluent:Notify({
                        Title = "Hypexz v2",
                        Content = "No Crab Cage",
                        Duration = 3
                    })
                    Options.PlaceCrabcage:SetValue(false)
                    return
                end
            end
        end)
    end
end)

local CollectCrabcage = Tabs.Main:AddToggle("CollectCrabcage", {Title = "Auto Collect Crab Cage", Default = false })

CollectCrabcage:OnChanged(function(value)
    AutoCollectCrabCage = value
end)

local skibidy

spawn(function()
    while task.wait() do
        if AutoCollectCrabCage then
            for i,v in pairs(workspace.active.crabcages:GetDescendants()) do
                if v.Name == PlayerName then
                    local prompt = v.Prompt
                    if prompt then
                        prompt.HoldDuration = 0
                        fireproximityprompt(prompt)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while wait() do
        for i,v in pairs(workspace.active.crabcages:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                v.Transparency = 1
            end
        end
    end
end)

local AutobuyCrabCage = Tabs.Main:AddToggle("AutobuyCrabCage", {Title = "Auto Buy Crab Cage", Default = false })

AutobuyCrabCage:OnChanged(function(value)
    AutobuyCrabCagevalue = value
end)

spawn(function()
    while task.wait() do
        if AutobuyCrabCagevalue then
            pcall(function()
                TP(CFrame.new(474.875, 150.50001525878906, 232.84576416015625))
                for i, v in pairs(workspace.world.interactables["Crab Cage"]:GetChildren()) do
                    if v.Name == "Crab Cage" then
                        for j, z in pairs(v:GetChildren()) do
                            if z.Name == "PromptTemplate" and z:IsA("ProximityPrompt") then
                                fireproximityprompt(z)
                            end
                        end
                    end
                end

                task.wait(0.1)
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                    if v:IsA("TextBox") and v.Name == "amount" then
                        v.Text = 50
                    end
                end
                for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                    if v:IsA("ImageButton") or v:IsA("TextButton") and v.Name == 'confirm' then
                        for i, Signal in pairs(Signals) do
                            firesignal(v[Signal])
                        end
                    end
                end
            end)
        end
    end
end)


local FarmSection = Tabs.Main:AddSection("Treasure Hunt")

local AutoRepairtoggle = Tabs.Main:AddToggle("AutoRepairtoggle", {Title = "Auto Repair Map", Default = false })

AutoRepairtoggle:OnChanged(function(value)
    AutoRepair = value
end)

spawn(function()
    while task.wait() do
        if AutoRepair then
            local Player = game.Players.LocalPlayer
            local Jack = workspace.world.npcs:FindFirstChild("Jack Marrow")
            if not Jack then 
                TP(CFrame.new(-2824.359, 214.311, 1518.130))
                repeat wait() until workspace.world.npcs:FindFirstChild("Jack Marrow") or not  AutoRepair
            else
                for _, v in pairs(Player.Backpack:GetChildren()) do
                    if v.Name == "Treasure Map" then
                        Player.Character.Humanoid:EquipTool(v)
                        workspace.world.npcs["Jack Marrow"].treasure.repairmap:InvokeServer()
                    end
                end
            end
        end
    end
end)


local AutoOpenChestToggle = Tabs.Main:AddToggle("AutoOpenChestToggle", {Title = "Auto Open Cheast", Default = false })

AutoOpenChestToggle:OnChanged(function(value)
    AutoOpenChest = value
end)

spawn(function()
    while task.wait() do
        if AutoOpenChest then
            for _, v in ipairs(workspace.world.chests:GetDescendants()) do
                if v.ClassName == "ProximityPrompt" then
                    v.HoldDuration = 0
                end
            end

            for _, v in pairs(workspace.world.chests:GetDescendants()) do
                if v:IsA("Part") and v:FindFirstChild("ChestSetup") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    for _, prompt in pairs(workspace.world.chests:GetDescendants()) do
                        if prompt.Name == "ProximityPrompt" then
                            fireproximityprompt(prompt)
                        end
                    end
                    task.wait(1)
                end
            end
        end
    end
end)

local FarmSection = Tabs.Main:AddSection("Enable Setting")

local EnableCastToggle = Tabs.Main:AddToggle("EnableCastToggle", {Title = "Enable Cast", Default = _G.Settings.Farm.Cast.Enable })

EnableCastToggle:OnChanged(function(value)
    _G.Settings.Farm.Cast.Enable = value
    getgenv().SaveSetting()
end)

local EnableShakeToggle = Tabs.Main:AddToggle("EnableShakeToggle", {Title = "Enable Shake", Default = _G.Settings.Farm.Shake.Enable })

EnableShakeToggle:OnChanged(function(value)
    _G.Settings.Farm.Shake.Enable = value
    getgenv().SaveSetting()
end)

local EnableReelToggle = Tabs.Main:AddToggle("EnableReelToggle", {Title = "Enable Reel", Default = _G.Settings.Farm.Reel.Enable })

EnableReelToggle:OnChanged(function(value)
    _G.Settings.Farm.Reel.Enable = value
    getgenv().SaveSetting()
end)


local EnableBoatToggle = Tabs.Main:AddToggle("EnableBoatToggle", {Title = "Enable Farm WithBoat", Default = _G.Settings.Farm.EnableBoat })

EnableBoatToggle:OnChanged(function(value)
    _G.Settings.Farm.EnableBoat = value
    getgenv().SaveSetting()
end)

local FarmSection = Tabs.Rod:AddSection("Rod Setting")

local PathRod = workspace.PlayerStats[PlayerName].T[PlayerName].Rods
local RodNames = {}
local RodNameSet = {}

for _, v in pairs(PathRod:GetChildren()) do
    if not RodNameSet[v.Name] then
        table.insert(RodNames, v.Name)
        RodNameSet[v.Name] = true
    end
end

table.sort(RodNames, function(a, b)
    return a:lower() < b:lower()
end)

local SelectRodm = Tabs.Rod:AddDropdown("SelectRodm", {
    Title = "Select Main Rod",
    Values = RodNames,
    Multi = false,
    Default = _G.Settings.Farm.Rod.FarmRod,
})

SelectRodm:OnChanged(function(value)
    _G.Settings.Farm.Rod.FarmRod = value
    getgenv().SaveSetting()
end)

local SelectRodsc = Tabs.Rod:AddDropdown("SelectRodsc", {
    Title = "Select Scylla Rod",
    Values = RodNames,
    Multi = false,
    Default = _G.Settings.Farm.Rod.ScyllaRod,
})

SelectRodsc:OnChanged(function(value)
    _G.Settings.Farm.Rod.ScyllaRod = value
    getgenv().SaveSetting()
end)

local SelectRodmj = Tabs.Rod:AddDropdown("SelectRodmj", {
    Title = "Select MossJaw Rod",
    Values = RodNames,
    Multi = false,
    Default = _G.Settings.Farm.Rod.MossjawRod,
})

SelectRodmj:OnChanged(function(value)
    _G.Settings.Farm.Rod.MossjawRod = value
    getgenv().SaveSetting()
end)


local SelectRodam = Tabs.Rod:AddDropdown("SelectRodam", {
    Title = "Select Admin Event Rod",
    Values = RodNames,
    Multi = false,
    Default = _G.Settings.Farm.Rod.Admin_Event,
})

SelectRodam:OnChanged(function(value)
    _G.Settings.Farm.Rod.Admin_Event = value
    getgenv().SaveSetting()
end)


Tabs.Rod:AddButton({
    Title = "Refresh Rod List",
    Description = "Refresh Rod List",
    Callback = function()
        table.Clear(RodNames)
        for _, v in pairs(PathRod:GetChildren()) do
            RodNameSet[v.Name] = false
            if not RodNameSet[v.Name] then
                table.insert(RodNames, v.Name)
                RodNameSet[v.Name] = true
            end
        end
        table.sort(RodNames, function(a, b)
            return a:lower() < b:lower()
        end)
        Options.SelectRodm:UpdateOptions(RodNames)
        Options.SelectRodsc:UpdateOptions(RodNames)
        Options.SelectRodmj:UpdateOptions(RodNames)
        Options.SelectRodam:UpdateOptions(RodNames)
    end
})


local extraTPs = {
    {
        Name = "Carrot Garden", Position = Vector3.new(3744, -1116, -1108)
    },
    {
        Name = "Crystal Cove",
        Position = Vector3.new(1364, -612, 2472)
    },
    {
        Name = "Underground Music Venue",
        Position = Vector3.new(2043, -645, 2471)
    },
    {
        Name = "Castaway Cliffs",
        Position = Vector3.new(655, 179, -1793)
    },
    {
        Name = "Luminescent Cavern",
        Position = Vector3.new(-1016, -337, -4071)
    },
    {
        Name = "Crimson Cavern",
        Position = Vector3.new(-1013, -340, -4891)
    },
    {
        Name = "Oscar's Locker",
        Position = Vector3.new(266, -387, 3407)
    },
    {
        Name = "The Boom Ball",
        Position = Vector3.new(-1296, -900, -3479)
    },
    {
        Name = "Lost Jungle",
        Position = Vector3.new(-2690, 149, -2051)
    }
}

local tpFolder = workspace:WaitForChild("world"):WaitForChild("spawns"):WaitForChild("TpSpots")

local tpNames = {}
for _, spot in ipairs(tpFolder:GetChildren()) do
    table.insert(tpNames, spot.Name)
end

for _, tp in ipairs(extraTPs) do
    table.insert(tpNames, tp.Name)
end

table.sort(tpNames,function(a,b) return a:lower() < b:lower() end)

local teleport_running = false
local function StartTeleport()
    if teleport_running then return end
    teleport_running = true
    
    local hrp = Character.HumanoidRootPart
    local spot = tpFolder:FindFirstChild(selectedIsland)

    if not spot then
        for _, tp in ipairs(extraTPs) do
            if tp.Name == selectedIsland then
                spot = {CFrame = CFrame.new(tp.Position)}
                break
            end
        end
    end

    if hrp and spot then
        pcall(function() hrp.CFrame = spot.CFrame + Vector3.new(0,5,0) end)
    end
    task.wait()

teleport_running = false

end

local SelectTplocla = Tabs.Teleport:AddDropdown("", {
    Title = "Select Location",
    Values = tpNames,
    Multi = false,
    Default = 1,
})


SelectTplocla:OnChanged(function(Value)
    selectedIsland = Value
end)

Tabs.Teleport:AddButton({
    Title = "Teleport",
    Description = "",
    Callback = function()
        StartTeleport()
    end
})


local FarmSection = Tabs.Teleport:AddSection("Enchant")

local Encchantlist = {
    "Abyssal",
    "Blessed",
    "Blood Reckoning",
    "Breezed",
    "Chaotic",
    "Chronos",
    "Clever",
    "Controlled",
    "Divine",
    "Flashline",
    "Ghastly",
    "Hasty",
    "Insight",
    "Long",
    "Lucky",
    "Momentum",
    "Mutated",
    "Noir",
    "Quality",
    "Resilient",
    "Scavenger",
    "Sea King",
    "Scrapper",
    "Steady",
    "Storming",
    "Swift",
    "Unbreakable",
    "Wormhole"
}

table.sort(Encchantlist,function(a,b) return a:lower() < b:lower() end)

local SelectEnc = Tabs.Teleport:AddDropdown("SelectEnc", {
    Title = "Select Enchant",
    Values = Encchantlist,
    Multi = false,
    Default = 1,
})

SelectEnc:OnChanged(function(value)
    SelectedEnc = value
end)


local SatrtEnchant = Tabs.Teleport:AddToggle("SatrtEnchant", {Title = "Start Enchant", Default = false })


SatrtEnchant:OnChanged(function(value)
    AutoEnchant = value
end)

 spawn(function()
    while task.wait() do
        -- local suc , err = pcall(function()
            if AutoEnchant then
                local RodState = workspace:WaitForChild("PlayerStats")[PlayerName].T[PlayerName].Stats.rod.Value
                if workspace.PlayerStats[PlayerName].T[PlayerName].Rods[RodState].Value == SelectedEnc then
                    Fluent:Notify({
                        Title = "Hypexz v2",
                        Content = (RodState.." : Found Enc : "..SelectedEnc),
                        Duration = 3
                    })
                    Options.SatrtEnchant:SetValue(false)
                    return
                end
                TP(CFrame.new(1309.2786865234375, -802.427001953125, -83.36397552490234))
                wait(.2)
                if not game.Players.LocalPlayer.Character:FindFirstChild("Enchant Relic") then
                    EnchantRelic = nil
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA('Tool') and v.Name == 'Enchant Relic' then
                            EnchantRelic = v
                        end
                    end
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(EnchantRelic)
                else
                    for _, Enchant in pairs(workspace.world.interactables:GetChildren()) do
                        if Enchant:IsA('Model') and Enchant.Name == 'Enchant Altar' then
                            Enchant.PromptTemplate.HoldDuration = 0
                            if workspace.world.interactables["Enchant Altar"].PromptTemplate.Enabled == true then
                                fireproximityprompt(Enchant.PromptTemplate)
                            end
                            wait(0.3)
                            if game:GetService("Players").LocalPlayer.PlayerGui.over:FindFirstChild("prompt") then
                                for _, Button in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                                    if Button:IsA("ImageButton") or Button:IsA("TextButton") and Button.Name == 'confirm' then
                                        for i, Signal in pairs(Signals) do
                                            firesignal(Button[Signal])
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        -- end)
    end
end)


local ExaltedList = {
    "Anomalous",
    "Herculean",
    "Immortal",
    "Invincible",
    "Mystical",
    "Piercing",
    "Quantum",
    "Sea Overlord"
}

table.sort(ExaltedList,function(a,b) return a:lower() < b:lower() end)

local SelectExEnc = Tabs.Teleport:AddDropdown("SelectExEnc", {
    Title = "Select Exalted Enchant",
    Values = ExaltedList,
    Multi = false,
    Default = 1,
})

SelectExEnc:OnChanged(function(value)
    SelectedExEnc = value
end)


local SatrtExEnchant = Tabs.Teleport:AddToggle("SatrtExEnchant", {Title = "Start Exalted Enchant", Default = false })


SatrtExEnchant:OnChanged(function(value)
    AutoExEnchant = value
    local RodState = workspace:WaitForChild("PlayerStats")[PlayerName].T[PlayerName].Stats.rod.Value
    spawn(function()
        while task.wait() do
            -- xpcall(function()
                if AutoExEnchant then
                    if workspace.PlayerStats[PlayerName].T[PlayerName].Rods[RodState].Value == SelectedExEnc then
                        Fluent:Notify({
                            Title = "Hypexz v2",
                            Content = (RodState.." : Found Enc : "..SelectedExEnc),
                            Duration = 3
                        })
                        Options.SatrtEnchant:SetValue(false)
                        return
                    end
                    TP(CFrame.new(1309.2786865234375, -802.427001953125, -83.36397552490234))
                    wait(.2)
                    if not game.Players.LocalPlayer.Character:FindFirstChild("Exalted Relic") then
                        EnchantRelic = nil
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA('Tool') and v.Name == 'Exalted Relic' then
                                EnchantRelic = v
                            end
                        end
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(EnchantRelic)
                    else
                        for _, Enchant in pairs(workspace.world.interactables:GetChildren()) do
                            if Enchant:IsA('Model') and Enchant.Name == 'Enchant Altar' then
                                Enchant.PromptTemplate.HoldDuration = 0
                                if workspace.world.interactables["Enchant Altar"].PromptTemplate.Enabled == true then
                                    fireproximityprompt(Enchant.PromptTemplate)
                                end
                                wait(1)
                                if game:GetService("Players").LocalPlayer.PlayerGui.over:FindFirstChild("prompt") then
                                    for _, Button in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                                        if Button:IsA("ImageButton") or Button:IsA("TextButton") and Button.Name == 'confirm' then
                                            for i, Signal in pairs(Signals) do
                                                firesignal(Button[Signal])
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            -- end,print)
        end
    end)
end)


local CosmicList = {
    "Cryogenic",
    "Glittered",
    "Overclocked",
    "Sea Prince",
    "Tenacity",
    "Tryhard",
    "Wise"
}

local FarmSection = Tabs.Teleport:AddSection("Server")

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId
local function rejoinServer()
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end



Tabs.Teleport:AddButton({
    Title = "Rejoin Server",
    Description = "Rejoin Your Server",
    Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

Tabs.Teleport:AddButton({
    Title = "Vip Server",
    Description = "Create Vip Server",
    Callback = function()
       local md5 = {}
        local hmac = {}
        local base64 = {}

        do
            do
                local T = {
                    0xd76aa478,
                    0xe8c7b756,
                    0x242070db,
                    0xc1bdceee,
                    0xf57c0faf,
                    0x4787c62a,
                    0xa8304613,
                    0xfd469501,
                    0x698098d8,
                    0x8b44f7af,
                    0xffff5bb1,
                    0x895cd7be,
                    0x6b901122,
                    0xfd987193,
                    0xa679438e,
                    0x49b40821,
                    0xf61e2562,
                    0xc040b340,
                    0x265e5a51,
                    0xe9b6c7aa,
                    0xd62f105d,
                    0x02441453,
                    0xd8a1e681,
                    0xe7d3fbc8,
                    0x21e1cde6,
                    0xc33707d6,
                    0xf4d50d87,
                    0x455a14ed,
                    0xa9e3e905,
                    0xfcefa3f8,
                    0x676f02d9,
                    0x8d2a4c8a,
                    0xfffa3942,
                    0x8771f681,
                    0x6d9d6122,
                    0xfde5380c,
                    0xa4beea44,
                    0x4bdecfa9,
                    0xf6bb4b60,
                    0xbebfbc70,
                    0x289b7ec6,
                    0xeaa127fa,
                    0xd4ef3085,
                    0x04881d05,
                    0xd9d4d039,
                    0xe6db99e5,
                    0x1fa27cf8,
                    0xc4ac5665,
                    0xf4292244,
                    0x432aff97,
                    0xab9423a7,
                    0xfc93a039,
                    0x655b59c3,
                    0x8f0ccc92,
                    0xffeff47d,
                    0x85845dd1,
                    0x6fa87e4f,
                    0xfe2ce6e0,
                    0xa3014314,
                    0x4e0811a1,
                    0xf7537e82,
                    0xbd3af235,
                    0x2ad7d2bb,
                    0xeb86d391,
                }

                local function add(a, b)
                    local lsw = bit32.band(a, 0xFFFF) + bit32.band(b, 0xFFFF)
                    local msw = bit32.rshift(a, 16) + bit32.rshift(b, 16) + bit32.rshift(lsw, 16)
                    return bit32.bor(bit32.lshift(msw, 16), bit32.band(lsw, 0xFFFF))
                end

                local function rol(x, n)
                    return bit32.bor(bit32.lshift(x, n), bit32.rshift(x, 32 - n))
                end

                local function F(x, y, z)
                    return bit32.bor(bit32.band(x, y), bit32.band(bit32.bnot(x), z))
                end
                local function G(x, y, z)
                    return bit32.bor(bit32.band(x, z), bit32.band(y, bit32.bnot(z)))
                end
                local function H(x, y, z)
                    return bit32.bxor(x, bit32.bxor(y, z))
                end
                local function I(x, y, z)
                    return bit32.bxor(y, bit32.bor(x, bit32.bnot(z)))
                end

                function md5.sum(message)
                    local a, b, c, d = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476

                    local message_len = #message
                    local padded_message = message .. "\128"
                    while #padded_message % 64 ~= 56 do
                        padded_message = padded_message .. "\0"
                    end

                    local len_bytes = ""
                    local len_bits = message_len * 8
                    for i = 0, 7 do
                        len_bytes = len_bytes .. string.char(bit32.band(bit32.rshift(len_bits, i * 8), 0xFF))
                    end
                    padded_message = padded_message .. len_bytes

                    for i = 1, #padded_message, 64 do
                        local chunk = padded_message:sub(i, i + 63)
                        local X = {}
                        for j = 0, 15 do
                            local b1, b2, b3, b4 = chunk:byte(j * 4 + 1, j * 4 + 4)
                            X[j] = bit32.bor(b1, bit32.lshift(b2, 8), bit32.lshift(b3, 16), bit32.lshift(b4, 24))
                        end

                        local aa, bb, cc, dd = a, b, c, d

                        local s = { 7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21 }

                        for j = 0, 63 do
                            local f, k, shift_index
                            if j < 16 then
                                f = F(b, c, d)
                                k = j
                                shift_index = j % 4
                            elseif j < 32 then
                                f = G(b, c, d)
                                k = (1 + 5 * j) % 16
                                shift_index = 4 + (j % 4)
                            elseif j < 48 then
                                f = H(b, c, d)
                                k = (5 + 3 * j) % 16
                                shift_index = 8 + (j % 4)
                            else
                                f = I(b, c, d)
                                k = (7 * j) % 16
                                shift_index = 12 + (j % 4)
                            end

                            local temp = add(a, f)
                            temp = add(temp, X[k])
                            temp = add(temp, T[j + 1])
                            temp = rol(temp, s[shift_index + 1])

                            local new_b = add(b, temp)
                            a, b, c, d = d, new_b, b, c
                        end

                        a = add(a, aa)
                        b = add(b, bb)
                        c = add(c, cc)
                        d = add(d, dd)
                    end

                    local function to_le_hex(n)
                        local s = ""
                        for i = 0, 3 do
                            s = s .. string.char(bit32.band(bit32.rshift(n, i * 8), 0xFF))
                        end
                        return s
                    end

                    return to_le_hex(a) .. to_le_hex(b) .. to_le_hex(c) .. to_le_hex(d)
                end
            end

            do
                function hmac.new(key, msg, hash_func)
                    if #key > 64 then
                        key = hash_func(key)
                    end

                    local o_key_pad = ""
                    local i_key_pad = ""
                    for i = 1, 64 do
                        local byte = (i <= #key and string.byte(key, i)) or 0
                        o_key_pad = o_key_pad .. string.char(bit32.bxor(byte, 0x5C))
                        i_key_pad = i_key_pad .. string.char(bit32.bxor(byte, 0x36))
                    end

                    return hash_func(o_key_pad .. hash_func(i_key_pad .. msg))
                end
            end

            do
                local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

                function base64.encode(data)
                    return (
                        (data:gsub(".", function(x)
                            local r, b_val = "", x:byte()
                            for i = 8, 1, -1 do
                                r = r .. (b_val % 2 ^ i - b_val % 2 ^ (i - 1) > 0 and "1" or "0")
                            end
                            return r
                        end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
                            if #x < 6 then
                                return ""
                            end
                            local c = 0
                            for i = 1, 6 do
                                c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
                            end
                            return b:sub(c + 1, c + 1)
                        end) .. ({ "", "==", "=" })[#data % 3 + 1]
                    )
                end
            end
        end

        local function GenerateReservedServerCode(placeId)
            local uuid = {}
            for i = 1, 16 do
                uuid[i] = math.random(0, 255)
            end

            uuid[7] = bit32.bor(bit32.band(uuid[7], 0x0F), 0x40) -- v4
            uuid[9] = bit32.bor(bit32.band(uuid[9], 0x3F), 0x80) -- RFC 4122

            local firstBytes = ""
            for i = 1, 16 do
                firstBytes = firstBytes .. string.char(uuid[i])
            end

            local gameCode =
                string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", table.unpack(uuid))

            local placeIdBytes = ""
            local pIdRec = placeId
            for _ = 1, 8 do
                placeIdBytes = placeIdBytes .. string.char(pIdRec % 256)
                pIdRec = math.floor(pIdRec / 256)
            end

            local content = firstBytes .. placeIdBytes

            local SUPERDUPERSECRETROBLOXKEYTHATTHEYDIDNTCHANGEEVERSINCEFOREVER = "e4Yn8ckbCJtw2sv7qmbg" -- legacy leaked key from ages ago that still works due to roblox being roblox.
            local signature = hmac.new(SUPERDUPERSECRETROBLOXKEYTHATTHEYDIDNTCHANGEEVERSINCEFOREVER, content, md5.sum)

            local accessCodeBytes = signature .. content

            local accessCode = base64.encode(accessCodeBytes)
            accessCode = accessCode:gsub("+", "-"):gsub("/", "_")

            local pdding = 0
            accessCode, _ = accessCode:gsub("=", function()
                pdding = pdding + 1
                return ""
            end)

            accessCode = accessCode .. tostring(pdding)

            return accessCode, gameCode
        end

        local accessCode, _ = GenerateReservedServerCode(game.PlaceId)
        game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", accessCode)
    end
})


local FarmSection = Tabs.Shop:AddSection("Totem")


local TotemList = {
    "Aurora",
    "Sundial",
    "Windset",
    "Smokescreen",
    "Tempest"
}

table.sort(TotemList,function(a,b) return a:lower() < b:lower() end)

local SelectTotem = Tabs.Shop:AddDropdown("SelectTotem", {
    Title = "Select Totem",
    Values = TotemList,
    Multi = false,
    Default = 1,
})

SelectTotem:OnChanged(function(Value)
    SelectedTOtem = Value
end)

local TotemInfo = {
    ["Aurora"] = CFrame.new(-1811, -137, -3282),
    ["Sundial"] = CFrame.new(-1148, 135, -1075),
    ["Windset"] = CFrame.new(2849, 178, 2702),
    ["Smokescreen"] = CFrame.new(2789, 140, -625),
    ["Tempest"] = CFrame.new(35, 133, 1943)
}

Tabs.Shop:AddButton({
    Title = "Teleport To Totem",
    Description = "warp To Selected Totem",
    Callback = function()
        TP(TotemInfo[SelectedTOtem])
    end
})

local BaitsList = {
    "Bait Crate",
    "Quality Bait Crate",
    "Tropical Bait Crate",
    "Coral Geode"
}


local BaitInfo = {
    ["Bait Crate"] = CFrame.new(-1470, 133, 669),
    ["Quality Bait Crate"] = CFrame.new(-220.0375518798828, 134.93197631835938, 1891.3602294921875),
    ["Tropical Bait Crate"] = CFrame.new(-922.9197998046875, 131.4174041748047, -1104.6754150390625),
    ["Coral Geode"] = CFrame.new(-1645, -210, -2855)
}

table.sort(BaitsList,function(a,b) return a:lower() < b:lower() end)

local SelectBait = Tabs.Shop:AddDropdown("SelectBait", {
    Title = "Select Bait Create",
    Values = BaitsList,
    Multi = false,
    Default = 1,
})


SelectBait:OnChanged(function(Value)
    SelectedBait = Value
end)


local AmountBait = Tabs.Shop:AddInput("AmountBait", {
    Title = "Bait [per 1t ime]",
    Default = 50,
    Numeric = true, 
    Finished = true,
    Callback = function(Value)
        AmountBaitValue = Value
        print(AmountBaitValue)
    end
})

local StatBuyBait = Tabs.Shop:AddToggle("StatBuyBait", {Title = "Start Buy Bait", Default = false })

StatBuyBait:OnChanged(function(value)
    pstartbuy = value
end)

spawn(function()
    while task.wait() do
        if pstartbuy then 
            local suc , err = pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = BaitInfo[SelectedBait]
                if SelectedBait == "Tropical Bait Crate" then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA('Model') and v.Name == "Tropical Bait Crate" then
                            local nested = v:FindFirstChild("Tropical Bait Crate")
                            if nested and nested:FindFirstChild("PromptTemplate") then
                                local prompt = nested.PromptTemplate
                                if prompt:IsA("ProximityPrompt") then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                else
                    for _, v in pairs(workspace.world.interactables:GetDescendants()) do
                        if v:IsA('Model') and v.Name == SelectedBait then
                            for _, x in pairs(v:GetDescendants()) do
                                if x:IsA('ProximityPrompt') and x.Name == 'PromptTemplate' then
                                    fireproximityprompt(x)
                                end
                            end
                        end
                    end 
                end
                task.wait()
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                    if v:IsA("TextBox") and v.Name == "amount" then
                        v.Text = tonumber(AmountBaitValue)
                    end
                end

                local Signals = {
                    "Activated",
                    "MouseButton1Down",
                    "MouseButton2Down",
                    "MouseButton1Click",
                    "MouseButton2Click"
                }
                for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.over:GetDescendants()) do
                    if v:IsA("ImageButton") or v:IsA("TextButton") and v.Name == 'confirm' then
                        for i, Signal in pairs(Signals) do
                            firesignal(v[Signal])
                        end
                    end
                end
            end)
            if not suc then
                warn(err)  
            end
        end
    end
end)

local Openbiat = Tabs.Shop:AddToggle("Openbiat", {Title = "Auto Open Bait", Default = false })

Openbiat:OnChanged(function(value)
    AutoOpenBait = value
end)


spawn(function()
    while RunService.Heartbeat:Wait() do
        if AutoOpenBait then 
            if LocalPlayer.Backpack:FindFirstChild(SelectedBait) then
                Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(SelectedBait))
            elseif Character:FindFirstChild(SelectedBait) then
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
            else
                Fluent:Notify({
                    Title = "Hypexz v2",
                    Content = "No have : "..SelectedBait,
                    Duration = 3
                })
                AutoOpenBait = false
                return
            end
        end
    end
end)

local FarmSection = Tabs.Shop:AddSection("Daily Shop")

-- game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.BlackMarket.Visible 

Tabs.Shop:AddButton({
    Title = "Open Black Market",
    Description = "",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.BlackMarket.Visible = true
    end
})


local FarmSection = Tabs.Shop:AddSection("Daily Shop")

local Itemlist = {
    "Sundial Totem",
    "Enchant Relic",
    "Meteor Totem",
    "Exalted Relic",
    "Mutation Totem",
    "Aurora Totem",
    "Shiny Totem",
    "Scylla Hunt Totem",
    "Megalodon Hunt Totem",
    "Kraken Hunt Totem",
    "Sparkling Totem",
    "Lunar Thread",
    "Moonstone",
    "Nuke"
}


table.sort(Itemlist,function(a,b) return a:lower() < b:lower() end)

local SelectItemDialyShop = Tabs.Shop:AddDropdown("SelectItemDialyShop", {
    Title = "Select Item",
    Values = Itemlist,
    Multi = true,
    Default = _G.Settings.Daily_Shop.SelectItem,
})



SelectItemDialyShop:OnChanged(function(Value)
    _G.Settings.Daily_Shop.SelectItem = Value
    getgenv().SaveSetting()
end)

for i,v in pairs(_G.Settings.Daily_Shop.SelectItem) do
    print(v)
end




local AutoBuyDailyShop = Tabs.Shop:AddToggle("AutoBuyDailyShop", {Title = "Auto Buy", Default = _G.Settings.Daily_Shop.Enable })



AutoBuyDailyShop:OnChanged(function(Value)
    _G.Settings.Daily_Shop.Enable = Value
    getgenv().SaveSetting()
end)

spawn(function()
    while task.wait() do
        if _G.Settings.Daily_Shop.Enable then
            xpcall(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local player = Players.LocalPlayer
                local dailyShopList = player.PlayerGui:WaitForChild("hud").safezone.DailyShop.List
                local BuyParent = {}
                local SSr = _G.Settings.Daily_Shop.SelectItem
                for _, v in pairs(dailyShopList:GetDescendants()) do
                    if v.Name == "Label" and v:IsA("TextLabel") then
                        local itemName = v.Text 
                        if table.find(SSr,itemName) then
                            table.insert(BuyParent, v.Parent)
                        end
                    end
                end

                for _, itemFrame in pairs(BuyParent) do
                    local soldOut = itemFrame:FindFirstChild("SoldOut")
                    if soldOut and not soldOut.Visible then
                        local itemName = itemFrame.Name -- or itemFrame.Label.Text
                        pcall(function()
                            ReplicatedStorage
                                :WaitForChild("packages")
                                :WaitForChild("Net")
                                :WaitForChild("RE/DailyShop/Purchase")
                                :FireServer(itemName)
                        end)
                    end
                end
            end,warn)
        end
    end
end)






SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("Hypexzv2ScriptHub")
SaveManager:SetFolder("Hypexzv2ScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Hypexz v2",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()



