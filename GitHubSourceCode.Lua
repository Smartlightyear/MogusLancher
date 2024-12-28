local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Initialization Message
print("Mogus Prompt, By Smartlightyear")

local Window = OrionLib:MakeWindow({Name = "Mogus Prompt", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local VisualTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Instant Prompt Function
local function hookProximityPrompt()
    for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = 0
            prompt.RequiresLineOfSight = false
        end
    end
    
    game:GetService("Workspace").DescendantAdded:Connect(function(prompt)
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = 0
            prompt.RequiresLineOfSight = false
        end
    end)
end

-- Night Vision Function
local function toggleNightVision(enable)
    local lighting = game:GetService("Lighting")
    if enable then
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.Brightness = 3
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
    else
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        lighting.Brightness = 1
        lighting.ClockTime = lighting.ClockTime
        lighting.FogEnd = lighting.FogEnd
        lighting.GlobalShadows = true
    end
end

MainTab:AddToggle({
    Name = "Instant Interact",
    Default = false,
    Callback = function(Value)
        if Value then
            hookProximityPrompt()
        end
    end
})

MainTab:AddSlider({
    Name = "Speed Multiplier",
    Min = 1,
    Max = 10,
    Default = 1,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    ValueName = "x",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 * Value
    end    
})

VisualTab:AddSlider({
    Name = "FOV",
    Min = 70,
    Max = 120,
    Default = 70,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "°",
    Callback = function(Value)
        game:GetService("Workspace").CurrentCamera.FieldOfView = Value
    end    
})

VisualTab:AddToggle({
    Name = "Night Vision",
    Default = false,
    Callback = function(Value)
        toggleNightVision(Value)
    end
})

OrionLib:Init()
