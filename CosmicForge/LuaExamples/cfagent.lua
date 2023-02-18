
-- Include any additiona lua files containing mode code to avoid having a single huge lua file which is hard to read
cfa.util.includeLuaFile("cfaArnikaTriggerActivation.lua")
cfa.util.includeLuaFile("cfaLMTriggerActivation.lua")
cfa.util.includeLuaFile("cfaMysterySwitchLogic.lua")
cfa.util.includeLuaFile("cfaDemoTriggersLogic.lua")


-- Called whenever a Trigger is about to be launched/executed. trigName is Uppercased!
-- Return cfa.result.ok to allow the Trigger to be activated normally.
-- Return cfa.result.cancel to prevent the Trigger's activation.
function onLocationTriggerActivated(trigName, trigType)

	-- Print some info into the agent log if we like
	cfa.util.logMessage("#onLocationTriggerActivated name:'%s', type:%i, location:%i\n", trigName, trigType, cfa.w8.locationGetCurrentID())

	-- More demos for recent functions
	if cfa.w8.locationGetCurrentID() == 8 then
		if onTriggerActivatedCheckIfDemoTrigger(trigName) == cfa.result.cancel then
			return cfa.result.cancel -- If function decided to prevent the Trigger's activation then return cfa.result.cancel immediately
		end
	end

	-- Separate function for processing triggers in Lower Monastery. It resides in a separate file and make the code cleaner.
	-- Contains a set of examples on different functions
	if cfa.w8.locationGetCurrentID() == 8 then
		if onLocationTriggerActivatedAtLM(trigName) == cfa.result.cancel then
			return cfa.result.cancel -- If function decided to prevent the Trigger's activation then return cfa.result.cancel immediately
		end
	end

	-- Separate function for processing triggers in Arnika. It resides in a separate file and make the code cleaner.
	-- Contains a set of examples on different functions
	-- Note: we should compare with Location ID 1 (Arnika), but since I'm testing at Lower Monastery only, then I commented the line out and added a line using ID 8 instead!
--	if cfa.w8.locationGetCurrentID() == 1
	if cfa.w8.locationGetCurrentID() == 8 then
		if onLocationTriggerActivatedAtArnika(trigName) == cfa.result.cancel then
			return cfa.result.cancel -- If function decided to prevent the Trigger's activation then return cfa.result.cancel immediately
		end
	end

	-- Processing of a complicated code for the 'mystery switch'. It resides in a separate file and make the code cleaner.
	-- Contains some examples of using bit-wise operations
	-- Contains example of using a single Fact to keep information on several independent events from different Locatons.
	if MysterySwitchLogic(trigName) == cfa.result.cancel then
		return cfa.result.cancel -- If function decided to prevent the Trigger's activation then return cfa.result.cancel immediately
	end

	-- Demonstrating selective teleport trigger dependent on the location variable
	if trigName == "MO103" then

		local telepTarget = "ARN13" -- default teleport destination in Arnika
		local telepTargetVal = cfa.w8.locationGetVariableValue("teleportTarget")
		if telepTargetVal == 1 then telepTarget = "MNT02" end
		if telepTargetVal == 2 then telepTarget = "MG102" end
		if telepTargetVal == 3 then telepTarget = "RAM08" end
		if telepTargetVal == 4 then telepTarget = "CT303" end
		if telepTargetVal == 5 then telepTarget = "CT611" end
		if telepTargetVal == 6 then telepTarget = "CNR01" end
		if telepTargetVal == 7 then telepTarget = "SWM04" end
		if telepTargetVal == 8 then telepTarget = "SC101" end

		-- Change the destination accordingly
		cfa.w8.locationSetTriggerTeleportDestination(trigName, telepTarget)

	end

	-- This trigger sycles variable value from 0 to 8, then 0 again and so on
	if trigName == "TELEPORTSWITCH" then

		local telepTargetVal = cfa.w8.locationGetVariableValue("teleportTarget")
		telepTargetVal = telepTargetVal + 1
		if telepTargetVal > 8 then telepTargetVal = 0 end
		cfa.w8.locationModifyVariableValue("teleportTarget", telepTargetVal, cfa.operation.setValue)

	end


	return cfa.result.ok -- by default allow activation of the Triggers

