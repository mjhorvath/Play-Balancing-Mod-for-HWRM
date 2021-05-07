Title:		Play Balancing Mod for HWRM
Version:	2.4.0
Author:		Mikali
Created:	2005/02/25
Updated:	2016/08/15
Homepage:	http://isometricland.net/homeworld/homeworld.php
Discussion:	https://forums.gearboxsoftware.com/t/play-balancing-mod-for-hwrm/1542877 (new)
		http://forums.relicnews.com/showthread.php?t=57399 (old)


================================================================================


DESCRIPTION
This gamerule iterates through a list of ships, comparing the performance of 
one ship versus the performance of another. Using this method, one can gauge to 
some degree of accuracy the relative combat strength of each ship versus the 
others.

INSTALLATION
Extract the ZIP archive and copy the "DataPlayBalancingHWRM" folder to your 
"Homeworld Remastered" directory. You will also need to edit your command line 
in order to get the mod to work properly. This is described in a later section.

INSTRUCTIONS
This mod is a singleplayer campaign made up of only one level. The game starts 
with one aggressive CPU player attacking a completely passive CPU opponent. You 
then iterate through all of Player 2's ships until they all have been defeated. 
Next, you iterate to Player 1's next ship and reset Player 2 to his first ship, 
repeating the cycle. When all of Player 1's ship have defeated all of Player 
2's ships, the game ends and the results are printed to the log, or to another 
file on the disk.

The goal is to compare the time it takes for Player 1's ship to defeat Player 
2's ship with the time it took for Player 2's ship to defeat Player 1's ship. 
The less time it takes, the more powerful the ship. Some ships don't have any 
weapons at all and are skipped.

A value of "NoAttack" means that one or both ships have no offensive weapon and 
therefore cannot attack. A value of "TimedOut" means that one or both ships ran 
out of time before killing all of the opponent's ships. Currently the timeout 
value is 1 hour. A value of "SameShip" means that the Left and Top Ships are 
identical, and therefore equal in strength. A value of "Failed" means the 
calculation has gone wrong somewhere and needs to be fixed.

You're going to have to modify your command-line in order to get the mod to 
run. See the section, below, for an example command-line. Note, that Players 1 
and 2 will be doing the actual fighting. You (Player 0) will merely be playing 
the part of observer. Simply let the game run until it is finished, and it will 
exit by itself. If you run out of memory first, or if the game should stall for 
some other reason, just quit the game and modify the configuration settings in 
"PlayBalancing_Config.lua" so that you can start right where you left off. Make 
sure to check "HwRM.log" for the results of the previous tests so that you can 
copy them to somewhere safe. Otherwise, they will be overriden and you will 
have to start over from scratch.

IN-GAME TEXT
While running the game you will see some text on the screen:

• Index: the place in the global ShipList table that each ship occupies.
• Count: the place in the current processing queue that each ship occupies.
• Alive: the number of alive ships belonging to Player 1 and Player 2.
• Health: the health of each player's fleet as a percentage of full health.
• Ships: Player 1 and Player 2's ship types.
• Research1: Player 1's researches.
• Research2: Player 2's researches.
• Round Time: the elapsed time in the current mini-battle.
• Game Time: the elapsed time since the start of game according to the game.
• World Time: the elapsed time since the start of game in real time.
• Display Text: a custom message set in "PlayBalancing_Config.lua".
• Script Version: the current version of the Play Balancing script.

Game Time and World Time will be different from each other if you start the 
game with the -superTurbo command line switch enabled. Otherwise, they should 
be identical.

OUTPUT LOG FILE
The script outputs the results of each mini-battle to a new line in "HwRM.log". 
At the end of the game, it also outputs all the cumulative stats to a file 
called "PBAL_Results.txt" in your player profile directory. If you exit the 
game early, or if the game crashes, this output file will not be written and 
you will need to piece together what happened by examining the individual lines 
in "HwRM.log".

Here are what the individual fields in the generated output mean:

