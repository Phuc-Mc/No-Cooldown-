local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "TinyCooldownUI"
screenGui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 100, 0, 30)
frame.Position = UDim2.new(0, 20, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1, 0, 1, 0)
toggle.Position = UDim2.new(0, 0, 0, 0)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14

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
	else
		C.AbilityCooldown = originalCooldown
		toggle.Text = "OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	end
end)