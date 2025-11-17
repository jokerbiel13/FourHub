-- CONFIG DO KEY SYSTEM
local KeySystem = {
    Key = "fh20", -- a chave que o usuário deve digitar
    LoadURL = "https://meusite.com/meuscript.lua", -- script que vai carregar SE a key estiver certa
    Discord = "https://discord.gg/cUwR4tUJv3" -- link do Discord para pegar a key
}

-- UI Simples usando notificação do Roblox
local player = game:GetService("Players").LocalPlayer
local starter = game:GetService("StarterGui")

local function notify(t, m)
    starter:SetCore("SendNotification", {
        Title = t,
        Text = m,
        Duration = 5
    })
end

-- CAIXA DE DIÁLOGO PARA PEDIR A KEY
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local VerifyButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")

ScreenGui.Parent = player:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UICorner.Parent = Frame

TextBox.Parent = Frame
TextBox.PlaceholderText = "Digite a Key"
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0, 20)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner2.Parent = TextBox

VerifyButton.Parent = Frame
VerifyButton.Text = "Verificar"
VerifyButton.Size = UDim2.new(0, 260, 0, 40)
VerifyButton.Position = UDim2.new(0.5, -130, 0, 80)
VerifyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- BOTÃO GET KEY (COPIA DISCORD)
GetKeyButton.Parent = Frame
GetKeyButton.Text = "Get Key (Discord)"
GetKeyButton.Size = UDim2.new(0, 260, 0, 40)
GetKeyButton.Position = UDim2.new(0.5, -130, 0, 130)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 85, 200)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- FUNÇÃO DO BOTÃO VERIFICAR
VerifyButton.MouseButton1Click:Connect(function()
    if TextBox.Text == KeySystem.Key then
        notify("Sucesso", "Key correta! Carregando...")

        ScreenGui:Destroy()

        loadstring(game:HttpGet(KeySystem.LoadURL))()
    else
        notify("Erro", "Key incorreta!")
    end
end)

-- FUNÇÃO DO BOTÃO GET KEY
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(KeySystem.Discord)
    notify("Copiado!", "Link do Discord copiado para sua área de transferência.")
end)
