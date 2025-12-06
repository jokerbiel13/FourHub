-- sus code leak lull!!!
-- (just saying that this is the oldest script maybe even the first script on defuse division i put 0 effort in this cus yuna was trying to put it in FLOHAXX)

local color, rgb, hex, hsv, rgbseq, rgbkey, numseq, numkey = Color3.new, Color3.fromRGB, Color3.fromHex, Color3.fromHSV, ColorSequence.new, ColorSequenceKeypoint.new, NumberSequence.new, NumberSequenceKeypoint.new
local forcefieldanimations = {
    ["sky"] = "rbxassetid://1494603972",
    ["web"] = "rbxassetid://301464986",
    ["webbed"] = "rbxassetid://2179243880",
    ["scanning"] = "rbxassetid://5843010904",
    ["pixelated"] = "rbxassetid://140652787",
    ["swirl"] = "rbxassetid://8133639623",
    ["checkerboard"] = "rbxassetid://5790215150",
    ["christmas"] = "rbxassetid://6853532738",
    ["player"] = "rbxassetid://4494641460",
    ["shield"] = "rbxassetid://361073795",
    ["dots"] = "rbxassetid://5830615971",
    ["bubbles"] = "rbxassetid://1461576423",
    ["matrix"] = "rbxassetid://10713189068",
    ["honeycomb"] = "rbxassetid://179898251",
    ["groove"] = "rbxassetid://10785404176",
    ["cloud"] = "rbxassetid://5176277457",
    ["smudge"] = "rbxassetid://6096634060",
    ["scrapes"] = "rbxassetid://6248583558",
    ["galaxy"] = "rbxassetid://1120738433",
    ["galaxies"] = "rbxassetid://5101923607",
    ["stars"] = "rbxassetid://598201818",
    ["rainbow"] = "rbxassetid://10037165803",
    ["wires"] = "rbxassetid://14127933",
    ["camo"] = "rbxassetid://3280937154",
    ["hexagon"] = "rbxassetid://6175083785",
    ["particles"] = "rbxassetid://1133822388",
    ["triangular"] = "rbxassetid://4504368932",
    ["wall"] = "rbxassetid://4271279"
}

local knives = {}
local allskins = {}

for _, v in pairs(game:GetService("ReplicatedStorage").Import.Guns.Weapons:GetChildren()) do
    if v:FindFirstChild("Melee") and v.Name ~= "C4" then
        table.insert(knives, v.Name)
    end
end

table.insert(knives, 1, "none")

for _, gun in pairs(game:GetService("ReplicatedStorage").Import.Assets.Skins:GetChildren()) do
    local skins = gun:GetChildren()
    
    allskins[gun.Name] = {"none"}
    
    if #skins > 0 then
        for _, skin in pairs(skins) do
            table.insert(allskins[gun.Name], skin.Name)
        end
    end
end


local dim_offset = UDim2.fromOffset 
local dim2 = UDim2.new 
local camera = workspace.CurrentCamera
local rgb = Color3.fromRGB 
local Players = cloneref(game:GetService("Players"))
local LocalPlayer, localplayer = Players.LocalPlayer, Players.LocalPlayer

local signal = loadstring(game:HttpGet("https://4haxx.vercel.app/scripts/signal.lua"))()
local Library, Esp, MiscOptions, Options = loadstring(game:HttpGet("https://raw.githubusercontent.com/inveris1337/storage/refs/heads/main/libraries/octohook.lua"))()
getgenv().Library = Library
local Holder = Library:Window({Name = "octohook"})

