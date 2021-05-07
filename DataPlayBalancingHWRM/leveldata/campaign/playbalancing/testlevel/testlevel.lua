ScriptVersion = "2.4.0 rev 037"
dofilepath("data:PlayBalancing_Config.lua")
dofilepath("data:scripts/SCAR/SCAR_Util.lua")
HCPI_RoundTime = 0
HCPN_Parameters = 1
RoundStartTime = 0
GameStartTime = 0
WorldStartTime = 0
RoundString = ""
GameString = ""
WorldString = ""
P1_ShipNumber = tonumber(Player1Start)
P2_ShipNumber = tonumber(Player2Start)
P1_ShipTotal = 0
P2_ShipTotal = 0
P1_ShipType = ""
P2_ShipType = ""
P1_Research = ""
P2_Research = ""
P1_Number = 0
P2_Number = 0
P1_PctHealth = 0
P2_PctHealth = 0
P1_CanAttack = 0
P2_CanAttack = 0
P1_ShipsLeft = 0
P2_ShipsLeft = 0
P1_ResearchList = ""
P2_ResearchList = ""
SkipThisShip = 0
OutputString = ""
TempFilePath = ""

function OnInit()
--	dofilepath("data:scripts/HW2_ThoughtDump_b.lua")
	GameStartTime = Universe_GameTime()
	WorldStartTime = clock()
	Player_Kill(0)
	ATI_LoadTemplates("data:leveldata\\campaign\\playbalancing\\testlevel\\ati.lua")
	ATI_CreateParameters(HCPN_Parameters)
	P1_ShipTotal = getn(ShipList[Player1Race])
	P2_ShipTotal = getn(ShipList[Player2Race])
	if (Player1End == nil) then
		Player1End = P1_ShipTotal
	end
	if (Player2End == nil) then
		Player2End = P2_ShipTotal
	end
	Player1End = min(P1_ShipTotal, Player1End)
	Player2End = min(P2_ShipTotal, Player2End)
	P1_ShipNumber = max(1, P1_ShipNumber)
	P2_ShipNumber = max(1, P2_ShipNumber)
	-- these should not be necessary in an ideal world
	Player_SetGlobalROE(1, OffensiveROE)
	Player_SetGlobalStance(1, AggressiveStance)
	if (P2_MakeImmobile == 1) then
		Player_SetGlobalROE(2, PassiveROE)
		Player_SetGlobalStance(2, EvasiveStance)
	else
		Player_SetGlobalROE(2, OffensiveROE)
		Player_SetGlobalStance(2, AggressiveStance)
	end
	SetStartFleetSuffix("noships")
	SobGroup_Create("Player1Group")
	SobGroup_Create("Player2Group")
	SobGroup_Create("Player1Captured")
	SobGroup_Create("Player2Captured")
	Player_ShareVision(1, 2, 1)
	Player_ShareVision(2, 1, 1)
	local fstamp = date("%Y-%m-%d_%H_%M_%S")
	TempFilePath = "temp_PBAL_" .. Player1Race .. "_[" .. PadZeroes(Player1Start) .. "-" .. PadZeroes(Player1End) .. "]_" .. Player2Race .. "_[" .. PadZeroes(Player2Start) .. "-" .. PadZeroes(Player2End) .. "]_" .. fstamp .. ".txt"
	local temp_string =
		"Player1Race: " .. Player1Race .. ", Player2Race: " .. Player2Race .. ", Player1Start: " .. Player1Start .. ", Player1End: " .. Player1End .. ", Player2Start: " .. Player2Start .. ", Player2End: " .. Player2End .. ", P1_MakeInvulnerable: " .. P1_MakeInvulnerable .. ", EnableSpecialAbility: " .. EnableSpecialAbility .. ", TimeOutValue: " .. TimeOutValue .. ", DistanceBtwPoints: " .. DistanceBtwPoints .. ", NumberOfPoints: " .. NumberOfPoints .. ", NumberOfUnits: " .. NumberOfUnits .. "\n"
		.. "--------------------------------------------------------------------------------\n"
		.. "P1_ShipNumber\tP1_ShipsLeft\tP1_PctHealth\tP1_ShipType\tP1_ResearchList\tP2_ShipNumber\tP2_ShipsLeft\tP2_PctHealth\tP2_ShipType\tP2_ResearchList\tRoundTime\n"
	MultiPrint(temp_string)
	Rule_Add("LetsBindStuff")
	if (P1_ShipNumber <= P1_ShipTotal) then
		Rule_Add("AddShipsAndAttackRule")
	else
		Subtitle_Message("Done. Switch races and start again.", 200000)
	end
	Rule_AddInterval("PrintStuffToATIRule", 1)
