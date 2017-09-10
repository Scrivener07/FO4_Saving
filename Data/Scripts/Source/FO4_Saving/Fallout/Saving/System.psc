Scriptname Fallout:Saving:System extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


; Functions
;---------------------------------------------

bool Function SaveGame()
	If (Player.IsInCombat())
		Fallout_Saving_MessageCantSaveCombat.Show()
		WriteLine(Log, "Cannot save the game while in combat.")
		return false
	Else
		Game.RequestSave()
		Fallout_Saving_MessageSaving.Show()
		WriteLine(Log, "The game has been saved.")
		return true
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Message Property Fallout_Saving_MessageSaving Auto Const Mandatory
	{Saving..}

	Message Property Fallout_Saving_MessageCantSaveCombat Auto Const Mandatory
	{You cannot save while in combat.}
EndGroup