local Window = Holder:Panel({
    Name = "octohook - defuse division", 
    ButtonName = "octohook", 
    Size = dim_offset(550, 709), 
    Position = dim2(0, (camera.ViewportSize.X / 2) - 550/2, 0, (camera.ViewportSize.Y / 2) - 709/2), -- offset based on sizing 
})

    local Tabs = {
        rage = Window:Tab({Name = "rage"}),
        movement = Window:Tab({Name = "movement"}),
        visual = Window:Tab({Name = "visual"}),
        skin_changer = Window:Tab({Name = "skin changer"}),
        esp = Window:Tab({Name = "esp"}),
    }

    local col1 = Tabs.rage:Column({})
    local movement = Tabs.movement:Column({})
    local skin_changer = Tabs.skin_changer:Column({})
    local visual = Tabs.visual:Column({})
    local aimlock = col1:Section({Name = "aimbot"})
    aimlock:Toggle({Name = "enabled", Flag = "rage_enabled"})
    aimlock:Toggle({Name = "auto shoot", Flag = "rage_auto_shoot"})
    aimlock:Toggle({Name = "auto wall", Flag = "rage_auto_wall"})
    aimlock:Dropdown({Name = "hitboxes", Flag = "rage_hitboxes", Options = {"head", "arms", "legs", "torso"}, Multi = true})
    --aimlock:Slider({Min = 1, Max = 4000, Decimal = 1, Flag = "rage_maxwalls", Name = "auto wall maximum wall"}) 
    aimlock:Toggle({Name = "kill all", Flag = "rage_kill_all"})
    local movement_main = movement:Section({Name = "main"})
    movement_main:Toggle({Name = "auto bhop", Flag = "movement_bhop", Callback = function(va)
        if game.Players.LocalPlayer.Character and va == true then
            local tables = {}
            for _, func in pairs(getgc(true)) do
                if type(func) == "function" then
                    for _, up in pairs(debug.getupvalues(func)) do
                        if type(up) == "table" and rawget(up, "autoBunnyHopping") ~= nil then
                            table.insert(tables, up)
                        end
                    end
                end
            end

            for _, v in pairs(tables) do
                v.autoBunnyHopping = Library.Flags.movement_bhop
                if v.bunnyHoppingEnabled ~= nil then
                    v.bunnyHoppingEnabled = Library.Flags.movement_bhop
                end
            end
        end
    end})
    movement_main:Label({Name = "nothing else here :P i couldn't find more"})
    
    local skin_changer_main = skin_changer:Section({Name = "main"})
    local knife_skin_list = nil
    skin_changer_main:Toggle({Name = "knife changer", Flag = "skin_knife_changer"})
    gay_furry_femboy = signal.new()
    skin_changer_main:Dropdown({
        Name = "knife list",
        Flag = "skin_knife_list",
        Options = knives,
        Multi = false,
        Callback = function(value)
            print(value)
            --gay_furry_femboy
            if knife_skin_list ~= nil then
                local skins = allskins[value]
                if not skins or next(skins) == nil then
                    skins = {"none"}
                    knife_skin_list.Set("none")
                end
                
                knife_skin_list.RefreshOptions(skins)
                knife_skin_list.Set("none")
                gay_furry_femboy:Fire(value)
            end
        end
    })
    local gay_furry_yuna = signal.new()
    knife_skin_list = skin_changer_main:Dropdown({Name = "knife skin list", Flag = "skin_knifeskin_list", Options = {}, Multi = false, Callback = function(valid)
        gay_furry_yuna:Fire(valid)
    end})
    if knife_skin_list ~= nil then
        local skins = allskins[Library.Flags.skin_knife_changer]
        if not skins or next(skins) == nil then
            skins = {"none"}
        end
                
        knife_skin_list.RefreshOptions(skins)
    end
    local data = require(game:GetService("ReplicatedStorage").Import.Framework.DataModule)
    local Terrorist_Loadout = data.PlayerData["TLoadout"]
    local Counter_Terrorist_Loadout = data.PlayerData["CTLoadout"]
    local knife_skin = "none"
    gay_furry_yuna:Connect(function(value)
        knife_skin = value
    end)
    gay_furry_femboy:Connect(function(value)
        if value and Library.Flags.skin_knifeskin_list == "none" then
            Terrorist_Loadout.Knife = value
            Counter_Terrorist_Loadout.Knife = value
        elseif Library.Flags.skin_knifeskin_list ~= "none" and Library.Flags.skin_knife_changer then
            Terrorist_Loadout.Knife = value  .. "_" .. knife_skin
            Counter_Terrorist_Loadout.Knife = value .. "_" .. knife_skin
        end
    end)
    local visual_main = visual:Section({Name = "main"})
    visual_main:Toggle({Name = "gun chams", Flag = "visual_gunchams"}):Colorpicker({Name = "gun chams color", Flag = "visual_gunchams_color", Color = color(1, 1, 1), Alpha = 0})

    --[[
    local List;
    mods:Textbox({Name = "Search", Callback = function(text)
        if not List then 
            return 
        end 

        List.Filter(text)
    end})

    List = mods:Dropdown({Name = "Search + Scroll", Scrolling = true, Size = 100, Search = true, Callback = function(option)
        print(option)
    end})
        
    local Table = {}

    for i = 1, 100 do 
        table.insert(Table, tostring(i))
    end

    List.RefreshOptions(Table)

    local List;
    mods:Textbox({Name = "Search", Callback = function(text)
        if not List then 
            return 
        end 

        List.Filter(text)
    end})

    List = mods:List({Name = "Search + Scroll", Scrolling = true, Size = 100, Callback = function(option)
        print(option)
    end})
        
    local Table = {}

    for i = 1, 100 do 
        table.insert(Table, tostring(i))
    end

    List.RefreshOptions(Table)

    mods:Slider({Min = 0.1, Max = 10, Decimal = 1}) ]]
