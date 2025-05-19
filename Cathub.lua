
local exec = identifyexecutor and identifyexecutor() or "Unknown"

if exec:lower():find("solara") or exec:lower():find("wave") then
    game.Players.LocalPlayer:Kick("Executor not supported.")
    return
end

-- Rayfield UI Loader (Safe fallback for all others)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
end)

if not success then
    warn("Rayfield failed to load.")
    return
end

-- Main UI Setup
local Window = Rayfield:CreateWindow({
    Name = "Cathub | Dead Rails Hub",
    LoadingTitle = "Dead Rails",
    LoadingSubtitle = "Cathub Loaded",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "CathubUI"
    },
    Discord = {
        Enabled = true,
        Invite = "wbnMSHh3",
        RememberJoins = false
    },
    KeySystem = false
})

-- Settings Tab
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateParagraph({Title = "Cathub Settings", Content = "Customize the UI"})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateButton({
    Name = "Fly Toggle",
    Callback = function()
        print("Fly enabled")
    end
})

MainTab:CreateButton({
    Name = "TP to End (80km Bridge)",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(80000, 50, 0)
            wait(1)
            local noclip = true
            game:GetService("RunService").Stepped:Connect(function()
                if noclip then
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide == true then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
})

-- Visual Tab
local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateButton({
    Name = "Night Vision",
    Callback = function()
        game.Lighting.Brightness = 5
        game.Lighting.TimeOfDay = "00:00:00"
    end
})

-- Humanoid Tab
local HumanoidTab = Window:CreateTab("Humanoid", 4483362458)
HumanoidTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

HumanoidTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

-- Aimbot Tab
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)
AimbotTab:CreateButton({
    Name = "Silent Aim (beta)",
    Callback = function()
        print("Silent Aim enabled (simulate)")
    end
})

return "Cathub script loaded successfully."
