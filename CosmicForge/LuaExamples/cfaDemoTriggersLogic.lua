function onTriggerActivatedCheckIfDemoTrigger(trigName)
	if(trigName == "DEMO1") then

		-- Get some random characters here. It does nothing, just prints results in the cfagent.log
		for counter = 1, 30, 1 do
			cfa.util.logMessage("random female character: %i \n", cfa.w8.partyGetRandomCharacter(cfa.gender.female))
		end
		for counter = 1, 30, 1 do
			cfa.util.logMessage("random male character (except 2nd): %i \n", cfa.w8.partyGetRandomCharacter(cfa.gender.male, 2))
		end
		for counter = 1, 30, 1 do
			cfa.util.logMessage("random character: %i \n", cfa.w8.partyGetRandomCharacter(cfa.gender.any))
		end

		-- Remove hex, missing & enthrallment conditions from characters 5, 4 & 3 respectively
		cfa.w8.characterRemoveCondition(5, cfa.condition.hex,			true)
		cfa.w8.characterRemoveCondition(4, cfa.condition.missing,		true)
		cfa.w8.characterRemoveCondition(3, cfa.condition.enthrallment,	true)
	end

	if(trigName == "DEMO2") then
		-- Add hex, missing & enthrallment conditions to characters 5, 4 & 3 respectively for 10 minutes
		-- Note that certain conditions are 'permanent' until removed: f.e. missing, enthrallment.
		cfa.w8.characterAddCondition(5, cfa.condition.hex,			10, 0, true)
		cfa.w8.characterAddCondition(4, cfa.condition.missing,		10, 0, true)
		cfa.w8.characterAddCondition(3, cfa.condition.enthrallment,	10, 0, true)

		-- Paralyze 6th character for 2 minutes
		cfa.w8.characterAddCondition(6, cfa.condition.paralyze, 	2, 0, true)
		-- Put 7th character asleep for 4 minutes
		cfa.w8.characterAddCondition(7, cfa.condition.sleep,		4, 0, true)
		-- Poison 2nd character for 3 minutes with strength 1
		cfa.w8.characterAddCondition(2, cfa.condition.poison,		3, 1, true)
	end

	-- See if we can figure out if party has certain items
	if(trigName == "DEMO3") then
		-- If party has 'faerie stick' ANYWHERE
		if cfa.w8.partyHasItem(63, true, true, true, true) == true then
			cfa.util.showMessageInGame("Party has 'faerie stick' item in either party items or backpacks or equipped") -- Show message in game
		end
		-- If party has 'faerie stick' equipped
		if cfa.w8.partyHasItem(63, true, false, false, false) == true then
			cfa.util.showMessageInGame("Party has 'faerie stick' item equipped.") -- Show message in game
		end
		-- If party has 'faerie stick' NOT equipped
		if cfa.w8.partyHasItem(63, false, true, true, true) == true then
			cfa.util.showMessageInGame("Party has 'faerie stick' item in party items or backpacks.") -- Show message in game
		end
		-- If 7th character has 'faerie stick' equipped or in the backpack
		if (cfa.w8.characterHasItemEquipped(7, 63) == true) or (cfa.w8.characterHasItemInBackpack(7, 63) == true) then
			cfa.util.showMessageInGame("Char 7 has 'faerie stick' equipped or in the backpack.") -- Show message in game
		end
	end

	if(trigName == "DEMO4") then
		cfa.w8.partyAddItem(336, true, false, true)	-- Add identified 'mod heal' to party, don't show message, stack items if possible
		cfa.w8.partyAddItem(337, true, true, false)		-- Add 'hv. heal' to party, show message, don't stack items if possible
		cfa.w8.partyAddItem(338, true, false, false)	-- Add 'superman' to party, don't show message, don't stack items if possible


		if cfa.w8.characterAddItem(3, 215, false, true, true, false) == false then	-- Add unidentified 'Leather Helm' to the 3rd character, equip if possible, show message of taking item
			cfa.w8.partyAddItem(215, false, true, true)							-- If failed (no space in backpack) then add it to the party
		end
		if cfa.w8.characterAddItem(4, 335, true, false, true, true) == false then	-- Add identified 'Potion of Light Heal' to the 4th character, show message of taking item, stack if possible
			cfa.w8.partyAddItem(335, true, true, true)							-- If failed (no space in backpack) then add it to the party
		end
		if cfa.w8.characterAddItem(4, 336, true, false, true, false) == false then	-- Add identified 'Potion of Moderate Heal' to the 4th character, show message of taking item, don't stack
			cfa.w8.partyAddItem(336, true, true, true)							-- If failed (no space in backpack) then add it to the party
		end
	end

	if(trigName == "DEMO5") then
		local isCritical = cfa.w8.itemGetProperty(16, cfa.itemprop.isCritical)
		local isCursed = cfa.w8.itemGetProperty(16, cfa.itemprop.isCursed)
		local name = cfa.w8.itemGetProperty(16, cfa.itemprop.name)
		local price = cfa.w8.itemGetProperty(16, cfa.itemprop.price)
		local spell = cfa.w8.itemGetProperty(16, cfa.itemprop.spell)
		local itemType = cfa.w8.itemGetProperty(16, cfa.itemprop.type)
		cfa.util.showMessageInGame("'%s', cost: %i, spell: %i, type: %i, crit: %s, cursed: %s", name, price, spell, itemType, isCritical, isCursed)
	end

	if(trigName == "DEMO6") then
		local partyItem2 = cfa.w8.partyGetItem(-1, cfa.itemslotgroup.party, 2)
		local partyItem10 = cfa.w8.partyGetItem(-1, cfa.itemslotgroup.party, 10)
		local char7BackpackItem0 = cfa.w8.partyGetItem(7, cfa.itemslotgroup.backpack, 0)
		local char3EquippedItem4 = cfa.w8.partyGetItem(3, cfa.itemslotgroup.equipment, 4)
		cfa.util.showMessageInGame("party item 2 is '%s' (%i)", cfa.w8.itemGetProperty(partyItem2, cfa.itemprop.name), partyItem2)
		cfa.util.showMessageInGame("party item 10 is '%s' (%i)", cfa.w8.itemGetProperty(partyItem10, cfa.itemprop.name), partyItem10)
		cfa.util.showMessageInGame("char 7 backpack item 0 is '%s' (%i)", cfa.w8.itemGetProperty(char7BackpackItem0, cfa.itemprop.name), char7BackpackItem0)
		cfa.util.showMessageInGame("char 3 equipped item 4 is '%s' (%i)", cfa.w8.itemGetProperty(char3EquippedItem4, cfa.itemprop.name), char3EquippedItem4)
	end

	if(trigName == "DEMO7") then

		-- Look for 'Cure Light Condition Potion' in the Party items only
		cfa.util.logMessage("Look for item '%s'\n", cfa.w8.itemGetProperty(347, cfa.itemprop.name))
		local charIndex, itemSlotGroup, itemSlotIndex = cfa.w8.partyFindItem(347, false, false, true, false)
		if itemSlotIndex == -1 then
			cfa.util.showMessageInGame("No '%s' in party items.", cfa.w8.itemGetProperty(347, cfa.itemprop.name))
		else
			cfa.util.showMessageInGame("'%s' is at position %i in party items.", cfa.w8.itemGetProperty(347, cfa.itemprop.name), itemSlotIndex)
		end

		-- Look for 'Light Heal Potion' in the characters' backpacks only
		cfa.util.logMessage("Look for item '%s'\n", cfa.w8.itemGetProperty(335, cfa.itemprop.name))
		charIndex, itemSlotGroup, itemSlotIndex = cfa.w8.partyFindItem(335, false, true, false, false)
		if charIndex == -1 then
			cfa.util.showMessageInGame("No '%s' in characters' backpacks.", cfa.w8.itemGetProperty(335, cfa.itemprop.name))
		else
			cfa.util.showMessageInGame("'%s' is in the character %i's backpack at position %i.", cfa.w8.itemGetProperty(335, cfa.itemprop.name), charIndex, itemSlotIndex)
		end

		-- Look for 'Faerie Stick' everywhere (party items, backpacks, equipped items and cursor)
		cfa.util.logMessage("Look for item '%s'\n", cfa.w8.itemGetProperty(63, cfa.itemprop.name))
		charIndex, itemSlotGroup, itemSlotIndex = cfa.w8.partyFindItem(63, true, true, true, true)
		if itemSlotIndex == -1 then
			cfa.util.showMessageInGame("No '%s' posessed by the party.", cfa.w8.itemGetProperty(63, cfa.itemprop.name))
		elseif itemSlotGroup == cfa.itemslotgroup.backpack then
			cfa.util.showMessageInGame("'%s' is in the character %i's backpack at position %i.", cfa.w8.itemGetProperty(63, cfa.itemprop.name), charIndex, itemSlotIndex)
		elseif itemSlotGroup == cfa.itemslotgroup.equipment then
			cfa.util.showMessageInGame("'%s' is equipped by the character %i at position %i.", cfa.w8.itemGetProperty(63, cfa.itemprop.name), charIndex, itemSlotIndex)
		elseif itemSlotGroup == cfa.itemslotgroup.party then
			cfa.util.showMessageInGame("'%s' is at position %i in party items.", cfa.w8.itemGetProperty(63, cfa.itemprop.name), itemSlotIndex)
		elseif itemSlotGroup == cfa.itemslotgroup.cursor then
			cfa.util.showMessageInGame("'%s' is in the cursor.", cfa.w8.itemGetProperty(63, cfa.itemprop.name))
		end

	end

	if(trigName == "DEMO8") then
		cfa.w8.locationModifyVariableValue("BurzNotHappyVar", 1, cfa.operation.setValue)
	end

	if(trigName == "DEMO9") then
		cfa.w8.partyAffectBySpell(46, 2)	-- Cast 'silence' spell with power 2 on the Party
		return cfa.result.cancel	-- Prevent the trigger from execution
	end

	-- Spawn two neutral 'Madras' monsters at NPP "mine"
	if(trigName == "DEMO10") then
		cfa.w8.locationSpawnMonsters(206, 2, cfa.disposition.neutral, "mine")
		return cfa.result.cancel	-- Prevent the trigger from execution
	end

	-- Spawn 'Strings of Seduction' with 50% chance at NPP "mine1"
	if(trigName == "DEMO11") then
		cfa.w8.locationSpawnItem(397, true, 50, "mine1")
		return cfa.result.cancel	-- Prevent the trigger from execution
	end

	-- Enable monster generator "crabsgen"
	if(trigName == "DEMO12") then
		cfa.w8.locationEnableMonGen("crabsgen", true)
	end

	-- Activate monster generator "crabsgen" every time this trigger is activated, as the result the generator produces monsters :)
	if(trigName == "DEMO13") then
		cfa.w8.locationActivateMonGen("crabsgen")
	end


	-- Random character says "Need rest" quote
	if(trigName == "DEMO30") then
		cfa.w8.partySayQuote(4, -1);
	end

	return cfa.result.ok
end