end

function AddShipsAndAttackRule()
	local temp_list = ShipList[Player1Race][P1_ShipNumber]
	P1_ShipType	= temp_list[1]
	P1_Research	= temp_list[2]
	P1_Number	= temp_list[3]
	P1_CanAttack	= temp_list[4]
	P1_ResearchList = ""
	temp_list = ShipList[Player2Race][P2_ShipNumber]
	P2_ShipType	= temp_list[1]
	P2_Research	= temp_list[2]
	P2_Number	= temp_list[3]
	P2_CanAttack	= temp_list[4]
	P2_ResearchList = ""
	if (getn(P1_Research) == 0) then
		P1_ResearchList = "none"
	else
		for i, iCount in P1_Research do
			if (i > 1) then
				P1_ResearchList = P1_ResearchList .. ", "
			end
			P1_ResearchList = P1_ResearchList .. iCount
		end
	end
	if (getn(P2_Research) == 0) then
		P2_ResearchList = "none"
	else
		for i, iCount in P2_Research do
			if (i > 1) then
				P2_ResearchList = P2_ResearchList .. ", "
			end
			P2_ResearchList = P2_ResearchList .. iCount
		end
	end
	if ((P1_CanAttack == 1) and ((P2_SkipNoAttack == 0) or (P2_CanAttack == 1)) and ((P1_ShipType ~= P2_ShipType) or (P1_ResearchList ~= P2_ResearchList))) then
		for i = 1, P1_Number do
			SobGroup_SpawnNewShipInSobGroup(1, P1_ShipType, "Player1_Ship_" .. i, "Player1Group", "Player1Point" .. i)
		end
		for i = 1, P2_Number do
			SobGroup_SpawnNewShipInSobGroup(2, P2_ShipType, "Player2_Ship_" .. i, "Player2Group", "Player2Point" .. i)
		end
		for i, iCount in P1_Research do
			if (Player_HasResearch(1, iCount) == 0) then
				Player_GrantResearchOption(1, iCount)
			end
		end
		for i, iCount in P2_Research do
			if (Player_HasResearch(2, iCount) == 0) then
				Player_GrantResearchOption(2, iCount)
			end
		end
		-- currently only considered for marine frigates
		-- rename? plural?
		if (EnableSpecialAbility == 0) then
			SobGroup_SetCaptureState("Player1Group", 0)
			SobGroup_SetCaptureState("Player2Group", 0)
		end
		SobGroup_SetAsDeployed("Player1Group")
		SobGroup_SetAsDeployed("Player2Group")
		SobGroup_SetROE("Player1Group", OffensiveROE)
		SobGroup_SetStance("Player1Group", AggressiveStance)
		SobGroup_Attack(1, "Player1Group", "Player2Group")
		if (P1_MakeInvulnerable == 1) then
			SobGroup_SetInvulnerability("Player1Group", 1)
		end
		if (P2_MakeImmobile == 1) then
			SobGroup_SetROE("Player2Group", PassiveROE)
			SobGroup_SetStance("Player2Group", EvasiveStance)
			SobGroup_AbilityActivate("Player2Group", AB_Move, 0)
			SobGroup_AbilityActivate("Player2Group", AB_Attack, 0)
		else
			SobGroup_SetROE("Player2Group", OffensiveROE)
			SobGroup_SetStance("Player2Group", AggressiveStance)
			SobGroup_Attack(2, "Player2Group", "Player1Group")
		end
	end
	RoundStartTime = Universe_GameTime()
	Rule_AddInterval("PeriodicallyAttack", 10)
	Rule_AddInterval("CheckStatusAndCountRule", 1)
	Rule_Remove("AddShipsAndAttackRule")
end

