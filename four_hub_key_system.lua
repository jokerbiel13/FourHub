-- FOUR HUB | Key System
-- Autor: jokerbiel13 (adaptado)
-- Estrutura exigida:
-- 1) Configuração (KeyConfig)
-- 2) Carregar WindUI
-- 3) Sistema de SaveKey
-- 4) Checagem automática da Key salva
-- 5) Criação da janela WindUI
-- 6) Lógica da interface (textbox, botões)
-- 7) Lógica de verificação da Key
-- 8) Execução do loadstring final

-- =========================
-- 1) Configuração (KeyConfig)
-- =========================
local KeyConfig = {
    Key = "fh20", -- Key fixa
    LoadURL = "https://raw.githubusercontent.com/jokerbiel13/FourHub/refs/heads/main/bfv2.lua", -- Link a ser carregado após validação
    Discord = "https://discord.gg/cUwR4tUJv3", -- Link do Discord
    SaveFile = "FourHubKey.txt", -- arquivo usado por writefile/readfile
    -- URL padrão para WindUI. Se sua versão de WindUI estiver em outro local, altere aqui.
    WindUI_URL = "https://raw.githubusercontent.com/GreenDude2/Wind-UI/main/Source.lua"
}

-- Tema azul personalizado (Color3) conforme solicitado
local Theme = {
    Main = Color3.fromRGB(0, 85, 255),
    Secondary = Color3.fromRGB(0, 55, 185),
    Stroke = Color3.fromRGB(0, 35, 120),
    Text = Color3.fromRGB(255, 255, 255),
    Notify = Color3.fromRGB(0, 100, 255)
}

-- Pequenas funções utilitárias (não quebram a ordem pedida)
local function safeReadFile(name)
    if type(readfile) == "function" then
        local ok, res = pcall(readfile, name)
        if ok then return res end
    end
    return nil
end

local function safeWriteFile(name, content)
    if type(writefile) == "function" then
        local ok, res = pcall(writefile, name, content)
        return ok
    end
    return false
end

local function safeFileExists(name)
    if type(isfile) == "function" then
        local ok, res = pcall(isfile, name)
        if ok then return res end
    else
        -- fallback: try readfile
        return safeReadFile(name) ~= nil
    end
    return false
end

local function safeSetClipboard(text)
    pcall(function()
        if setclipboard then
            setclipboard(text)
        elseif syn and syn.set_clipboard then
            syn.set_clipboard(text)
        end
    end)
end

local function sendNotification(title, text, duration)
    duration = duration or 4
    -- tentativas de notificação via WindUI (se disponível) serão tratadas externamente.
    -- Usar SetCore como fallback
    local ok, _ = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration;
        })
    end)
    return ok
end

-- =========================
-- 2) Carregar WindUI
-- =========================
-- Carrega WindUI via HTTP. Se necessário, altere KeyConfig.WindUI_URL para a fonte correta.
local WindUI = nil
local WindUILoaded, WindUIErr = pcall(function()
    local success, lib = pcall(function()
        local httpGet = game.HttpGet or (syn and syn.request and function(_, u) return syn.request({Url = u, Method = "GET"}).Body end) or nil
        if httpGet then
            return loadstring(game:HttpGet(KeyConfig.WindUI_URL))()
        else
            -- Tentar mesmo chamar game:HttpGet (pode falhar em ambientes restritos)
            return loadstring(game:HttpGet(KeyConfig.WindUI_URL))()
        end
    end)
    if success then
        WindUI = lib
    else
        error(lib)
    end
end)

if not WindUILoaded then
    -- Não abortar totalmente: avisar que WindUI não foi carregado corretamente.
    warn("[FOUR HUB] Falha ao carregar WindUI:", WindUIErr)
    -- Continuamos com fallbacks (SetCore notifications + funções próprias) para que o sistema ainda funcione em ambientes sem WindUI.
end

-- =========================
-- 3) Sistema de SaveKey
-- =========================
local SaveKey = {}
-- Salva a key no arquivo definido em KeyConfig.SaveFile usando writefile
function SaveKey.save(key)
    local ok = safeWriteFile(KeyConfig.SaveFile, key)
    if not ok then
        warn("[FOUR HUB] Não foi possível salvar a key localmente. Ambiente pode não permitir writefile.")
    end
    return ok
