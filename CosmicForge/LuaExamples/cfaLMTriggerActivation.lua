function onLocationTriggerActivatedAtLM(trigName)

	-- Query the current state of a Location Variable and a Fact
	local canOpenDoorValueBefore = cfa.w8.locationGetVariableValue("CanOpenDoor")
	local fact150ValueBefore = cfa.w8.factGetState(150)

	-- Trigger 'affectchar' increases the second's char's Piety and the Fifth's char's 'Polearm' skill
	if trigName == 'AFFECTCHAR' then
		cfa.w8.characterModifyAttribute(2, cfa.attr.piety, 1)
		cfa.w8.characterModifySkill(5, cfa.skill.polearm, 10, false)

		return cfa.result.ok
	end

	-- Some examples when 'mine' trigger is triggered
	if trigName == 'MINE' then

		-- example of using game day/time functions
		cfa.util.logMessage("Trigger 'mine' is activated at day %i, %.2i:%.2i\n", cfa.w8.gameGetDay(), cfa.w8.gameGetHour(), cfa.w8.gameGetMinute())

		-- Display string "Rocket Launcher" 16 times with 16 different colors
		for color = cfa.color.red, cfa.color.white, 1 do
			cfa.w8.gamePrintInterfaceStringInGeneralTextArea(1252, color)
		end

		-- Only allow the 'mine' Trigger to be activated when 'testvar' variable is equal to 17
		if cfa.w8.locationGetVariableValue("testvar") == 17 then
			return cfa.result.ok -- allow activation of the Trigger
		else
			return cfa.result.cancel -- prohibit activation of the Trigger
		end

	end

	-- 'starter chest' will change the Fact and Location Variable if at Lower Monsatery as well as doing some other stuff
	if trigName == ' ' then
		cfa.w8.factModifyState(150, 1, cfa.operation.increaseByValue)
		cfa.w8.locationModifyVariableValue("CanOpenDoor", 1, cfa.operation.increaseByValue)

		-- add 3 'Canes of Corpus' to Burz's inventory immediately :))
		cfa.w8.npcAddItemToTradeInventory(80, 29, 3, 0)

		-- add random item from the 'HLL Locker' Loot to Party, show message and stack items if possible
--		cfa.w8.partyAddItem(cfa.w8.lootGetRandomItem(12), true, true, true)

		-- increase Vitality by 1
		cfa.w8.partyModifyAttribute(cfa.attr.vitality, 1)
		-- decrease Senses by 2
		cfa.w8.partyModifyAttribute(cfa.attr.senses, -2)

		-- add unidentified 'Ankh of Dexterity' to Party, show message and don't stack items (its ankh - unstackable anyway)
		cfa.w8.partyAddItem(274, false, true, false)

		return cfa.result.ok
	end

	-- Some logic - custom object with a trigger will change the Fact and Location Variable if at Lower Monsatery
	if trigName == 'DOOR_LOCKER' then
		cfa.w8.factModifyState(150, 1, cfa.operation.decreaseByValue)
		cfa.w8.locationModifyVariableValue("CanOpenDoor", 1, cfa.operation.decreaseByValue)

		-- increase Psionics by 2
		cfa.w8.partyModifySkill(cfa.skill.psionics, 2, false)
		-- decrease Sword by 1
		cfa.w8.partyModifySkill(cfa.skill.sword, -1, false)

		-- add identified 'Medicine Bag' to Party, show message and stack items if possible
		cfa.w8.partyAddItem(304, true, true, true)

		cfa.w8.locationActivateTrigger("trigger7602")

		return cfa.result.ok
	end

	-- Query the state of a Location Variable and a Fact after out logic
	local canOpenDoorValueAfter = cfa.w8.locationGetVariableValue("CanOpenDoor")
	local fact150ValueAfter = cfa.w8.factGetState(150)

	-- See if location variable has been changed and print about it
	if canOpenDoorValueBefore ~= canOpenDoorValueAfter then
		cfa.util.logMessage("'CanOpenDoor': %i -> %i\n", canOpenDoorValueBefore, canOpenDoorValueAfter)
	end

	-- See if fact150 has been changed and print about it
	if fact150ValueBefore ~= fact150ValueAfter then
		cfa.util.logMessage("'fact150': %i -> %i\n", fact150ValueBefore, fact150ValueAfter)
	end


	return cfa.result.ok -- by default allow activation of the Triggers
end