• P1_ShipNumber: the index number of player 1's ship in ShipList.
• P1_ShipsLeft: the number of player 1's ships left over at the end of a round.
• P1_AvgHealth: the average health of player 1's ships (including dead ones) at 
  the end of a round.
• P1_ShipType: the type of player 1's ship.
• P1_ResearchList: any research items applied to player 1's ships.
• P2_ShipNumber: the index number of player 2's ship in ShipList.
• P2_ShipsLeft: the number of player 2's ships left over at the end of a round.
• P2_AvgHealth: the average health of player 2's ships (including dead ones) at 
  the end of a round.
• P2_ShipType: the type of player 2's ship.
• P2_ResearchList: any research items applied to player 2's ships.
• RoundTime: the duration of the battle between player 1 and player 2's ships. 
  Or a flag indicating why the duration of the battle was not recorded. If the 
  "ExtrapolateStats" setting is enabled, then RoundTime is also the amount of 
  time it *would* take (probably) for Player 1 to kill Player 2 if time were 
  allowed to continue past "TimeOutValue". If none of Player 2's ships are left 
  alive, or if all of Player 2's ships are at 100% health, then "RoundTime" not 
  be any different.

THE COMMAND LINE
You will need to edit your command line settings in order to run this mod. This 
mod is a singleplayer mod, not multiplayer, so you will need to set the correct 
campaign and starting level in the command line. At the very least, you should 
use the following flags:

	"%HWRM%\Bin\Release\HomeworldRM.exe" -moddatapath DataPlayBalancingHWRM -campaign PlayBalancing -startingLevel testlevel -overrideBigFile -luaTrace -superTurbo -quickLoad

The -superTurbo switch is probably the most important of these, as it allows 
you to speed up the game by a factor of about 50. Without it, this sort of 
testing would require unbearably long periods of time. It is also handy to run 
teh game in a window using the -windowed switch to make the ALT+TAB between 
windows easier.

The -quickLoad switch used to be important when running Homeworld 2 Classic, 
but I don't think it works for Homeworld Remastered any more.

STARTING THE GAME FROM A BATCH FILE
If, like me, you start running out of space in the "Target" field of your 
desktop shortcut, you can start the game from a batch file. Here is what one of 
my batch files looks like:

	e:
	cd %HWRM%\Bin\Release
	HomeworldRM.exe -overrideBigFile -luatrace -hardwareCursor -w 800 -h 600 -windowed -ssTGA -moddatapath DataPlayBalancingHWRM -freeMouse -traceHODs  -nosound -noMovies -quickLoad  -campaign playbalancing -startinglevel testlevel -superTurbo -logfilename=%HWRM%\Bin\Release\HwRM_left.log
	pause

The first line switches to the E:\ drive, since that is where I have Homeworld 
Remastered installed. The second line switches the current working directory 
to the "Release" folder, which contains the game's executable. The game won't 
start unless you do this first! The third line actually starts the game using 
the command line switches you have selected. I actually use more switches than 
you see above, since I run multiple instances of the game, and need the game to 
write to separate log files. The last line pauses the command prompt window so 
that it doesn't disappear right away. If the game quits and there are error 
messages, they will appear in the command prompt window.

Note that %HWRM% is an environmental system variable. You can create these 
variables to store frequently used strings of text, such as paths to files and 
folders that you work on frequently. Here are some instructions on how to use 
and set up environmental variables:

	https://support.microsoft.com/en-us/kb/310519

These instructions should be applicable to most versions of MS Windows.

TIPS
Remember that research is cumulative. This means that once it's been granted, 
it will remain in effect until the game ends. To compensate for this you can 
test ships in blocks by modifying the starting and ending points for each 
player. The ship list, as well as other modifiable values, is stored in 
"PlayBalancing_Config.lua" in your "DataPlayBalancingHWRM" directory. Note that 
there may be a delay of a few seconds between some rounds, as non-combat-
capable ships are skipped when pitted against other non-combat-capable ships. 
Battles will also time-out after 1 hours (game-time).

