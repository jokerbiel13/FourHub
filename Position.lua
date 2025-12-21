-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Position Tool",
   LoadingTitle = "Position Tool",
   LoadingSubtitle = "by Joker",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Posição", 4483362458)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- COPIAR POSIÇÃO
Tab:CreateButton({
   Name = "📋 Copiar posição atual",
   Callback = function()
       local pos = getHRP().Position
       local text = string.format(
           "Vector3.new(%.2f, %.2f, %.2f)",
           pos.X, pos.Y, pos.Z
       )

       if setclipboard then
           setclipboard(text)
       end

       Rayfield:Notify({
           Title = "Posição copiada",
           Content = text,
           Duration = 4
       })
   end
})

-- INPUT ÚNICO
local coordText = ""

Tab:CreateInput({
   Name = "Coordenada completa",
   PlaceholderText = "Vector3.new(x, y, z)  ou  x, y, z",
   RemoveTextAfterFocusLost = false,
   Callback = function(value)
       coordText = value
   end
})

-- FUNÇÃO PARSE
local function parseVector3(text)
    -- Remove Vector3.new e parênteses
    text = text:gsub("Vector3%.new", "")
    text = text:gsub("[%(%)]", "")

    -- Captura números
    local nums = {}
    for n in text:gmatch("[-%d%.]+") do
        table.insert(nums, tonumber(n))
    end

    if #nums ~= 3 then
        return nil
    end

    return Vector3.new(nums[1], nums[2], nums[3])
end

-- TELEPORTAR
Tab:CreateButton({
   Name = "📌 Ir para coordenada",
   Callback = function()
       local vec = parseVector3(coordText)

       if not vec then
           Rayfield:Notify({
               Title = "Erro",
               Content = "Formato inválido",
               Duration = 3
           })
           return
       end

       getHRP().CFrame = CFrame.new(vec)

       Rayfield:Notify({
           Title = "Teleportado",
           Content = tostring(vec),
           Duration = 3
       })
   end
})
