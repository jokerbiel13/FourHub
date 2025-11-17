-- CONFIG DO KEY SYSTEM
local KeySystem = {
    Key = "fh20",
    LoadURL = "https://raw.githubusercontent.com/jokerbiel13/FourHub/refs/heads/main/bfv2.lua",
    Discord = "https://discord.gg/cUwR4tUJv3"
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

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Logo = Instance.new("ImageLabel") -- <-- AQUI CRIOU A IMAGEM
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

-- 🔵 TÍTULO "Key System - FourHub"
Title.Parent = Frame
Title.Text = "🔐 Key System - FourHub"
Title.Size = UDim2.new(0, 300, 0, 35)
Title.Position = UDim2.new(0.5, -150, 0, 5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- 🖼️ IMAGEM CENTRAL
Logo.Parent = Frame
Logo.Size = UDim2.new(0, 120, 0, 120)
Logo.Position = UDim2.new(0.5, -60, 0, 45)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://137518578026159"

-- 🔑 DIGITAR KEY
TextBox.Parent = Frame
TextBox.PlaceholderText = "Digite sua Key"
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0, 175)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner2.Parent = TextBox

-- BOTÃO VERIFICAR
VerifyButton.Parent = Frame
VerifyButton.Text = "Verificar Key"
VerifyButton.Size = UDim2.new(0, 260, 0, 40)
VerifyButton.Position = UDim2.new(0.5, -130, 0, 225)
VerifyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- BOTÃO GET KEY
GetKeyButton.Parent = Frame
GetKeyButton.Text = "Get Key (Discord)"
GetKeyButton.Size = UDim2.new(0, 260, 0, 40)
GetKeyButton.Position = UDim2.new(0.5, -130, 0, 275)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 85, 200)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- VERIFICAR KEY
VerifyButton.MouseButton1Click:Connect(function()
    if TextBox.Text == KeySystem.Key then
        notify("Sucesso", "Key correta! Carregando...")
        ScreenGui:Destroy()
        loadstring(game:HttpGet(KeySystem.LoadURL))()
    else
        notify("Erro", "Key incorreta!")
    end
end)

-- GET KEY (DISCORD)
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(KeySystem.Discord)
    notify("Copiado!", "Link do Discord copiado!")
end)