If you're modifying this mod for your own purposes, remember to remove any 
spawned salvage from within the .ship files. Search each .ship file for 
commands that start with "SpawnSalvageOnDeath" and delete those lines. This is 
necessary in order to keep the game from slowing to a crawl, and hunks of 
salvage from getting in the way of weapons fire. Further, the salvage hunks use 
additional RAM.

If you only run the game in small batches instead of all ships battling all 
other ships, you decrease the likelyhood of the game crashing due to lack of 
memory. Remember that Homeworld Remastered is a 32-bit application, and thus 
can only address a few gigabytes of RAM. On my computer, the game crashes after 
about 200 mini-battles, but consider that just one Vaygr vs. Hiigaran campaign 
consists of over 1500 mini-battles. If you have a lot of RAM and multiple CPU 
cores, you can run multiple instances of the game. This is described in the 
next section.

If the game crashes, you may be able to recover the stats that have accumulated 
up to that point and edit them by hand.

RUNNING MULTIPLE INSTANCES OF THE MOD
If you have plenty of RAM and a multi-core CPU, then you can run multiple 
instances of Homeworld Remastered. Obviously, this will speed up your tests 
considerably. In order to keep track of which instance is doing what, I added 
the following code to my copy of "PlayBalancing_Config.lua":

	SetMeUp = 0
	if (SetMeUp == 0) then
		DisplayText = "Left"
		Player1Race = "hiigaran"
		Player1Start = 31
		Player1End = 35
		Player2Race = "hiigaran"
		Player2Start = 1
		Player2End = nil
	else
		DisplayText = "Right"
		Player1Race = "vaygr"
		Player1Start = 30
		Player1End = 33
		Player2Race = "vaygr"
		Player2Start = 1
		Player2End = nil
	end

I then switch between instances by editing the "SetMeUp" variable. For 
instance, when I have two instances running, one is on the left side of my 
screen, and one is on the right side of my screen. The code above keeps the 
two instances from stepping on each others' toes.


================================================================================


LICENSE

You're free to use this code in any way as long as proper credit is given for 
the work that I have done.


================================================================================


ISSUES

• Some units will not pursue a target while attacking, or will run away when 
  their health falls too low. These should not be tested against each other. In 
  "PlayBalancing_Config.lua", you should give these ships a "CanAttack" value 
  of zero. I'm not sure what to do with marine frigates, however. It does have 
  offensive weapons, but still runs away from ships such as the ion turret. 
  The scout likewise will run away from a mothership.
• Maybe I should allow "AB_UseSpecialWeaponsInNormalAttack". I'm not really 
  sure, though, what this does, exactly.
• I must find a more convenient way of making research non-cumulative (e.g. 
  turning researches on/off via scripting).
• If both players have the same ship and that ship has the Capture Abilty, then 
  a player may end up with more ships than he/she started out with. This only 
  happens when the "EnableSpecialAbility" setting is turned on.
• If the game is running for a long enough time, it will start to run out of 
  memory due to the number of ships and salvage. That's why running the mod in 
  small batches and deleting all "SpawnSalvageOnDeath" commands from .ship 
  files is so important!
• It would be great if you could see all of the ships' health bars at once 
  instead of having to click on each individual ship. This is the default 
  behavior for ships that belong to you, but does not work for allies or 
  enemies. Need to find some way of making it work with other players' ships 
  too.
• The game now writes two sets of files to disk: a normal set and a 
  "temporary" set. Are both necessary? Would it be okay to just stick with the 
  latter?
• The blast radius of large ships like the mothership may be obliterating 
  strike craft in the next round. Have to maybe extend the delay between 
  rounds.
• The "Auto Reload" feature is very complicated, so I suggest not using it. I'm 
  also not going to document it until I feel better about how it is designed.
• The "CalcTime" or "ExtraDuration" parameters do not take into account Player 
  1's health, unfortunately. This means they should be ignored in rounds where 
  both Player 1 and Player 2 can take damage


================================================================================


CHANGE LOG

