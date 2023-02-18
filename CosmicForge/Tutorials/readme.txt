***********************
1. General
***********************

1.1 Editing heavily built on dialogs. No MDI environment.
1.2 All main dialogs (Item, Monster, Loot & Map editors) modify data locally and capable of Discard or Apply changes into the application memory. After that application memory could be applied to W7 data file(s) by either hitting Ctrl-S anywhere or 'Save changes' button on the main dialog.
1.3 Some values that can be edited have constraints in their values. Others the user should worry about. It it very good practice to check  if the new thing works in the game. The game may crashes often because of invalid values, not because of corrupted data.
1.4 Though I never encountered corrupting the data, please, make backups of your W7 data files (see the current list in the end) often.

**************************
1. Latest Version Features 
**************************

* General
- Does not work without game installed on your machine. Requires game files only, so it is not necessary to be able to launch the game itself. 
- Uses mostly pictures & icons from the game data files to make interface more "alive".
- Uses mostly terms and strings directly from the game.
- Uses "heavily based on dialogs" interface which is not so comfortable, but more easy (and time consuming) to implement.
- Almost in all lists throughout the dialogs you can use double-click to view particular entity from that list.
- Almost every image can be saved as BMP file or placed to clipboard for future use (right-click on the picture to invoke menu).


* Wizardry 6
- Item Editor Dialog which allows to:
	- View/Modify every item's attribute known to me.
	- Get information in what incident or loot you party can get particular item.
	- Direct access to Item Images Modification Dialog (left-click on item's image).
	- Search for a particular item by substring in its name.
- Item List Dialog which allows to:
	- View all items in the scenario and most of their properties.
	- Sort items by any property.
	- Filter out items by many of their properties.
	- Direct access to Item Editor Dialog (double-click on particular item).
- Monster Editor Dialog which allows to:
	- View/Modify every monster's attribute known to me.
	- Get information on what items particular monster can drop.
	- View monster image(s).
	- Direct access to Item Editor Dialog (double-click on particular item in the loot list).
- Monster List Dialog which allows to:
	- View all monsters in the scenario and most of their properties.
	- Sort monsters by any property.
	- Direct access to Monster Editor Dialog (double-click on particular monster).
- Text Editor dialog which allows to:
	- View/Modify scenario texts.
	- Search text by substring.
	- Patch game executable so it will correctly process new modified texts.
- Loot Editor Dialog which allows to:
	- View/Modify loot records.
	- Get information what monsters drop, incidents sell or map locations contain the particular loot.
	- Direct access to Item Editor Dialog (double-click on particular item in the loot list).
	- Direct access to Monster Editor Dialog (double-click on particular monster in the monster list).
	- Direct access to Incident Editor Dialog (double-click on particular incident in the monster list).
	- View on the map where exactly this loot is placed (double-click on particular map location in the location list).
- Incident Editor Dialog which allows to:
	- View/Modify incidents.
	- Get information what incidents sell and what actions it can perform.
	- Direct access to Item Editor Dialog (double-click on particular item in the trade list).
- Picture Editor Dialog which allows to:
	- View frames of every picture.
	- Call Editor Dialog to view picture frames (editing of pictures is not allowed).
- Map Editor Dialog which allows to:
	- View scenario maps.
	- View map events and map terrain features.
	- Filter out certain types of terrain features and map events.
	- Invoke Manage Map Quadrants Dialog which is capable to change map quadrant disposition and monster sets that your party can encounter on particular map.
	- Invoke Manage Map Terrain Dialog which is capable to change map terrain (walls, type of floor, display features such as sconces, niches, stairs and so on).
	- Invoke Manage Map Events Dialog which is capable to change map events, their relationships and their initial states.
- Save Files Viewer Dialog which allows to:
	- View every attribute of your characters from saved file or from guild file (their statistics, resistances, attacks, damages, negative effects and so on).
	- Invoke Character vs NPC Dialog to see how NPCs treat your character.
	- Invoke Character's Items Dialog to see what items your character is carrying now (double-click on particular item will invoke Item Editor Dialog).
	- Invoke Character vs Professions Dialog to see what professions your character can pick now and what attributes he(she) requires to pick yet unpickable professions.
	- Invoke Save File World Dialog in which you can learn about party location, game time passed, global enchantments (power and duration) and list of incidents and live status of incident's NPC.
- Editing of item images.
- Editing of character portraits.
- Editing of background pictures.
- Editing of text font.
- Editing of miscellaneous images.
- Game Info Viewer Dialog which allows to:
	- View Classes and their information (attribute requirement, amount of HP and Skill Points granted during character generation and leveling up, mana regeneration rates, favourite skills, base and per level resistances, experience table, Skills allowed).
	- View Races and their information (minimum attributes, resistance modifiers and additional features).
	- Invoke Game Calculations dialog which allows to see what your character will get during creating and leveling up.
- Modification of character creation algorithm to make better characters (increased ability bonus). 



* Wizardry 7
- Item Editor Dialog which allows to:
	- View/Modify every item's attribute known to me.
	- Get information in what incident or loot you party can get particular item.
	- Direct access to Item Images Modification Dialog (left-click on item's image).
	- Search for a particular item by substring in its name.
	- View text if item is readable.
- Item List Dialog which allows to:
	- View all items in the scenario and most of their properties.
	- Sort items by any property.
	- Filter out items by many of their properties.
	- Direct access to Item Editor Dialog (double-click on particular item).
- Monster Editor Dialog which allows to:
	- View/Modify every monster's attribute known to me.
	- Get information on what items particular monster can drop.
	- View monster image(s).
	- Direct access to Item Editor Dialog (double-click on particular item in the loot list).
- Monster List Dialog which allows to:
	- View all monsters in the scenario and most of their properties.
	- Sort monsters by any property.
	- Direct access to Monster Editor Dialog (double-click on particular monster).
- Text Editor dialog which allows to:
	- View/Modify scenario texts.
	- Search text by substring.
	- Patch game executable so it will correctly process new modified texts.
- Loot Editor Dialog which allows to:
	- View/Modify loot records.
	- Get information what monsters drop, incidents sell or map locations contain the particular loot.
	- Direct access to Item Editor Dialog (double-click on particular item in the loot list).
	- Direct access to Monster Editor Dialog (double-click on particular monster in the monster list).
	- Direct access to Incident Editor Dialog (double-click on particular incident in the monster list).
	- View on the map where exactly this loot is placed (double-click on particular map location in the location list).
- Incident Editor Dialog which allows to:
	- View/Modify incidents.
	- Get information what incidents sell and what actions it can perform.
	- Direct access to Item Editor Dialog (double-click on particular item in the trade list).
- Picture Editor Dialog which allows to:
	- View frames of every picture.
	- Call Editor Dialog to edit picture frames.
- Map Editor Dialog which allows to:
	- View scenario maps.
	- View map events and map terrain features.
	- Filter out certain types of terrain features and map events.
	- Invoke Manage Map Quadrants Dialog which is capable to change map quadrant disposition and monster sets that your party can encounter on particular map.
	- Invoke Manage Map Terrain Dialog which is capable to change map terrain (walls, type of floor, display features such as sconces, niches, stairs and so on).
	- Invoke Manage Map Events Dialog which is capable to change map events, their relationships and their initial states.
- Save Files Viewer Dialog which allows to:
	- View every attribute of your characters from saved file or from guild file (their statistics, resistances, attacks, damages, negative effects and so on).
	- Invoke Character vs NPC Dialog to see how NPCs treat your character.
	- Invoke Character's Items Dialog to see what items your character is carrying now (double-click on particular item will invoke Item Editor Dialog).
	- Invoke Character vs Professions Dialog to see what professions your character can pick now and what attributes he(she) requires to pick yet unpickable professions.
	- Invoke Save File World Dialog in which you can learn about party location, game time passed, global enchantments (power and duration), dropped items locations, list of wandering NPCs and their live status and location, list of incidents and live status of incident's NPC and what items party can buy from that incdent, relationships with different alliances.
- Editing of item images.
- Editing of character portraits.
- Editing of background pictures.
- Editing of text fonts.
- Editing of miscellaneous images.
- Editing of pictures.
- Game Info Viewer Dialog which allows to:
	- View Classes and their information (attribute requirement, amount of HP and Skill Points granted during character generation and leveling up, mana regeneration rates, favourite skills, base and per level resistances, experience table, Skills allowed).
	- View Races and their information (minimum attributes, resistance modifiers and additional features).
	- Invoke Game Calculations dialog which allows to see what your character will get during creating and leveling up.
- Modification of character creation algorithm to make better characters (increased ability bonus). 




***********************
2. Item Editor
***********************

2.1 Allows to edit items.
2.2 Changing item ID feature can be used to arrange loots (loot havily depends on item order). Changing imem ID affects two items as you can understand.
2.3 Last unknown byte has been revealed. A weapon range.
2.3.1 Explanation of the weapong range:
	SHORT - Character can reach two first monster rows from the first character row only (first 3 character slots).
	EXTENDED - Character can reach two first monster rows from any character row.
	THROWN - Character can reach three first monster rows from any character row.
	LONG - Character can reach any monster row from any character row.
2.4 Around 30 new items can be created (those named '?unknown items?), though no new pictures can be made. All picture slots are used for now. And picture byte controls item type, weapon skill, etc. I will eventually make the picture editor, but this will only allow to change existing pictures.
2.5 It is possible to edit Item Images. Just click on the image in Item Editor Dialog.

***********************
3. Monster Editor
***********************

3.1 Allows to edit monsters.
3.2 Does not allow to add new monsters (more than 250). To add a new monster you should change existing one - in that case existing monster will no longer exist.
3.3 Few bytes are not understood.

***********************
4. Loot Editor
***********************

4.1 Allows to edit loots.
4.2 Loots - everything that chests contains or monsters drop after their death or monsters sell or party finds in several places.
4.3 Loot contains of 8 loot entries and trap information. Each entry can hold Gold, Item, Advanced Item, Experience or may be empty. Each entry has its chance to be created when loot is generated (chest is opened, monster is killed).
4.4 Gold entry - generates gold in random amount from min to max. Then amount is divided by character count and each character recieves its share of gold.
4.5 Item entry - the first item specified and the number specified. This means that one of the 'number' items can be generated beginning at selected item.
4.6 Advanced item entry - the same as the Item entry, except it has no chance of being generated, but it has 'item availability level'. 'Item availability level' - is the mysterious number that the game somehow modifies and if party 'Item availability level' reached the Advanced item entry availability level then this entry is accesible. The example is the XEN XHENG's loot.
4.7 Experience entry - just gives every character specified amount of experience.
4.8 Loot may be completely empty (such as the first (zero) loot - it is used for monsters that produce no loot at all).
4.9 Trap - is the mask of traps. When chest is accessed, the random trap is generated (from those checked by the mask). Trap level - greater level means, the harder to disarm, more damage from the trap and more duration from trap effects.
4.10 Explode anyway flag. All 'deadly coffers' in Dane Tower has it. The lockpicking is useless.
4.11 Loot editor allows to name loots as you wish. This is not affects the game, but can make easier the edit process.


***********************
5. Map Editor
***********************

5.1 Allows to edit the maps.
5.2 Main dialog is just a viewer and does not allows to edit anything.

5.3 Use 'manage quadrants' menu to invoke Quadrant Editor.
5.3.1 Quadrant Editor allows to edit quadrants disposition and monster distribution on the particular map.
5.3.2 Map consists of 16 quadrants each of 8x8 cells. You can look existing maps to quickly understand all quadrants things.
5.3.3 Monster distribution: each map has 144 monster slots (12 by 12). Each map quadrants has two numbers - the two indexes of monster collections (by 12 monsters each) from the 144 map monster slots. Also each map quadrant has a chance of monster being generated from the first monster collection. In other words: when the game decides to arrange a battle it take the quadrant's chance and rolls 1d100. If the chance is rolled then it generates a random monster from the first monster collection used by the quadrant (one out of 12 monsters), otherwise it generates a random monster from the second monster collection used by the quadrant (one out of 12 monsters too).
5.3.4 Note that two different quadrants may use the same monster collection, so changing monster collection (12 monsters) can affect several quadrants.
5.3.5 Changes in Quadrant Editor are local. The cannot be discarded or applied. If you press OK then changes applied to Main Map Editor dialog and can be applied or discarded from it. If you press Cancel then changes are forfeit.

5.4 Use 'manage terrain' menu to invoke Terrain Editor.
5.4.1 Terrain Editor allows to edit walls, landscape (battle mask, darkness, fog, etc) and display features on the map.
5.4.2 You must understand that each map (32 maps total) has its own type. I don't know where it is stored or how it is determined. That 'type' regulates what walls and landscapes are valid for this map. In turn Display Features will crash the game if they not 'compatible' with walls and(or) landscape. For example, you can't add secret button, lever or sconce on wood wall. You can't add a portcullis or a window on Map 0 and can't have water there too (except for fake water). Those restrictions heavily limit the editing capability, but I can't see how to avoid them yet.
5.4.3 So, when you changed something, go in game and it crashes - it does not mean that Editor screwed it all up, it means that you've just used invalid wall, landscape of display feature on this map.
5.4.4 Wall is rather staionary (though it can be changed in game).
5.4.5 Landscape is the mask. Each cell can have up to four masks or have no at all. Be free to determine what mask means for each map (I already determined most of those (otherwise how my map viewer could work :) ), but not all of them). I will appreciate any info about that and soon get rid of those '?Unknown' names.
5.4.6 Display features.... Each display feature has a direction. For secret buttons, levers, fontains it is vital, but for statues it is not. Fell free to explore.

5.5 Map events editor (see How_to_edit_map_events.txt)


***********************
6. Image Editor
***********************

6.1 It is possible to Undo operation with following hot key combinations: Ctrl+Z, Alt+Backspace.
6.2 It is possible to Redo operation with following hot key combinations: Ctrl+A, Ctrl+Y.
6.3 For PIC file images their dimensions can be changed, but must be divisible by 8.
6.4 For icon-like images (items, portraits, etc) their dimensions are constant and cannot be changed.
6.5 Not much drawing operations are available now. You can use external editor along with copy/paste functionality.
6.6 It is possible to Copy image being edited into Clipboard either by button of hot key combinations: Ctrl+C, Ctrl+Ins.
6.7 It is possible to Paste bitmap image from Clipboard either by button of hot key combinations: Ctrl+V, Shift+Ins.


	

*********************************************************************
Special Thanks
*********************************************************************

1. To Rick Rice aka Llevram for pointing me to the true nature of the weapon range byte that is not the same as weapon type (Weapon can be of EXTENDED type, but can have LONG range - this is nonsence but this way the game implemented).
2. To Sergey Antoshin, Vadim Lopatin, Andrey Schegolev, Andrey Elizarov for their piece of code regarding MISC.HDR which lead me to better understanding the text database. This allowed me to implement multilanguage support more or less.
3. To Dwain Longfeet who granted me aforementioned piece of code.
4. Of course to Sirtech Team that made perfect games.
5. To many other people who and used the editor and gave a lot of ideas and feedback to make it better.



*************************************************************
All info about bugs, mulfunctions, inaccuracies, etc. is appreciated.
Write me to 'spershin@dev.aelita.com'.
Please, be more specific about the bug: 1. how to reproduce, 2. what happens. 3. screenshots (compress them, please, using any rar or zip).

mad god.


