Scriptname Fallout:Saving:BedPerk extends Perk
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = "GameSave"
EndEvent


Event OnEntryRun(int auiEntryID, ObjectReference akBed, Actor akPlayer)
	WriteLine(Log, "The Perk " + self + " on " + akPlayer + " ran entry " + auiEntryID + " on target " + akBed)

	If (akPlayer.IsInCombat())
		Fallout_SavingMsgCantSaveCombat.Show()
		WriteLine(Log, "Cannot save the game while in combat.")
	Else
		If (HasOwnership(akPlayer, akBed))
			Game.RequestSave()
			Fallout_SavingMsgSaved.Show()
			WriteLine(Log, "The game has been saved.")
		Else
			Fallout_SavingMsgCantSaveOwnership.Show()
			WriteLine(Log, "The bed does not meet ownership requirements for a game save.")
		EndIf
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

Group Messages
	Message Property Fallout_SavingMsgSaved Auto Const Mandatory
	{Saving..}

	Message Property Fallout_SavingMsgCantSaveOwnership Auto Const Mandatory
	{You cannot save with an unowned bed.}

	Message Property Fallout_SavingMsgCantSaveCombat Auto Const Mandatory
	{You cannot save while in combat.}
EndGroup