2.4.0 --- 2016/08/15
• Replaced the "ExtraTime" column in the output with the "ExtrapolateStats" 
  configuration setting. If this setting is enabled, then the regular 
  "RoundTime" column will contain the extrapolated stats.
• Added the "P2_SkipNoAttack" setting. Now you can configure whether to skip 
  battles where Player 1 has attack capability but Player 2 does not. The 
  default is to not skip them.
• Slight tweaks to output.

2.3.0 --- 2016/08/12
• Removed the "AutoReloadInterval" parameter from "PlayBalancing_Config.lua". 
  Since the positive aspects of having it are not that great (simplicity, 
  saving a little time), and the negative aspect (higher memory usage) is 
  pretty big, I decided to axe the feature. That memory can be better spent 
  running additional instances of HWRM in parallel.
• Player 1 and Player 2 now share vision completely. In the past, sometimes a 
  lone straggler would get lost in a corner of the map and the game would go on 
  forever and ever. Hopefully this fixes that problem for good.
• Added a short message for when you've completed all rounds for a particular 
  set of races and it's time to switch races and start over.
• Some tweaks to the "AutoReload" feature allowing the mod to pick up after it 
  left off in case of a crash, even midway through Player 2's list of ships.
  The script is now able to record Player 2's status, and write it to disk 
  after every battle instead of after every round.
• The game now also records each player's race as part of the "AutoReload" 
  feature.
• Health percentages are now calculated for all 10 ships, not just the 
  remaining alive ones.
• Added the "ExtraTime" and "ExtraDuration" parameters. They are used to extra-
  polate how long it *would* take (probably) for Player 1 to kill Player 2's 
  ships if the round time were allowed to proceed past the timeout value. These 
  numbers are derived from the health of any of Player 2's ships that are still 
  alive when "TimeOutValue" is reached. If no ships are left alive, or if all 
  the ships are at 100% health, then "ExtraTime" will equal "RoundTime".

2.2.0 --- 2016/08/09
• Started to implement a method of reading and writing to output files so you 
  can continue on where you left off if the game crashes. This is enabled by 
  the "AutoReloadFlag" setting, but is experimental and tricky to manage. Be 
  careful when using this setting!
• The new "AutoReload" feature is very complicated, so I suggest not using it. 
  I'm not going to document it until I feel better about how it is designed.
• The mod now writes stats to a temporary file in case the game crashes and you 
  have to launch the game again. You will have to clean up these files manually 
  when done using them since they are not deleted automatically by the mod. The 
  mod also now no longer prints to "HWRM.log".
• The "DisplayText" variable is now used for generating the 
  "NextIteration_<text>.lua" file in the player profile directory. This file is 
  used in conjunction with the "AutoReloadFlag" setting to permit you to 
  restart the mod after a game crash, and is no longer merely cosmetic.
• You can now skip a round and move on to the next ship by pressing the "P"
  key. This causes the round to be marked "Skipped" in the log files. Do this 
  when the health percentages are both stuck at 100% or thereabouts.
• Increased the default round duration to 2 hours instead of 1.
• Added the "ScriptVersion" parameter to help keep myself organized.
• Increased the amount of time between ending the last round and starting the 
  new one. This was because motherships' splash damage upon death was killing 
  strike craft.
• You can now see the health percentage each player's ships on the screen.
• The game now periodically reminds Player 1 and Player 2 to attack each other. 
  This was in response to ships losing sight or running away from each other. 
  The *real* solution for the former may be to give each player perfect vision 
  across the whole map. Not sure how to do this, though.
• Added a "Please wait" message between rounds so that players know not to quit 
  the game when the action pauses.

2.1.1 --- 2016/08/07
• Added spaces around commas in research lists.
• Created a new variable called "MakeImmobile". Player 2's ships will now move 
  about as per normal game behavior when attacked unless this setting is 
  enabled. If enabled, the setting causes Player 2's ships to sit still in a 
  completely passive state. This setting is disabled by default.

