Scriptname Fallout:Saving:SaveBed extends Papyrus:Project:Modules:Optional
import Fallout
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnEnable()
	RegisterForRemoteEvent(Fallout_Saving_BedPerk, "OnEntryRun")
	Player.AddPerk(Fallout_Saving_BedPerk, false)
	WriteLine(Log, "Added the save with beds perk." + Fallout_Saving_BedPerk)
EndEvent


Event OnDisable()
	UnregisterForRemoteEvent(Fallout_Saving_BedPerk, "OnEntryRun")
	Player.RemovePerk(Fallout_Saving_BedPerk)
	WriteLine(Log, "Removed the save with beds perk." + Fallout_Saving_BedPerk)
EndEvent


Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
	If (akSender == Fallout_Saving_BedPerk)
		If (HasOwnership(akOwner, akTarget))
			System.SaveGame()
		Else
			Fallout_Saving_MessageCantSaveOwnership.Show()
			WriteLine(Log, "The bed does not meet ownership requirements for a game save.")
		EndIf
	Else
		WriteLine(Log, "Perk entry point sender is unhandled: " + akSender)
	EndIf
EndEvent


; Functions
;---------------------------------------------

bool Function HasOwnership(Actor akPlayer, ObjectReference akBed) Global
	If (akBed.HasOwner() == false)
		return true
	ElseIf (akBed.IsOwnedBy(akPlayer))
		return true
	Else
		int enemyReaction = 1 const
		Actor actorOwner = akBed.GetActorRefOwner()
		If (actorOwner && actorOwner.GetFactionReaction(akPlayer) > enemyReaction)
			return true
		Else
			Faction factionOwner = akBed.GetFactionOwner()
			If (factionOwner && factionOwner.GetFactionReaction(akPlayer) > enemyReaction)
				return true
			Else
				return false
			EndIf
		EndIf
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Saving
	Saving:System Property System Auto Const Mandatory
EndGroup

Group Properties
	Perk Property Fallout_Saving_BedPerk Auto Const Mandatory

	Message Property Fallout_Saving_MessageCantSaveOwnership Auto Const Mandatory
	{You cannot save with an unowned bed.}
EndGroup