function CheckStatusAndCountRule()
	local RoundDuration = floor(Universe_GameTime() - RoundStartTime + 0.5)
	-- check if the other player has any of your ships due to being captured
	if (EnableSpecialAbility == 1) then
		Player_FillShipsByType("Player1Captured", 1, P2_ShipType)
		Player_FillShipsByType("Player2Captured", 2, P1_ShipType)
		SobGroup_SetHealth("Player1Captured", 0)
		SobGroup_SetHealth("Player2Captured", 0)
	end
	P1_ShipsLeft = SobGroup_Count("Player1Group")
	P2_ShipsLeft = SobGroup_Count("Player2Group")
	P1_RawHealth = SobGroup_HealthPercentage("Player1Group") * P1_ShipsLeft / NumberOfUnits
	P2_RawHealth = SobGroup_HealthPercentage("Player2Group") * P2_ShipsLeft / NumberOfUnits
	P1_PctHealth = ceil(P1_RawHealth * 100)
	P2_PctHealth = ceil(P2_RawHealth * 100)
	if ((P1_ShipsLeft == 0) or (P2_ShipsLeft == 0) or (RoundDuration >= TimeOutValue) or (SkipThisShip == 1) or ((RoundDuration >= SoftTimeOut) and (P1_PctHealth == 100) and (P2_PctHealth == 100))) then
		if ((P1_ShipType == P2_ShipType) and (P1_ResearchList == P2_ResearchList)) then
			RoundDuration = "SameShip"
		elseif (P1_CanAttack == 0) then
			RoundDuration = "NoAttack"
		elseif ((P2_SkipNoAttack == 1) and (P2_CanAttack == 0)) then
			RoundDuration = "NoAttack"
		elseif (RoundDuration >= TimeOutValue) then
			-- doesn't take into account Player 1's health unfortunately
			-- may not work in modes where both Player 1 and Player 2 may take damage
			if ((ExtrapolateStats == 1) and (P2_PctHealth > 0) and (P2_PctHealth < 100)) then
				RoundDuration = ceil(TimeOutValue/(1 - P2_RawHealth))
			else
				RoundDuration = "TimedOut"
			end
		elseif (SkipThisShip == 1) then
			RoundDuration = "Skipped"
		elseif ((RoundDuration >= SoftTimeOut) and (P1_PctHealth == 100) and (P2_PctHealth == 100)) then
			RoundDuration = "Skipped"
		end
		local temp_string = P1_ShipNumber .. "\t" .. P1_ShipsLeft .. "\t" .. P1_PctHealth .. "\t" .. P1_ShipType .. "\t" .. P1_ResearchList .. "\t" .. P2_ShipNumber .. "\t" .. P2_ShipsLeft .. "\t" .. P2_PctHealth .. "\t" .. P2_ShipType .. "\t" .. P2_ResearchList .. "\t" .. RoundDuration .. "\n"
		MultiPrint(temp_string)
		-- produces weird effects, such as smoke and flames that don't go away
--		SobGroup_Despawn("Player1Group")
--		SobGroup_Despawn("Player2Group")
		SobGroup_SetHealth("Player1Group", 0)
		SobGroup_SetHealth("Player2Group", 0)
		if (P2_ShipNumber < Player2End) then
			P2_ShipNumber = P2_ShipNumber + 1
		else
			P1_ShipNumber = P1_ShipNumber + 1
			if (AutoReloadFlag == 1) then
				P2_ShipNumber = 1
			else
				P2_ShipNumber = Player2Start
			end
		end
		-- write to the iteration file that will get loaded next time the game starts
		if (AutoReloadFlag == 1) then
			local AutoReloadString =
				"Player1Race = \"" .. Player1Race .. "\"\n"		..
				"Player1Start = " .. P1_ShipNumber .. "\n"	..
				"Player1End = " .. P1_ShipNumber .. "\n"	..
				"Player2Race = \"" .. Player2Race .. "\"\n"		..
				"Player2Start = " .. P2_ShipNumber .. "\n"	..
				"Player2End = nil\n"
			writeto("NextIteration_" .. DisplayText .. ".lua")
			write(AutoReloadString)
			writeto()
		end
		Subtitle_Message("Please wait 20 seconds.", 20)		-- subtitle message time is measured in *real time* not game time
		Rule_AddInterval("StopWaiting", 20)
		if (P1_ShipNumber <= Player1End) then
			Rule_AddInterval("AddShipsAndAttackRule", 20)
		else
			Rule_AddInterval("WriteStuffAndExit", 20)
		end
		SkipThisShip = 0
		Rule_Remove("CheckStatusAndCountRule")
	end
end