2.1.0 --- 2016/08/05
• Added the "DisplayText" variable so now you can print some arbitrary text to 
  the screen to stay organized.
• Added an example of running multiple instances of the mod and game to the 
  documentation.
• Updated the documentation with additional tips.
• Placed the time duration measurements and display text at the start of the 
  output file instead of the end.
• The printed output file names are now numbered to make it easier to tell at a 
  glance what they contain.
• The script was ignoring the research list when determining whether two ships 
  were the "same" or not.
• The script now properly detects whether you have specified values for 
  Player1End and Player2End that are greater than the length of the ship lists.
• Other minor tweaks.

2.0.0 --- 2016/08/02
• Updated the mod to work with Homeworld Remastered instead of Homeworld 2 
  Classic. This includes the game rule and the "ShipList" table in 
  "PlayBalancing_Config.lua".
• The entries for each race in the "ShipList" table now use text identifiers 
  instead of numerical identifiers.
• Lots of tweaks to ATI display output.
• Lowered the "TimeOutValue" variable to 1 hours. If it takes longer than this 
  amount for ships to kill each other, then the ships are not worth tracking.
• The mod now also writes cumulative stats to a text file in the player profile 
  directory. However, this only happens if the game doesn't crash (or you don't 
  quit) before the mod finishes its task.
• Renamed the .level file and mission from "Mission_01" to "testlevel".
• The script now skips battles if *either* player's ship does not have an 
  offensive capability, not just Player 1's ship.
• Removed the "SkipDuplicates" parameter. The mod now automatically skips 
  battles where both players' ships are identical. I may add this feature again 
  in the future, because I'm not sure removing it was the best choice.
• Fixed a bug where Players 1 and 2 were being assigned the wrong races in the 
  level file due to the "player" table having been idexed improperly.
• Player 2's move ability is now deactivated when Player 1 is set to being 
  invulnerable.
• Other minor tweaks.

1.2.0 --- 2009/03/30
• Fixed an error in "PlayBalancing_Config.lua".
• The ShipList table in "PlayBalancing_Config.lua" has been collapsed, 
  reordered and extended.
• You can now specify a list of research items to be granted, instead of just a 
  single item.
• The mod now works properly if the "MakeInvulnerable" parameter is set to 1 
  (it was broken).
• Changed the rule names.
• Gun, ion and missile platforms now have their "CanAttack" setting set to 1.
• All platforms are now set as deployed.
• The number of ships that may be spawned can now be specified individually for 
  each type of ship.
• Added the "EnableSpecialAbility" parameter to "PlayBalancing_Config.lua".
• Added the "NumberOfPoints" parameter to "PlayBalancing_Config.lua".
• Renamed the "DistanceBtwUnits" parameter to "DistanceBtwPoints".
• The map now generates positions for each ship in the form of a cube instead 
  of a sphere.

1.1.0 --- 2005/03/03
• Fixed an error in "PlayBalancing_Config.lua".
• All platforms now have their "CanAttack" setting set to zero.
• Changed several parameters in "PlayBalancing_Config.lua".
• Added the "MakeInvulnerable" parameter to "PlayBalancing_Config.lua".
• Added the "TimeOutValue" parameter to "PlayBalancing_Config.lua".
• Removed the background image and music from the map to speed things up a bit 
  and cut down on memory usage.
• Increased the delay between rounds to 5 seconds to allow time for errant 
  missiles to fade away.
• Now checks whether any ships have been captured, and then destroys those 
  ships.
• Now reports the total health percentage of the remaining ships.
• Changed the mod to a singleplayer campaign instead of a multiplayer gametype.
• Removed spawned salvage from the .ship files. This is necessary in order to 
  keep memory usage down to a minimum.
• Added an ATI display showing the current round, the remaining ships and a 
  timer for the current round (in seconds).
• Ships are now destroyed at the end of each round instead of despawned (uses 
  less memory).
• Set the AI difficulty to level 1 instead of the default level 0.
• Other fixes.

1.0.0 --- 2005/02/25
• Initial release.
