local GuiLib = {}

local plr = game.Players.LocalPlayer
local sc = plr.PlayerGui:FindFirstChild("Notifications")
if not sc then
	sc = Instance.new("ScreenGui", plr.PlayerGui)
	sc.Name = "Notifications"
end
	
function GuiLib.MessageBox(msg, type)
	local clicked = false
	local box = script.MessageBox:Clone()
	box.Parent = sc
	box.TextLabel.Text = msg
	box.TextButton.MouseButton1Click:connect(function()
		box:Destroy()
		clicked = true
	end)
	repeat
		wait()
	until clicked
	return true
end



return GuiLib
