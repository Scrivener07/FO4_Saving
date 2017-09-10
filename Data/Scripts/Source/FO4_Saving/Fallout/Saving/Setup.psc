Scriptname Fallout:Saving:Setup extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnEnable()
	If (HasHolotape)
		WriteLine(Log, "Player already has a holotape." + Fallout_Saving_Holotape)
	Else
		Player.AddItem(Fallout_Saving_Holotape, 1, true)
		WriteLine(Log, "Added the holotape." + Fallout_Saving_Holotape)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Holotape Property Fallout_Saving_Holotape Auto Const Mandatory
EndGroup

bool Property HasHolotape Hidden
	bool Function Get()
		return Player.GetItemCount(Fallout_Saving_Holotape) > 0
	EndFunction
EndProperty
