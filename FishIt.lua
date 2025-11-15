local success, WindUI = pcall(function()
    -- NOVO LINK DIRETO (Raw) para maior estabilidade.
    local script_content = game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/main.lua")
    return loadstring(script_content)()
end)

if not success or not WindUI then
    warn("⚠️ UI failed to load!(Tentei o link RAW, falhou!)")
    return
else
    print("✓ UI loaded successfully!")
end

local Window = WindUI:CreateWindow({
    Title = "FourHub", -- EDITADO
    Icon = "rbxassetid://137518578026159",
    Author = "Premium | Fish It",
    Folder = "FOUR_HUB", -- EDITADO
    Size = UDim2.fromOffset(260, 290),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 170,
    HasOutline = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:SetTheme("Dark")
        end,
    },
})

Window:Tag({
    Title = "v0.0.3.5",
    Color = Color3.fromRGB(255, 255, 255),
    Radius = 17,
})

WindUI:Notify({
    Title = "FourHub Loaded", -- EDITADO
    Content = "UI loaded successfully!",
    Duration = 3,
    Icon = "bell",
})

local Tab1 = Window:Tab({
    Title = "Info",
    Icon = "info",
})

Tab1:Section({
    Title = "Community",
    Icon = "chevrons-left-right-ellipsis",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab1:Divider()

Tab1:Button({
    Title = "Discord",
    Desc = "click to copy link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/cUwR4tUJv3")
        end
    end
})

Tab1:Divider()

Tab1:Section({
    Title = "Join discord for update",
    TextXAlignment = "Left",
    TextSize = 17,
})

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Tab2 = Window:Tab({
    Title = "Players",
    Icon = "user",
})

Tab2:Slider({
    Title = "Speed",
    Desc = false,
    Step = 1,
    Value = {
        Min = 18,
        Max = 100,
        Default = 18,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = Value
    end
})

Tab2:Slider({
    Title = "Jump",
    Desc = false,
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = Value
    end
})

Tab2:Divider()

Tab2:Button({
    Title = "Reset Jump Power",
    Desc = "Return Jump Power to normal (50)",
    Callback = function()
        _G.CustomJumpPower = 50
        local humanoid = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
        print("🔄 Jump Power reset to 50")
    end
})

Player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.UseJumpPower = true
    humanoid.JumpPower = _G.CustomJumpPower or 50
end)

Tab2:Button({
    Title = "Reset Speed",
    Desc = "Return speed to normal (18)",
    Callback = function()
        Humanoid.WalkSpeed = 18
        print("WalkSpeed reset to default (18)")
    end
})

Tab2:Divider()

local UserInputService = game:GetService("UserInputService")

Tab2:Toggle({
    Title = "Infinite Jump",
    Desc = "activate to use infinite jump",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.InfiniteJump = state
        if state then
            print("✅ Infinite Jump Active")
        else
            print("❌ Infinite Jump Inactive")
        end
    end
})

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
})

Tab2:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.Noclip = state
        task.spawn(function()
            local Player = game:GetService("Players").LocalPlayer
            while _G.Noclip do
                task.wait(0.1)
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local isFrozen = false
local lastPos = nil

local function notify(msg, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FREEZE] " .. msg,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function freezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	lastPos = root.CFrame

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		pcall(function() track:Stop(0) end)
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		pcall(function() animator:Destroy() end)
	end

	root.Anchored = true
end

local function unfreezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		humanoid.AutoRotate = true
		humanoid.PlatformStand = false
		if not humanoid:FindFirstChildOfClass("Animator") then
			local newAnimator = Instance.new("Animator")
			newAnimator.Parent = humanoid
		end
	end

	if root then
		root.Anchored = false
		if lastPos then
			root.CFrame = lastPos
		end
	end
end

local function toggleFreeze(state)
	isFrozen = state
	local char = player.Character or player.CharacterAdded:Wait()

	if state then
		freezeCharacter(char)
		notify("Freeze character", Color3.fromRGB(100,200,255))
	else
		unfreezeCharacter(char)
		notify("Character released", Color3.fromRGB(255,150,150))
	end
end

local Toggle = Tab2:Toggle({
	Title = "Freeze Character",
	Desc = "freeze your character",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		toggleFreeze(state)
	end
})

player.CharacterAdded:Connect(function(char)
	if isFrozen then
		task.wait(0.5)
		freezeCharacter(char)
	end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function stopAllAnimations()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop(0)
        end
    end
end

local function toggleAnimation(state)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local animate = char:FindFirstChild("Animate")

    if state then
        if animate then animate.Disabled = true end
        stopAllAnimations()
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            animator:Destroy()
        end
    else
        if animate then animate.Disabled = false end
        if humanoid and not humanoid:FindFirstChildOfClass("Animator") then
            local newAnimator = Instance.new("Animator")
            newAnimator.Parent = humanoid
        end
    end
end

Tab2:Toggle({
    Title = "Disable Animations",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        toggleAnimation(state)
    end
})

_G.AutoFishing=false
_G.AutoEquipRod=false
_G.AutoSell=false
_G.Radar=false
_G.Instant=false
_G.SellDelay=_G.SellDelay or 30
_G.InstantDelay=_G.InstantDelay or 0.35
_G.CallMinDelay=_G.CallMinDelay or 0.18
_G.CallBackoff=_G.CallBackoff or 1.5

local lastCall={}
local function safeCall(k,f)
 local n=os.clock()
 local d=_G.CallMinDelay
 local b=_G.CallBackoff
 if lastCall[k] and n-lastCall[k]<d then task.wait(d-(n-lastCall[k])) end
 local o,r=pcall(f)
 lastCall[k]=os.clock()
 if not o then
  local m=tostring(r):lower()
  task.wait(m:find("429")or m:find("too many requests")and b or 0.2)
 end
 return o,r
end

local RS=game:GetService("ReplicatedStorage")
local net=RS.Packages._Index["sleitnick_net@0.2.0"].net

local function rod()safeCall("rod",function()net["RE/EquipToolFromHotbar"]:FireServer(1)end)end
local function sell()safeCall("sell",function()net["RF/SellAllItems"]:InvokeServer()end)end
local function autoon()safeCall("autoon",function()net["RF/UpdateAutoFishingState"]:InvokeServer(true)end)end
local function autooff()safeCall("autooff",function()net["RF/UpdateAutoFishingState"]:InvokeServer(false)end)end
local function catch()safeCall("catch",function()net["RE/FishingCompleted"]:FireServer()end)end
local function charge()safeCall("charge",function()net["RF/ChargeFishingRod"]:InvokeServer()end)end
local function lempar()
 safeCall("lempar",function()net["RF/RequestFishingMinigameStarted"]:InvokeServer(-1.233,0.996,1761532005.497)end)
 safeCall("charge2",function()net["RF/ChargeFishingRod"]:InvokeServer()end)
end

local function autosell()
 while _G.AutoSell do
  sell()
  local d=tonumber(_G.SellDelay)or 30
  local w=0
  while w<d and _G.AutoSell do task.wait(0.25) w=w+0.25 end
 end
end

local function instant_cycle()
 charge()
 lempar()
 task.wait(_G.InstantDelay)
 catch()
end

local Tab3=Window:Tab{Title="Main",Icon="gamepad-2"}
Tab3:Section{Title="Fishing",Icon="fish",TextXAlignment="Left",TextSize=17}
Tab3:Divider()
Tab3:Toggle{Title="Auto Equip Rod",Value=false,Callback=function(v)_G.AutoEquipRod=v if v then rod()end end}

local mode="Instant"
local fishThread,sellThread

Tab3:Dropdown{Title="Mode",Values={"Instant","Legit"},Value="Instant",Callback=function(v)mode=v WindUI:Notify{Title="Mode",Content="Mode: "..v,Duration=3}end}

Tab3:Toggle{
 Title="Auto Fishing",Value=false,
 Callback=function(v)
  _G.AutoFishing=v
  if v then
   if mode=="Instant" then
    _G.Instant=true
    WindUI:Notify{Title="Auto Fishing",Content="Instant ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Instant" do
      instant_cycle()
      task.wait(0.35)
     end
    end)
   else
    WindUI:Notify{Title="Auto Fishing",Content="Legit ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Legit" do
      autoon()
      task.wait(1)
     end
    end)
   end
  else
   WindUI:Notify{Title="Auto Fishing",Content="OFF",Duration=3}
   autooff()
   _G.Instant=false
   if fishThread then task.cancel(fishThread)end
   fishThread=nil
  end
 end
}

Tab3:Slider{
 Title="Instant Fishing Delay",
 Step=0.01,
 Value={Min=0.2,Max=1,Default=0.35},
 Callback=function(v)_G.InstantDelay=v WindUI:Notify{Title="Delay",Content="Instant Delay: "..v.."s",Duration=2}end
}

Tab3:Section({     
    Title = "Item",
    Icon = "list-collapse",
    TextXAlignment = "Left",
    TextSize = 17,    
})

Tab3:Divider()

Tab3:Toggle{
    Title = "Radar",
    Value = false,
    Callback = function(state)
        local RS = game:GetService("ReplicatedStorage")
        local Lighting = game:GetService("Lighting")
        local Replion = require(RS.Packages.Replion).Client:GetReplion("Data")
        local NetFunction = require(RS.Packages.Net):RemoteFunction("UpdateFishingRadar")
        
        if Replion and NetFunction:InvokeServer(state) then
            local sound = require(RS.Shared.Soundbook).Sounds.RadarToggle:Play()
            sound.PlaybackSpeed = 1 + math.random() * 0.3
            
            local colorEffect = Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
            if colorEffect then
                require(RS.Packages.spr).stop(colorEffect)
                local timeController = require(RS.Controllers.ClientTimeController)
                local lightingProfile = (timeController._getLightingProfile and timeController:_getLightingProfile() or timeController._getLighting_profile and timeController:_getLighting_profile() or {})
                local colorCorrection = lightingProfile.ColorCorrection or {}
                
                colorCorrection.Brightness = colorCorrection.Brightness or 0.04
                colorCorrection.TintColor = colorCorrection.TintColor or Color3.fromRGB(255, 255, 255)
                
                if state then
                    colorEffect.TintColor = Color3.fromRGB(42, 226, 118)
                    colorEffect.Brightness = 0.4
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Enabled",
                        TextColor = {R = 9, G = 255, B = 0}
                    }
                else
                    colorEffect.TintColor = Color3.fromRGB(255, 0, 0)
                    colorEffect.Brightness = 0.2
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Disabled", 
                        TextColor = {R = 255, G = 0, B = 0}
                    }
                end
                
                require(RS.Packages.spr).target(colorEffect, 1, 1, colorCorrection)
            end
            
            require(RS.Packages.spr).stop(Lighting)
            Lighting.ExposureCompensation = 1
            require(RS.Packages.spr).target(Lighting, 1, 2, {ExposureCompensation = 0})
        end
    end
}

Tab3:Toggle({
    Title = "Bypass Oxygen",
    Desc = "Inf Oxygen",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.DivingGear = state
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemoteFolder = ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.2.0").net
        if _G.DivingGear then
            local args = {
                [1] = 105
            }
            RemoteFolder:FindFirstChild("RF/EquipOxygenTank"):InvokeServer(unpack(args))
        else
            RemoteFolder:FindFirstChild("RF/UnequipOxygenTank"):InvokeServer()
        end
    end
})

local Tab4 = Window:Tab({
	Title = "Auto",
	Icon = "circle-ellipsis"
})

Tab4:Section{Title="Auto Sell",Icon="coins",TextXAlignment="Left",TextSize=17}

Tab4:Divider()

Tab4:Toggle{
 Title="Auto Sell",Value=false,
 Callback=function(v)
  _G.AutoSell=v
  if v then
   if sellThread then task.cancel(sellThread)end
   sellThread=task.spawn(autosell)
  else
   _G.AutoSell=false
   if sellThread then task.cancel(sellThread)end
   sellThread=nil
  end
 end
}

Tab4:Slider{
	Title="Sell Delay",
	Step= 1,
	Value={
		Min= 1,
		Max= 120,
		Default= 30
	},
	Callback=function(v)
		_G.SellDelay=v
	end
}

local rs = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local QuestList = require(rs.Shared.Quests.QuestList)
local QuestUtility = require(rs.Shared.Quests.QuestUtility)
local Replion = require(rs.Packages.Replion)

local repl = nil
task.spawn(function()
    repl = Replion.Client:WaitReplion("Data")
end)

local function GetEJ()
    if not repl then return nil end
    return repl:Get(QuestList.ElementJungle.ReplionPath)
end

local function GetDeepSea()
    if not repl then return nil end
    return repl:Get(QuestList.DeepSea.ReplionPath)
end

_G.CheckEJ = function()
    local data = GetEJ()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Element Jungle",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end
    
    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("ElementJungle","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Element Jungle Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="leaf"
    })
end

_G.CheckQuestProgress = function()
    local data = GetDeepSea()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Deep Sea Quest",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end

    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("DeepSea","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Deep Sea Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="check-circle"
    })
end

task.spawn(function()
    while task.wait(5) do
        if _G.AutoNotifyEJ then _G.CheckEJ() end
        if _G.AutoNotifyQuest then _G.CheckQuestProgress() end
    end
end)

Tab4:Section({
    Title = "Quest",
    Icon = "file-question-mark",
    TextXAlignment="Left",
    TextSize=17
})

Tab4:Divider()

Tab4:Button({
    Title = "Element Jungle Quest Progress",
    Desc = "Check Element Junggle Quest Progress",
    Callback=function()
        _G.CheckEJ()
    end
})

Tab4:Button({
    Title = "Deep Sea Quest Progress",
    Desc = "Check Deep Sea Quest Progress",
    Callback=function()
        _G.CheckQuestProgress()
    end
})

local Tab5 = Window:Tab({
    Title = "Shop",
    Icon = "shopping-cart",
})