-- 

-- Esp preview 
    local Column = Tabs.esp:Column({})
    local EspPreviewSection = Column:Section({Name = "ESP"})
    local EspPreview = EspPreviewSection:EspPreview({})
    local PlayersTab = EspPreview:AddTab({
        Name = "Players", 
        Model = "rbxassetid://14966982841",
        Chams = true
    });
    -- EspPreview:AddTab({Name = "Idk", Model = "rbxassetid://12340371165", Scale = 0.5})
    

    --[[
        READ IF YOU WANT TO MODIFY THE ESP SOURCE CODE

        Adding a new text or bar means you have to go to the createobject code and make a new element for said item 
            -> (Also you have to call addbar or addtext to add a suffix to the esp) 
           
        For adding static text (like usernames), make the text and filter it in the refreshelements function. 
            -> Yes the filter looks like yandere dev code and can be easily rewritten.
        
        For updating text, eg distance or tools or whatever, update it in the update function
            -> Look at the distance text for more info 

        Bars aren't filtered I didnt add code for it, if you want you can modify it to filter through like healthbars
            -> If you make the filter then you can follow same instructions as the text. 
        
        Boxes just exist, you dont need to do anything to them I believe

        Yes multi tabs exist however I didnt find a use for 2 tabs yet so the code may not be compatible, you will need to code a filter for that aswell.
        (Literally can be added in like under 5 minutes if you know lua)

        Extra Info: 
        + CHAMS ARE HARDCODED TO PLAYERS TAB
        + For the tab where the 3d character is held, there is a scale parameter for larger models. 
        + Esp relies on miscoptions and options for the newindex where each element is filtered and updated. Dont ask why.  
    ]]
    
    PlayersTab.AddBar({Name = "Healthbar", Prefix = "Healthbar"})
    PlayersTab.AddText({Name = "Name", Prefix = "Name"})
    PlayersTab.AddText({Name = "Distance", Prefix = "Distance"})
    PlayersTab.AddBox({Name = "Box"})
    
    local Column = Tabs.esp:Column({})
-- 

Tabs.Settings = Window:Tab({Name = "settings"})
Library:Configs(Holder, Tabs.Settings)

