
repeat
    wait()
until game:IsLoaded()

function lumlua(ToolSe)
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    local character = player.Character

    local tool = backpack:FindFirstChild(ToolSe)
    if tool then
        wait(0.5)
        character.Humanoid:EquipTool(tool)
    end
end


local plr = game.Players.LocalPlayer
local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade() 
    local p13 = CbFw2.activeController
    local ret = p13.blades[1]
    if not ret then return end
    while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
    return ret
end

function thangngu()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for indexincrement = 1, 3 do -- Tăng số lần lặp để tấn công nhanh hơn nữa
            local bladehit = getAllBladeHits(60)
            if #bladehit > 0 then
                local AcAttack8 = debug.getupvalue(ac.attack, 5)
                local AcAttack9 = debug.getupvalue(ac.attack, 6)
                local AcAttack7 = debug.getupvalue(ac.attack, 4)
                local AcAttack10 = debug.getupvalue(ac.attack, 7)
                local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
                local NumberAc13 = AcAttack7 * 798405
                (function()
                    NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
                    AcAttack8 = math.floor(NumberAc12 / AcAttack9)
                    AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
                end)()
                AcAttack10 = AcAttack10 + 1
                debug.setupvalue(ac.attack, 5, AcAttack8)
                debug.setupvalue(ac.attack, 6, AcAttack9)
                debug.setupvalue(ac.attack, 4, AcAttack7)
                debug.setupvalue(ac.attack, 7, AcAttack10)
                for k, v in pairs(ac.animator.anims.basic) do
                    v:Play(0.001, 0.001, 0.001) -- Giảm thời gian chơi hoạt ảnh
                end
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(CurrentWeapon()))
                    game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
                end
            end
        end
    end
end

function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function beo(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/300, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 300 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end

spawn(function()
	while task.wait() do
		pcall(function()
			if _G.conmemay then
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity")
					Noclip.Name = "BodyClip"
					Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
					Noclip.MaxForce = Vector3.new(100000,100000,100000)
					Noclip.Velocity = Vector3.new(0,0,0)
				end
			else
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
			end
		end)
	end
end)

_G.caubedangyeu = 0.05
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ErutTheTeru/uilibrary/main/wazurev1uimain.lua"))()

local Notify = WazureV1:Notify({
	["Title"] = "Made by: Khanhdz",
	["Content"] = "Loaded UI!, Loaded game!",
	["Logo"] = "rbxassetid://18289959127",
	["Time"] = 0.5,
	["Delay"] = 5
})

local Main = lib:Start({
	["Name"] = "W-azure (Remake)",
	["Logo Player"] = "rbxassetid://18243105495",
	["Name Player"] = "ruteteru",
	["Tab Width"] = 120,
	["Color"] = Color3.fromRGB(6.000000117346644, 141.0000067949295, 234.00000125169754),
	["Custom Toggle"] = false,
	["CloseCallBack"] = function()
		WazureV1:Notify({
			["Title"] = "Notify",
			["Content"] = "Closed UI!",
			["Logo"] = "rbxassetid://18289959127",
			["Time"] = 0.5,
			["Delay"] = 5
		})
	end
})

local M = lib:MakeTab("Main")
local abc = M:Seperator("Main")

local Bring = M:Toggle({
	["Title"]= "bring",
	["Content"] = "This is a Toggle",
	["Default"] = true,
	["Callback"] = function(Value) 
		_G.BringMob = Value
	end
})

task.spawn(function()
    while task.wait() do
        if _G.BringMob then
            pcall(function()
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if not string.find(v.Name, "Boss") and v.Name == MonFarm and 
                       (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then
                        if InMyNetWork(v.HumanoidRootPart) then
                            v.HumanoidRootPart.CFrame = FarmPos
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
end)


local Dropdown = M:Dropdown({
	["Title"] = "Dropdown",
	["Content"] = "This is a dropdown",
	["Multi"] = false,
	["Options"] = {"Melee", "Sword", "Blox Fruit", "Gun"},
	["Default"] = {"Melee"},
	["Callback"] = function(Value)
		ChooseWeapon = Value
	end
})

task.spawn(function()
	while wait() do
		pcall(function()
			if ChooseWeapon == "Melee" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							SelectWeapon = v.Name
						end
					end
				end
			elseif ChooseWeapon == "Sword" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							SelectWeapon = v.Name
						end
					end
				end
			elseif ChooseWeapon == "Blox Fruit" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							SelectWeapon = v.Name
						end
					end
				end
			else
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Gun" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							SelectWeapon = v.Name
						end
					end
				end
			end
		end)
	end
end)

local Label = M:Label("Katakuri Leigt")

local Toggle = M:Toggle({
	["Title"]= "Toggle",
	["Content"] = "This is a Toggle",
	["Default"] = false
})
local ToggleSetting = Toggle:AddSetting()
local SettingToggle = ToggleSetting:Toggle({
	["Name"] = "Toggle",
	["Default"] = false,
	["Callback"] = function(Value)
		_G.conmemay = Value
	end
})

--[[
Living Zombie
Reborn Skeleton
Posessed Mummy
Demonic Soul
]]--

spawn(function()
	while wait() do
		if _G.conmemay then
			pcall(function()
				if (CFrame.new(-9515.75, 174.8521728515625, 6079.40625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 500 then
					beo(CFrame.new(-9515.75, 174.8521728515625, 6079.40625))
				else
					if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                    repeat wait(_G.caubedangyeu)
                                        thangngu()
                                        AutoHaki()
                                        lumlua(SelectWeapon)
                                        beo(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
			                            v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                    until not _G.AutoBone or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
					end
				end
			end)
		end
	end
end)