end

function SaveKey.load()
    local content = safeReadFile(KeyConfig.SaveFile)
    if content and type(content) == "string" then
        return content
    end
    return nil
end

function SaveKey.clear()
    if type(delfile) == "function" and safeFileExists(KeyConfig.SaveFile) then
        pcall(delfile, KeyConfig.SaveFile)
    end
end

-- =========================
-- 4) Checagem automática da Key salva
-- =========================
local function tryExecuteFromKey(key)
    -- Validação simples: comparar com KeyConfig.Key
    if key == KeyConfig.Key then
        -- Notificação de sucesso
        if WindUI and type(WindUI.Notification) == "function" then
            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Key válida! Carregando...", Duration = 4}) end)
        else
            sendNotification("FOUR HUB", "Key válida! Carregando...", 4)
        end

        -- Executa o loadstring conforme especificado (execução final)
        pcall(function()
            loadstring(game:HttpGet(KeyConfig.LoadURL))()
        end)
        return true
    else
        -- Notificação de erro (caso a key salva seja inválida)
        if WindUI and type(WindUI.Notification) == "function" then
            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Key salva inválida.", Duration = 4}) end)
        else
            sendNotification("FOUR HUB", "Key salva inválida.", 4)
        end
        return false
    end
end

-- Auto-checar se já existe uma key salva
local saved = SaveKey.load()
if saved then
    -- remover espaços em branco
    saved = tostring(saved):gsub("^%s*(.-)%s*$", "%1")
    pcall(function() tryExecuteFromKey(saved) end)
end

-- =========================
-- 5) Criação da janela WindUI
-- =========================
-- Variáveis de UI que usaremos mais abaixo
local Window, Page = nil, nil
local TextBoxValue = "" -- armazenará o texto digitado

-- Função para criar a janela usando WindUI quando possível, senão criamos fallbacks mínimos
local function createUI()
    if WindUI then
        -- Tentar várias assinaturas comuns de WindUI
        local created = false
        local w, p = nil, nil
        -- 1) WindUI:CreateWindow(title) -> Window
        pcall(function()
            if WindUI.CreateWindow then
                w = WindUI:CreateWindow("FOUR HUB | Key System")
            elseif WindUI:CreateWindow then
                w = WindUI:CreateWindow("FOUR HUB | Key System")
            elseif WindUI.New then
                w = WindUI:New({Title = "FOUR HUB | Key System"})
            else
                -- tentar o padrão loadstring() retorna função que faz Window = WindUI("Title")
                local success, res = pcall(function() return WindUI("FOUR HUB | Key System") end)
                if success then w = res end
            end
        end)

        if w == nil then
            warn("[FOUR HUB] WindUI foi carregado, mas não foi possível identificar API padrão. Usando fallback de notificações.")
        else
            Window = w
            -- Tentar criar página
            pcall(function()
                if Window.CreatePage then
                    p = Window:CreatePage("Key System")
                elseif Window.AddPage then
                    p = Window:AddPage("Key System")
                elseif Window:CreateTab then
                    p = Window:CreateTab("Key System")
                end
            end)
            -- Aplicar tema se possível
            pcall(function()
                if WindUI.ApplyTheme then
                    WindUI:ApplyTheme(Theme)
                elseif Window.ApplyTheme then
                    Window:ApplyTheme(Theme)
                elseif WindUI.SetTheme then
                    WindUI:SetTheme(Theme)
                end
            end)
            Page = p
            created = true
        end

        if not created then
            Window, Page = nil, nil
        end
    end

    -- Se WindUI não foi usado ou a API é desconhecida, apenas exibir mensagens que instruam o usuário.
    if not Window then
        warn("[FOUR HUB] WindUI não disponível ou API incompatível. A interface gráfica pode não ser exibida.")
    end
end

createUI()