-- Loops for text
    task.spawn(function()
        while task.wait(1) do
            if not Holder.Items.Holder.Visible then 
                continue
            end 

            Holder.ChangeMenuTitle(string.format("%s - gay femboy vers. - %s", Holder.Name, os.date("%b. %d %Y, %X")))
        end 
    end)

    Holder.ChangeMenuTitle(string.format("%s - gay femboy vers. - %s", Holder.Name, os.date("%b. %d %Y, %X")))
-- 

-- init this before esp 
    for index,value in MiscOptions do 
        Options[index] = value -- gotta trigger that new index
    end
-- 

for _,player in Players:GetPlayers() do 
    if player == LocalPlayer then 
        continue 
    end 

    Esp.CreateObject(player)
end 

Esp:Connection(Players.PlayerRemoving, Esp.RemovePlayer)
Esp:Connection(Players.PlayerAdded, function(player)
    Esp.CreateObject(player)

    for index,value in MiscOptions do 
        Options[index] = value
    end 
end)

local workspace         = workspace --nigger
local game              = game
local math              = math
local RaycastParams     = RaycastParams
local table             = table
local getnamecallmethod = getnamecallmethod
local task              = task
local string            = string
local next              = next
local debug             = debug
local Enum              = Enum
local soundService      = game.SoundService
local lighting          = game.Lighting
local players           = game:GetService("Players")
local runService        = game:GetService("RunService")
local teleportService   = game:GetService("TeleportService")
local userInputService  = game:GetService("UserInputService")
local httpService       = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userSettings      = UserSettings():GetService("UserGameSettings")
local tweenService      = game:GetService("TweenService")
local physicsService    = game:GetService("PhysicsService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local networkClient     = game:GetService("NetworkClient")
local hitpart = game:GetService("ReplicatedStorage").Import.Remotes.HurtPlayer
local cam, camera = workspace.CurrentCamera, workspace.CurrentCamera

local client_script = nil
for _,v in pairs(getgc(true)) do
    if type(v) == "table" and rawget(v, "regcount") ~= nil then
        client_script = v
    end
end

local function rpm_to_seconds(rpm)
    return 60 / rpm
end

local utility = {}
local ragebot = {}
utility["loops"] = {}
local event_map = {
    renderstepped = runService.RenderStepped,
    stepped = runService.Stepped,
    heartbeat = runService.Heartbeat,
    presimulation = runService.PreSimulation,
    postsimulation = runService.PostSimulation
}

function utility.runservice_new(loop_type, name)
    if not name then error("requires a name.") end
    local self = setmetatable({}, utility)
    self.name = name
    self.loop_type = loop_type and loop_type:lower() or "heartbeat"
    self.connections = {}
    utility["loops"][self.name] = self
    return self
end

function utility:connect(callback)
    if typeof(callback) ~= "function" then
        error("expected a function but got " .. tostring(typeof(callback)))
    end

    local event = event_map[self.loop_type]
    if not event then
        error("invalid " .. self.loop_type)
    end

    local conn = event:Connect(callback)
    table.insert(self.connections, conn)
    return conn
end

function utility:disconnect_all()
    for _, conn in ipairs(self.connections) do
        if conn.Connected then
            conn:Disconnect()
        end
    end
    self.connections = {}
    utility["loops"][self.name] = nil
end

function utility.disconnect(name)
    local loop = utility["loops"][name]
    if loop then
        loop:disconnect_all()
    end
end

function utility:get_team(player)
    return IsA(player, "Player") and player.Team or nil
end

function utility:get_character(player)
    return player.Character or nil
end

function utility:get_humanoid(character)
    return FindFirstChildWhichIsA(character, "Humanoid")
end

function utility:get_players()
    return players:GetPlayers()
end

function utility:get_name(player)
    return player.Name
end

function utility:get_health(player, humanoid)
    return humanoid and humanoid.Health or 100, humanoid and humanoid.MaxHealth or 100
end

function utility:get_local_player_character()
    return utility:get_character(LocalPlayer)
end

function utility:get_tool_name(player, character)
    local tool = FindFirstChildWhichIsA(character, "Tool")
    return tool and tool.Name
end

--// ragebot achor!!
--// (ill code my own this time FUCK LINEMASTER SHE SUCKS :skull: UNPRIVATE UR CODE NIGGA!!)
--// APPRENTLY SHES COMMENTING SHIT WITH "--//" ??????????? WHO ARE U..
-- lowk this looked like bloxsense.. i might be invaded.. guys..

-- this is only when we are shooting them not actually the get_closet_player stuff ykyk..
ragebot["current_target"] = {}
ragebot["current_target"]["player"] = nil
ragebot["current_target"]["character"] = nil
ragebot["current_target"]["last_head_pos"] = Vector3.new(0, 0, 0)

ragebot["can_shoot"] = true

function ragebot:getdistance(a, b)
    return (a - b).Magnitude
end
local can_wallbang_this_guy = false
function ragebot:can_wallbang(origin, pos, maxpenetration)
    local direction = (pos - origin).Unit
    local distance = (pos - origin).Magnitude
    local remainingdistance = distance
    local currentorigin = origin
    local wallspassed = 0

    while remainingdistance > 0 do
        local raycastparams = RaycastParams.new()
        raycastparams.FilterType = Enum.RaycastFilterType.Whitelist
        raycastparams.FilterDescendantsInstances = {workspace.Map.Geometry}
        local result = workspace:Raycast(currentorigin, direction * remainingdistance, raycastparams)
        
        if result then
            wallspassed = wallspassed + 1
            if wallspassed > maxpenetration then
                can_wallbang_this_guy = false
                return false
            end
            currentorigin = result.Position + direction * 0.1
            remainingdistance = (pos - currentorigin).Magnitude
        else
            can_wallbang_this_guy = true
            return true
        end
    end
    can_wallbang_this_guy = true
    return true
end

function ragebot:run_hitpart(player, hitbox, damage, gun, headshot, noscope, wallbang)
	local plr_char 	= player.Character
	
	hitbox 		= hitbox or "Head"
	headshot 	= headshot or false
	noscope 	= noscope or false
	wallbang 	= wallbang or false
	damage		= damage or 9e9
	gun			= gun or "Karambit"

    local gunfolder = game.Players.LocalPlayer:FindFirstChild("Gun")
    local cur_gun = (gunfolder and gunfolder.Value) or "USP"
    local weps    = game:GetService("ReplicatedStorage").Import.Guns.Weapons:FindFirstChild(cur_gun)

	if headshot == nil then headshot = false 	  end
	if noscope  == nil then noscope  = false 	  end
	if wallbang == nil then wallbang = false 	  end
	if hitbox 	== nil then hitbox 	 = "Head"     end
	if damage 	== nil then damage   = 9e9 	 	  end
	if gun		== nil then gun		 = "Karambit" end
    if hitbox == "Head"  then
        if weps:FindFirstChild("DamageMultiplier") then
            local dmg_mult = weps:FindFirstChild("DamageMultiplier").Value or 6
            damage = damage * dmg_mult
        else
            damage = damage * 6
        end
        headshot = true --// forces it to be true cus.. why not duh
    end
	local args = {
		plr_char,
		damage,
		game:GetService("ReplicatedStorage").Import.GunWork.Client,
		plr_char:FindFirstChild(hitbox),
		headshot, -- headshot
		wallbang, -- wallbang
		noscope, -- noscope
		client_script.regcount,
		gun,
		nil
	}
	hitpart:FireServer(unpack(args, 1, #args + 1))
    client_script.firebullet()
end



function ragebot:get_hitboxes(tbl)
    local result = {}

    for _, name in pairs(tbl) do
        local lower = name:lower()

        if lower == "head" then
            table.insert(result, "Head")

        elseif lower == "arms" then
            table.insert(result, "LeftUpperArm")
            table.insert(result, "LeftLowerArm")
            table.insert(result, "LeftHand")
            table.insert(result, "RightUpperArm")
            table.insert(result, "RightLowerArm")
            table.insert(result, "RightHand")

        elseif lower == "legs" then
            table.insert(result, "LeftUpperLeg")
            table.insert(result, "LeftLowerLeg")
            table.insert(result, "LeftFoot")
            table.insert(result, "RightUpperLeg")
            table.insert(result, "RightLowerLeg")
            table.insert(result, "RightFoot")

        elseif lower == "torso" then
            table.insert(result, "UpperTorso")
            table.insert(result, "LowerTorso")
        end
    end

    return result
end


function ragebot:isvisible(target)
    local origin = camera.CFrame.Position
    local direction = (target.Position - origin)
    local raycastparams = RaycastParams.new()
    raycastparams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastparams.FilterDescendantsInstances = {localplayer.Character}
    local result = workspace:Raycast(origin, direction, raycastparams)
    return result == nil or result.Instance:IsDescendantOf(target.Parent)
end
function ragebot:get_head_pos(enemy)
    if not enemy or not enemy.Character then return nil end
    local head = enemy.Character:FindFirstChild("Head")
    if head and head.Position then
        self["current_target"]["last_head_pos"] = head.Position
        return head.Position
    elseif self["current_target"]["last_head_pos"] then
        return self["current_target"]["last_head_pos"]
    end

    return nil
end

function ragebot:getclosestplayers()
    local closest
    local closest_dist = math.huge
    local autowall_enabled = Library.Flags.rage_auto_wall
    local localplayer_team = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerStates") and game:GetService("Players").LocalPlayer.PlayerStates:FindFirstChild("Team") and game:GetService("Players").LocalPlayer.PlayerStates.Team.Value

    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr == localplayer then continue end

        local plr_team = plr:FindFirstChild("PlayerStates") and plr.PlayerStates:FindFirstChild("Team") and plr.PlayerStates.Team.Value
        if plr_team == localplayer_team or plr_team == nil or plr_team == "Spectator" or localplayer_team == "Spectator" then
            continue
        end

        local char = plr.Character
        if not char then continue end

        local head = char:FindFirstChild("Head")
        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if not head or not humanoid or humanoid.Health <= 0 then continue end

        local hrp = localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart")
        local origin = hrp and hrp.Position or cam.CFrame.Position


        local cansee = ragebot:isvisible(head)
        local canwall = false

        if autowall_enabled and not cansee then
            canwall = ragebot:can_wallbang(origin, head.Position, client_script.maxwallbangs)
        end

        if not cansee and not canwall then continue end

        local dist = (head.Position - origin).Magnitude
        if dist < closest_dist then
            closest_dist = dist
            closest = plr
        end
    end

    return closest
end

local last_fire = 0
runService.RenderStepped:Connect(function()
    local now = tick()
    local enemies = nil
    local gunfolder = game.Players.LocalPlayer:FindFirstChild("Gun")
    local cur_gun = (gunfolder and gunfolder.Value) or "USP"

    local weps    = game:GetService("ReplicatedStorage").Import.Guns.Weapons:FindFirstChild(cur_gun)
    if Library.Flags.rage_enabled then
        enemies = ragebot:getclosestplayers()
        if enemies and enemies.Character then
            ragebot["current_target"]["character"] = enemies.Character
            ragebot["current_target"]["player"] = enemies
            ragebot:get_head_pos(enemies)
        end
    end

    if Library.Flags.rage_kill_all then
        task.spawn(function()
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v and v.Character and v.Character:FindFirstChild("Head") then
                    local Event = game:GetService("ReplicatedStorage").Import.Remotes.HurtPlayer
                    Event:FireServer(
                        v.Character,
                        9e9,
                        game:GetService("ReplicatedStorage").Import.GunWork.Client,
                        v.Character.Head,
                        true,
                        false,
                        false,
                        client_script.regcount,
                        "Karambit", -- brr brr patapim
                        nil
                    )
                end
            end
        end)
    end

    if Library.Flags.rage_auto_shoot and Library.Flags.rage_enabled and enemies and enemies.Character then
        if game.Players.LocalPlayer.Character 
        and not game.Players.LocalPlayer.Character:FindFirstChild("Freeze") 
        and game:GetService("ReplicatedStorage").Import.Control.ExtendControl.ExtendControl.Reloading.Value ~= true 
        and game:GetService("ReplicatedStorage").Import.Control.ExtendControl.ExtendControl.Equipping.Value       ~= true
        and cur_gun
        then
            local hitboxes = ragebot:get_hitboxes(Library.Flags.rage_hitboxes)
            if #hitboxes == 0 then
                hitboxes = {"Head"}
            end

            local gun_name = cur_gun:lower()
            if gun_name:find("knife") 
            or gun_name:find("karambit") 
            or gun_name:find("bowie") 
            or gun_name:find("canis") then
                return
            end

            local rpm = weps:FindFirstChild("FireRate").Value or 600
            if now - last_fire >= rpm_to_seconds(rpm) then
                ragebot:run_hitpart(enemies, hitboxes[math.random(1, #hitboxes)], 50, cur_gun, nil, false, can_wallbang_this_guy)
                last_fire = now
            end
        end
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    local tables = {}
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" then
            for _, up in pairs(debug.getupvalues(func)) do
                if type(up) == "table" and rawget(up, "autoBunnyHopping") ~= nil then
                    table.insert(tables, up)
                end
            end
        end
    end

    for _, v in pairs(tables) do
        v.autoBunnyHopping = Library.Flags.movement_bhop
        if v.bunnyHoppingEnabled ~= nil then
            v.bunnyHoppingEnabled = Library.Flags.movement_bhop
        end
    end
end)

local cast_bullet_old = client_script.CastBulletBulletTracer
client_script.CastBulletBulletTracer = function(...)
    local args = {...}

    if args and Library.Flags.rage_enabled and ragebot["current_target"] and ragebot["current_target"]["last_head_pos"] then
        local head_pos = ragebot["current_target"]["last_head_pos"]
        local camera = workspace.CurrentCamera

        local screen_pos = camera:WorldToViewportPoint(head_pos)
        local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
        local offset = Vector3.new(
            (screen_pos.X - center.X) / (camera.ViewportSize.X / 1920),
            -(screen_pos.Y - center.Y) / (camera.ViewportSize.Y / 1080),
            0
        )
        --print("omg bro just work")
        args[1] = offset
        args[2] = (head_pos - camera.CFrame.Position).Magnitude
    end

    return cast_bullet_old(table.unpack(args))
end

local bullethole_old = client_script.createbullethole
client_script.createbullethole = function(...)
    local args = {...}

    if args and Library.Flags.rage_enabled and ragebot["current_target"] and ragebot["current_target"]["last_head_pos"] then
        local head_pos = ragebot["current_target"]["last_head_pos"]
        args[3] = head_pos
    end

    return bullethole_old(table.unpack(args))
end
local old_namecall
old_namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod():lower()
        if self.Name == "CreateBulletHole" and method == "fireserver" then
            if Library.Flags.rage_enabled and ragebot["current_target"]["character"] then
                args[3] = ragebot["current_target"]["last_head_pos"]
                print("yes i am functioning!", self.Name)
            end
            return old_namecall(self, unpack(args))
        elseif self.Name == "TracerServer" and method == "fireserver" then
            if Library.Flags.rage_enabled and ragebot["current_target"]["character"] then
                args[1] = ragebot["current_target"]["last_head_pos"]
                print("yes i am functioning!", self.Name)
            end
            return old_namecall(self, unpack(args))
        elseif self.Name == "WallbangTracer" and method == "fireserver" then
            if Library.Flags.rage_enabled and ragebot["current_target"]["character"] then
                args[1] = ragebot["current_target"]["last_head_pos"]
                print("yes i am functioning!", self.Name)
            end
            return old_namecall(self, unpack(args))
        end

    return old_namecall(self, ...)
end)
-- unfinisihed ion gaf
workspace.CurrentCamera.ChildAdded:Connect(function(obj)
	if obj:IsA("Model") and obj.Name == "Arms" and Library.Flags.visual_gunchams then
		for _, arms_object in pairs(obj:GetDescendants()) do
			if arms_object:IsA("MeshPart") then
				local name = arms_object.Name:lower()
				if not (string.find(name, "arm") or string.find(name, "hands") or string.find(name, "sleeve") or string.find(name, "glove")) then
					local mesh = arms_object
                    mesh.Color = Library.Flags.visual_gunchams_color.Color
                    --mesh.Transparency = Library.Flags.visual_gunchams_color.Alpha
					mesh.Material = Enum.Material.ForceField
					if mesh:FindFirstChildOfClass("SurfaceAppearance") then
						mesh:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
					end
					mesh.TextureID = forcefieldanimations["sky"]
				end
			end
		end
	end
end)

--[[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
        local tables = {}
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" then
            for _, up in pairs(debug.getupvalues(func)) do
                if type(up) == "table" and rawget(up, "autoBunnyHopping") ~= nil then
                    table.insert(tables, up)
                end
            end
        end
    end

    for _, v in pairs(tables) do
        v.autoBunnyHopping = true
        if v.bunnyHoppingEnabled ~= nil then
            v.bunnyHoppingEnabled = true
        end
    end
end)

if LocalPlayer.Character then
        local tables = {}
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" then
            for _, up in pairs(debug.getupvalues(func)) do
                if type(up) == "table" and rawget(up, "autoBunnyHopping") ~= nil then
                    table.insert(tables, up)
                end
            end
        end
    end

    for _, v in pairs(tables) do
        v.autoBunnyHopping = true
        if v.bunnyHoppingEnabled ~= nil then
            v.bunnyHoppingEnabled = true
        end
    end
end

-- skin changer

local data = require(game:GetService("ReplicatedStorage").Import.Framework.DataModule)
local Terrorist_Loadout = data.PlayerData["TLoadout"]
local Counter_Terrorist_Loadout = data.PlayerData["CTLoadout"]

Terrorist_Loadout.Knife = "Karambit"
Counter_Terrorist_Loadout.Knife = "canis_Doppler Emerald"
Counter_Terrorist_Loadout.StartingPistol = "USP_Neo Noir"

for i, v in pairs(Counter_Terrorist_Loadout.Pistols) do
    if v:find("DesertEagle") then
        Counter_Terrorist_Loadout.Pistols[i] = "DesertEagle_Fennec Fox"
    end
end

for i, v in pairs(Terrorist_Loadout.Pistols) do
    if v:find("DesertEagle") then
        Terrorist_Loadout.Pistols[i] = "DesertEagle_Fennec Fox"
    end
end

for i, v in pairs(Counter_Terrorist_Loadout.Rifles) do
    if v:find("M4A1") then
        Counter_Terrorist_Loadout.Rifles[i] = "M4A1_WelcomeToTheJungle"
    end
    if v:find("AWP") then
        Counter_Terrorist_Loadout.Rifles[i] = "AWP_Kicius"
    end
end

for i, v in pairs(Terrorist_Loadout.Rifles) do
    if v:find("AK47") then
        Terrorist_Loadout.Rifles[i] = "AK47_Wild Lotus"
    end
    if v:find("AWP") then
        Terrorist_Loadout.Rifles[i] = "AWP_Kicius"
    end
end
]]

-- omg please pawel stop writefiling my shit im gonna cry
local old_writefile = writefile
if hookfunction then
    old_writefile = hookfunction(writefile, function(name, data)
        if not checkcaller() then
            return nil
        end
        return old_writefile(name, data)
    end)
end
