function toggleFactBit(factID, bit)
	local factStatus = cfa.w8.factGetState(951)
	local isBitSet = cfa.util.getBit(factStatus, bit)
	if isBitSet == true then
		cfa.w8.factModifyState(factID, bit, cfa.operation.clearBit)
	else
		cfa.w8.factModifyState(factID, bit, cfa.operation.setBit)
	end
end


function MysterySwitchLogic(trigName)

	-- ############################################################################
	-- Here is a made-up case which can serve as the example of using a single Fact to keep a state
	-- of up to 8 different and potentially independent events (flags)
	-- ############################################################################

	-- Every 'Energy Node' can be clicked and it turns it on or off
	-- The code make sure to alternate the certain bit in the Fact 951 between 0 or 1
	-- Note how the helper function 'toggleFactBit' is used (see it above) in order to reuse the code and make it more clear.
	-- Note that each node corresponds to a distinguished bit so not to mess with the other nodes.
	-- Note that nodes are also located in different Locations, so we can't use a Location Variable and have to use Fact
	if cfa.w8.locationGetCurrentID() == 2 then
		if trigName == 'energyNodeRed' then
			toggleFactBit(951, 0)
		end
		if trigName == 'energyNodeOrange' then
			toggleFactBit(951, 1)
		end
	end

	if cfa.w8.locationGetCurrentID() == 32 then
		if trigName == 'energyNodeYellow' then
			toggleFactBit(951, 2)
		end
		if trigName == 'energyNodeGreen' then
			toggleFactBit(951, 3)
		end
	end

	if cfa.w8.locationGetCurrentID() == 17 then
		if trigName == 'energyNodeBlue' then
			toggleFactBit(951, 4)
		end
		if trigName == 'energyNodeIndigo' then
			toggleFactBit(951, 5)
		end
	end

	if cfa.w8.locationGetCurrentID() == 40 then
		if trigName == 'energyNodeViolet' then
			toggleFactBit(951, 6)
		end
	end

	if cfa.w8.locationGetCurrentID() == 5 then
		if trigName == 'energyNodeWhite' then
			toggleFactBit(951, 7)
		end
	end

	-- Now here you can asses the status of the bits in Fact 951 to determine which nodes are active and which are not
	if cfa.w8.locationGetCurrentID() == 9 then
		if trigName == 'mysterySwitch'then

			-- if 'switch broken' location variable is not zero then prevent trigger's activation - it is no longer functional
			if cfa.w8.locationGetVariableValue("varMysterySwitchBroken") ~= 0 then
				return cfa.result.cancel
			end

			local factStatus = cfa.w8.factGetState(951)

			-- Increase all Party members' 'Dexterity' attribute  by 5 if Green, Orange and Indigo are all set (regardless of the state of other nodes)
			local mask = 0
			mask = cfa.util.setBit(mask, 3) -- Green bit
			mask = cfa.util.setBit(mask, 1) -- Orange bit
			mask = cfa.util.setBit(mask, 5) -- Indigo bit
			if cfa.util.hasAllBitsSet(factStatus, mask) then
				cfa.w8.partyModifyAttribute(cfa.attr.dexterity, 5)
				return cfa.result.ok -- We don't want anything else to happen when this condition is satisfied, so return from the function
			end

			-- Teleport Party to the secret Location when only 'White' node is activated and others are deactivated
			mask = cfa.util.setBit(0, 7) -- White bit
			if factStatus == mask then
				cfa.w8.locationActivateTrigger("BLA36") -- Assuming "BLA36" is the teleporter trigger which teleports to the fabled secret location
				return cfa.result.ok -- We don't want anything else to happen when this condition is satisfied, so return from the function
			end

			-- Punish Party for switching on ALL nodes and overloading the mechanism!
			local mask = 0
			mask = cfa.util.setBit(mask, 0)
			mask = cfa.util.setBit(mask, 1)
			mask = cfa.util.setBit(mask, 2)
			mask = cfa.util.setBit(mask, 3)
			mask = cfa.util.setBit(mask, 4)
			mask = cfa.util.setBit(mask, 5)
			mask = cfa.util.setBit(mask, 6)
			mask = cfa.util.setBit(mask, 7)
			if cfa.util.hasAllBitsSet(factStatus, mask) then
				cfa.w8.locationActivateTrigger("BIG_ZAP")
				cfa.w8.locationModifyVariableValue("varMysterySwitchBroken", 1, cfa.operation.setValue) -- mark the Mystery Switch as broken!
				return cfa.result.ok -- We don't want anything else to happen when this condition is satisfied, so return from the function
			end

		end
	end

	return cfa.result.ok -- by default allow activation of the Triggers
end

