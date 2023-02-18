

-- Called whenever a Trigger is about to be launched/executed. trigName is Uppercased!
-- Return cfa.result.ok to allow the Trigger to be activated normally.
-- Return cfa.result.cancel to prevent the Trigger's activation.
function onLocationTriggerActivated(trigName, trigType)

	return cfa.result.ok -- by default allow activation of the Triggers

end


-- Called whenever an NPC script command is about to be executed. scriptFlag1 or scriptFlag2 might point if it is NPC,RPC or VOC script!
-- Return cfa.result.ok to allow the Command to execute normally.
-- Return cfa.result.cancel to suppress the Command's execution.
-- Return non-negative number (zero or positive number) to suppress the Command's execution and perform Unconditional Jump to another Script Block.
function onNPCScriptCommandExecuted(cmdType, NPCID, scriptBlock, commandIndex, scriptBlockPrev, scriptFlag1, scriptFlag2)

	-- Return cfa.result.ok by default which means that everything is executed normally.
	-- Returning any other number (>=0) will treat this command as 'Unconditional Jump' jumpting to the Script Block indicated by the returned number.
	return cfa.result.ok

end

-- Called whenever a Fact state is being changed
function onFactStateModified(factID, newState)


end

-- Called whenever an Item is acquired by Party or its members
function onItemAcquired(itemID)


end

-- Called whenever an Item is used or attempted to be used
-- Return cfa.result.ok to allow the Item to be used normally.
-- Return cfa.result.cancel to prevent the Item's use.
function onItemUsed(itemID, characterIndex, itemSlotGroup, itemSlotIndex)

	return cfa.result.ok -- by default allow game code to proceed using the item, returning cfa.result.cancel for an item will effectively cancel its conventional usage

end

-- Called whenever an Item is picked up at a Location
function onItemPickedUp(itemID)


end

-- Called whenever a Combat has started
function onCombatStarted()


end


-- Called whenever a Monster Generator spawns a group of Monsters
function onMonGenActivated(monGenName)


end


-- Called whenever a Monster is killed in the Game
function onMonsterKilled(monsterID)


end

-- Called whenever a Location is loaded (loading the saved game, through the teleporter, etc.)
function onLocationLoaded()


end

-- Called whenever a Location is about to load or a Location property is about to be fetched
-- Can be used to substitute one Location by another if certain conditions are met (like "Wilderness Clearing (Rapax Camp)" and "Wilderness Clearing").
-- Note that the original game code that processes Locations 16 and 38 will be run after this handler!
function onProcessLocationID(locationID)

	-- By default return the same Location ID - this way we don't change anything
	return locationID

end
