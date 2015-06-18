local plr = game.Players.LocalPlayer
local char = plr.CharacterAdded:wait()
local auth = game.ReplicatedStorage.Authenticate
local createCred = game.ReplicatedStorage.CreateCredentials
local pgui = plr:WaitForChild("PlayerGui")
wait(.5)

local GuiLib = require(game.ReplicatedStorage.GuiLib)

local window = pgui["SCSS-Window"]
local login = window.Frame.LoginFrame
local create = window.Frame.CreateFrame
local title = window.Frame.Title


local loginok = login.ButtonOk
local register = login.ButtonRegister
local createok = create.ButtonOk

local loginUser = login.UserBox.TextBox
local loginPw = login.PassBox.TextBox

local createUser = create.UserBox.TextBox
local createPw = create.PassBox.TextBox


register.MouseButton1Click:connect(function()
	login.Visible = false
	create.Visible = true
	title.Text = "Create User"
end)

loginok.MouseButton1Click:connect(function()
	print("Authenticating entered credentials..")
	local success = auth:InvokeServer(loginUser.Text, loginPw.Text)
	if success then
		print("Login successful")
		GuiLib.MessageBox("Login successful!")
	else
		print("Login unsuccessful")
		GuiLib.MessageBox("Access denied, Invalid username or password!")
	end
end)

createok.MouseButton1Click:connect(function()
	local success = createCred:InvokeServer(createUser.Text, createPw.Text)
	if success then
		print("User credentials created")
		GuiLib.MessageBox("User credentials created! Please log in.")
		create.Visible = false
		login.Visible = true
		title.Text = "Login"
	else
		print("User credential creation failed, user already exists")
		GuiLib.MessageBox("User with that name already exists!")
	end
end)