-- =========================
-- 6) Lógica da interface (textbox, botões)
-- =========================
-- Se Page (WindUI) estiver disponível, criamos os elementos via WindUI
local function setupInterface()
    if Page then
        -- Muitos WindUI têm CreateTextbox/MakeTextbox/Textbox
        pcall(function()
            if Page.CreateTextbox then
                Page:CreateTextbox("Digite sua Key", "Insira a key aqui", function(val)
                    TextBoxValue = tostring(val or "")
                end)
            elseif Page.AddTextbox then
                Page:AddTextbox("Digite sua Key", function(val) TextBoxValue = tostring(val or "") end)
            elseif Page.Textbox then
                Page:Textbox("Digite sua Key", function(val) TextBoxValue = tostring(val or "") end)
            end
        end)

        pcall(function()
            if Page.CreateButton then
                Page:CreateButton("Verificar Key", function()
                    -- botão invoca verificação (implementada na seção 7)
                    VerifyKey(TextBoxValue)
                end)
            elseif Page.AddButton then
                Page:AddButton("Verificar Key", function() VerifyKey(TextBoxValue) end)
            elseif Page.Button then
                Page:Button("Verificar Key", function() VerifyKey(TextBoxValue) end)
            end
        end)

        pcall(function()
            if Page.CreateButton then
                Page:CreateButton("Copiar Discord", function()
                    safeSetClipboard(KeyConfig.Discord)
                    if WindUI and WindUI.Notification then
                        pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Link do Discord copiado!", Duration = 4}) end)
                    else
                        sendNotification("FOUR HUB", "Link do Discord copiado!", 4)
                    end
                end)
            else
                -- fallback: adicionar botão alternativo (algumas APIs não suportam mais de 1 botão assim)
                if Page.AddButton then
                    Page:AddButton("Copiar Discord", function()
                        safeSetClipboard(KeyConfig.Discord)
                        if WindUI and WindUI.Notification then
                            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Link do Discord copiado!", Duration = 4}) end)
                        else
                            sendNotification("FOUR HUB", "Link do Discord copiado!", 4)
                        end
                    end)
                end
            end
        end)
    else
        -- Fallback textual simples: não há WindUI, então criar prompts que funcionam via console
        print("[FOUR HUB] Interface gráfica não encontrada. Use VerifyKey('suaKey') manualmente ou salve uma key no arquivo FourHubKey.txt.")
    end
end

-- Chamamos a configuração da interface
-- Note: a função VerifyKey é referenciada aqui; definimos abaixo (a linguagem Lua permite forward reference se usamos global func name)
setupInterface()

-- =========================
-- 7) Lógica de verificação da Key
-- =========================
-- Implementar VerifyKey conforme pedido: mostrar notificação de sucesso/erro e, em caso de sucesso,
-- chamar: loadstring(game:HttpGet(KeyConfig.LoadURL))()

function VerifyKey(inputKey)
    inputKey = tostring(inputKey or ""):gsub("^%s*(.-)%s*$", "%1")

    if inputKey == "" then
        if WindUI and WindUI.Notification then
            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Por favor, digite uma Key.", Duration = 3}) end)
        else
            sendNotification("FOUR HUB", "Por favor, digite uma Key.", 3)
        end
        return false
    end

    if inputKey == KeyConfig.Key then
        -- Salvar a key localmente (tentativa)
        SaveKey.save(inputKey)

        -- Notificação de sucesso
        if WindUI and WindUI.Notification then
            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Key válida! Carregando...", Duration = 4}) end)
        else
            sendNotification("FOUR HUB", "Key válida! Carregando...", 4)
        end

        -- Execução final do loadstring (conforme especificado)
        -- =========================
        -- 8) Execução do loadstring final
        -- =========================
        pcall(function()
            loadstring(game:HttpGet(KeyConfig.LoadURL))()
        end)
        return true
    else
        -- Key inválida: notificar erro
        if WindUI and WindUI.Notification then
            pcall(function() WindUI:Notification({Title = "FOUR HUB", Content = "Key incorreta. Tente novamente.", Duration = 4}) end)
        else
            sendNotification("FOUR HUB", "Key incorreta. Tente novamente.", 4)
        end
        return false
    end
end

-- expor VerifyKey globalmente para fallback console (caso WindUI não carregue)
_G.FourHubVerifyKey = VerifyKey

-- fim do arquivo
