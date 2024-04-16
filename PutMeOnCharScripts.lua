local speed1_const = .001 

local speedm1 = -90

local default_cam = workspace.CurrentCamera.CoordinateFrame

local freefall = false

local cam  = workspace.CurrentCamera
local lastdat = -1

local fdmg = false
local freefall = false

Humanoid.StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Freefall then

		local speed1_const = .001
		freefall = true
		RunService.RenderStepped:Connect(function()
			local Velocity = HumanoidRootPart.Velocity
			if Velocity.Y < speedm1 then
				fdmg = true
				speed1_const += .002
				HumanoidRootPart.Velocity = Vector3.new(Velocity.X, Velocity.Y-speed1_const, Velocity.Z)
				if cam.CoordinateFrame ~= default_cam and speed1_const == .001 then
					cam.CoordinateFrame = default_cam
				else
					cam.CoordinateFrame=cam.CoordinateFrame*CFrame.new(0,0,0,1-speed1_const,0,0,0,1-speed1_const,0,0,0,1)
				end
				if Velocity.Y > speedm1*5 then
					local dm291 =  0
					local timeR = math.random(5,6) 
					ReplicatedStorage.Fire.FallThing:FireServer(dm291,timeR) --- Do Pre Ragdoll Or take damage idk
				end
				if Velocity.Y < -1100 then
					ReplicatedStorage.Fire.Fast________RE_RE_RE_R_E_E__E_E_E_E_E__SPAWM:FireServer(Player)
				end
				lastdat = Velocity.Y
				print(Velocity.Y)
				print("Current Mult: "..speed1_const)
			end
		end)
	else
		local Velocity = HumanoidRootPart.Velocity
		speed1_const = .001
		local timeR = math.random(2,5) 
		local damage = lastdat*-.1
		if fdmg == true then
			ReplicatedStorage.Fire.FallThing:FireServer(lastdat,timeR) -- Do Touched Floor Dmg
			HumanoidRootPart.Velocity = Vector3.new(Velocity.X, 0, Velocity.Z)
		end
		lastdat = 0
		fdmg = false
		HumanoidRootPart.Velocity = Vector3.new(Velocity.X, 0, Velocity.Z)
	end
end)
