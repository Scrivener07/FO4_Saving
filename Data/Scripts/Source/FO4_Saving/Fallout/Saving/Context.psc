Scriptname Fallout:Saving:Context extends Quest
import Papyrus:Diagnostics:Log

UserLog Log
Actor Player


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = "GameSave"
	Player = Game.GetPlayer()
EndEvent


Event OnQuestInit()
	Player.AddPerk(Fallout_SavingBedPerk, false)
	WriteLine(Log, "Added the save with beds perk." + Fallout_SavingBedPerk)
EndEvent


Event OnQuestShutdown()
	Player.RemovePerk(Fallout_SavingBedPerk)
	WriteLine(Log, "Removed the save with beds perk." + Fallout_SavingBedPerk)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Perk Property Fallout_SavingBedPerk Auto Const Mandatory
EndGroup
