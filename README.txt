Installation
--------------------------------------------------------------------------
1. Copy or install Wizardry 6 to "<DosBox>\Wiz6\"
2. Run playwiz6.bat


Configuration
--------------------------------------------------------------------------
[Automap Mod]
It's required to set "output=opengl" and "fullscreen=false" in [sdl] section of config file.

Options in [AutoMap] section of config file:
"enable" - Enable automap feature for Wizardry 6.
"show_tooltips" - Enable tooltips feature for Wizardry 6.
"hide_in_dark_zones" - Hides automap in dark zones.
"width" - Width of automap window.
"height" - Height of automap window.

[Wizardry 6 / 7 - Audio Popping] 
The new setting wizpopfix was developed specifically for Wizardry 6 and 7 and reduces popping from the pc speaker sounds in those games. To enable it add the 	line wizpopfix=6 or wizpopfix=7 respectively, below pcspeaker=true in the config file.