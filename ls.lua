local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 
local Window = Rayfield:CreateWindow({
    Name = "Lifting Simulator",
    LoadingTitle = "Lifting Simulator",
    LoadingSubtitle = "by Roblox Scripter",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })
 
 Rayfield:Notify({
    Title = "Executor Supported",
    Content = "You are ready to go!",
    Duration = 6.5,
    Image = 4483362458,
    Actions = { -- Notification Buttons
       Ignore = {
          Name = "Okay!",
          Callback = function()
          print("The user tapped Okay!")
       end
    },
 },
 })
 
 local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image
 local Section = MainTab:CreateSection("Main")
 
 local Button = MainTab:CreateButton({
    Name = "Auto Click",
    Callback = function()
        while wait() do
            local args = {
                [1] = {
                    [1] = "GainMuscle"
                }
            }
 
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
             end
    end,
 })
 
 local Button = MainTab:CreateButton({
    Name = "Auto Sell",
    Callback = function()
        while wait(1.5) do
            local args = {
                [1] = {
                    [1] = "SellMuscle"
                }
            }
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            end
    end,
 })
 
 local Button = MainTab:CreateButton({
    Name = "Anti-Afk (Credits #James0007",
    Callback = function()
        while wait(1.5) do
             loadstring(game:HttpGet("https://raw.githubusercontent.com/KazeOnTop/Rice-Anti-Afk/main/Wind", true))()
    end
    end,
 })
 
 local Button = MainTab:CreateButton({
    Name = "Kill Script",
    Callback = function()
        Rayfield:Destroy()
    end,
 })
 
 
 
 local MiscTab = Window:CreateTab("Misc", 4483362458)
 local Section = MiscTab:CreateSection("Section Example")
 
 local Button = MiscTab:CreateButton({
    Name = "Inf Yield (Don't Use FLY! Admin)",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end,
 })
 
 local Button = MiscTab:CreateButton({
    Name = "Cmd X (Don't Use FLY! Admin)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
    end,
 })
 
local Button = MiscTab:CreateButton({
   Name = "BackFlip And FrontFlip (Toggles = X,Z) 5 SEC to load",
   Callback = function()
  -- Copy from where it says wait(5) this is not my script so I will not take script credits
 
-- Discord server coming soon
 
wait(5)
 
--[[ Info ]]--
 
local ver = "2.00"
local scriptname = "feFlip"
 
 
--[[ Keybinds ]]--
 
local FrontflipKey = Enum.KeyCode.Z
local BackflipKey = Enum.KeyCode.X
local AirjumpKey = Enum.KeyCode.C
 
 
--[[ Dependencies ]]--
 
local ca = game:GetService("ContextActionService")
local zeezy = game:GetService("Players").LocalPlayer
local h = 0.0174533
local antigrav
 
 
--[[ Functions ]]--
 
function zeezyFrontflip(act,inp,obj)
	if inp == Enum.UserInputState.Begin then
		zeezy.Character.Humanoid:ChangeState("Jumping")
		wait()
		zeezy.Character.Humanoid.Sit = true
		for i = 1,360 do 
			delay(i/720,function()
			zeezy.Character.Humanoid.Sit = true
				zeezy.Character.HumanoidRootPart.CFrame = zeezy.Character.HumanoidRootPart.CFrame * CFrame.Angles(-h,0,0)
			end)
		end
		wait(0.55)
		zeezy.Character.Humanoid.Sit = false
	end
end
 
function zeezyBackflip(act,inp,obj)
	if inp == Enum.UserInputState.Begin then
		zeezy.Character.Humanoid:ChangeState("Jumping")
		wait()
		zeezy.Character.Humanoid.Sit = true
		for i = 1,360 do
			delay(i/720,function()
			zeezy.Character.Humanoid.Sit = true
				zeezy.Character.HumanoidRootPart.CFrame = zeezy.Character.HumanoidRootPart.CFrame * CFrame.Angles(h,0,0)
			end)
		end
		wait(0.55)
		zeezy.Character.Humanoid.Sit = false
	end
end
 
function zeezyAirjump(act,inp,obj)
	if inp == Enum.UserInputState.Begin then
		zeezy.Character:FindFirstChildOfClass'Humanoid':ChangeState("Seated")
		wait()
		zeezy.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")	
	end
end
 
 
--[[ Binds ]]--
 
ca:BindAction("zeezyFrontflip",zeezyFrontflip,false,FrontflipKey)
ca:BindAction("zeezyBackflip",zeezyBackflip,false,BackflipKey)
ca:BindAction("zeezyAirjump",zeezyAirjump,false,AirjumpKey)
 
--[[ Load Message ]]--
 
print(scriptname .. " " .. ver .. " loaded successfully")
print("made by RobloxScripter")
 
local notifSound = Instance.new("Sound",workspace)
notifSound.PlaybackSpeed = 1.5
notifSound.Volume = 0.15
notifSound.SoundId = "rbxassetid://170765130"
notifSound.PlayOnRemove = true
notifSound:Destroy()
game.StarterGui:SetCore("SendNotification", {Title = "feFlip", Text = "feFlip loaded successfully!", Icon = "rbxassetid://505845268", Duration = 5, Button1 = "Okay"})
   end,
})
