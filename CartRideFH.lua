-- =================================
-- https://rscripts.net/@jokerbiel13
-- DEV -- > FOURHUB ; DISCORD - jokerbiel13
-- https://rscripts.net/@jokerbiel13
-- =================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Cart Ride Around Nothing by Jokerzin",
    Icon = 70975600266728,
    LoadingTitle = "Cart Ride Around Nothing",
    LoadingSubtitle = "by jokerzin",
    ShowText = "RayField",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = { Enabled = true, FolderName = "R77", FileName = "CRAN_R77" },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", "rocket")
MainTab:CreateSection("Cart Tools")

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
end
local function getHumanoid(char)
    return char:FindFirstChildOfClass("Humanoid")
end

MainTab:CreateButton({
    Name = "Load Fling GUI (by jokerzin13)",
    Callback = function()
        Rayfield:Notify({Title = "Fling GUI", Content = "Loading…", Duration = 2})
        local ok, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/jokerbiel13/FourHub/refs/heads/main/Fling.lua", true))()
        end)
        if ok then
            Rayfield:Notify({Title = "Fling GUI", Content = "Done! Fling GUI loaded.", Duration = 4})
        else
            Rayfield:Notify({Title = "Fling GUI", Content = "Error: "..tostring(result), Duration = 6})
        end
    end
})

local FLYING = false
local QEfly = true
local iyflyspeed = 1
local vehicleflyspeed = 1
local flyKeyDown, flyKeyUp
local IYMouse = LocalPlayer:GetMouse()

function sFLY(vfly)
    repeat task.wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat task.wait() until IYMouse
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

    local T = getRoot(Players.LocalPlayer.Character)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = 0

    local function FLY()
        FLYING = true
        local BG = Instance.new("BodyGyro")
        local BV = Instance.new("BodyVelocity")
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat task.wait()
                if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = workspace.CurrentCamera.CoordinateFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
            end
        end)
    end

    flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
        if KEY:lower() == "w" then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "s" then
            CONTROL.B = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "a" then
            CONTROL.L = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "d" then
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif QEfly and KEY:lower() == "e" then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed) * 2
        elseif QEfly and KEY:lower() == "q" then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed) * 2
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
    end)

    flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
        if KEY:lower() == "w" then
            CONTROL.F = 0
        elseif KEY:lower() == "s" then
            CONTROL.B = 0
        elseif KEY:lower() == "a" then
            CONTROL.L = 0
        elseif KEY:lower() == "d" then
            CONTROL.R = 0
        elseif KEY:lower() == "e" then
            CONTROL.Q = 0
        elseif KEY:lower() == "q" then
            CONTROL.E = 0
        end
    end)

    FLY()
end

function NOFLY()
    FLYING = false
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
    if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local vehicleToggle
vehicleToggle = MainTab:CreateToggle({
    Name = "Vehicle Fly — ON/OFF",
    CurrentValue = false,
    Callback = function(state)
        if state then
            sFLY(true)
            Rayfield:Notify({Title = "Vehicle Fly", Content = "ON (W/A/S/D, Q/E vertical)", Duration = 5})
        else
            NOFLY()
            Rayfield:Notify({Title = "Vehicle Fly", Content = "OFF", Duration = 3})
        end
    end
})

MainTab:CreateKeybind({
    Name = "Toggle VFLY",
    CurrentKeybind = "V",
    HoldToInteract = false,
    Flag = "R77_VFlyBind",
    Callback = function()
        vehicleToggle:Set(not vehicleToggle.CurrentValue)
        if Rayfield and Rayfield.SaveConfiguration then pcall(function() Rayfield:SaveConfiguration() end) end
    end
})

local function getGiverCFrame()
    local misc = workspace:FindFirstChild("Misc")
    if not misc then return nil end
    local giver = misc:FindFirstChild("Giver")
    if not giver then return nil end
    if giver:IsA("BasePart") then
        return giver.CFrame
    elseif giver:IsA("Model") then
        local primary = giver.PrimaryPart or giver:FindFirstChildWhichIsA("BasePart")
        if primary then return primary.CFrame end
    end
    return nil
end

local function tpToGiver()
    local cf = getGiverCFrame()
    if not cf then
        Rayfield:Notify({Title = "TP", Content = "the secret room not found (contact dev)", Duration = 5})
        return
    end
    local targetCF = cf * CFrame.new(0, 3, 0)
    local char = getCharacter()
    local hum = getHumanoid(char)
    if hum and hum.Sit and hum.SeatPart and hum.SeatPart.Parent then
        local seat = hum.SeatPart
        local model = seat.Parent
        if model:IsA("Model") then
            if not model.PrimaryPart then model.PrimaryPart = seat end
            local ok = pcall(function() model:PivotTo(targetCF) end)
            if not ok and model.PrimaryPart then model:SetPrimaryPartCFrame(targetCF) end
        else
            seat.CFrame = targetCF
        end
    else
        local root = getRoot(char)
        if root then
            root.CFrame = targetCF
        else
            Rayfield:Notify({Title = "TP", Content = "HumanoidRootPart not found", Duration = 5})
            return
        end
    end
    Rayfield:Notify({Title = "TP", Content = "Teleport to the secret room completed", Duration = 4})
end

MainTab:CreateButton({
    Name = "TP to the secret room",
    Callback = tpToGiver
})

MainTab:CreateButton({
    Name = "Activate ESP (by Lucasfin000)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
    end
})

local GUITab = Window:CreateTab("GUI", "settings")
GUITab:CreateSection("Interface")
GUITab:CreateButton({
    Name = "Destroy this GUI",
    Callback = function()
        if Rayfield and Rayfield.SaveConfiguration then pcall(function() Rayfield:SaveConfiguration() end) end
        if FLYING then NOFLY() end
        Rayfield:Destroy()
    end
})

if Rayfield and Rayfield.LoadConfiguration then pcall(function() Rayfield:LoadConfiguration() end) end

-- =================================
-- https://rscripts.net/@jokerbiel13
-- DEV -- > FOURHUB; DISCORD - jokerzin13
-- https://rscripts.net/@jokerbiel13

-- =================================