end


-- Called whenever an NPC script command is about to be executed. scriptFlag1 or scriptFlag2 might point if it is NPC,RPC or VOC script!
-- Return cfa.result.ok to allow the Command to execute normally.
-- Return cfa.result.cancel to suppress the Command's execution.
-- Return non-negative number (zero or positive number) to suppress the Command's execution and perform Unconditional Jump to another Script Block.
function onNPCScriptCommandExecuted(cmdType, NPCID, scriptBlock, commandIndex, scriptBlockPrev, scriptFlag1, scriptFlag2)

	cfa.util.logMessage("#onNPCScriptCommandExecuted NPC:'%s' (%i), command %i in block %i of type '%s'. Prev block %i, flags: %i / %i \n",
		cfa.w8.npcGetName(NPCID), NPCID, commandIndex, scriptBlock, cmdType, scriptBlockPrev, scriptFlag1, scriptFlag2)

	-- While talking to Burz, on a certain command, instead of executing it, we jump to the Script Block 23 if certain Location Variable is set to 1
	if NPCID == 80 and scriptBlock == 1 and commandIndex == 0 then
		if cfa.w8.locationGetVariableValue("BurzNotHappyVar") == 1 then
			return 23
		end

		return cfa.result.cancel -- This command there is for the sole purpose of jump when we need it. Returning cfa.result.cancel here will suppress it.
	end

	-- Return cfa.result.ok by default which means that everything is executed normally.
	-- Returning any other number (>=0) will treat this command as 'Unconditional Jump' jumpting to the Script Block indicated by the returned number.
	return cfa.result.ok

end

-- Called whenever a Fact state is being changed
function onFactStateModified(factID, newState)

	cfa.util.logMessage("#onFactStateModified Fact: '%s' (%i), new state: %i\n", cfa.w8.factGetName(factID), factID, newState)

end

-- Called whenever an Item is acquired by Party or its members
function onItemAcquired(itemID)

	cfa.util.logMessage("#onItemAcquired Item: '%s' (%i)\n", cfa.w8.itemGetProperty(itemID, cfa.itemprop.name), itemID)

end

-- helper function to print friendly name for the item slot group, purely for debug and demo purposes
function getItemSlotGroupName(slot)

	if slot == cfa.itemslotgroup.backpack then
		return "backpack"
	elseif slot == cfa.itemslotgroup.equipment then
		return "equipment"
	elseif slot == cfa.itemslotgroup.party then
		return "party"
	elseif slot == cfa.itemslotgroup.cursor then
		return "cursor"
	end

	return "<unknown>" -- This should never happen!

end


-- Called whenever an Item is used or attempted to be used
-- Return cfa.result.ok to allow the Item to be used normally.
-- Return cfa.result.cancel to prevent the Item's use.
function onItemUsed(itemID, characterIndex, itemSlotGroup, itemSlotIndex)

	-- Log the event in cfagent.log file
	cfa.util.logMessage("#onItemUsed Item: '%s' (%i) by character %i, slot group: '%s' (%i), slot index: %i \n", cfa.w8.itemGetProperty(itemID, cfa.itemprop.name), itemID, characterIndex, getItemSlotGroupName(itemSlotGroup), itemSlotGroup, itemSlotIndex)
	-- Show message in game
	cfa.util.showMessageInGame("Char %i Used '%s' (%i) from '%s', slot %i", characterIndex, cfa.w8.itemGetProperty(itemID, cfa.itemprop.name), itemID, getItemSlotGroupName(itemSlotGroup), itemSlotIndex)

	-- When a character is using a faerie stick then increase his/her strength by 1.
	if itemID == 63 then
		cfa.w8.characterModifyAttribute(characterIndex, cfa.attr.strength, 1)
		-- Play sound too!
		cfa.w8.gamePlaySound("Data\\Sound\\misc\\fountain_magic.wav")

		-- 'Use' item (remove it)
		cfa.w8.partyRemoveItem(characterIndex, itemSlotGroup, itemSlotIndex)

		-- We have called 'remove item' for this item, so to prevent glitches return cfa.result.cancel here
		return cfa.result.cancel -- prohibit the game code to 'use' the item
	end

	-- Prohibit the use of 'Light Heal Potion' from 12:00 till 22:00 (excluding). The game will do nothing when you try to use it during these hours.
	if itemID == 335 then

		local gameHour = cfa.w8.gameGetHour()
		if gameHour >= 12 and gameHour < 22 then
			cfa.util.showMessageInGame("Sorry, usage of '%s' is blocked by lua script!", cfa.w8.itemGetProperty(itemID, cfa.itemprop.name)) -- Show message in game
			return cfa.result.cancel -- prohibit the game code to 'use' the item
		end

	end

	-- Prohibit usage, but remove the item
	if itemID == 346 then

		cfa.w8.partyRemoveItem(characterIndex, itemSlotGroup, itemSlotIndex)
		return cfa.result.cancel

	end

	return cfa.result.ok -- by default allow game code to proceed using the item, returning cfa.result.cancel for an item will effectively cancel its conventional usage
