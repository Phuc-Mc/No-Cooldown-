local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SmoothCooldownUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 30, 0, 30)
frame.Position = UDim2.new(0, 20, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 0.8
frame.Parent = screenGui

-- Toggle Button
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, 0, 1, 0)
toggle.Position = UDim2.new(0, 0, 0, 0)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14
toggle.BackgroundTransparency = 1
toggle.TextTransparency = 1
toggle.Parent = frame

-- Tween config
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local expand = TweenService:Create(frame, tweenInfo, {
	Size = UDim2.new(0, 100, 0, 30),
	BackgroundTransparency = 0
})
local shrink = TweenService:Create(frame, tweenInfo, {
	Size = UDim2.new(0, 30, 0, 30),
	BackgroundTransparency = 0.8
})

local fadeIn = TweenService:Create(toggle, tweenInfo, {
	TextTransparency = 0,
	BackgroundTransparency = 0
})
local fadeOut = TweenService:Create(toggle, tweenInfo, {
	TextTransparency = 1,
	BackgroundTransparency = 1
})

-- Hover hiệu ứng
frame.MouseEnter:Connect(function()
	expand:Play()
	fadeIn:Play()
end)

frame.MouseLeave:Connect(function()
	if not toggle:IsFocused() then
		shrink:Play()
		fadeOut:Play()
	end
end)

-- Cooldown logic
local isOn = false
local C = require(game:GetService("ReplicatedStorage").Controllers.AbilityController)
local originalCooldown = C.AbilityCooldown

toggle.MouseButton1Click:Connect(function()
	isOn = not isOn
	if isOn then
		C.AbilityCooldown = function(s, n, ...) return originalCooldown(s, n, 0, ...) end
		toggle.Text = "ON"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	else
		C.AbilityCooldown = originalCooldown
		toggle.Text = "OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	end
end)