Tab5:Section({ 
    Title = "Buy Rod",
    Icon = "shrimp",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RFPurchaseFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseFishingRod"]

local rods = {
    ["Luck Rod"] = 79,
    ["Carbon Rod"] = 76,
    ["Grass Rod"] = 85,
    ["Demascus Rod"] = 77,
    ["Ice Rod"] = 78,
    ["Lucky Rod"] = 4,
    ["Midnight Rod"] = 80,
    ["Steampunk Rod"] = 6,
    ["Chrome Rod"] = 7,
    ["Astral Rod"] = 5,
    ["Ares Rod"] = 126,
    ["Angler Rod"] = 168,
    ["Bamboo Rod"] = 258
}

local rodNames = {
    "Luck Rod (350 Coins)", "Carbon Rod (900 Coins)", "Grass Rod (1.5k Coins)", "Demascus Rod (3k Coins)",
    "Ice Rod (5k Coins)", "Lucky Rod (15k Coins)", "Midnight Rod (50k Coins)", "Steampunk Rod (215k Coins)",
    "Chrome Rod (437k Coins)", "Astral Rod (1M Coins)", "Ares Rod (3M Coins)", "Angler Rod (8M Coins)",
    "Bamboo Rod (12M Coins)"
}

local rodKeyMap = {
    ["Luck Rod (350 Coins)"] = "Luck Rod",
    ["Carbon Rod (900 Coins)"] = "Carbon Rod",
    ["Grass Rod (1.5k Coins)"] = "Grass Rod",
    ["Demascus Rod (3k Coins)"] = "Demascus Rod",
    ["Ice Rod (5k Coins)"] = "Ice Rod",
    ["Lucky Rod (15k Coins)"] = "Lucky Rod",
    ["Midnight Rod (50k Coins)"] = "Midnight Rod",
    ["Steampunk Rod (215k Coins)"] = "Steampunk Rod",
    ["Chrome Rod (437k Coins)"] = "Chrome Rod",
    ["Astral Rod (1M Coins)"] = "Astral Rod",
    ["Ares Rod (3M Coins)"] = "Ares Rod",
    ["Angler Rod (8M Coins)"] = "Angler Rod",
    ["Bamboo Rod (12M Coins)"] = "Bamboo Rod"
}

local selectedRod = rodNames[1]

Tab5:Dropdown({
    Title = "Select Rod",
    Values = rodNames,
    Value = selectedRod,
    Callback = function(value)
        selectedRod = value
        WindUI:Notify({Title="Rod Selected", Content=value, Duration=3})
    end
})

Tab5:Button({
    Title="Buy Rod",
    Callback=function()
        local key = rodKeyMap[selectedRod]
        if key and rods[key] then
            local success, err = pcall(function()
                RFPurchaseFishingRod:InvokeServer(rods[key])
            end)
            if success then
                WindUI:Notify({Title="Rod Purchase", Content="Purchased "..selectedRod, Duration=3})
            else
                WindUI:Notify({Title="Rod Purchase Error", Content=tostring(err), Duration=5})
            end
        end
    end
})

Tab5:Section({
    Title = "Buy Baits",
    Icon = "compass",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseBait = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]  

local baits = {
    ["TopWater Bait"] = 10,
    ["Lucky Bait"] = 2,
    ["Midnight Bait"] = 3,
    ["Chroma Bait"] = 6,
    ["Dark Mater Bait"] = 8,
    ["Corrupt Bait"] = 15,
    ["Aether Bait"] = 16,
    ["Floral Bait"] = 20,
}

local baitNames = {  
    "Luck Bait (1k Coins)", "Midnight Bait (3k Coins)", "Nature Bait (83.5k Coins)",  
    "Chroma Bait (290k Coins)", "Dark Matter Bait (630k Coins)", "Corrupt Bait (1.15M Coins)",  
    "Aether Bait (3.7M Coins)", "Floral Bait (4M Coins)"  
}  

local baitKeyMap = {  
    ["Luck Bait (1k Coins)"] = "Luck Bait",  
    ["Midnight Bait (3k Coins)"] = "Midnight Bait",  
    ["Nature Bait (83.5k Coins)"] = "Nature Bait",  
    ["Chroma Bait (290k Coins)"] = "Chroma Bait",  
    ["Dark Matter Bait (630k Coins)"] = "Dark Matter Bait",  
    ["Corrupt Bait (1.15M Coins)"] = "Corrupt Bait",  
    ["Aether Bait (3.7M Coins)"] = "Aether Bait",  
    ["Floral Bait (4M Coins)"] = "Floral Bait"  
}  

local selectedBait = baitNames[1]  

Tab5:Dropdown({  
    Title = "Select Bait",  
    Values = baitNames,  
    Value = selectedBait,  
    Callback = function(value)  
        selectedBait = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Bait",  
    Callback = function()  
        local key = baitKeyMap[selectedBait]  
        if key and baits[key] then  
            local success, err = pcall(function()  
                RFPurchaseBait:InvokeServer(baits[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Bait Purchase", Content = "Purchased " .. selectedBait, Duration = 3})  
            else  
                WindUI:Notify({Title = "Bait Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

Tab5:Section({
    Title = "Buy Weather Event",
    Icon = "cloud-drizzle",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseWeatherEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]  

local weathers = {
    ["Wind"] = "Wind",
    ["Cloudy"] = "Cloudy",
    ["Snow"] = "Snow",
    ["Storm"] = "Storm",
    ["Shine"] = "Shine",
    ["Shark Hunt"] = "Shark Hunt"
}

local weatherNames = {  
    "Windy (10k Coins)", "Cloudy (20k Coins)", "Stormy (35k Coins)", 
    "Shining (50k Coins)", "Shark Hunt (300k Coins)", "Snow (15k Coins)"  
}  

local weatherKeyMap = {  
    ["Windy (10k Coins)"] = "Wind",  
    ["Cloudy (20k Coins)"] = "Cloudy",  
    ["Stormy (35k Coins)"] = "Storm",  
    ["Shining (50k Coins)"] = "Shine",  
    ["Shark Hunt (300k Coins)"] = "Shark Hunting",  
    ["Snow (15k Coins)"] = "Snow"  
}  

local selectedWeather = weatherNames[1]  

Tab5:Dropdown({  
    Title = "Select Weather Event",  
    Values = weatherNames,  
    Value = selectedWeather,  
    Callback = function(value)  
        selectedWeather = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Weather Event",  
    Callback = function()  
        local key = weatherKeyMap[selectedWeather]  
        if key and weathers[key] then  
            local success, err = pcall(function()  
                RFPurchaseWeatherEvent:InvokeServer(weathers[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Weather Purchase", Content = "Purchased " .. selectedWeather, Duration = 3})  
            else  
                WindUI:Notify({Title = "Weather Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

local Tab6 = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
})

Tab6:Section({ 
    Title = "Island",
    Icon = "tree-palm",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local IslandLocations = {
    ["Admin Event"] = Vector3.new(-1981, -442, 7428),
    ["Ancient Jungle"] = Vector3.new(1518, 1, -186),
    ["Coral Refs"] = Vector3.new(-2855, 47, 1996),
    ["Crater Island"] = Vector3.new(997, 1, 5012),
    ["Crystal Cavern"] = Vector3.new(-1841, -456, 7186),
    ["Enchant Room"] = Vector3.new(3221, -1303, 1406),
    ["Enchant Room 2"] = Vector3.new(1480, 126, -585),
    ["Esoteric Island"] = Vector3.new(1990, 5, 1398),
    ["Fisherman Island"] = Vector3.new(-175, 3, 2772),
    ["Kohana Volcano"] = Vector3.new(-545.302429, 17.1266193, 118.870537),
    ["Konoha"] = Vector3.new(-603, 3, 719),
    ["Lost Isle"] = Vector3.new(-3643, 1, -1061),
    ["Sacred Temple"] = Vector3.new(1498, -23, -644),
    ["Sysyphus Statue"] = Vector3.new(-3783.26807, -135.073914, -949.946289),
    ["Treasure Room"] = Vector3.new(-3600, -267, -1575),
    ["Tropical Grove"] = Vector3.new(-2091, 6, 3703),
    ["Underground Cellar"] = Vector3.new(2135, -93, -701),
    ["Weather Machine"] = Vector3.new(-1508, 6, 1895),
    ["Ancient Ruin"] = Vector3.new(6051, -541, 4414),
}

local SelectedIsland = nil

local IslandDropdown = Tab6:Dropdown({
    Title = "Select Island",
    Values = (function()
        local keys = {}
        for name in pairs(IslandLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedIsland = Value
    end
})

Tab6:Button({
    Title = "Teleport to Island",
    Callback = function()
        if SelectedIsland and IslandLocations[SelectedIsland] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(IslandLocations[SelectedIsland])
        end
    end
})

Tab6:Section({ 
    Title = "Fishing Spot",
    Icon = "spotlight",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local FishingLocations = {
    ["Levers 1"] = Vector3.new(1475,4,-847),
    ["Levers 2"] = Vector3.new(882,5,-321),
    ["levers 3"] = Vector3.new(1425,6,126),
    ["levers 4"] = Vector3.new(1837,4,-309),
    ["Sysyphus Statue"] = Vector3.new(-3712, -137, -1010),
    ["Volcano"] = Vector3.new(-632, 55, 197),
	["King Jelly Spot (For quest elemental)"] = Vector3.new(1473.60, 3.58, -328.23),
	["El Shark Gran Maja Spot"] = Vector3.new(1526, 4, -629),
    ["Ancient Lochness"] = Vector3.new(6078, -586, 4629),
}

local SelectedFishing = nil

Tab6:Dropdown({
    Title = "Select Spot",
    Values = (function()
        local keys = {}
        for name in pairs(FishingLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedFishing = Value
    end
})

Tab6:Button({
    Title = "Teleport to Fishing Spot",
    Callback = function()
        if SelectedFishing and FishingLocations[SelectedFishing] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(FishingLocations[SelectedFishing])
        end
    end
})

Tab6:Section({
    Title = "Location NPC",
    Icon = "bot",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local NPC_Locations = {
    ["Alex"] = Vector3.new(43,17,2876),
    ["Aura kid"] = Vector3.new(70,17,2835),
    ["Billy Bob"] = Vector3.new(84,17,2876),
    ["Boat Expert"] = Vector3.new(32,9,2789),
    ["Esoteric Gatekeeper"] = Vector3.new(2101,-30,1350),
    ["Jeffery"] = Vector3.new(-2771,4,2132),
    ["Joe"] = Vector3.new(144,20,2856),
    ["Jones"] = Vector3.new(-671,16,596),
    ["Lava Fisherman"] = Vector3.new(-593,59,130),
    ["McBoatson"] = Vector3.new(-623,3,719),
    ["Ram"] = Vector3.new(-2838,47,1962),
    ["Ron"] = Vector3.new(-48,17,2856),
    ["Scott"] = Vector3.new(-19,9,2709),
    ["Scientist"] = Vector3.new(-6,17,2881),
    ["Seth"] = Vector3.new(107,17,2877),
    ["Silly Fisherman"] = Vector3.new(97,9,2694),
    ["Tim"] = Vector3.new(-604,16,609),
}

local SelectedNPC = nil

Tab6:Dropdown({
    Title = "Select NPC",
    Values = (function()
        local keys = {}
        for name in pairs(NPC_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedNPC = Value
    end
})

Tab6:Button({
    Title = "Teleport to NPC",
    Callback = function()
        if SelectedNPC and NPC_Locations[SelectedNPC] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(NPC_Locations[SelectedNPC])
        end
    end
})

Tab6:Section({
    Title = "Event Teleporter",
    Icon = "calendar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local Event_Locations = {
    ["Black Hole"] = Vector3.new(883, -1.4, 2542),
    ["Ghost Shark Hunt"] = Vector3.new(489.559, -1.35, 25.406),
    ["Megalodon Hunt"] = Vector3.new(-1076.3, -1.4, 1676.2),
    ["Meteor Rain"] = Vector3.new(383, -1.4, 2452),
    ["Shark Hunt"] = Vector3.new(1.65, -1.35, 2095.725),
    ["Storm Hunt"] = Vector3.new(1735.85, -1.4, -208.425),
    ["Worm Hunt"] = Vector3.new(1591.55, -1.4, -105.925),
}

local ActiveEvent = nil

Tab6:Dropdown({
    Title = "Select Event",
    Values = (function()
        local keys = {}
        for name in pairs(Event_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        ActiveEvent = Value
    end
})

Tab6:Button({
    Title = "Teleport to Event",
    Callback = function()
        local Char = Player.Character or Player.CharacterAdded:Wait()
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        if ActiveEvent and Event_Locations[ActiveEvent] then
            HRP.CFrame = CFrame.new(Event_Locations[ActiveEvent])
        end
    end
})

local Tab7 = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

Tab7:Toggle({
    Title = "AntiAFK",
    Desc = "Prevent Roblox from kicking you when idle",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.AntiAFK = state
        local VirtualUser = game:GetService("VirtualUser")

        if state then
            task.spawn(function()
                while _G.AntiAFK do
                    task.wait(60)
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end)

            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK loaded!",
                Text = "Coded By Lexs",
                Button1 = "Okey",
                Duration = 5
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK Disabled",
                Text = "Stopped AntiAFK",
                Duration = 3
            })
        end
    end
})

Tab7:Toggle({
    Title = "Auto Reconnect",
    Desc = "Automatic reconnect if disconnected",
    Icon = false,
    Default = false,
    Callback = function(state)
        _G.AutoReconnect = state
        if state then
            task.spawn(function()
                while _G.AutoReconnect do
                    task.wait(2)

                    local reconnectUI = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                    if reconnectUI then
                        local prompt = reconnectUI:FindFirstChild("promptOverlay")
                        if prompt then
                            local button = prompt:FindFirstChild("ButtonPrimary")
                            if button and button.Visible then
                                firesignal(button.MouseButton1Click)
                            end
                        end
                    end
                end
            end)
        end
    end
})

Tab7:Section({ 
    Title = "Graphics In Game",
    Icon = "chart-bar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function notify(text, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FPS BOOST] " .. text,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function applyFPSBoost(state)
	if state then
		---------------------------------------------------
		-- 🟢 AKTIFKAN MODE BOOST
		---------------------------------------------------
		notify("Mode Ultra Aktif ✅", Color3.fromRGB(100,255,100))
		print("[FPS BOOST] Mode Ultra Aktif")

		-- Hapus efek Lighting berat
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
				or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere")
				or v:IsA("Sky") or v:IsA("Clouds") or v:IsA("PostEffect") then
				v.Parent = nil
			end
		end

		-- Nonaktifkan Lighting complexa
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e6
		Lighting.Brightness = 1
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
		Lighting.OutdoorAmbient = Color3.new(1,1,1)

		-- Terrain mais leve
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
		end

		-- Limpar workspace
		for _, obj in ipairs(Workspace:GetDescendants()) do
			-- Remover textura e decal
			if obj:IsA("Decal") or obj:IsA("Texture") then
				obj.Transparency = 1
			end

			-- Desligar efeitos visuais
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire")
				or obj:IsA("Smoke") or obj:IsA("Sparkles") then
				obj.Enabled = false
			end

			-- Remover efeitos PBR (SurfaceAppearance)
			if obj:IsA("SurfaceAppearance") then
				obj.Parent = nil
			end

			-- Desabilitar sombra e mudar material para Plastic
			if obj:IsA("BasePart") then
				obj.CastShadow = false
				pcall(function() obj.Material = Enum.Material.Plastic end)
			end
		end
		
		local char = Players.LocalPlayer.Character
		if char then
			for _, acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then
					acc:Destroy()
				end
			end
			if char:FindFirstChild("Animate") then
				char.Animate.Disabled = true
			end
		end
		
		workspace.StreamingEnabled = true
		workspace.StreamingMinRadius = 64
		workspace.StreamingTargetRadius = 128
		
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		
		collectgarbage("collect")

	else
		---------------------------------------------------
		-- 🔴 DESATIVAR MODO BOOST
		---------------------------------------------------
		notify("Mode Ultra Nonaktif ❌", Color3.fromRGB(255,120,120))
		print("[FPS BOOST] Mode Ultra Nonaktif")

		-- Restaurar Lighting segura
		Lighting.GlobalShadows = true
		Lighting.FogEnd = 1000
		Lighting.Brightness = 2
		Lighting.EnvironmentDiffuseScale = 1
		Lighting.EnvironmentSpecularScale = 1
		Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5)

		if Terrain then
			Terrain.WaterWaveSize = 0.15
			Terrain.WaterWaveSpeed = 10
			Terrain.WaterReflectance = 1
			Terrain.WaterTransparency = 0.5
		end

		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic

		-- Reabilitar animações do personagem
		local char = Players.LocalPlayer.Character
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = false
		end
	end
end


local Toggle = Tab7:Toggle({
	Title = "FPS Boost",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		applyFPSBoost(state)
	end
})

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// State
local blockerEnabled = false
local guiConnections = {}

--// Função de bloqueio de GUI
local function blockGuiObject(obj)
    if not blockerEnabled then return end
    if obj:IsA("ScreenGui") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        local name = obj.Name:lower()
        if string.find(name, "notif") 
        or string.find(name, "popup")
        or string.find(name, "you got")
        or string.find(name, "drop")
        or string.find(name, "reward")
        or string.find(name, "fish")
        or string.find(name, "catch") then
            task.wait()
            pcall(function()
                obj.Enabled = false
                obj:Destroy()
            end)
            print("[Blocked Game Notification]:", obj.Name)
        end
    end
end

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Hide All Notifications",
    Desc = "Hide All Notifications Fish Caught",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        blockerEnabled = state

        if state then
            print("[🛑 Game Notification Blocker Enabled]")

            -- Remover GUIs existentes
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                blockGuiObject(gui)
            end
            for _, gui in ipairs(CoreGui:GetChildren()) do
                blockGuiObject(gui)
            end

            -- Observar novas GUIs
            guiConnections["PlayerGui"] = PlayerGui.ChildAdded:Connect(blockGuiObject)
            guiConnections["CoreGui"] = CoreGui.ChildAdded:Connect(blockGuiObject)

        else
            print("[🔔 Game Notification Blocker Disabled]")
            for _, conn in pairs(guiConnections) do
                conn:Disconnect()
            end
            guiConnections = {}
        end
    end
})

--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// Placeholder de GUI
local whiteScreen = nil

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Disable 3D Rendering",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        if state then
            print("[🛑 3D Rendering Disabled + White Screen Enabled]")

            -- Desligar renderização 3D
            pcall(function()
                RunService:Set3dRenderingEnabled(false)
            end)

            -- Criar tela branca cheia
            whiteScreen = Instance.new("ScreenGui")
            whiteScreen.IgnoreGuiInset = true
            whiteScreen.ResetOnSpawn = false
            whiteScreen.Name = "WhiteScreenOverlay"
            whiteScreen.Parent = PlayerGui

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
            frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            frame.BorderSizePixel = 0
            frame.Parent = whiteScreen

        else
            print("[✅ 3D Rendering Re-enabled + White Screen Removed]")

            -- Reabilitar renderização
            pcall(function()
                RunService:Set3dRenderingEnabled(true)
            end)

            -- Remover tela branca
            if whiteScreen then
                whiteScreen:Destroy()
                whiteScreen = nil
            end
        end
    end
})

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- State
local vfxDisabled = false
local storedVFX = {}

-- Lista de tipos de efeitos a serem desabilitados
local vfxClasses = {
	"ParticleEmitter", "Beam", "Trail", "Smoke", "Fire", "Sparkles", "Explosion",
	"PointLight", "SpotLight", "SurfaceLight", "Highlight"
}

-- Efeitos de pós-processamento de Lighting
local lightingEffects = {
	"BloomEffect", "SunRaysEffect", "ColorCorrectionEffect", "DepthOfFieldEffect", "Atmosphere"
}

-- Desabilitar todos os efeitos visuais
local function disableAllVFX()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if table.find(vfxClasses, obj.ClassName) then
			if obj.Enabled ~= nil and obj.Enabled == true then
				storedVFX[obj] = true
				obj.Enabled = false
			end
		end
	end

	-- Desligar efeitos na Lighting
	for _, effName in ipairs(lightingEffects) do
		local eff = Lighting:FindFirstChildOfClass(effName)
		if eff and eff.Enabled ~= nil then
			storedVFX[eff] = true
			eff.Enabled = false
		end
	end

	print("[🧊 All VFX Disabled]")
end

-- Reabilitar todos os efeitos visuais
local function enableAllVFX()
	for obj in pairs(storedVFX) do
		if obj and obj.Parent and obj.Enabled ~= nil then
			obj.Enabled = true
		end
	end
	storedVFX = {}
	print("[✨ All VFX Restored]")
end

-- Toggle UI
local Toggle = Tab7:Toggle({
    Title = "Hide All VFX",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        vfxDisabled = state

        if state then
            disableAllVFX()

            -- Se novos efeitos aparecerem após o toggle estar ativo
            Workspace.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(vfxClasses, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

            Lighting.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(lightingEffects, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

        else
            enableAllVFX()
        end
    end
})

Tab7:Section({ 
    Title = "Server",
    Icon = "server",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Button = Tab7:Button({
    Title = "Rejoin",
    Desc = "rejoin to the same server",
    Locked = false,
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

TeleportService:Teleport(game.PlaceId, player)

    end
})

Tab7:Button({
    Title = "Server Hop",
    Desc = "Switch to another server",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local function GetServers()
            local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
            local response = HttpService:JSONDecode(game:HttpGet(url))
            return response.data
        end

        local function FindBestServer(servers)
            for _, server in ipairs(servers) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    return server.id
                end
            end
            return nil
        end

        local servers = GetServers()
        local serverId = FindBestServer(servers)

        if serverId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
        else
            warn("⚠️ No suitable server found!")
        end
    end
})

Tab7:Section({ 
    Title = "Config",
    Icon = "folder-open",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local ConfigFolder = "FOUR_HUB/Configs" -- EDITADO
if not isfolder("FOUR_HUB") then makefolder("FOUR_HUB") end -- EDITADO
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end

local ConfigName = "default.json"

local function GetConfig()
    return {
        WalkSpeed = Humanoid.WalkSpeed,
        JumpPower = _G.CustomJumpPower or 50,
        InfiniteJump = _G.InfiniteJump or false,
        AutoSell = _G.AutoSell or false,
        InstantCatch = _G.InstantCatch or false,
        AntiAFK = _G.AntiAFK or false,
        AutoReconnect = _G.AutoReconnect or false,
    }
end

local function ApplyConfig(data)
    if data.WalkSpeed then 
        Humanoid.WalkSpeed = data.WalkSpeed 
    end
    if data.JumpPower then
        _G.CustomJumpPower = data.JumpPower
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = data.JumpPower
        end
    end
    if data.InfiniteJump ~= nil then
        _G.InfiniteJump = data.InfiniteJump
    end
    if data.AutoSell ~= nil then
        _G.AutoSell = data.AutoSell
    end
    if data.InstantCatch ~= nil then
        _G.InstantCatch = data.InstantCatch
    end
    if data.AntiAFK ~= nil then
        _G.AntiAFK = data.AntiAFK
    end
    if data.AutoReconnect ~= nil then
        _G.AutoReconnect = data.AutoReconnect
    end
end

Tab7:Button({
    Title = "Save Config",
    Desc = "Save all settings",
    Callback = function()
        local data = GetConfig()
        writefile(ConfigFolder.."/"..ConfigName, game:GetService("HttpService"):JSONEncode(data))
        print("✅ Config saved!")
    end
})

Tab7:Button({
    Title = "Load Config",
    Desc = "Use saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            local data = readfile(ConfigFolder.."/"..ConfigName)
            local decoded = game:GetService("HttpService"):JSONDecode(data)
            ApplyConfig(decoded)
            print("✅ Config applied!")
        else
            warn("⚠️ Config not found, please Save first.")
        end
    end
})

Tab7:Button({
    Title = "Delete Config",
    Desc = "Delete saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            delfile(ConfigFolder.."/"..ConfigName)
            print("🗑 Config deleted!")
        else
            warn("⚠️ No config to delete.")
        end
    end
})

Tab7:Section({ 
    Title = "Other Scripts",
    Icon = "file-code-2",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

Tab7:Button({
    Title = "Infinite Yield",
    Desc = "Other Scripts",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end
})

getgenv().FourHubWindow = Window -- EDITADO

return Window
    Title = "Jump",
    Desc = false,
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = Value
    end
})

Tab2:Divider()

Tab2:Button({
    Title = "Reset Jump Power",
    Desc = "Return Jump Power to normal (50)",
    Callback = function()
        _G.CustomJumpPower = 50
        local humanoid = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
        print("🔄 Jump Power reset to 50")
    end
})

Player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.UseJumpPower = true
    humanoid.JumpPower = _G.CustomJumpPower or 50
end)

Tab2:Button({
    Title = "Reset Speed",
    Desc = "Return speed to normal (18)",
    Callback = function()
        Humanoid.WalkSpeed = 18
        print("WalkSpeed reset to default (18)")
    end
})

Tab2:Divider()

local UserInputService = game:GetService("UserInputService")

Tab2:Toggle({
    Title = "Infinite Jump",
    Desc = "activate to use infinite jump",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.InfiniteJump = state
        if state then
            print("✅ Infinite Jump Active")
        else
            print("❌ Infinite Jump Inactive")
        end
    end
})

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

Tab2:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.Noclip = state
        task.spawn(function()
            local Player = game:GetService("Players").LocalPlayer
            while _G.Noclip do
                task.wait(0.1)
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local isFrozen = false
local lastPos = nil

local function notify(msg, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FREEZE] " .. msg,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function freezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	lastPos = root.CFrame

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		pcall(function() track:Stop(0) end)
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		pcall(function() animator:Destroy() end)
	end

	root.Anchored = true
end

local function unfreezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		humanoid.AutoRotate = true
		humanoid.PlatformStand = false
		if not humanoid:FindFirstChildOfClass("Animator") then
			local newAnimator = Instance.new("Animator")
			newAnimator.Parent = humanoid
		end
	end

	if root then
		root.Anchored = false
		if lastPos then
			root.CFrame = lastPos
		end
	end
end

local function toggleFreeze(state)
	isFrozen = state
	local char = player.Character or player.CharacterAdded:Wait()

	if state then
		freezeCharacter(char)
		notify("Freeze character", Color3.fromRGB(100,200,255))
	else
		unfreezeCharacter(char)
		notify("Character released", Color3.fromRGB(255,150,150))
	end
end

local Toggle = Tab2:Toggle({
	Title = "Freeze Character",
	Desc = "freeze your character",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		toggleFreeze(state)
	end
})

player.CharacterAdded:Connect(function(char)
	if isFrozen then
		task.wait(0.5)
		freezeCharacter(char)
	end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function stopAllAnimations()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop(0)
        end
    end
end

local function toggleAnimation(state)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local animate = char:FindFirstChild("Animate")

    if state then
        if animate then animate.Disabled = true end
        stopAllAnimations()
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            animator:Destroy()
        end
    else
        if animate then animate.Disabled = false end
        if humanoid and not humanoid:FindFirstChildOfClass("Animator") then
            local newAnimator = Instance.new("Animator")
            newAnimator.Parent = humanoid
        end
    end
end

Tab2:Toggle({
    Title = "Disable Animations",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        toggleAnimation(state)
    end
})

_G.AutoFishing=false
_G.AutoEquipRod=false
_G.AutoSell=false
_G.Radar=false
_G.Instant=false
_G.SellDelay=_G.SellDelay or 30
_G.InstantDelay=_G.InstantDelay or 0.35
_G.CallMinDelay=_G.CallMinDelay or 0.18
_G.CallBackoff=_G.CallBackoff or 1.5

local lastCall={}
local function safeCall(k,f)
 local n=os.clock()
 local d=_G.CallMinDelay
 local b=_G.CallBackoff
 if lastCall[k] and n-lastCall[k]<d then task.wait(d-(n-lastCall[k])) end
 local o,r=pcall(f)
 lastCall[k]=os.clock()
 if not o then
  local m=tostring(r):lower()
  task.wait(m:find("429")or m:find("too many requests")and b or 0.2)
 end
 return o,r
end

local RS=game:GetService("ReplicatedStorage")
local net=RS.Packages._Index["sleitnick_net@0.2.0"].net

local function rod()safeCall("rod",function()net["RE/EquipToolFromHotbar"]:FireServer(1)end)end
local function sell()safeCall("sell",function()net["RF/SellAllItems"]:InvokeServer()end)end
local function autoon()safeCall("autoon",function()net["RF/UpdateAutoFishingState"]:InvokeServer(true)end)end
local function autooff()safeCall("autooff",function()net["RF/UpdateAutoFishingState"]:InvokeServer(false)end)end
local function catch()safeCall("catch",function()net["RE/FishingCompleted"]:FireServer()end)end
local function charge()safeCall("charge",function()net["RF/ChargeFishingRod"]:InvokeServer()end)end
local function lempar()
 safeCall("lempar",function()net["RF/RequestFishingMinigameStarted"]:InvokeServer(-1.233,0.996,1761532005.497)end)
 safeCall("charge2",function()net["RF/ChargeFishingRod"]:InvokeServer()end)
end

local function autosell()
 while _G.AutoSell do
  sell()
  local d=tonumber(_G.SellDelay)or 30
  local w=0
  while w<d and _G.AutoSell do task.wait(0.25) w=w+0.25 end
 end
end

local function instant_cycle()
 charge()
 lempar()
 task.wait(_G.InstantDelay)
 catch()
end

local Tab3=Window:Tab{Title="Main",Icon="gamepad-2"}
Tab3:Section{Title="Fishing",Icon="fish",TextXAlignment="Left",TextSize=17}
Tab3:Divider()
Tab3:Toggle{Title="Auto Equip Rod",Value=false,Callback=function(v)_G.AutoEquipRod=v if v then rod()end end}

local mode="Instant"
local fishThread,sellThread

Tab3:Dropdown{Title="Mode",Values={"Instant","Legit"},Value="Instant",Callback=function(v)mode=v WindUI:Notify{Title="Mode",Content="Mode: "..v,Duration=3}end}

Tab3:Toggle{
 Title="Auto Fishing",Value=false,
 Callback=function(v)
  _G.AutoFishing=v
  if v then
   if mode=="Instant" then
    _G.Instant=true
    WindUI:Notify{Title="Auto Fishing",Content="Instant ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Instant" do
      instant_cycle()
      task.wait(0.35)
     end
    end)
   else
    WindUI:Notify{Title="Auto Fishing",Content="Legit ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Legit" do
      autoon()
      task.wait(1)
     end
    end)
   end
  else
   WindUI:Notify{Title="Auto Fishing",Content="OFF",Duration=3}
   autooff()
   _G.Instant=false
   if fishThread then task.cancel(fishThread)end
   fishThread=nil
  end
 end
}

Tab3:Slider{
 Title="Instant Fishing Delay",
 Step=0.01,
 Value={Min=0.2,Max=1,Default=0.35},
 Callback=function(v)_G.InstantDelay=v WindUI:Notify{Title="Delay",Content="Instant Delay: "..v.."s",Duration=2}end
}

Tab3:Section({     
    Title = "Item",
    Icon = "list-collapse",
    TextXAlignment = "Left",
    TextSize = 17,    
})

Tab3:Divider()

Tab3:Toggle{
    Title = "Radar",
    Value = false,
    Callback = function(state)
        local RS = game:GetService("ReplicatedStorage")
        local Lighting = game:GetService("Lighting")
        local Replion = require(RS.Packages.Replion).Client:GetReplion("Data")
        local NetFunction = require(RS.Packages.Net):RemoteFunction("UpdateFishingRadar")
        
        if Replion and NetFunction:InvokeServer(state) then
            local sound = require(RS.Shared.Soundbook).Sounds.RadarToggle:Play()
            sound.PlaybackSpeed = 1 + math.random() * 0.3
            
            local colorEffect = Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
            if colorEffect then
                require(RS.Packages.spr).stop(colorEffect)
                local timeController = require(RS.Controllers.ClientTimeController)
                local lightingProfile = (timeController._getLightingProfile and timeController:_getLightingProfile() or timeController._getLighting_profile and timeController:_getLighting_profile() or {})
                local colorCorrection = lightingProfile.ColorCorrection or {}
                
                colorCorrection.Brightness = colorCorrection.Brightness or 0.04
                colorCorrection.TintColor = colorCorrection.TintColor or Color3.fromRGB(255, 255, 255)
                
                if state then
                    colorEffect.TintColor = Color3.fromRGB(42, 226, 118)
                    colorEffect.Brightness = 0.4
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Enabled",
                        TextColor = {R = 9, G = 255, B = 0}
                    }
                else
                    colorEffect.TintColor = Color3.fromRGB(255, 0, 0)
                    colorEffect.Brightness = 0.2
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Disabled", 
                        TextColor = {R = 255, G = 0, B = 0}
                    }
                end
                
                require(RS.Packages.spr).target(colorEffect, 1, 1, colorCorrection)
            end
            
            require(RS.Packages.spr).stop(Lighting)
            Lighting.ExposureCompensation = 1
            require(RS.Packages.spr).target(Lighting, 1, 2, {ExposureCompensation = 0})
        end
    end
}

Tab3:Toggle({
    Title = "Bypass Oxygen",
    Desc = "Inf Oxygen",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.DivingGear = state
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemoteFolder = ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.2.0").net
        if _G.DivingGear then
            local args = {
                [1] = 105
            }
            RemoteFolder:FindFirstChild("RF/EquipOxygenTank"):InvokeServer(unpack(args))
        else
            RemoteFolder:FindFirstChild("RF/UnequipOxygenTank"):InvokeServer()
        end
    end
})

local Tab4 = Window:Tab({
	Title = "Auto",
	Icon = "circle-ellipsis"
})

Tab4:Section{Title="Auto Sell",Icon="coins",TextXAlignment="Left",TextSize=17}

Tab4:Divider()

Tab4:Toggle{
 Title="Auto Sell",Value=false,
 Callback=function(v)
  _G.AutoSell=v
  if v then
   if sellThread then task.cancel(sellThread)end
   sellThread=task.spawn(autosell)
  else
   _G.AutoSell=false
   if sellThread then task.cancel(sellThread)end
   sellThread=nil
  end
 end
}

Tab4:Slider{
	Title="Sell Delay",
	Step= 1,
	Value={
		Min= 1,
		Max= 120,
		Default= 30
	},
	Callback=function(v)
		_G.SellDelay=v
	end
}

local rs = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local QuestList = require(rs.Shared.Quests.QuestList)
local QuestUtility = require(rs.Shared.Quests.QuestUtility)
local Replion = require(rs.Packages.Replion)

local repl = nil
task.spawn(function()
    repl = Replion.Client:WaitReplion("Data")
end)

local function GetEJ()
    if not repl then return nil end
    return repl:Get(QuestList.ElementJungle.ReplionPath)
end

local function GetDeepSea()
    if not repl then return nil end
    return repl:Get(QuestList.DeepSea.ReplionPath)
end

_G.CheckEJ = function()
    local data = GetEJ()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Element Jungle",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end
    
    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("ElementJungle","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Element Jungle Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="leaf"
    })
end

_G.CheckQuestProgress = function()
    local data = GetDeepSea()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Deep Sea Quest",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end

    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("DeepSea","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Deep Sea Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="check-circle"
    })
end

task.spawn(function()
    while task.wait(5) do
        if _G.AutoNotifyEJ then _G.CheckEJ() end
        if _G.AutoNotifyQuest then _G.CheckQuestProgress() end
    end
end)

Tab4:Section({
    Title = "Quest",
    Icon = "file-question-mark",
    TextXAlignment="Left",
    TextSize=17
})

Tab4:Divider()

Tab4:Button({
    Title = "Element Jungle Quest Progress",
    Desc = "Check Element Junggle Quest Progress",
    Callback=function()
        _G.CheckEJ()
    end
})

Tab4:Button({
    Title = "Deep Sea Quest Progress",
    Desc = "Check Deep Sea Quest Progress",
    Callback=function()
        _G.CheckQuestProgress()
    end
})

local Tab5 = Window:Tab({
    Title = "Shop",
    Icon = "shopping-cart",
})

Tab5:Section({ 
    Title = "Buy Rod",
    Icon = "shrimp",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RFPurchaseFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseFishingRod"]

local rods = {
    ["Luck Rod"] = 79,
    ["Carbon Rod"] = 76,
    ["Grass Rod"] = 85,
    ["Demascus Rod"] = 77,
    ["Ice Rod"] = 78,
    ["Lucky Rod"] = 4,
    ["Midnight Rod"] = 80,
    ["Steampunk Rod"] = 6,
    ["Chrome Rod"] = 7,
    ["Astral Rod"] = 5,
    ["Ares Rod"] = 126,
    ["Angler Rod"] = 168,
    ["Bamboo Rod"] = 258
}

local rodNames = {
    "Luck Rod (350 Coins)", "Carbon Rod (900 Coins)", "Grass Rod (1.5k Coins)", "Demascus Rod (3k Coins)",
    "Ice Rod (5k Coins)", "Lucky Rod (15k Coins)", "Midnight Rod (50k Coins)", "Steampunk Rod (215k Coins)",
    "Chrome Rod (437k Coins)", "Astral Rod (1M Coins)", "Ares Rod (3M Coins)", "Angler Rod (8M Coins)",
    "Bamboo Rod (12M Coins)"
}

local rodKeyMap = {
    ["Luck Rod (350 Coins)"] = "Luck Rod",
    ["Carbon Rod (900 Coins)"] = "Carbon Rod",
    ["Grass Rod (1.5k Coins)"] = "Grass Rod",
    ["Demascus Rod (3k Coins)"] = "Demascus Rod",
    ["Ice Rod (5k Coins)"] = "Ice Rod",
    ["Lucky Rod (15k Coins)"] = "Lucky Rod",
    ["Midnight Rod (50k Coins)"] = "Midnight Rod",
    ["Steampunk Rod (215k Coins)"] = "Steampunk Rod",
    ["Chrome Rod (437k Coins)"] = "Chrome Rod",
    ["Astral Rod (1M Coins)"] = "Astral Rod",
    ["Ares Rod (3M Coins)"] = "Ares Rod",
    ["Angler Rod (8M Coins)"] = "Angler Rod",
    ["Bamboo Rod (12M Coins)"] = "Bamboo Rod"
}

local selectedRod = rodNames[1]

Tab5:Dropdown({
    Title = "Select Rod",
    Values = rodNames,
    Value = selectedRod,
    Callback = function(value)
        selectedRod = value
        WindUI:Notify({Title="Rod Selected", Content=value, Duration=3})
    end
})

Tab5:Button({
    Title="Buy Rod",
    Callback=function()
        local key = rodKeyMap[selectedRod]
        if key and rods[key] then
            local success, err = pcall(function()
                RFPurchaseFishingRod:InvokeServer(rods[key])
            end)
            if success then
                WindUI:Notify({Title="Rod Purchase", Content="Purchased "..selectedRod, Duration=3})
            else
                WindUI:Notify({Title="Rod Purchase Error", Content=tostring(err), Duration=5})
            end
        end
    end
})

Tab5:Section({
    Title = "Buy Baits",
    Icon = "compass",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseBait = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]  

local baits = {
    ["TopWater Bait"] = 10,
    ["Lucky Bait"] = 2,
    ["Midnight Bait"] = 3,
    ["Chroma Bait"] = 6,
    ["Dark Mater Bait"] = 8,
    ["Corrupt Bait"] = 15,
    ["Aether Bait"] = 16,
    ["Floral Bait"] = 20,
}

local baitNames = {  
    "Luck Bait (1k Coins)", "Midnight Bait (3k Coins)", "Nature Bait (83.5k Coins)",  
    "Chroma Bait (290k Coins)", "Dark Matter Bait (630k Coins)", "Corrupt Bait (1.15M Coins)",  
    "Aether Bait (3.7M Coins)", "Floral Bait (4M Coins)"  
}  

local baitKeyMap = {  
    ["Luck Bait (1k Coins)"] = "Luck Bait",  
    ["Midnight Bait (3k Coins)"] = "Midnight Bait",  
    ["Nature Bait (83.5k Coins)"] = "Nature Bait",  
    ["Chroma Bait (290k Coins)"] = "Chroma Bait",  
    ["Dark Matter Bait (630k Coins)"] = "Dark Matter Bait",  
    ["Corrupt Bait (1.15M Coins)"] = "Corrupt Bait",  
    ["Aether Bait (3.7M Coins)"] = "Aether Bait",  
    ["Floral Bait (4M Coins)"] = "Floral Bait"  
}  

local selectedBait = baitNames[1]  

Tab5:Dropdown({  
    Title = "Select Bait",  
    Values = baitNames,  
    Value = selectedBait,  
    Callback = function(value)  
        selectedBait = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Bait",  
    Callback = function()  
        local key = baitKeyMap[selectedBait]  
        if key and baits[key] then  
            local success, err = pcall(function()  
                RFPurchaseBait:InvokeServer(baits[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Bait Purchase", Content = "Purchased " .. selectedBait, Duration = 3})  
            else  
                WindUI:Notify({Title = "Bait Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

Tab5:Section({
    Title = "Buy Weather Event",
    Icon = "cloud-drizzle",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseWeatherEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]  

local weathers = {
    ["Wind"] = "Wind",
    ["Cloudy"] = "Cloudy",
    ["Snow"] = "Snow",
    ["Storm"] = "Storm",
    ["Shine"] = "Shine",
    ["Shark Hunt"] = "Shark Hunt"
}

local weatherNames = {  
    "Windy (10k Coins)", "Cloudy (20k Coins)", "Stormy (35k Coins)", 
    "Shining (50k Coins)", "Shark Hunt (300k Coins)", "Snow (15k Coins)"  
}  

local weatherKeyMap = {  
    ["Windy (10k Coins)"] = "Wind",  
    ["Cloudy (20k Coins)"] = "Cloudy",  
    ["Stormy (35k Coins)"] = "Storm",  
    ["Shining (50k Coins)"] = "Shine",  
    ["Shark Hunt (300k Coins)"] = "Shark Hunting",  
    ["Snow (15k Coins)"] = "Snow"  
}  

local selectedWeather = weatherNames[1]  

Tab5:Dropdown({  
    Title = "Select Weather Event",  
    Values = weatherNames,  
    Value = selectedWeather,  
    Callback = function(value)  
        selectedWeather = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Weather Event",  
    Callback = function()  
        local key = weatherKeyMap[selectedWeather]  
        if key and weathers[key] then  
            local success, err = pcall(function()  
                RFPurchaseWeatherEvent:InvokeServer(weathers[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Weather Purchase", Content = "Purchased " .. selectedWeather, Duration = 3})  
            else  
                WindUI:Notify({Title = "Weather Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

local Tab6 = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
})

Tab6:Section({ 
    Title = "Island",
    Icon = "tree-palm",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local IslandLocations = {
    ["Admin Event"] = Vector3.new(-1981, -442, 7428),
    ["Ancient Jungle"] = Vector3.new(1518, 1, -186),
    ["Coral Refs"] = Vector3.new(-2855, 47, 1996),
    ["Crater Island"] = Vector3.new(997, 1, 5012),
    ["Crystal Cavern"] = Vector3.new(-1841, -456, 7186),
    ["Enchant Room"] = Vector3.new(3221, -1303, 1406),
    ["Enchant Room 2"] = Vector3.new(1480, 126, -585),
    ["Esoteric Island"] = Vector3.new(1990, 5, 1398),
    ["Fisherman Island"] = Vector3.new(-175, 3, 2772),
    ["Kohana Volcano"] = Vector3.new(-545.302429, 17.1266193, 118.870537),
    ["Konoha"] = Vector3.new(-603, 3, 719),
    ["Lost Isle"] = Vector3.new(-3643, 1, -1061),
    ["Sacred Temple"] = Vector3.new(1498, -23, -644),
    ["Sysyphus Statue"] = Vector3.new(-3783.26807, -135.073914, -949.946289),
    ["Treasure Room"] = Vector3.new(-3600, -267, -1575),
    ["Tropical Grove"] = Vector3.new(-2091, 6, 3703),
    ["Underground Cellar"] = Vector3.new(2135, -93, -701),
    ["Weather Machine"] = Vector3.new(-1508, 6, 1895),
    ["Ancient Ruin"] = Vector3.new(6051, -541, 4414),
}

local SelectedIsland = nil

local IslandDropdown = Tab6:Dropdown({
    Title = "Select Island",
    Values = (function()
        local keys = {}
        for name in pairs(IslandLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedIsland = Value
    end
})

Tab6:Button({
    Title = "Teleport to Island",
    Callback = function()
        if SelectedIsland and IslandLocations[SelectedIsland] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(IslandLocations[SelectedIsland])
        end
    end
})

Tab6:Section({ 
    Title = "Fishing Spot",
    Icon = "spotlight",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local FishingLocations = {
    ["Levers 1"] = Vector3.new(1475,4,-847),
    ["Levers 2"] = Vector3.new(882,5,-321),
    ["levers 3"] = Vector3.new(1425,6,126),
    ["levers 4"] = Vector3.new(1837,4,-309),
    ["Sysyphus Statue"] = Vector3.new(-3712, -137, -1010),
    ["Volcano"] = Vector3.new(-632, 55, 197),
	["King Jelly Spot (For quest elemental)"] = Vector3.new(1473.60, 3.58, -328.23),
	["El Shark Gran Maja Spot"] = Vector3.new(1526, 4, -629),
    ["Ancient Lochness"] = Vector3.new(6078, -586, 4629),
}

local SelectedFishing = nil

Tab6:Dropdown({
    Title = "Select Spot",
    Values = (function()
        local keys = {}
        for name in pairs(FishingLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedFishing = Value
    end
})

Tab6:Button({
    Title = "Teleport to Fishing Spot",
    Callback = function()
        if SelectedFishing and FishingLocations[SelectedFishing] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(FishingLocations[SelectedFishing])
        end
    end
})

Tab6:Section({
    Title = "Location NPC",
    Icon = "bot",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local NPC_Locations = {
    ["Alex"] = Vector3.new(43,17,2876),
    ["Aura kid"] = Vector3.new(70,17,2835),
    ["Billy Bob"] = Vector3.new(84,17,2876),
    ["Boat Expert"] = Vector3.new(32,9,2789),
    ["Esoteric Gatekeeper"] = Vector3.new(2101,-30,1350),
    ["Jeffery"] = Vector3.new(-2771,4,2132),
    ["Joe"] = Vector3.new(144,20,2856),
    ["Jones"] = Vector3.new(-671,16,596),
    ["Lava Fisherman"] = Vector3.new(-593,59,130),
    ["McBoatson"] = Vector3.new(-623,3,719),
    ["Ram"] = Vector3.new(-2838,47,1962),
    ["Ron"] = Vector3.new(-48,17,2856),
    ["Scott"] = Vector3.new(-19,9,2709),
    ["Scientist"] = Vector3.new(-6,17,2881),
    ["Seth"] = Vector3.new(107,17,2877),
    ["Silly Fisherman"] = Vector3.new(97,9,2694),
    ["Tim"] = Vector3.new(-604,16,609),
}

local SelectedNPC = nil

Tab6:Dropdown({
    Title = "Select NPC",
    Values = (function()
        local keys = {}
        for name in pairs(NPC_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedNPC = Value
    end
})

Tab6:Button({
    Title = "Teleport to NPC",
    Callback = function()
        if SelectedNPC and NPC_Locations[SelectedNPC] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(NPC_Locations[SelectedNPC])
        end
    end
})

Tab6:Section({
    Title = "Event Teleporter",
    Icon = "calendar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local Event_Locations = {
    ["Black Hole"] = Vector3.new(883, -1.4, 2542),
    ["Ghost Shark Hunt"] = Vector3.new(489.559, -1.35, 25.406),
    ["Megalodon Hunt"] = Vector3.new(-1076.3, -1.4, 1676.2),
    ["Meteor Rain"] = Vector3.new(383, -1.4, 2452),
    ["Shark Hunt"] = Vector3.new(1.65, -1.35, 2095.725),
    ["Storm Hunt"] = Vector3.new(1735.85, -1.4, -208.425),
    ["Worm Hunt"] = Vector3.new(1591.55, -1.4, -105.925),
}

local ActiveEvent = nil

Tab6:Dropdown({
    Title = "Select Event",
    Values = (function()
        local keys = {}
        for name in pairs(Event_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        ActiveEvent = Value
    end
})

Tab6:Button({
    Title = "Teleport to Event",
    Callback = function()
        local Char = Player.Character or Player.CharacterAdded:Wait()
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        if ActiveEvent and Event_Locations[ActiveEvent] then
            HRP.CFrame = CFrame.new(Event_Locations[ActiveEvent])
        end
    end
})

local Tab7 = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

Tab7:Toggle({
    Title = "AntiAFK",
    Desc = "Prevent Roblox from kicking you when idle",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.AntiAFK = state
        local VirtualUser = game:GetService("VirtualUser")

        if state then
            task.spawn(function()
                while _G.AntiAFK do
                    task.wait(60)
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end)

            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK loaded!",
                Text = "Coded By Lexs",
                Button1 = "Okey",
                Duration = 5
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK Disabled",
                Text = "Stopped AntiAFK",
                Duration = 3
            })
        end
    end
})

Tab7:Toggle({
    Title = "Auto Reconnect",
    Desc = "Automatic reconnect if disconnected",
    Icon = false,
    Default = false,
    Callback = function(state)
        _G.AutoReconnect = state
        if state then
            task.spawn(function()
                while _G.AutoReconnect do
                    task.wait(2)

                    local reconnectUI = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                    if reconnectUI then
                        local prompt = reconnectUI:FindFirstChild("promptOverlay")
                        if prompt then
                            local button = prompt:FindFirstChild("ButtonPrimary")
                            if button and button.Visible then
                                firesignal(button.MouseButton1Click)
                            end
                        end
                    end
                end
            end)
        end
    end
})

Tab7:Section({ 
    Title = "Graphics In Game",
    Icon = "chart-bar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function notify(text, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FPS BOOST] " .. text,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function applyFPSBoost(state)
	if state then
		---------------------------------------------------
		-- 🟢 AKTIFKAN MODE BOOST
		---------------------------------------------------
		notify("Mode Ultra Aktif ✅", Color3.fromRGB(100,255,100))
		print("[FPS BOOST] Mode Ultra Aktif")

		-- Hapus efek Lighting berat
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
				or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere")
				or v:IsA("Sky") or v:IsA("Clouds") or v:IsA("PostEffect") then
				v.Parent = nil
			end
		end

		-- Nonaktifkan Lighting kompleks
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e6
		Lighting.Brightness = 1
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
		Lighting.OutdoorAmbient = Color3.new(1,1,1)

		-- Terrain lebih ringan
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
		end

		-- Bersihkan workspace
		for _, obj in ipairs(Workspace:GetDescendants()) do
			-- Hilangkan texture dan decal
			if obj:IsA("Decal") or obj:IsA("Texture") then
				obj.Transparency = 1
			end

			-- Matikan efek visual
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire")
				or obj:IsA("Smoke") or obj:IsA("Sparkles") then
				obj.Enabled = false
			end

			-- Hapus efek PBR (SurfaceAppearance)
			if obj:IsA("SurfaceAppearance") then
				obj.Parent = nil
			end

			-- Nonaktifkan shadow dan ubah material ke Plastic
			if obj:IsA("BasePart") then
				obj.CastShadow = false
				pcall(function() obj.Material = Enum.Material.Plastic end)
			end
		end
		
		local char = Players.LocalPlayer.Character
		if char then
			for _, acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then
					acc:Destroy()
				end
			end
			if char:FindFirstChild("Animate") then
				char.Animate.Disabled = true
			end
		end
		
		workspace.StreamingEnabled = true
		workspace.StreamingMinRadius = 64
		workspace.StreamingTargetRadius = 128
		
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		
		collectgarbage("collect")

	else
		---------------------------------------------------
		-- 🔴 MATIKAN MODE BOOST
		---------------------------------------------------
		notify("Mode Ultra Nonaktif ❌", Color3.fromRGB(255,120,120))
		print("[FPS BOOST] Mode Ultra Nonaktif")

		-- Pulihkan Lighting aman
		Lighting.GlobalShadows = true
		Lighting.FogEnd = 1000
		Lighting.Brightness = 2
		Lighting.EnvironmentDiffuseScale = 1
		Lighting.EnvironmentSpecularScale = 1
		Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5)

		if Terrain then
			Terrain.WaterWaveSize = 0.15
			Terrain.WaterWaveSpeed = 10
			Terrain.WaterReflectance = 1
			Terrain.WaterTransparency = 0.5
		end

		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic

		-- Aktifkan kembali animasi karakter
		local char = Players.LocalPlayer.Character
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = false
		end
	end
end


local Toggle = Tab7:Toggle({
	Title = "FPS Boost",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		applyFPSBoost(state)
	end
})

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// State
local blockerEnabled = false
local guiConnections = {}

--// Fungsi blokir GUI
local function blockGuiObject(obj)
    if not blockerEnabled then return end
    if obj:IsA("ScreenGui") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        local name = obj.Name:lower()
        if string.find(name, "notif") 
        or string.find(name, "popup")
        or string.find(name, "you got")
        or string.find(name, "drop")
        or string.find(name, "reward")
        or string.find(name, "fish")
        or string.find(name, "catch") then
            task.wait()
            pcall(function()
                obj.Enabled = false
                obj:Destroy()
            end)
            print("[Blocked Game Notification]:", obj.Name)
        end
    end
end

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Hide All Notifications",
    Desc = "Hide All Notifications Fish Caught",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        blockerEnabled = state

        if state then
            print("[🛑 Game Notification Blocker Enabled]")

            -- Hapus GUI yang sudah ada
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                blockGuiObject(gui)
            end
            for _, gui in ipairs(CoreGui:GetChildren()) do
                blockGuiObject(gui)
            end

            -- Awasi GUI baru
            guiConnections["PlayerGui"] = PlayerGui.ChildAdded:Connect(blockGuiObject)
            guiConnections["CoreGui"] = CoreGui.ChildAdded:Connect(blockGuiObject)

        else
            print("[🔔 Game Notification Blocker Disabled]")
            for _, conn in pairs(guiConnections) do
                conn:Disconnect()
            end
            guiConnections = {}
        end
    end
})

--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// GUI placeholder
local whiteScreen = nil

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Disable 3D Rendering",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        if state then
            print("[🛑 3D Rendering Disabled + White Screen Enabled]")

            -- Matikan rendering 3D
            pcall(function()
                RunService:Set3dRenderingEnabled(false)
            end)

            -- Buat layar putih full
            whiteScreen = Instance.new("ScreenGui")
            whiteScreen.IgnoreGuiInset = true
            whiteScreen.ResetOnSpawn = false
            whiteScreen.Name = "WhiteScreenOverlay"
            whiteScreen.Parent = PlayerGui

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
            frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            frame.BorderSizePixel = 0
            frame.Parent = whiteScreen

        else
            print("[✅ 3D Rendering Re-enabled + White Screen Removed]")

            -- Aktifkan render kembali
            pcall(function()
                RunService:Set3dRenderingEnabled(true)
            end)

            -- Hapus layar putih
            if whiteScreen then
                whiteScreen:Destroy()
                whiteScreen = nil
            end
        end
    end
})

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- State
local vfxDisabled = false
local storedVFX = {}

-- Daftar tipe efek yang ingin dinonaktifkan
local vfxClasses = {
	"ParticleEmitter", "Beam", "Trail", "Smoke", "Fire", "Sparkles", "Explosion",
	"PointLight", "SpotLight", "SurfaceLight", "Highlight"
}

-- Efek Lighting pasca-proses
local lightingEffects = {
	"BloomEffect", "SunRaysEffect", "ColorCorrectionEffect", "DepthOfFieldEffect", "Atmosphere"
}

-- Nonaktifkan semua efek visual
local function disableAllVFX()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if table.find(vfxClasses, obj.ClassName) then
			if obj.Enabled ~= nil and obj.Enabled == true then
				storedVFX[obj] = true
				obj.Enabled = false
			end
		end
	end

	-- Matikan efek di Lighting
	for _, effName in ipairs(lightingEffects) do
		local eff = Lighting:FindFirstChildOfClass(effName)
		if eff and eff.Enabled ~= nil then
			storedVFX[eff] = true
			eff.Enabled = false
		end
	end

	print("[🧊 All VFX Disabled]")
end

-- Aktifkan kembali efek visual
local function enableAllVFX()
	for obj in pairs(storedVFX) do
		if obj and obj.Parent and obj.Enabled ~= nil then
			obj.Enabled = true
		end
	end
	storedVFX = {}
	print("[✨ All VFX Restored]")
end

-- Toggle UI
local Toggle = Tab7:Toggle({
    Title = "Hide All VFX",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        vfxDisabled = state

        if state then
            disableAllVFX()

            -- Jika efek baru muncul setelah toggle aktif
            Workspace.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(vfxClasses, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

            Lighting.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(lightingEffects, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

        else
            enableAllVFX()
        end
    end
})

Tab7:Section({ 
    Title = "Server",
    Icon = "server",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Button = Tab7:Button({
    Title = "Rejoin",
    Desc = "rejoin to the same server",
    Locked = false,
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

TeleportService:Teleport(game.PlaceId, player)

    end
})

Tab7:Button({
    Title = "Server Hop",
    Desc = "Switch to another server",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local function GetServers()
            local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
            local response = HttpService:JSONDecode(game:HttpGet(url))
            return response.data
        end

        local function FindBestServer(servers)
            for _, server in ipairs(servers) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    return server.id
                end
            end
            return nil
        end

        local servers = GetServers()
        local serverId = FindBestServer(servers)

        if serverId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
        else
            warn("⚠️ No suitable server found!")
        end
    end
})

Tab7:Section({ 
    Title = "Config",
    Icon = "folder-open",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local ConfigFolder = "LEXS_HUB/Configs"
if not isfolder("LEXS_HUB") then makefolder("LEXS_HUB") end
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end

local ConfigName = "default.json"

local function GetConfig()
    return {
        WalkSpeed = Humanoid.WalkSpeed,
        JumpPower = _G.CustomJumpPower or 50,
        InfiniteJump = _G.InfiniteJump or false,
        AutoSell = _G.AutoSell or false,
        InstantCatch = _G.InstantCatch or false,
        AntiAFK = _G.AntiAFK or false,
        AutoReconnect = _G.AutoReconnect or false,
    }
end

local function ApplyConfig(data)
    if data.WalkSpeed then 
        Humanoid.WalkSpeed = data.WalkSpeed 
    end
    if data.JumpPower then
        _G.CustomJumpPower = data.JumpPower
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = data.JumpPower
        end
    end
    if data.InfiniteJump ~= nil then
        _G.InfiniteJump = data.InfiniteJump
    end
    if data.AutoSell ~= nil then
        _G.AutoSell = data.AutoSell
    end
    if data.InstantCatch ~= nil then
        _G.InstantCatch = data.InstantCatch
    end
    if data.AntiAFK ~= nil then
        _G.AntiAFK = data.AntiAFK
    end
    if data.AutoReconnect ~= nil then
        _G.AutoReconnect = data.AutoReconnect
    end
end

Tab7:Button({
    Title = "Save Config",
    Desc = "Save all settings",
    Callback = function()
        local data = GetConfig()
        writefile(ConfigFolder.."/"..ConfigName, game:GetService("HttpService"):JSONEncode(data))
        print("✅ Config saved!")
    end
})

Tab7:Button({
    Title = "Load Config",
    Desc = "Use saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            local data = readfile(ConfigFolder.."/"..ConfigName)
            local decoded = game:GetService("HttpService"):JSONDecode(data)
            ApplyConfig(decoded)
            print("✅ Config applied!")
        else
            warn("⚠️ Config not found, please Save first.")
        end
    end
})

Tab7:Button({
    Title = "Delete Config",
    Desc = "Delete saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            delfile(ConfigFolder.."/"..ConfigName)
            print("🗑 Config deleted!")
        else
            warn("⚠️ No config to delete.")
        end
    end
})

Tab7:Section({ 
    Title = "Other Scripts",
    Icon = "file-code-2",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

Tab7:Button({
    Title = "Infinite Yield",
    Desc = "Other Scripts",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end
})

getgenv().LexsHubWindow = Window

return Window    Icon = "user",
})

Tab2:Slider({
    Title = "Speed",
    Desc = false,
    Step = 1,
    Value = {
        Min = 18,
        Max = 100,
        Default = 18,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = Value
    end
})

Tab2:Slider({
    Title = "Jump",
    Desc = false,
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = Value
    end
})

Tab2:Divider()

Tab2:Button({
    Title = "Reset Jump Power",
    Desc = "Return Jump Power to normal (50)",
    Callback = function()
        _G.CustomJumpPower = 50
        local humanoid = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
        print("🔄 Jump Power reset to 50")
    end
})

Player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.UseJumpPower = true
    humanoid.JumpPower = _G.CustomJumpPower or 50
end)

Tab2:Button({
    Title = "Reset Speed",
    Desc = "Return speed to normal (18)",
    Callback = function()
        Humanoid.WalkSpeed = 18
        print("WalkSpeed reset to default (18)")
    end
})

Tab2:Divider()

local UserInputService = game:GetService("UserInputService")

Tab2:Toggle({
    Title = "Infinite Jump",
    Desc = "activate to use infinite jump",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.InfiniteJump = state
        if state then
            print("✅ Infinite Jump Active")
        else
            print("❌ Infinite Jump Inactive")
        end
    end
})

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

Tab2:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.Noclip = state
        task.spawn(function()
            local Player = game:GetService("Players").LocalPlayer
            while _G.Noclip do
                task.wait(0.1)
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local isFrozen = false
local lastPos = nil

local function notify(msg, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FREEZE] " .. msg,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function freezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	lastPos = root.CFrame

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		pcall(function() track:Stop(0) end)
	end
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		pcall(function() animator:Destroy() end)
	end

	root.Anchored = true
end

local function unfreezeCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		humanoid.AutoRotate = true
		humanoid.PlatformStand = false
		if not humanoid:FindFirstChildOfClass("Animator") then
			local newAnimator = Instance.new("Animator")
			newAnimator.Parent = humanoid
		end
	end

	if root then
		root.Anchored = false
		if lastPos then
			root.CFrame = lastPos
		end
	end
end

local function toggleFreeze(state)
	isFrozen = state
	local char = player.Character or player.CharacterAdded:Wait()

	if state then
		freezeCharacter(char)
		notify("Freeze character", Color3.fromRGB(100,200,255))
	else
		unfreezeCharacter(char)
		notify("Character released", Color3.fromRGB(255,150,150))
	end
end

local Toggle = Tab2:Toggle({
	Title = "Freeze Character",
	Desc = "freeze your character",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		toggleFreeze(state)
	end
})

player.CharacterAdded:Connect(function(char)
	if isFrozen then
		task.wait(0.5)
		freezeCharacter(char)
	end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function stopAllAnimations()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop(0)
        end
    end
end

local function toggleAnimation(state)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local animate = char:FindFirstChild("Animate")

    if state then
        if animate then animate.Disabled = true end
        stopAllAnimations()
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            animator:Destroy()
        end
    else
        if animate then animate.Disabled = false end
        if humanoid and not humanoid:FindFirstChildOfClass("Animator") then
            local newAnimator = Instance.new("Animator")
            newAnimator.Parent = humanoid
        end
    end
end

Tab2:Toggle({
    Title = "Disable Animations",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        toggleAnimation(state)
    end
})

_G.AutoFishing=false
_G.AutoEquipRod=false
_G.AutoSell=false
_G.Radar=false
_G.Instant=false
_G.SellDelay=_G.SellDelay or 30
_G.InstantDelay=_G.InstantDelay or 0.35
_G.CallMinDelay=_G.CallMinDelay or 0.18
_G.CallBackoff=_G.CallBackoff or 1.5

local lastCall={}
local function safeCall(k,f)
 local n=os.clock()
 local d=_G.CallMinDelay
 local b=_G.CallBackoff
 if lastCall[k] and n-lastCall[k]<d then task.wait(d-(n-lastCall[k])) end
 local o,r=pcall(f)
 lastCall[k]=os.clock()
 if not o then
  local m=tostring(r):lower()
  task.wait(m:find("429")or m:find("too many requests")and b or 0.2)
 end
 return o,r
end

local RS=game:GetService("ReplicatedStorage")
local net=RS.Packages._Index["sleitnick_net@0.2.0"].net

local function rod()safeCall("rod",function()net["RE/EquipToolFromHotbar"]:FireServer(1)end)end
local function sell()safeCall("sell",function()net["RF/SellAllItems"]:InvokeServer()end)end
local function autoon()safeCall("autoon",function()net["RF/UpdateAutoFishingState"]:InvokeServer(true)end)end
local function autooff()safeCall("autooff",function()net["RF/UpdateAutoFishingState"]:InvokeServer(false)end)end
local function catch()safeCall("catch",function()net["RE/FishingCompleted"]:FireServer()end)end
local function charge()safeCall("charge",function()net["RF/ChargeFishingRod"]:InvokeServer()end)end
local function lempar()
 safeCall("lempar",function()net["RF/RequestFishingMinigameStarted"]:InvokeServer(-1.233,0.996,1761532005.497)end)
 safeCall("charge2",function()net["RF/ChargeFishingRod"]:InvokeServer()end)
end

local function autosell()
 while _G.AutoSell do
  sell()
  local d=tonumber(_G.SellDelay)or 30
  local w=0
  while w<d and _G.AutoSell do task.wait(0.25) w=w+0.25 end
 end
end

local function instant_cycle()
 charge()
 lempar()
 task.wait(_G.InstantDelay)
 catch()
end

local Tab3=Window:Tab{Title="Main",Icon="gamepad-2"}
Tab3:Section{Title="Fishing",Icon="fish",TextXAlignment="Left",TextSize=17}
Tab3:Divider()
Tab3:Toggle{Title="Auto Equip Rod",Value=false,Callback=function(v)_G.AutoEquipRod=v if v then rod()end end}

local mode="Instant"
local fishThread,sellThread

Tab3:Dropdown{Title="Mode",Values={"Instant","Legit"},Value="Instant",Callback=function(v)mode=v WindUI:Notify{Title="Mode",Content="Mode: "..v,Duration=3}end}

Tab3:Toggle{
 Title="Auto Fishing",Value=false,
 Callback=function(v)
  _G.AutoFishing=v
  if v then
   if mode=="Instant" then
    _G.Instant=true
    WindUI:Notify{Title="Auto Fishing",Content="Instant ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Instant" do
      instant_cycle()
      task.wait(0.35)
     end
    end)
   else
    WindUI:Notify{Title="Auto Fishing",Content="Legit ON",Duration=3}
    if fishThread then fishThread=nil end
    fishThread=task.spawn(function()
     while _G.AutoFishing and mode=="Legit" do
      autoon()
      task.wait(1)
     end
    end)
   end
  else
   WindUI:Notify{Title="Auto Fishing",Content="OFF",Duration=3}
   autooff()
   _G.Instant=false
   if fishThread then task.cancel(fishThread)end
   fishThread=nil
  end
 end
}

Tab3:Slider{
 Title="Instant Fishing Delay",
 Step=0.01,
 Value={Min=0.2,Max=1,Default=0.35},
 Callback=function(v)_G.InstantDelay=v WindUI:Notify{Title="Delay",Content="Instant Delay: "..v.."s",Duration=2}end
}

Tab3:Section({     
    Title = "Item",
    Icon = "list-collapse",
    TextXAlignment = "Left",
    TextSize = 17,    
})

Tab3:Divider()

Tab3:Toggle{
    Title = "Radar",
    Value = false,
    Callback = function(state)
        local RS = game:GetService("ReplicatedStorage")
        local Lighting = game:GetService("Lighting")
        local Replion = require(RS.Packages.Replion).Client:GetReplion("Data")
        local NetFunction = require(RS.Packages.Net):RemoteFunction("UpdateFishingRadar")
        
        if Replion and NetFunction:InvokeServer(state) then
            local sound = require(RS.Shared.Soundbook).Sounds.RadarToggle:Play()
            sound.PlaybackSpeed = 1 + math.random() * 0.3
            
            local colorEffect = Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
            if colorEffect then
                require(RS.Packages.spr).stop(colorEffect)
                local timeController = require(RS.Controllers.ClientTimeController)
                local lightingProfile = (timeController._getLightingProfile and timeController:_getLightingProfile() or timeController._getLighting_profile and timeController:_getLighting_profile() or {})
                local colorCorrection = lightingProfile.ColorCorrection or {}
                
                colorCorrection.Brightness = colorCorrection.Brightness or 0.04
                colorCorrection.TintColor = colorCorrection.TintColor or Color3.fromRGB(255, 255, 255)
                
                if state then
                    colorEffect.TintColor = Color3.fromRGB(42, 226, 118)
                    colorEffect.Brightness = 0.4
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Enabled",
                        TextColor = {R = 9, G = 255, B = 0}
                    }
                else
                    colorEffect.TintColor = Color3.fromRGB(255, 0, 0)
                    colorEffect.Brightness = 0.2
                    require(RS.Controllers.TextNotificationController):DeliverNotification{
                        Type = "Text",
                        Text = "Radar: Disabled", 
                        TextColor = {R = 255, G = 0, B = 0}
                    }
                end
                
                require(RS.Packages.spr).target(colorEffect, 1, 1, colorCorrection)
            end
            
            require(RS.Packages.spr).stop(Lighting)
            Lighting.ExposureCompensation = 1
            require(RS.Packages.spr).target(Lighting, 1, 2, {ExposureCompensation = 0})
        end
    end
}

Tab3:Toggle({
    Title = "Bypass Oxygen",
    Desc = "Inf Oxygen",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.DivingGear = state
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemoteFolder = ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.2.0").net
        if _G.DivingGear then
            local args = {
                [1] = 105
            }
            RemoteFolder:FindFirstChild("RF/EquipOxygenTank"):InvokeServer(unpack(args))
        else
            RemoteFolder:FindFirstChild("RF/UnequipOxygenTank"):InvokeServer()
        end
    end
})

local Tab4 = Window:Tab({
	Title = "Auto",
	Icon = "circle-ellipsis"
})

Tab4:Section{Title="Auto Sell",Icon="coins",TextXAlignment="Left",TextSize=17}

Tab4:Divider()

Tab4:Toggle{
 Title="Auto Sell",Value=false,
 Callback=function(v)
  _G.AutoSell=v
  if v then
   if sellThread then task.cancel(sellThread)end
   sellThread=task.spawn(autosell)
  else
   _G.AutoSell=false
   if sellThread then task.cancel(sellThread)end
   sellThread=nil
  end
 end
}

Tab4:Slider{
	Title="Sell Delay",
	Step= 1,
	Value={
		Min= 1,
		Max= 120,
		Default= 30
	},
	Callback=function(v)
		_G.SellDelay=v
	end
}

local rs = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local QuestList = require(rs.Shared.Quests.QuestList)
local QuestUtility = require(rs.Shared.Quests.QuestUtility)
local Replion = require(rs.Packages.Replion)

local repl = nil
task.spawn(function()
    repl = Replion.Client:WaitReplion("Data")
end)

local function GetEJ()
    if not repl then return nil end
    return repl:Get(QuestList.ElementJungle.ReplionPath)
end

local function GetDeepSea()
    if not repl then return nil end
    return repl:Get(QuestList.DeepSea.ReplionPath)
end

_G.CheckEJ = function()
    local data = GetEJ()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Element Jungle",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end
    
    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("ElementJungle","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Element Jungle Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="leaf"
    })
end

_G.CheckQuestProgress = function()
    local data = GetDeepSea()
    if not data or not data.Available or not data.Available.Forever then
        WindUI:Notify({Title="Deep Sea Quest",Content="Quest tidak ditemukan",Duration=4,Icon="alert-circle"})
        return
    end

    local quests = data.Available.Forever.Quests
    local total = #quests
    local done = 0
    local list = ""

    for _,q in ipairs(quests) do
        local info = QuestUtility:GetQuestData("DeepSea","Forever",q.QuestId)
        if info then
            local maxVal = QuestUtility.GetQuestValue(repl,info)
            local percent = math.floor(math.clamp(q.Progress/maxVal,0,1)*100)
            if percent>=100 then done+=1 end
            list = list..info.DisplayName.." - "..percent.."%\n"
        end
    end

    local totalPercent = math.floor((done/total)*100)
    WindUI:Notify({
        Title="Deep Sea Progress",
        Content="Total: "..totalPercent.."%\n\n"..list,
        Duration=7,
        Icon="check-circle"
    })
end

task.spawn(function()
    while task.wait(5) do
        if _G.AutoNotifyEJ then _G.CheckEJ() end
        if _G.AutoNotifyQuest then _G.CheckQuestProgress() end
    end
end)

Tab4:Section({
    Title = "Quest",
    Icon = "file-question-mark",
    TextXAlignment="Left",
    TextSize=17
})

Tab4:Divider()

Tab4:Button({
    Title = "Element Jungle Quest Progress",
    Desc = "Check Element Junggle Quest Progress",
    Callback=function()
        _G.CheckEJ()
    end
})

Tab4:Button({
    Title = "Deep Sea Quest Progress",
    Desc = "Check Deep Sea Quest Progress",
    Callback=function()
        _G.CheckQuestProgress()
    end
})

local Tab5 = Window:Tab({
    Title = "Shop",
    Icon = "shopping-cart",
})

Tab5:Section({ 
    Title = "Buy Rod",
    Icon = "shrimp",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RFPurchaseFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseFishingRod"]

local rods = {
    ["Luck Rod"] = 79,
    ["Carbon Rod"] = 76,
    ["Grass Rod"] = 85,
    ["Demascus Rod"] = 77,
    ["Ice Rod"] = 78,
    ["Lucky Rod"] = 4,
    ["Midnight Rod"] = 80,
    ["Steampunk Rod"] = 6,
    ["Chrome Rod"] = 7,
    ["Astral Rod"] = 5,
    ["Ares Rod"] = 126,
    ["Angler Rod"] = 168,
    ["Bamboo Rod"] = 258
}

local rodNames = {
    "Luck Rod (350 Coins)", "Carbon Rod (900 Coins)", "Grass Rod (1.5k Coins)", "Demascus Rod (3k Coins)",
    "Ice Rod (5k Coins)", "Lucky Rod (15k Coins)", "Midnight Rod (50k Coins)", "Steampunk Rod (215k Coins)",
    "Chrome Rod (437k Coins)", "Astral Rod (1M Coins)", "Ares Rod (3M Coins)", "Angler Rod (8M Coins)",
    "Bamboo Rod (12M Coins)"
}

local rodKeyMap = {
    ["Luck Rod (350 Coins)"] = "Luck Rod",
    ["Carbon Rod (900 Coins)"] = "Carbon Rod",
    ["Grass Rod (1.5k Coins)"] = "Grass Rod",
    ["Demascus Rod (3k Coins)"] = "Demascus Rod",
    ["Ice Rod (5k Coins)"] = "Ice Rod",
    ["Lucky Rod (15k Coins)"] = "Lucky Rod",
    ["Midnight Rod (50k Coins)"] = "Midnight Rod",
    ["Steampunk Rod (215k Coins)"] = "Steampunk Rod",
    ["Chrome Rod (437k Coins)"] = "Chrome Rod",
    ["Astral Rod (1M Coins)"] = "Astral Rod",
    ["Ares Rod (3M Coins)"] = "Ares Rod",
    ["Angler Rod (8M Coins)"] = "Angler Rod",
    ["Bamboo Rod (12M Coins)"] = "Bamboo Rod"
}

local selectedRod = rodNames[1]

Tab5:Dropdown({
    Title = "Select Rod",
    Values = rodNames,
    Value = selectedRod,
    Callback = function(value)
        selectedRod = value
        WindUI:Notify({Title="Rod Selected", Content=value, Duration=3})
    end
})

Tab5:Button({
    Title="Buy Rod",
    Callback=function()
        local key = rodKeyMap[selectedRod]
        if key and rods[key] then
            local success, err = pcall(function()
                RFPurchaseFishingRod:InvokeServer(rods[key])
            end)
            if success then
                WindUI:Notify({Title="Rod Purchase", Content="Purchased "..selectedRod, Duration=3})
            else
                WindUI:Notify({Title="Rod Purchase Error", Content=tostring(err), Duration=5})
            end
        end
    end
})

Tab5:Section({
    Title = "Buy Baits",
    Icon = "compass",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseBait = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]  

local baits = {
    ["TopWater Bait"] = 10,
    ["Lucky Bait"] = 2,
    ["Midnight Bait"] = 3,
    ["Chroma Bait"] = 6,
    ["Dark Mater Bait"] = 8,
    ["Corrupt Bait"] = 15,
    ["Aether Bait"] = 16,
    ["Floral Bait"] = 20,
}

local baitNames = {  
    "Luck Bait (1k Coins)", "Midnight Bait (3k Coins)", "Nature Bait (83.5k Coins)",  
    "Chroma Bait (290k Coins)", "Dark Matter Bait (630k Coins)", "Corrupt Bait (1.15M Coins)",  
    "Aether Bait (3.7M Coins)", "Floral Bait (4M Coins)"  
}  

local baitKeyMap = {  
    ["Luck Bait (1k Coins)"] = "Luck Bait",  
    ["Midnight Bait (3k Coins)"] = "Midnight Bait",  
    ["Nature Bait (83.5k Coins)"] = "Nature Bait",  
    ["Chroma Bait (290k Coins)"] = "Chroma Bait",  
    ["Dark Matter Bait (630k Coins)"] = "Dark Matter Bait",  
    ["Corrupt Bait (1.15M Coins)"] = "Corrupt Bait",  
    ["Aether Bait (3.7M Coins)"] = "Aether Bait",  
    ["Floral Bait (4M Coins)"] = "Floral Bait"  
}  

local selectedBait = baitNames[1]  

Tab5:Dropdown({  
    Title = "Select Bait",  
    Values = baitNames,  
    Value = selectedBait,  
    Callback = function(value)  
        selectedBait = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Bait",  
    Callback = function()  
        local key = baitKeyMap[selectedBait]  
        if key and baits[key] then  
            local success, err = pcall(function()  
                RFPurchaseBait:InvokeServer(baits[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Bait Purchase", Content = "Purchased " .. selectedBait, Duration = 3})  
            else  
                WindUI:Notify({Title = "Bait Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

Tab5:Section({
    Title = "Buy Weather Event",
    Icon = "cloud-drizzle",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab5:Divider()

local RFPurchaseWeatherEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]  

local weathers = {
    ["Wind"] = "Wind",
    ["Cloudy"] = "Cloudy",
    ["Snow"] = "Snow",
    ["Storm"] = "Storm",
    ["Shine"] = "Shine",
    ["Shark Hunt"] = "Shark Hunt"
}

local weatherNames = {  
    "Windy (10k Coins)", "Cloudy (20k Coins)", "Stormy (35k Coins)", 
    "Shining (50k Coins)", "Shark Hunt (300k Coins)", "Snow (15k Coins)"  
}  

local weatherKeyMap = {  
    ["Windy (10k Coins)"] = "Wind",  
    ["Cloudy (20k Coins)"] = "Cloudy",  
    ["Stormy (35k Coins)"] = "Storm",  
    ["Shining (50k Coins)"] = "Shine",  
    ["Shark Hunt (300k Coins)"] = "Shark Hunting",  
    ["Snow (15k Coins)"] = "Snow"  
}  

local selectedWeather = weatherNames[1]  

Tab5:Dropdown({  
    Title = "Select Weather Event",  
    Values = weatherNames,  
    Value = selectedWeather,  
    Callback = function(value)  
        selectedWeather = value  
    end  
})  

Tab5:Button({  
    Title = "Buy Weather Event",  
    Callback = function()  
        local key = weatherKeyMap[selectedWeather]  
        if key and weathers[key] then  
            local success, err = pcall(function()  
                RFPurchaseWeatherEvent:InvokeServer(weathers[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Weather Purchase", Content = "Purchased " .. selectedWeather, Duration = 3})  
            else  
                WindUI:Notify({Title = "Weather Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

local Tab6 = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
})

Tab6:Section({ 
    Title = "Island",
    Icon = "tree-palm",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local IslandLocations = {
    ["Admin Event"] = Vector3.new(-1981, -442, 7428),
    ["Ancient Jungle"] = Vector3.new(1518, 1, -186),
    ["Coral Refs"] = Vector3.new(-2855, 47, 1996),
    ["Crater Island"] = Vector3.new(997, 1, 5012),
    ["Crystal Cavern"] = Vector3.new(-1841, -456, 7186),
    ["Enchant Room"] = Vector3.new(3221, -1303, 1406),
    ["Enchant Room 2"] = Vector3.new(1480, 126, -585),
    ["Esoteric Island"] = Vector3.new(1990, 5, 1398),
    ["Fisherman Island"] = Vector3.new(-175, 3, 2772),
    ["Kohana Volcano"] = Vector3.new(-545.302429, 17.1266193, 118.870537),
    ["Konoha"] = Vector3.new(-603, 3, 719),
    ["Lost Isle"] = Vector3.new(-3643, 1, -1061),
    ["Sacred Temple"] = Vector3.new(1498, -23, -644),
    ["Sysyphus Statue"] = Vector3.new(-3783.26807, -135.073914, -949.946289),
    ["Treasure Room"] = Vector3.new(-3600, -267, -1575),
    ["Tropical Grove"] = Vector3.new(-2091, 6, 3703),
    ["Underground Cellar"] = Vector3.new(2135, -93, -701),
    ["Weather Machine"] = Vector3.new(-1508, 6, 1895),
    ["Ancient Ruin"] = Vector3.new(6051, -541, 4414),
}

local SelectedIsland = nil

local IslandDropdown = Tab6:Dropdown({
    Title = "Select Island",
    Values = (function()
        local keys = {}
        for name in pairs(IslandLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedIsland = Value
    end
})

Tab6:Button({
    Title = "Teleport to Island",
    Callback = function()
        if SelectedIsland and IslandLocations[SelectedIsland] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(IslandLocations[SelectedIsland])
        end
    end
})

Tab6:Section({ 
    Title = "Fishing Spot",
    Icon = "spotlight",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local FishingLocations = {
    ["Levers 1"] = Vector3.new(1475,4,-847),
    ["Levers 2"] = Vector3.new(882,5,-321),
    ["levers 3"] = Vector3.new(1425,6,126),
    ["levers 4"] = Vector3.new(1837,4,-309),
    ["Sysyphus Statue"] = Vector3.new(-3712, -137, -1010),
    ["Volcano"] = Vector3.new(-632, 55, 197),
	["King Jelly Spot (For quest elemental)"] = Vector3.new(1473.60, 3.58, -328.23),
	["El Shark Gran Maja Spot"] = Vector3.new(1526, 4, -629),
    ["Ancient Lochness"] = Vector3.new(6078, -586, 4629),
}

local SelectedFishing = nil

Tab6:Dropdown({
    Title = "Select Spot",
    Values = (function()
        local keys = {}
        for name in pairs(FishingLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedFishing = Value
    end
})

Tab6:Button({
    Title = "Teleport to Fishing Spot",
    Callback = function()
        if SelectedFishing and FishingLocations[SelectedFishing] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(FishingLocations[SelectedFishing])
        end
    end
})

Tab6:Section({
    Title = "Location NPC",
    Icon = "bot",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local NPC_Locations = {
    ["Alex"] = Vector3.new(43,17,2876),
    ["Aura kid"] = Vector3.new(70,17,2835),
    ["Billy Bob"] = Vector3.new(84,17,2876),
    ["Boat Expert"] = Vector3.new(32,9,2789),
    ["Esoteric Gatekeeper"] = Vector3.new(2101,-30,1350),
    ["Jeffery"] = Vector3.new(-2771,4,2132),
    ["Joe"] = Vector3.new(144,20,2856),
    ["Jones"] = Vector3.new(-671,16,596),
    ["Lava Fisherman"] = Vector3.new(-593,59,130),
    ["McBoatson"] = Vector3.new(-623,3,719),
    ["Ram"] = Vector3.new(-2838,47,1962),
    ["Ron"] = Vector3.new(-48,17,2856),
    ["Scott"] = Vector3.new(-19,9,2709),
    ["Scientist"] = Vector3.new(-6,17,2881),
    ["Seth"] = Vector3.new(107,17,2877),
    ["Silly Fisherman"] = Vector3.new(97,9,2694),
    ["Tim"] = Vector3.new(-604,16,609),
}

local SelectedNPC = nil

Tab6:Dropdown({
    Title = "Select NPC",
    Values = (function()
        local keys = {}
        for name in pairs(NPC_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedNPC = Value
    end
})

Tab6:Button({
    Title = "Teleport to NPC",
    Callback = function()
        if SelectedNPC and NPC_Locations[SelectedNPC] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(NPC_Locations[SelectedNPC])
        end
    end
})

Tab6:Section({
    Title = "Event Teleporter",
    Icon = "calendar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab6:Divider()

local Event_Locations = {
    ["Black Hole"] = Vector3.new(883, -1.4, 2542),
    ["Ghost Shark Hunt"] = Vector3.new(489.559, -1.35, 25.406),
    ["Megalodon Hunt"] = Vector3.new(-1076.3, -1.4, 1676.2),
    ["Meteor Rain"] = Vector3.new(383, -1.4, 2452),
    ["Shark Hunt"] = Vector3.new(1.65, -1.35, 2095.725),
    ["Storm Hunt"] = Vector3.new(1735.85, -1.4, -208.425),
    ["Worm Hunt"] = Vector3.new(1591.55, -1.4, -105.925),
}

local ActiveEvent = nil

Tab6:Dropdown({
    Title = "Select Event",
    Values = (function()
        local keys = {}
        for name in pairs(Event_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        ActiveEvent = Value
    end
})

Tab6:Button({
    Title = "Teleport to Event",
    Callback = function()
        local Char = Player.Character or Player.CharacterAdded:Wait()
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        if ActiveEvent and Event_Locations[ActiveEvent] then
            HRP.CFrame = CFrame.new(Event_Locations[ActiveEvent])
        end
    end
})

local Tab7 = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

Tab7:Toggle({
    Title = "AntiAFK",
    Desc = "Prevent Roblox from kicking you when idle",
    Icon = false,
    Type = false,
    Default = false,
    Callback = function(state)
        _G.AntiAFK = state
        local VirtualUser = game:GetService("VirtualUser")

        if state then
            task.spawn(function()
                while _G.AntiAFK do
                    task.wait(60)
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end)

            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK loaded!",
                Text = "Coded By Lexs",
                Button1 = "Okey",
                Duration = 5
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "AntiAFK Disabled",
                Text = "Stopped AntiAFK",
                Duration = 3
            })
        end
    end
})

Tab7:Toggle({
    Title = "Auto Reconnect",
    Desc = "Automatic reconnect if disconnected",
    Icon = false,
    Default = false,
    Callback = function(state)
        _G.AutoReconnect = state
        if state then
            task.spawn(function()
                while _G.AutoReconnect do
                    task.wait(2)

                    local reconnectUI = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                    if reconnectUI then
                        local prompt = reconnectUI:FindFirstChild("promptOverlay")
                        if prompt then
                            local button = prompt:FindFirstChild("ButtonPrimary")
                            if button and button.Visible then
                                firesignal(button.MouseButton1Click)
                            end
                        end
                    end
                end
            end)
        end
    end
})

Tab7:Section({ 
    Title = "Graphics In Game",
    Icon = "chart-bar",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function notify(text, color)
	pcall(function()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[FPS BOOST] " .. text,
			Color = color or Color3.fromRGB(150,255,150),
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size24
		})
	end)
end

local function applyFPSBoost(state)
	if state then
		---------------------------------------------------
		-- 🟢 AKTIFKAN MODE BOOST
		---------------------------------------------------
		notify("Mode Ultra Aktif ✅", Color3.fromRGB(100,255,100))
		print("[FPS BOOST] Mode Ultra Aktif")

		-- Hapus efek Lighting berat
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
				or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere")
				or v:IsA("Sky") or v:IsA("Clouds") or v:IsA("PostEffect") then
				v.Parent = nil
			end
		end

		-- Nonaktifkan Lighting kompleks
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e6
		Lighting.Brightness = 1
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
		Lighting.OutdoorAmbient = Color3.new(1,1,1)

		-- Terrain lebih ringan
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
		end

		-- Bersihkan workspace
		for _, obj in ipairs(Workspace:GetDescendants()) do
			-- Hilangkan texture dan decal
			if obj:IsA("Decal") or obj:IsA("Texture") then
				obj.Transparency = 1
			end

			-- Matikan efek visual
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire")
				or obj:IsA("Smoke") or obj:IsA("Sparkles") then
				obj.Enabled = false
			end

			-- Hapus efek PBR (SurfaceAppearance)
			if obj:IsA("SurfaceAppearance") then
				obj.Parent = nil
			end

			-- Nonaktifkan shadow dan ubah material ke Plastic
			if obj:IsA("BasePart") then
				obj.CastShadow = false
				pcall(function() obj.Material = Enum.Material.Plastic end)
			end
		end
		
		local char = Players.LocalPlayer.Character
		if char then
			for _, acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then
					acc:Destroy()
				end
			end
			if char:FindFirstChild("Animate") then
				char.Animate.Disabled = true
			end
		end
		
		workspace.StreamingEnabled = true
		workspace.StreamingMinRadius = 64
		workspace.StreamingTargetRadius = 128
		
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		
		collectgarbage("collect")

	else
		---------------------------------------------------
		-- 🔴 MATIKAN MODE BOOST
		---------------------------------------------------
		notify("Mode Ultra Nonaktif ❌", Color3.fromRGB(255,120,120))
		print("[FPS BOOST] Mode Ultra Nonaktif")

		-- Pulihkan Lighting aman
		Lighting.GlobalShadows = true
		Lighting.FogEnd = 1000
		Lighting.Brightness = 2
		Lighting.EnvironmentDiffuseScale = 1
		Lighting.EnvironmentSpecularScale = 1
		Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5)

		if Terrain then
			Terrain.WaterWaveSize = 0.15
			Terrain.WaterWaveSpeed = 10
			Terrain.WaterReflectance = 1
			Terrain.WaterTransparency = 0.5
		end

		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic

		-- Aktifkan kembali animasi karakter
		local char = Players.LocalPlayer.Character
		if char and char:FindFirstChild("Animate") then
			char.Animate.Disabled = false
		end
	end
end


local Toggle = Tab7:Toggle({
	Title = "FPS Boost",
	Icon = false,
	Type = false,
	Value = false,
	Callback = function(state)
		applyFPSBoost(state)
	end
})

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// State
local blockerEnabled = false
local guiConnections = {}

--// Fungsi blokir GUI
local function blockGuiObject(obj)
    if not blockerEnabled then return end
    if obj:IsA("ScreenGui") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        local name = obj.Name:lower()
        if string.find(name, "notif") 
        or string.find(name, "popup")
        or string.find(name, "you got")
        or string.find(name, "drop")
        or string.find(name, "reward")
        or string.find(name, "fish")
        or string.find(name, "catch") then
            task.wait()
            pcall(function()
                obj.Enabled = false
                obj:Destroy()
            end)
            print("[Blocked Game Notification]:", obj.Name)
        end
    end
end

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Hide All Notifications",
    Desc = "Hide All Notifications Fish Caught",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        blockerEnabled = state

        if state then
            print("[🛑 Game Notification Blocker Enabled]")

            -- Hapus GUI yang sudah ada
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                blockGuiObject(gui)
            end
            for _, gui in ipairs(CoreGui:GetChildren()) do
                blockGuiObject(gui)
            end

            -- Awasi GUI baru
            guiConnections["PlayerGui"] = PlayerGui.ChildAdded:Connect(blockGuiObject)
            guiConnections["CoreGui"] = CoreGui.ChildAdded:Connect(blockGuiObject)

        else
            print("[🔔 Game Notification Blocker Disabled]")
            for _, conn in pairs(guiConnections) do
                conn:Disconnect()
            end
            guiConnections = {}
        end
    end
})

--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// GUI placeholder
local whiteScreen = nil

--// Toggle MacLib
local Toggle = Tab7:Toggle({
    Title = "Disable 3D Rendering",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        if state then
            print("[🛑 3D Rendering Disabled + White Screen Enabled]")

            -- Matikan rendering 3D
            pcall(function()
                RunService:Set3dRenderingEnabled(false)
            end)

            -- Buat layar putih full
            whiteScreen = Instance.new("ScreenGui")
            whiteScreen.IgnoreGuiInset = true
            whiteScreen.ResetOnSpawn = false
            whiteScreen.Name = "WhiteScreenOverlay"
            whiteScreen.Parent = PlayerGui

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
            frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            frame.BorderSizePixel = 0
            frame.Parent = whiteScreen

        else
            print("[✅ 3D Rendering Re-enabled + White Screen Removed]")

            -- Aktifkan render kembali
            pcall(function()
                RunService:Set3dRenderingEnabled(true)
            end)

            -- Hapus layar putih
            if whiteScreen then
                whiteScreen:Destroy()
                whiteScreen = nil
            end
        end
    end
})

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- State
local vfxDisabled = false
local storedVFX = {}

-- Daftar tipe efek yang ingin dinonaktifkan
local vfxClasses = {
	"ParticleEmitter", "Beam", "Trail", "Smoke", "Fire", "Sparkles", "Explosion",
	"PointLight", "SpotLight", "SurfaceLight", "Highlight"
}

-- Efek Lighting pasca-proses
local lightingEffects = {
	"BloomEffect", "SunRaysEffect", "ColorCorrectionEffect", "DepthOfFieldEffect", "Atmosphere"
}

-- Nonaktifkan semua efek visual
local function disableAllVFX()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if table.find(vfxClasses, obj.ClassName) then
			if obj.Enabled ~= nil and obj.Enabled == true then
				storedVFX[obj] = true
				obj.Enabled = false
			end
		end
	end

	-- Matikan efek di Lighting
	for _, effName in ipairs(lightingEffects) do
		local eff = Lighting:FindFirstChildOfClass(effName)
		if eff and eff.Enabled ~= nil then
			storedVFX[eff] = true
			eff.Enabled = false
		end
	end

	print("[🧊 All VFX Disabled]")
end

-- Aktifkan kembali efek visual
local function enableAllVFX()
	for obj in pairs(storedVFX) do
		if obj and obj.Parent and obj.Enabled ~= nil then
			obj.Enabled = true
		end
	end
	storedVFX = {}
	print("[✨ All VFX Restored]")
end

-- Toggle UI
local Toggle = Tab7:Toggle({
    Title = "Hide All VFX",
    Icon = false,
    Type = false,
    Value = false,
    Callback = function(state)
        vfxDisabled = state

        if state then
            disableAllVFX()

            -- Jika efek baru muncul setelah toggle aktif
            Workspace.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(vfxClasses, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

            Lighting.DescendantAdded:Connect(function(obj)
                if vfxDisabled and table.find(lightingEffects, obj.ClassName) then
                    task.wait()
                    if obj.Enabled ~= nil then
                        obj.Enabled = false
                    end
                end
            end)

        else
            enableAllVFX()
        end
    end
})

Tab7:Section({ 
    Title = "Server",
    Icon = "server",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local Button = Tab7:Button({
    Title = "Rejoin",
    Desc = "rejoin to the same server",
    Locked = false,
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

TeleportService:Teleport(game.PlaceId, player)

    end
})

Tab7:Button({
    Title = "Server Hop",
    Desc = "Switch to another server",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local function GetServers()
            local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
            local response = HttpService:JSONDecode(game:HttpGet(url))
            return response.data
        end

        local function FindBestServer(servers)
            for _, server in ipairs(servers) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    return server.id
                end
            end
            return nil
        end

        local servers = GetServers()
        local serverId = FindBestServer(servers)

        if serverId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
        else
            warn("⚠️ No suitable server found!")
        end
    end
})

Tab7:Section({ 
    Title = "Config",
    Icon = "folder-open",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

local ConfigFolder = "LEXS_HUB/Configs"
if not isfolder("LEXS_HUB") then makefolder("LEXS_HUB") end
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end

local ConfigName = "default.json"

local function GetConfig()
    return {
        WalkSpeed = Humanoid.WalkSpeed,
        JumpPower = _G.CustomJumpPower or 50,
        InfiniteJump = _G.InfiniteJump or false,
        AutoSell = _G.AutoSell or false,
        InstantCatch = _G.InstantCatch or false,
        AntiAFK = _G.AntiAFK or false,
        AutoReconnect = _G.AutoReconnect or false,
    }
end

local function ApplyConfig(data)
    if data.WalkSpeed then 
        Humanoid.WalkSpeed = data.WalkSpeed 
    end
    if data.JumpPower then
        _G.CustomJumpPower = data.JumpPower
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = data.JumpPower
        end
    end
    if data.InfiniteJump ~= nil then
        _G.InfiniteJump = data.InfiniteJump
    end
    if data.AutoSell ~= nil then
        _G.AutoSell = data.AutoSell
    end
    if data.InstantCatch ~= nil then
        _G.InstantCatch = data.InstantCatch
    end
    if data.AntiAFK ~= nil then
        _G.AntiAFK = data.AntiAFK
    end
    if data.AutoReconnect ~= nil then
        _G.AutoReconnect = data.AutoReconnect
    end
end

Tab7:Button({
    Title = "Save Config",
    Desc = "Save all settings",
    Callback = function()
        local data = GetConfig()
        writefile(ConfigFolder.."/"..ConfigName, game:GetService("HttpService"):JSONEncode(data))
        print("✅ Config saved!")
    end
})

Tab7:Button({
    Title = "Load Config",
    Desc = "Use saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            local data = readfile(ConfigFolder.."/"..ConfigName)
            local decoded = game:GetService("HttpService"):JSONDecode(data)
            ApplyConfig(decoded)
            print("✅ Config applied!")
        else
            warn("⚠️ Config not found, please Save first.")
        end
    end
})

Tab7:Button({
    Title = "Delete Config",
    Desc = "Delete saved config",
    Callback = function()
        if isfile(ConfigFolder.."/"..ConfigName) then
            delfile(ConfigFolder.."/"..ConfigName)
            print("🗑 Config deleted!")
        else
            warn("⚠️ No config to delete.")
        end
    end
})

Tab7:Section({ 
    Title = "Other Scripts",
    Icon = "file-code-2",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab7:Divider()

Tab7:Button({
    Title = "Infinite Yield",
    Desc = "Other Scripts",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end
})

getgenv().LexsHubWindow = Window

return Window
