-- One ship in the ShipList[Player1Race] table is pitted against all ships in the ShipList[Player2Race] table before moving on to the next ship in the ShipList[Player1Race] table.
-- Ships should be listed in the order of their research. They do not need to be listed alphabetically.
-- The total number of tests that will take place before the game ends is equal to (Player1End-Player1Start+1)*(Player2End-Player2Start+1).
-- The total number of tests should be somewhat less than 200, or you will likely run out of memory. Adjust the Player1End, Player1Start, Player2End and Player2Start parameters until total is less than 200.
-- Remember that HWRM is a 32-bit application, so is limited to 2GB of RAM. In reality, HWRM will crash before reaching 2GB. Anything you can do to reduce memory usage is going to help.

-- This text will be displayed on screen, but serves no real function. Do not use funny characters.
DisplayText = "temp"

-- Player races. (must be lower case)
Player1Race = "taiidan"
Player2Race = "kushan"

-- The beginning and ending positions in the ShipList[Player1Race] table for Player1.
-- Set Player1End to nil in order to stop at the end of the table.
Player1Start = 1
Player1End = 1

-- The beginning and ending positions in the ShipList[Player2Race] table for Player2.
-- Set Player2End to nil in order to stop at the end of the table.
Player2Start = 1
Player2End = nil

-- Enable this if you need the game to quit to desktop, restart and iterate to the next ship queue after it finishes the current one.
-- You will have to manually edit the "NextIteration" file in your player profile directory to start out with by setting Player1Start and Player1End to equal 1 (or whatever value you want to start out with).
-- After that, the mod will continue on stopping/restarting until all of Player 1's race's ships have battled all of Player 2's race's ships.
-- This feature is really tricky to manage (I make mistakes often and have to start over), so it's better not to enable it if possible.
AutoReloadFlag = 0
if (AutoReloadFlag == 1) then
	dofilepath("player:NextIteration_" .. DisplayText .. ".lua")
end

-- Make the attacker (Player1) invulnerable to the defender's (Player2) fire. (0 = disable, 1 = enable)
-- Used when generating stats for each player separately.
P1_MakeInvulnerable = 1

-- Make the defender (Player2) totally passive and immobile. (0 = disable, 1 = enable)
P2_MakeImmobile = 0

-- Also skip battles where the defender (Player 2) has no attack capability.
-- Otherwise, only the attacker (Player 1) is considered.
P2_SkipNoAttack = 0

-- Enable units' special abilities. (0 = disable, 1 = enable)
-- Currently, this applies only to the Infiltrator Frigate and Marine Frigate.
-- I can't remember exactly how this works, so it may be broken.
EnableSpecialAbility = 0

-- A round will automatically end after this amount of time has elapsed (in seconds), regardless of who is winning or losing.
TimeOutValue = 7200	-- 2 hours

-- If Player 2's ships have suffered less than 1% damage by this amount of time (in seconds), the round is automatically ended.
SoftTimeOut = 900	-- 15 mins

-- Allows the script to extrapolate how much time it *would* take for Player 1 to kill Player 2 if time were allowed to extend beyond TimeOutValue.
ExtrapolateStats = 1

-- The distance between each unit on the map.
DistanceBtwPoints = 1000

-- The number of each type of unit to spawn.
-- Values can be specified below for each ship, individually, as well.
NumberOfUnits = 10

-- The number of positions to create (but not necessarily fill) on the map.
-- These points are then divided equally among each player.
-- It must equal n^3, where n can be any integer.
-- It must be equal to or greater than NumberOfUnits * 2.
NumberOfPoints = 27

-- ShipList Legend	= {ShipType,ResearchList,NumberOfShips,CanAttack,},
-- ShipType		= the type of ship
-- ResearchList		= a table of research items to grant the player
-- NumberOfShips	= the number of that type of unit to spawn, overriding the above NumberOfShips variable
-- CanAttack		= a flag indicating whether a ship can move, attack and pursue its target. Otherwise, the ship will just sit there and do nothing.