end

-- Called whenever an Item is picked up at a Location
function onItemPickedUp(itemID)

	cfa.util.logMessage("#onItemPickedUp Item: '%s' (%i)\n", cfa.w8.itemGetProperty(itemID, cfa.itemprop.name), itemID)

end

-- Called whenever a Combat has started
function onCombatStarted()

	cfa.util.logMessage("#onCombatStarted at day %i, %.2i:%.2i\n", cfa.w8.gameGetDay(), cfa.w8.gameGetHour(), cfa.w8.gameGetMinute())

	-- make sure everybody is afraid to fight for two rounds in Lower Monastery :)
	if cfa.w8.locationGetCurrentID() == 8 then
		cfa.w8.characterAddCondition(0, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(1, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(2, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(3, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(4, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(5, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(6, cfa.condition.fear, 2, 0, true)
		cfa.w8.characterAddCondition(7, cfa.condition.fear, 2, 0, true)
	end

	-- In the beginning of EVERY comabat Cast 'body of stone' spell with power 1 on every character which has 'Faerie Stick' equipped
	for charIndex = 0, 7 do
		if cfa.w8.characterHasItemEquipped(charIndex, 63) == true then
			cfa.w8.characterAffectBySpell(charIndex, 65, 1)	-- Cast 'body of stone' spell with power 1 on every character which has 'Faerie Stick' equipped
		end
	end

end

-- Called whenever a Monster Generator spawns a group of Monsters
function onMonGenActivated(monGenName)

	cfa.util.logMessage("#onMonGenActivated '%s' at day %i, %.2i:%.2i\n", monGenName, cfa.w8.gameGetDay(), cfa.w8.gameGetHour(), cfa.w8.gameGetMinute())
	cfa.util.showMessageInGame("#onMonGenActivated '%s' at day %i, %.2i:%.2i\n", monGenName, cfa.w8.gameGetDay(), cfa.w8.gameGetHour(), cfa.w8.gameGetMinute())

end

-- Called whenever a Monster is killed in the Game
function onMonsterKilled(monsterID)

	cfa.util.logMessage("onMonsterKilled '%s' (%i), type %i, level %i, faction %i \n",
		cfa.w8.monsterGetProperty(monsterID, cfa.monsterprop.name),
		monsterID,
		cfa.w8.monsterGetProperty(monsterID, cfa.monsterprop.type),
		cfa.w8.monsterGetProperty(monsterID, cfa.monsterprop.level),
		cfa.w8.monsterGetProperty(monsterID, cfa.monsterprop.faction))

end

-- Called whenever a Location is loaded (loading the saved game, through the teleporter, etc.)
function onLocationLoaded()

	cfa.util.logMessage("onLocationLoaded ID=%i\n", cfa.w8.locationGetCurrentID())

	cfa.w8.partyAffectBySpell(68, 1)	-- Cast 'Heal All' on the party when loading a Location just for the hell of it

	-- Example of use of characterGetProperty() function
	cfa.util.showMessageInGame("short name is %s", cfa.w8.characterGetProperty(2, cfa.charprop.shortName, 0))
	cfa.util.showMessageInGame("name is %s", cfa.w8.characterGetProperty(2, cfa.charprop.name, 0))

	cfa.util.showMessageInGame("strength is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.strength),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.strength),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.strength),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.strength),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.strength))
	cfa.util.showMessageInGame("intelligence is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.intelligence),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.intelligence),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.intelligence),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.intelligence),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.intelligence))
	cfa.util.showMessageInGame("piety is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.piety),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.piety),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.piety),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.piety),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.piety))
	cfa.util.showMessageInGame("vitality is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.vitality),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.vitality),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.vitality),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.vitality),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.vitality))
	cfa.util.showMessageInGame("dexterity is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.dexterity),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.dexterity),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.dexterity),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.dexterity),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.dexterity))
	cfa.util.showMessageInGame("speed is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.speed),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.speed),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.speed),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.speed),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.speed))
	cfa.util.showMessageInGame("senses is %i/%i/%i/%i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.attribute_base, cfa.attr.senses),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_final, cfa.attr.senses),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_1, cfa.attr.senses),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_2, cfa.attr.senses),
															 cfa.w8.characterGetProperty(2, cfa.charprop.attribute_3, cfa.attr.senses))

	cfa.util.showMessageInGame("gender is %i", cfa.w8.characterGetProperty(2, cfa.charprop.gender, 0))
	cfa.util.showMessageInGame("profession is %i", cfa.w8.characterGetProperty(2, cfa.charprop.profession, 0))
	cfa.util.showMessageInGame("encumbrance is %i", cfa.w8.characterGetProperty(2, cfa.charprop.encumbrance, 0))

	cfa.util.showMessageInGame("fire sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.fire), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.fire))
	cfa.util.showMessageInGame("water sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.water), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.water))
	cfa.util.showMessageInGame("air sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.air), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.air))
	cfa.util.showMessageInGame("earth sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.earth), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.earth))
	cfa.util.showMessageInGame("mental sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.mental), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.mental))
	cfa.util.showMessageInGame("divine sp is %i/%i", cfa.w8.characterGetProperty(2, cfa.charprop.spMax, cfa.spellsphere.divine), cfa.w8.characterGetProperty(2, cfa.charprop.spCurrent, cfa.spellsphere.divine))

	cfa.util.showMessageInGame("communic base skill is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.communication))
	cfa.util.showMessageInGame("divinity base skill is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.divinity))
	cfa.util.showMessageInGame("mental magic base skill is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.mentalMagic))
	cfa.util.showMessageInGame("divine magic base skill is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.divineMagic))
	cfa.util.showMessageInGame("mace skill base is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.maceAndFlail))
	cfa.util.showMessageInGame("staff skill base is %i", cfa.w8.characterGetProperty(2, cfa.charprop.skill_base, cfa.skill.staffAndWand))

	cfa.util.showMessageInGame("stamina max is %i", cfa.w8.characterGetProperty(2, cfa.charprop.staminaMax, 0))
	
	-- Print all items Burz has in his inventory into the log file
	for itemID = 0, 818, 1 do
		if cfa.w8.npcHasItemInTradeInventory(80, itemID) then
			cfa.util.logMessage("%s has '%s'\n", cfa.w8.npcGetName(80), cfa.w8.itemGetProperty(itemID, cfa.itemprop.name))
		end
	end

end


-- Called whenever a Location is about to load or a Location property is about to be fetched
-- Can be used to substitute one Location by another if certain conditions are met (like "Wilderness Clearing (Rapax Camp)" and "Wilderness Clearing").
-- Note that the original game code that processes Locations 16 and 38 will be run after this handler!
function onProcessLocationID(locationID)

	cfa.util.logMessage("onProcessLocationID ID=%i\n", locationID)

	-- As an example this makes it impossible to get to Mountain Wilderness - instead you'll go to Northern Wilderness all the time
	if locationID == 31 then
		locationID = 32
	end

	-- By default return the same Location ID - this way we don't change anything
	return locationID

end