function PrintStuffToATIRule()
	ATI_Clear()
	-- Section 1
	local P1_CountNum = P1_ShipNumber - Player1Start + 1
	local P2_CountNum = P2_ShipNumber - Player2Start + 1
	local P1_CountDen = Player1End - Player1Start + 1
	local P2_CountDen = Player2End - Player2Start + 1
	ATI_AddString(HCPI_RoundTime, "Index: " .. P1_ShipNumber .. "/" .. P1_ShipTotal .. ", " .. P2_ShipNumber .. "/" .. P2_ShipTotal)
	ATI_Display2D("playerProgress", {0.01, 0.70, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Count: " .. P1_CountNum .. "/" .. P1_CountDen .. ", " .. P2_CountNum .. "/" .. P2_CountDen)
	ATI_Display2D("playerProgress", {0.01, 0.67, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Alive: " .. P1_ShipsLeft .. ", " .. P2_ShipsLeft)
	ATI_Display2D("playerProgress", {0.01, 0.64, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Health: " .. P1_PctHealth .. "%, " .. P2_PctHealth .. "%")
	ATI_Display2D("playerProgress", {0.01, 0.61, 0.30, 0.02}, 0)
	-- Section 2
	ATI_AddString(HCPI_RoundTime, "Ships: " .. P1_ShipType .. ", " .. P2_ShipType)
	ATI_Display2D("playerProgress", {0.01, 0.55, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Research1: " .. P1_ResearchList)
	ATI_Display2D("playerProgress", {0.01, 0.52, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Research2: " .. P2_ResearchList)
	ATI_Display2D("playerProgress", {0.01, 0.49, 0.30, 0.02}, 0)
	-- Section 3
	local round_time = Universe_GameTime() - RoundStartTime
	local round_h = floor(round_time/3600)
	local round_m = floor(round_time/60 - round_h * 60)
	local round_s = round_time - round_m * 60 - round_h * 3600
	RoundString = format("%2.0fh %2.0fm %3.0fs", round_h, round_m, round_s)
	local game_time = Universe_GameTime() - GameStartTime
	local game_h = floor(game_time/3600)
	local game_m = floor(game_time/60 - game_h * 60)
	local game_s = game_time - game_m * 60 - game_h * 3600
	GameString = format("%2.0fh %2.0fm %3.0fs", game_h, game_m, game_s)
	local world_time = clock() - WorldStartTime
	local world_h = floor(world_time/3600)
	local world_m = floor(world_time/60 - world_h * 60)
	local world_s = world_time - world_m * 60 - world_h * 3600
	WorldString = format("%2.0fh %2.0fm %3.0fs", world_h, world_m, world_s)
	ATI_AddString(HCPI_RoundTime, "Round Time: " .. RoundString)
	ATI_Display2D("playerProgress", {0.01, 0.43, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Game Time: " .. GameString)
	ATI_Display2D("playerProgress", {0.01, 0.40, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "World Time: " .. WorldString)
	ATI_Display2D("playerProgress", {0.01, 0.37, 0.30, 0.02}, 0)
	-- Section 4
	ATI_AddString(HCPI_RoundTime, "Display Text: " .. DisplayText)
	ATI_Display2D("playerProgress", {0.01, 0.31, 0.30, 0.02}, 0)
	ATI_AddString(HCPI_RoundTime, "Script Version: " .. ScriptVersion)
	ATI_Display2D("playerProgress", {0.01, 0.28, 0.30, 0.02}, 0)
end

function WriteStuffAndExit()
	-- write to the final file
	local fstamp = date("%Y-%m-%d_%H_%M_%S")
	local FinalFilePath = "PBAL_" .. Player1Race .. "_[" .. PadZeroes(Player1Start) .. "-" .. PadZeroes(Player1End) .. "]_" .. Player2Race .. "_[" .. PadZeroes(Player2Start) .. "-" .. PadZeroes(Player2End) .. "]_" .. fstamp .. ".txt"
	OutputString = "ScriptVersion: " .. ScriptVersion .. "\nDisplayText: " .. DisplayText .. "\nGameTime: " .. GameString .. ", WorldTime: " .. WorldString .. "\n" .. OutputString
	writeto(FinalFilePath)
	write(OutputString)
	writeto()
	UI_ExitApp()
end

function StopWaiting()
	Subtitle_Message(" ", 1)
	Rule_Remove("StopWaiting")
end

function PeriodicallyAttack()
	SobGroup_Attack(1, "Player1Group", "Player2Group")
	if (P2_MakeImmobile == 0) then
		SobGroup_Attack(2, "Player2Group", "Player1Group")
	end
end

function LetsBindStuff()
--	UI_BindKeyEvent(TILDEKEY, "SkipToTheNextShip")
	UI_BindKeyEvent(PKEY, "SkipToTheNextShip")
	Rule_Remove("LetsBindStuff")
end

function MultiPrint(in_text)
	local temp_file = openfile(TempFilePath, "a")
	write(temp_file, in_text)
	closefile(temp_file)
--	print("PBM: " .. in_text)
	OutputString = OutputString .. in_text
end

function PadZeroes(in_number)
	local temp_num = in_number
	if (in_number < 10) then
		temp_num = "0" .. temp_num
	end
	if (in_number < 100) then
		temp_num = "0" .. temp_num
	end
	return temp_num
end

function SkipToTheNextShip()
	SkipThisShip = 1
end
