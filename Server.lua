local auth = Instance.new("RemoteFunction", game.ReplicatedStorage)
local create = Instance.new("RemoteFunction", game.ReplicatedStorage)
auth.Name = "Authenticate"
create.Name = "CreateCredentials"

local shalib = require(workspace.SHA256)
local randStr = require(workspace.RandString)

	--user = {hash, salt}
local userdata = {}


function hash(str)
	local my_hash = shalib.sha256()
	my_hash:process(str)
	my_hash = my_hash:finish()
	return my_hash
end


function salt()
	return randStr(20)
end

function userExists(user)
	for username,_ in pairs(userdata) do
		if username == user then
			return true
		end
	end
	return false
end

function auth.OnServerInvoke(player, user, pw)
	if userExists(user) then
		local newhash = hash(pw .. userdata[user][2])
		if newhash == userdata[user][1] then
			print("Correct password!")
			return true
		else
			print("Password '"..pw.."'(hash:"..hash(pw .. userdata[user][2])..") does not equal stored hash("..userdata[user][1]..")")
		end
	end
	return false
end


function create.OnServerInvoke(player, user, pw)
	if not userExists(user) then
		local newsalt = salt()
		local newhash = hash(pw .. newsalt)
		userdata[user] = {newhash, newsalt}
		print("Username: " .. user)
		print("Password: " .. pw)
		print("Salt: " .. newsalt)
		print("Hash: " .. newhash)
		return true
	end
	return false
end






