
local long_range_flag = true	-- This variable will help alternating the missile distance and Burz facing
local location_message = 0	-- This varialbe will help to run through all Location messages

function onLocationTriggerActivatedAtArnika(trigName)

	-- Some logic for test button
	if trigName == 'TEST_BUTTON' then
		-- display Location message (this code will cycle through all location messages if the trigger is kept being activated over an over again)
		cfa.w8.locationShowMessage(location_message)
		location_message = location_message + 1

		-- Launches 'Acid Splash' from the NPP 'launcher'. The 'blast' will fly up to 100 meters, will deal 5d4+7 damage upon impact and a sound will be played upon the launch.
		-- Also make Burz face east and west intermittently, poor bastard :))
		if long_range_flag then
			cfa.w8.locationLaunchMissile(1, 100, 5, 4, 7, "launcher", "misc\spell backfire.wav")
			cfa.w8.locationAssignBehaviorScriptToMonster(218, "faceeast.msf")
		end
		if not long_range_flag then
			cfa.w8.locationLaunchMissile(1, 50, 5, 4, 7, "launcher", "ambients\ceiling fan loop.wav")
			cfa.w8.locationAssignBehaviorScriptToMonster(218, "facewest.msf")
		end
		long_range_flag = not long_range_flag

		-- use random function
		cfa.util.logMessage("30 rolls of 1d10: ")
		for counter = 1, 30, 1 do
			cfa.util.logMessage("%i ", cfa.util.getRandomNumber(10) + 1)
		end
		cfa.util.logMessage("\n")

		return cfa.result.ok
	end

	-- Some logic for test button 1
	if trigName == 'TEST_BUTTON1' then
		-- give birth to all El Doradoes and make them friendly towards the party.
		cfa.w8.locationChangeDispositionAndGiveBirthToMonsters(252, true, cfa.disposition.friendly)
		-- make all Crabs hostile towards the party.
		cfa.w8.locationChangeDispositionAndGiveBirthToMonsters(253, false, cfa.disposition.hostile)

		return cfa.result.ok
	end

	-- Using day time to disable the door trgger (the shop is closed at night)
	if trigeName == 'ANTONE_SHOP_DOOR' then
		local hour = cfa.w8.gameGetHour()
		local day = cfa.w8.gameGetDay()

		-- Antone works only from 6.00 till 19.00, wow, he is a hard worker!
		-- But he has day off on Sundays (every 7th day, assuming day 1 is Monday) :)
		if hour >= 19 or hour < 6 then
			cfa.w8.locationShowMessage(25) -- We put text "Closed" into the Arnika's Location Message 25
			return cfa.result.cancel;
		else
			if (day % 7) == 0 then
				cfa.w8.locationShowMessage(25) -- We put text "Closed on Sunday" into the Arnika's Location Message 25
				return cfa.result.cancel;
			end
		end

		return cfa.result.ok
	end

	return cfa.result.ok -- by default allow activation of the Triggers
end