ShipList =
{
	hiigaran =
	{
		-- Section 1: #1 to #23
		{"Hgn_AssaultCorvette",{},NumberOfUnits,1,},
		{"Hgn_AssaultFrigate",{},NumberOfUnits,1,},
		{"Hgn_AttackBomber",{},NumberOfUnits,1,},
		{"Hgn_BattleCruiser",{},NumberOfUnits,1,},
		{"Hgn_Carrier",{},NumberOfUnits,1,},
		{"Hgn_DefenseFieldFrigate",{},NumberOfUnits,0,},
		{"Hgn_Destroyer",{},NumberOfUnits,1,},
		{"Hgn_ECMProbe",{},NumberOfUnits,0,},
		{"Hgn_GunTurret",{},NumberOfUnits,1,},
		{"Hgn_Interceptor",{},NumberOfUnits,1,},
		{"Hgn_IonCannonFrigate",{},NumberOfUnits,1,},
		{"Hgn_IonTurret",{},NumberOfUnits,1,},
		{"Hgn_MarineFrigate",{},NumberOfUnits,1,},
		{"Hgn_MinelayerCorvette",{},NumberOfUnits,0,},
		{"Hgn_Mothership",{},NumberOfUnits,1,},
		{"Hgn_Probe",{},NumberOfUnits,0,},
		{"Hgn_ProximitySensor",{},NumberOfUnits,0,},
		{"Hgn_PulsarCorvette",{},NumberOfUnits,1,},
		{"Hgn_ResourceCollector",{},NumberOfUnits,0,},
		{"Hgn_ResourceController",{},NumberOfUnits,1,},
		{"Hgn_Scout",{},NumberOfUnits,1,},
		{"Hgn_Shipyard",{},NumberOfUnits,1,},
		{"Hgn_TorpedoFrigate",{},NumberOfUnits,1,},
		-- Section 2: #24 to #39
		{"Hgn_AssaultCorvette",{"AssaultCorvetteHealthUpgrade1","AssaultCorvetteMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_AssaultFrigate",{"AssaultFrigateHealthUpgrade1","AssaultFrigateMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_AttackBomber",{"AttackBomberImprovedBombs","AttackBomberMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_BattleCruiser",{"BattlecruiserHealthUpgrade1","BattlecruiserMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_Carrier",{"CarrierHealthUpgrade1","CarrierMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_Destroyer",{"DestroyerHealthUpgrade1","DestroyerMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_GunTurret",{"GunTurretHealthUpgrade1"},NumberOfUnits,1,},
		{"Hgn_Interceptor",{"InterceptorMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_IonCannonFrigate",{"IonCannonFrigateHealthUpgrade1","IonCannonFrigateMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_IonTurret",{"IonTurretHealthUpgrade1"},NumberOfUnits,1,},
		{"Hgn_Mothership",{"MothershipHealthUpgrade1","MothershipMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_PulsarCorvette",{"PulsarCorvetteHealthUpgrade1","PulsarCorvetteMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_ResourceCollector",{"ResourceCollectorHealthUpgrade1"},NumberOfUnits,0,},
		{"Hgn_ResourceController",{"ResourceControllerHealthUpgrade1"},NumberOfUnits,1,},
		{"Hgn_Shipyard",{"ShipyardHealthUpgrade1","ShipyardMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		{"Hgn_TorpedoFrigate",{"ImprovedTorpedo","TorpedoFrigateHealthUpgrade1","TorpedoFrigateMAXSPEEDUpgrade1",},NumberOfUnits,1,},
		-- Section 3: #36 to #50
--		{"Hgn_AttackBomberElite",{},NumberOfUnits,1,},
--		{"Hgn_AssaultCorvetteElite",{},NumberOfUnits,1,},
--		{"hgn_cloakingfrigate",{},NumberOfUnits,1,},
--		{"Hgn_Drone_Frigate",{},NumberOfUnits,0,},
--		{"Hgn_Drone_Frigate_2",{},NumberOfUnits,0,},
--		{"Hgn_Drone_Frigate_3",{},NumberOfUnits,0,},
--		{"Hgn_SupportFrigate",{},NumberOfUnits,0,},
--		{"Hgn_MarineFrigate_Soban",{},NumberOfUnits,1,},
--		{"Hgn_Dreadnaught",{},NumberOfUnits,1,},
--		{"Hgn_Shipyard_Elohim",{},NumberOfUnits,0,},
--		{"Hgn_Shipyard_SPG",{},NumberOfUnits,0,},
--		{"Hgn_TargetDrone",{},NumberOfUnits,0,},
--		{"Hgn_PulsarPlatform",{},NumberOfUnits,0,},
--		{"Hgn_CloudExplode",{},NumberOfUnits,0,},
--		{"Hgn_HSCore",{},NumberOfUnits,0,},
	},
	vaygr =
	{
		-- Section 1: #1 to #24
		{"Vgr_AssaultFrigate",{},NumberOfUnits,1,},
		{"Vgr_BattleCruiser",{},NumberOfUnits,1,},
		{"Vgr_Bomber",{},NumberOfUnits,1,},
		{"Vgr_Carrier",{},NumberOfUnits,1,},
		{"Vgr_CommandCorvette",{},NumberOfUnits,0,},
		{"Vgr_Destroyer",{},NumberOfUnits,1,},
		{"Vgr_HeavyMissileFrigate",{},NumberOfUnits,1,},
		{"Vgr_HyperSpace_Platform",{},NumberOfUnits,0,},
		{"Vgr_InfiltratorFrigate",{},NumberOfUnits,1,},
		{"Vgr_Interceptor",{},NumberOfUnits,1,},
		{"Vgr_LanceFighter",{},NumberOfUnits,1,},
		{"Vgr_LaserCorvette",{},NumberOfUnits,1,},
		{"Vgr_MinelayerCorvette",{},NumberOfUnits,0,},
		{"Vgr_MissileCorvette",{},NumberOfUnits,1,},
		{"Vgr_Mothership",{},NumberOfUnits,1,},
		{"Vgr_Probe",{},NumberOfUnits,0,},
		{"Vgr_Probe_ECM",{},NumberOfUnits,0,},
		{"Vgr_Probe_Prox",{},NumberOfUnits,0,},
		{"Vgr_ResourceCollector",{},NumberOfUnits,0,},
		{"Vgr_ResourceController",{},NumberOfUnits,1,},
		{"Vgr_Scout",{},NumberOfUnits,1,},
		{"Vgr_Shipyard",{},NumberOfUnits,1,},
		{"Vgr_WeaponPlatform_gun",{},NumberOfUnits,1,},
		{"Vgr_WeaponPlatform_missile",{},NumberOfUnits,1,},
		-- Section 2: #25 to #44
		{"Vgr_AssaultFrigate",{"FrigateHealthUpgrade1","FrigateSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_BattleCruiser",{"SuperCapHealthUpgrade1","SuperCapSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_Bomber",{"BomberImprovedBombs","FighterspeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_Carrier",{"SuperCapHealthUpgrade1","SuperCapSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_CommandCorvette",{"CorvetteHealthUpgrade1","CorvetteSpeedUpgrade1",},NumberOfUnits,0,},
		{"Vgr_Destroyer",{"SuperCapHealthUpgrade1","SuperCapSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_HeavyMissileFrigate",{"FrigateHealthUpgrade1","FrigateSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_HyperSpace_Platform",{"PlatformHealthUpgrade1",},NumberOfUnits,0,},
		{"Vgr_InfiltratorFrigate",{"FrigateHealthUpgrade1","FrigateSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_Interceptor",{"FighterspeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_LanceFighter",{"FighterspeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_LaserCorvette",{"CorvetteHealthUpgrade1","CorvetteSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_MinelayerCorvette",{"CorvetteHealthUpgrade1","CorvetteSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_MissileCorvette",{"CorvetteHealthUpgrade1","CorvetteSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_Mothership",{"SuperCapHealthUpgrade1","SuperCapSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_ResourceCollector",{"UtilityHealthUpgrade1",},NumberOfUnits,0,},
		{"Vgr_ResourceController",{"UtilityHealthUpgrade1",},NumberOfUnits,1,},
		{"Vgr_ShipYard",{"SuperCapHealthUpgrade1","SuperCapSpeedUpgrade1",},NumberOfUnits,1,},
		{"Vgr_WeaponPlatform_gun",{"PlatformHealthUpgrade1",},NumberOfUnits,1,},
		{"Vgr_WeaponPlatform_missile",{"PlatformHealthUpgrade1",},NumberOfUnits,1,},
		-- Section 3: #45 to #53
--		{"Vgr_Mothership_Makaan",{},NumberOfUnits,1,},
--		{"Vgr_CommStation",{},NumberOfUnits,0,},
--		{"Vgr_PrisonStation",{},NumberOfUnits,0,},
--		{"Vgr_PlanetKiller",{},NumberOfUnits,0,},
--		{"Vgr_PlanetKillerMissile",{},NumberOfUnits,0,},
--		{"Vgr_HyperSpace_Inhibitor",{},NumberOfUnits,0,},
--		{"Vgr_ArtilleryCruiser",{},NumberOfUnits,0,},
--		{"vgr_listeningpost",{},NumberOfUnits,0,},
--		{"vgr_transportfrigate",{},NumberOfUnits,0,},
	},
	kushan =
	{
		-- Section 1: #1 to #28
		{"Kus_AssaultFrigate",{},NumberOfUnits,1,},
		{"Kus_AttackBomber",{},NumberOfUnits,1,},
		{"Kus_Carrier",{},NumberOfUnits,1,},
		{"Kus_CloakedFighter",{},NumberOfUnits,1,},
		{"Kus_CloakGenerator",{},NumberOfUnits,0,},
		{"Kus_Defender",{},NumberOfUnits,1,},
		{"Kus_Destroyer",{},NumberOfUnits,1,},
		{"Kus_DroneFrigate",{},NumberOfUnits,1,},
		{"Kus_GravWellGenerator",{},NumberOfUnits,0,},
		{"Kus_HeavyCorvette",{},NumberOfUnits,1,},
		{"Kus_HeavyCruiser",{},NumberOfUnits,1,},
		{"Kus_Interceptor",{},NumberOfUnits,1,},
		{"Kus_IonCannonFrigate",{},NumberOfUnits,1,},
		{"Kus_LightCorvette",{},NumberOfUnits,1,},
		{"Kus_MinelayerCorvette",{},NumberOfUnits,0,},
		{"Kus_MissileDestroyer",{},NumberOfUnits,1,},
		{"Kus_Mothership",{},NumberOfUnits,1,},
		{"Kus_MultiGunCorvette",{},NumberOfUnits,1,},
		{"Kus_Probe",{},NumberOfUnits,0,},
		{"Kus_ProximitySensor",{},NumberOfUnits,0,},
		{"Kus_RepairCorvette",{},NumberOfUnits,1,},
		{"Kus_ResearchShip",{},NumberOfUnits,0,},
		{"Kus_ResourceCollector",{},NumberOfUnits,0,},
		{"Kus_ResourceController",{},NumberOfUnits,0,},
		{"Kus_SalvageCorvette",{},NumberOfUnits,0,},
		{"Kus_Scout",{},NumberOfUnits,1,},
		{"Kus_SensorArray",{},NumberOfUnits,0,},
		{"Kus_SupportFrigate",{},NumberOfUnits,1,},
		-- Section 2
--		{"Kus_TargetDrone",{},NumberOfUnits,0,},
--		{"Kus_ResearchShip_1",{},NumberOfUnits,0,},
--		{"Kus_ResearchShip_2",{},NumberOfUnits,0,},
--		{"Kus_ResearchShip_3",{},NumberOfUnits,0,},
--		{"Kus_ResearchShip_4",{},NumberOfUnits,0,},
--		{"Kus_ResearchShip_5",{},NumberOfUnits,0,},
--		{"Kus_Ambassador",{},NumberOfUnits,0,},
--		{"Kus_CryoTray",{},NumberOfUnits,0,},
--		{"Kus_CryoTray_M03",{},NumberOfUnits,0,},
--		{"Kus_HeadshotAsteroid",{},NumberOfUnits,0,},
--		{"Kus_Drone0",{},NumberOfUnits,0,},
--		{"Kus_Drone1",{},NumberOfUnits,0,},
--		{"Kus_Drone10",{},NumberOfUnits,0,},
--		{"Kus_Drone11",{},NumberOfUnits,0,},
--		{"Kus_Drone12",{},NumberOfUnits,0,},
--		{"Kus_Drone13",{},NumberOfUnits,0,},
--		{"Kus_Drone2",{},NumberOfUnits,0,},
--		{"Kus_Drone3",{},NumberOfUnits,0,},
--		{"Kus_Drone4",{},NumberOfUnits,0,},
--		{"Kus_Drone5",{},NumberOfUnits,0,},
--		{"Kus_Drone6",{},NumberOfUnits,0,},
--		{"Kus_Drone7",{},NumberOfUnits,0,},
--		{"Kus_Drone8",{},NumberOfUnits,0,},
--		{"Kus_Drone9",{},NumberOfUnits,0,},
	},
	taiidan =
	{
		-- Section 1: #1 to #28
		{"Tai_AssaultFrigate",{},NumberOfUnits,1,},
		{"Tai_AttackBomber",{},NumberOfUnits,1,},
		{"Tai_Carrier",{},NumberOfUnits,1,},
		{"Tai_CloakGenerator",{},NumberOfUnits,0,},
		{"Tai_Defender",{},NumberOfUnits,1,},
		{"Tai_DefenseFighter",{},NumberOfUnits,0,},
		{"Tai_Destroyer",{},NumberOfUnits,1,},
		{"Tai_FieldFrigate",{},NumberOfUnits,0,},
		{"Tai_GravWellGenerator",{},NumberOfUnits,0,},
		{"Tai_HeavyCorvette",{},NumberOfUnits,1,},
		{"Tai_HeavyCruiser",{},NumberOfUnits,1,},
		{"Tai_Interceptor",{},NumberOfUnits,1,},
		{"Tai_IonCannonFrigate",{},NumberOfUnits,1,},
		{"Tai_LightCorvette",{},NumberOfUnits,1,},
		{"Tai_MinelayerCorvette",{},NumberOfUnits,0,},
		{"Tai_MissileDestroyer",{},NumberOfUnits,1,},
		{"Tai_Mothership",{},NumberOfUnits,1,},
		{"Tai_MultiGunCorvette",{},NumberOfUnits,1,},
		{"Tai_Probe",{},NumberOfUnits,0,},
		{"Tai_ProximitySensor",{},NumberOfUnits,0,},
		{"Tai_RepairCorvette",{},NumberOfUnits,1,},
		{"Tai_ResearchShip",{},NumberOfUnits,0,},
		{"Tai_ResourceCollector",{},NumberOfUnits,0,},
		{"Tai_ResourceController",{},NumberOfUnits,0,},
		{"Tai_SalvageCorvette",{},NumberOfUnits,0,},
		{"Tai_Scout",{},NumberOfUnits,1,},
		{"Tai_SensorArray",{},NumberOfUnits,0,},
		{"Tai_SupportFrigate",{},NumberOfUnits,1,},
		-- Section 2
--		{"Tai_TargetDrone",{},NumberOfUnits,0,},
--		{"Tai_ResearchShip_1",{},NumberOfUnits,0,},
--		{"Tai_ResearchShip_2",{},NumberOfUnits,0,},
--		{"Tai_ResearchShip_3",{},NumberOfUnits,0,},
--		{"Tai_ResearchShip_4",{},NumberOfUnits,0,},
--		{"Tai_ResearchShip_5",{},NumberOfUnits,0,},
--		{"Tai_ResearchStation",{},NumberOfUnits,1,},
--		{"Tai_HeadshotAsteroid",{},NumberOfUnits,0,},
--		{"Tai_FieldGenerator",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorDummy",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment1",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment2",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment3",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment4",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment5",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment6",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment7",{},NumberOfUnits,1,},
--		{"Tai_FieldGeneratorSegment8",{},NumberOfUnits,1,},
	},
}
