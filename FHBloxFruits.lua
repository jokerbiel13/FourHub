-- 🔑 KEY SYSTEM CONFIG
local KeySystem = {
    Key = "fh20",
    LoadURL = "https://raw.githubusercontent.com/jokerbiel13/FourHub/refs/heads/main/bfv2.lua",
    Discord = "https://discord.gg/cUwR4tUJv3",
    SaveFileName = "fourhub_key.txt" -- File name to save the key
}

local player = game:GetService("Players").LocalPlayer
local starter = game:GetService("StarterGui")

local function notify(t, m)
    starter:SetCore("SendNotification", {
        Title = t,
        Text = m,
        Duration = 5
    })
end

-- 🚀 FUNCTION TO LOAD THE SCRIPT
local ScreenGui = nil -- Initialize ScreenGui as nil for global access

local function loadAndExecute()
    notify("Success", "Correct Key! Loading script...")
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
    -- Use pcall to safely execute the script loading
    local success, result = pcall(function()
        loadstring(game:HttpGet(KeySystem.LoadURL))()
    end)
    if not success then
        notify("Critical Error", "Failed to load the script: " .. tostring(result))
    end
end

-- 💾 ATTEMPT TO LOAD THE SAVED KEY
-- Checks if file reading functions are available (common in exploit executors)
if is_synapse_context or readfile then
    local savedKey = readfile(KeySystem.SaveFileName)
    if savedKey and savedKey:gsub("%s", "") == KeySystem.Key then -- Trim whitespace
        notify("Saved Key Found!", "Correct key and ready! Opening script...")
        return loadAndExecute() -- Correct key, load, and exit the script
    end
end

-- --- GUI START (If key was not loaded automatically) ---

ScreenGui = Instance.new("ScreenGui") -- Define ScreenGui here for the GUI
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Logo = Instance.new("ImageLabel")
local TextBox = Instance.new("TextBox")
local VerifyButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")

ScreenGui.Parent = player:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 330, 0, 330)
Frame.Position = UDim2.new(0.5, -165, 0.5, -165)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UICorner.Parent = Frame

-- 🔵 TITLE "Key System - FourHub"
Title.Parent = Frame
Title.Text = "🔐 Key System - FourHub"
Title.Size = UDim2.new(0, 300, 0, 35)
Title.Position = UDim2.new(0.5, -150, 0, 5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- 🖼️ CENTRAL IMAGE
Logo.Parent = Frame
Logo.Size = UDim2.new(0, 120, 0, 120)
Logo.Position = UDim2.new(0.5, -60, 0, 45)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://137518578026159"

-- 🔑 ENTER KEY
TextBox.Parent = Frame
TextBox.PlaceholderText = "Enter your Key"
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0, 175)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner2.Parent = TextBox

-- VERIFY BUTTON
VerifyButton.Parent = Frame
VerifyButton.Text = "Verify Key"
VerifyButton.Size = UDim2.new(0, 260, 0, 40)
VerifyButton.Position = UDim2.new(0.5, -130, 0, 225)
VerifyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- GET KEY BUTTON
GetKeyButton.Parent = Frame
GetKeyButton.Text = "Get Key (Discord)"
GetKeyButton.Size = UDim2.new(0, 260, 0, 40)
GetKeyButton.Position = UDim2.new(0.5, -130, 0, 275)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 85, 200)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- --- BUTTON LISTENERS ---

-- VERIFY KEY
VerifyButton.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text:gsub("%s", "") -- Trim whitespace
    if enteredKey == KeySystem.Key then
        -- 🎉 CORRECT KEY: SAVE AND LOAD
        if writefile then -- Check if file writing function exists
            local success, err = pcall(writefile, KeySystem.SaveFileName, KeySystem.Key)
            if success then
                notify("Key Saved!", "Your Key has been saved for the next access.")
            else
                notify("Warning", "Could not save the Key: " .. tostring(err))
            end
        end
        loadAndExecute()
    else
        -- ❌ INCORRECT KEY
        notify("Error", "Incorrect Key!")
    end
end)

-- GET KEY (DISCORD)
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(KeySystem.Discord)
    notify("Copied!", "Discord link copied to clipboard!")
end)
