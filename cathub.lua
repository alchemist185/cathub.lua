--[[ Cathub Script by Alchemist185 ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- Rayfield UI Load
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Cathub | Dead Rails",
	LoadingTitle = "Cathub",
	LoadingSubtitle = "by Alchemist185",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "CathubData",
		FileName = "Cathub"
	},
	Discord = {
		Enabled = true,
		Invite = "wbnMSHh3",
		RememberJoins = false
	},
	KeySystem = false,
})

Rayfield:Notify({
	Title = "Cathub Loaded",
	Content = "Welcome to Dead Rails",
	Duration = 4,
	Image = "https://i.imgur.com/qTv5vHS.jpeg"
})

-- Prompt to Join Discord
Rayfield:Prompt({
	Title = "Join our Discord?",
	Content = "Would you like to join Cathub Discord?",
	Buttons = {
		Accept = function()
			setclipboard("https://discord.gg/wbnMSHh3")
			Rayfield:Notify({Title="Copied", Content="Discord invite copied to clipboard", Duration=3})
		end,
		Decline = function()
			Rayfield:Notify({Title="Okay!", Content="You can join later anytime.", Duration=2})
		end,
	}
})

-- Settings Tab
local Settings = Window:CreateTab("Settings", 4483362458)
Settings:CreateColorPicker({Name = "UI Accent Color", Callback = function(color) Rayfield:SetTheme({Accent = color}) end})
Settings:CreateToggle({Name = "Draggable UI", CurrentValue = true, Callback = function(v) game:GetService("StarterGui"):SetCore("DevConsoleVisible", not v) end})

-- Main Tab
local Main = Window:CreateTab("Main", 4483362458)

Main:CreateButton({
	Name = "Teleport to End (80km)",
	Callback = function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		char:MoveTo(Vector3.new(80000, 25, 0)) -- adjust Y/Z if needed
		wait(0.5)
		loadstring(game:HttpGet("https://pastebin.com/raw/NCnK8bPf"))() -- Noclip loader
	end,
})

Main:CreateButton({
	Name = "Teleport to Tesla Lab",
	Callback = function()
		local pos = Vector3.new(4250, 15, -240) -- estimated location
		game.Players.LocalPlayer.Character:MoveTo(pos)
	end,
})

Main:CreateButton({
	Name = "Teleport to Castle Roof",
	Callback = function()
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(6125, 85, -1420))
		Rayfield:Notify({Title="Teleported", Content="Wait to avoid vampires/werewolves", Duration=5})
	end,
})

Main:CreateButton({
	Name = "Teleport to Sterling",
	Callback = function()
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(12000, 25, 500))
		Rayfield:Notify({Title="Teleported", Content="Sterling Village Front", Duration=4})
	end,
})

Main:CreateButton({
	Name = "Fly Toggle",
	Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/5HF3xZ1b"))()
	end,
})

Main:CreateButton({
	Name = "Auto Bond Collector",
	Callback = function()
		Rayfield:Notify({Title="Auto Bond", Content="Running. Don't touch anything.", Duration=4})
		local collected = 0
		local function scan()
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj.Name == "Bond" and obj:IsA("Part") then
					game.Players.LocalPlayer.Character:MoveTo(obj.Position)
					wait(0.3)
					collected += 1
				end
			end
			Rayfield:Notify({Title="Scan Complete", Content="Collected "..collected.." bonds", Duration=4})
		end
		scan()
	end,
})

-- Visual Tab
local Visual = Window:CreateTab("Visual", 4483362458)
Visual:CreateToggle({
	Name = "Night Vision",
	CurrentValue = false,
	Callback = function(v)
		game.Lighting.Brightness = v and 5 or 1
	end,
})

Visual:CreateSlider({
	Name = "Camera Zoom",
	Range = {10, 120},
	Increment = 5,
	CurrentValue = 70,
	Callback = function(v)
		game.Players.LocalPlayer.CameraMaxZoomDistance = v
	end,
})

Visual:CreateLabel("More coming soon...")

-- Humanoid Tab
local Humanoid = Window:CreateTab("Humanoid", 4483362458)

Humanoid:CreateSlider({
	Name = "Walk Speed",
	Range = {16, 200},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
	end,
})

Humanoid:CreateSlider({
	Name = "Jump Power",
	Range = {50, 250},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(v)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
	end,
})

Humanoid:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Callback = function(v)
		local RunService = game:GetService("RunService")
		if v then
			_G.noclip = true
			RunService.Stepped:Connect(function()
				if _G.noclip then
					for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if part:IsA("BasePart") and part.CanCollide then
							part.CanCollide = false
						end
					end
				end
			end)
		else
			_G.noclip = false
		end
	end,
})

-- Aimbot Tab
local Aimbot = Window:CreateTab("Aimbot", 4483362458)

Aimbot:CreateToggle({
	Name = "Silent Aim",
	CurrentValue = false,
	Callback = function(v)
		_G.silentaim = v
		if v then
			loadstring(game:HttpGet("https://pastebin.com/raw/4bkAyRfj"))()
		end
	end,
})

Aimbot:CreateDropdown({
	Name = "Target Hit Part",
	Options = {"Head", "Torso", "Legs"},
	CurrentOption = "Head",
	Callback = function(option)
		_G.hitPart = option
	end,
})

-- Webhook Log (Optional anti-crack/user detection)
pcall(function()
	local http = game:GetService("HttpService")
	local user = game.Players.LocalPlayer.Name
	local data = {
		content = "**Cathub Loaded**\nUser: "..user.."\nGame: "..game.PlaceId,
		username = "Cathub Logger"
	}
	local json = http:JSONEncode(data)
	http:PostAsync("https://yourwebhookurl.here", json)
end)
