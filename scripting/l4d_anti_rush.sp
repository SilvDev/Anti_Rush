/*
*	Anti Rush
*	Copyright (C) 2025 Silvers
*
*	This program is free software: you can redistribute it and/or modify
*	it under the terms of the GNU General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	This program is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*	GNU General Public License for more details.
*
*	You should have received a copy of the GNU General Public License
*	along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/



#define PLUGIN_VERSION 		"1.25"
#define DEBUG_BENCHMARK		0			// 0=Off. 1=Benchmark logic function.

/*======================================================================================
	Plugin Info:

*	Name	:	[L4D & L4D2] Anti Rush
*	Author	:	SilverShot
*	Descrp	:	Slowdown or teleport rushers and slackers back to the group. Uses flow distance for accuracy.
*	Link	:	https://forums.alliedmods.net/showthread.php?t=322392
*	Plugins	:	https://sourcemod.net/plugins.php?exact=exact&sortby=title&search=1&author=Silvers

========================================================================================
	Change Log:

1.25 (01-Jul-2025)
	- Plugin now fires a forward "Anti_Rush_Trigger" for clients who are rushing or slacking. Useful for external plugins to trigger events.

1.24 (21-May-2025)
	- Fixed not ignoring Chargers carrying someone when they are about to be pummelled. Thanks to "little_froy" for reporting.

1.23 (16-May-2024)
	- Added cvar "l4d_anti_rush_flash" to display a flash when health is being taken away.
	- Added cvar "l4d_anti_rush_sound" to play a sound when health is being taken away.
	- Added cvars "l4d_anti_rush_type2" and "l4d_anti_rush_health2" to hurt players who are rushing.
	- Changed cvars "l4d_anti_rush_range_last" and "l4d_anti_rush_time" description to include health drain.
	- Changes requested by "Voevoda".
	- All translations updated.

1.22 (05-Mar-2024)
	- Fixed using the lead range instead of last range when teleporting the slacker. Thanks to "49459317" for reporting.

1.21 (28-Jan-2024)
	- Fixed memory leak caused by clearing StringMap/ArrayList data instead of deleting.

1.20 (10-Jan-2024)
	- Changed the plugins on/off/mode cvars to use the "Left 4 DHooks" method instead of creating an entity.

1.19 (10-Mar-2023)
	- Added cvar "l4d_anti_rush_health" to hurt players who are rushing. Requested by "Voevoda".
	- Changed cvar "l4d_anti_rush_type" to allow disabling teleport or slowdown, to only enable health drain.
	- Translation phrases updated to support the health drain only type. Thanks to "Voevoda" and "HarryPotter" for updating Russian and Chinese translations.

1.18 (01-Jun-2022)
	- L4D1: Fixed throwing errors.
	- L4D2: Added map "c5m5_bridge" to the data config.

1.17 (04-Dec-2021)
	- Changes to fix warnings when compiling on SourceMod 1.11.

1.16 (19-Oct-2021)
	- Plugin now ignores players who are being healed or revived, or players healing or reviving someone. Requested to "Psyk0tik".

1.15 (09-Sep-2021)
	- Fixed the last update breaking the plugin in L4D1.

1.14 (25-Aug-2021)
	- Plugin now ignores players being carried by the Charger. Thanks to "Darkwob" for reporting.

1.13 (30-Jun-2021)
	- Plugin now ignores players inside elevators.

1.12 (16-Jun-2021)
	- L4D1: Fixed throwing errors about missing property "m_type". Thanks to "Dragokas" for reporting.

1.11 (20-Apr-2021)
	- Added cvars "l4d_anti_rush_flags" and "l4d_anti_rush_ignore" to make players with certain flags immune to the plugins actions. Requested by "Shadowart".

1.10a (12-Apr-2021)
	- Updated data config "data/l4d_anti_rush.cfg" with new triggers. Thanks to "jeremyvillanueva" for providing.

1.10 (23-Mar-2021)
	- Cleaning source code from last update.
	- Fixed potentially using the wrong "add" range from the config.

1.9 (22-Mar-2021)
	- Added optional config "data/l4d_anti_rush.cfg" to extend the trigger detection range during certain crescendo events. Requested by "SilentBr".

1.8 (09-Oct-2020)
	- Changed cvar "l4d_anti_rush_finale" to allow working in Gauntlet type finales only. Thanks to "Xanaguy" for requesting.
	- Renamed cvar "l4d_anti_rush_inacpped" to "l4d_anti_rush_incapped" fixing spelling mistake.

1.7 (09-Oct-2020)
	- Added cvar "l4d_anti_rush_tanks" to control if the plugins active when any tank is alive.
	- Fixed not resetting slowdown on team change or player death (optimization).

1.6 (15-Jul-2020)
	- Optionally added left4dhooks forwards "L4D_OnGetCrouchTopSpeed" and "L4D_OnGetWalkTopSpeed" to modify speed when walking or crouched.
	- Uncomment the section and recompile if you want to enable. Only required to slowdown players more than default.
	- Thanks to "SilentBr" for reporting.

1.5 (10-May-2020)
	- Added Traditional Chinese and Simplified Chinese translations. Thanks to "fbef0102".
	- Extra checks to prevent "IsAllowedGameMode" throwing errors.
	- Various changes to tidy up code.

1.4 (10-Apr-2020)
	- Added Hungarian translations. Thanks to "KasperH" for providing.
	- Added Russian translations. Thanks to "Dragokas" for updating with new phrases.
	- Added cvar "l4d_anti_rush_incapped" to ignored incapped players from being used to calculate rushers or slackers distance.
	- Added cvars "l4d_anti_rush_warn_last" and "l4d_anti_rush_warn_lead" to warn players about being teleported or slowed down.
	- Added cvar "l4d_anti_rush_warn_time" to control how often someone is warned.
	- Removed minimum value being set for "l4d_anti_rush_range_lead" cvar which prevented turning off lead feature.
	- The cvars "l4d_anti_rush_range_last" and "l4d_anti_rush_range_lead" minimum values are now set internally (1500.0).
	- Translation files and plugin updated.

1.3 (09-Apr-2020)
	- Added reset slowdown in case players are out-of-bound or have invalid flow distances to calculate the range.
	- Increased minimum value of "l4d_anti_rush_range_lead" cvar from 500.0 to 1000.0.
	- Removed minimum value being set for "l4d_anti_rush_range_last" cvar. Thanks to "Alex101192" for reporting.

1.2 (08-Apr-2020)
	- Added cvar "l4d_anti_rush_finale" to allow or disallow the plugin in finales.

1.1 (07-Apr-2020)
	- Changed how the plugin functions. Now calculates rushers/slackers by their flow distance to the nearest half of Survivors.
	- Fixed not accounting for multiple rushers with "type 2" setting.
	- Fixed "IsAllowedGameMode" from throwing errors when the "_tog" cvar was changed before MapStart.

1.0 (26-Mar-2020)
	- Added Russian translations to the .zip. Thanks to "KRUTIK" for providing.
	- No other changes.

1.0 (26-Mar-2020)
	- Initial release.

======================================================================================*/

#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <left4dhooks>

#if DEBUG_BENCHMARK
#include <profiler>
Handle g_Prof;
float g_fBenchMin;
float g_fBenchMax;
float g_fBenchAvg;
float g_iBenchTicks;
#endif

#define CVAR_FLAGS			FCVAR_NOTIFY
#define MINIMUM_RANGE		1500.0			// Minimum range for last and lead cvars.
#define EVENTS_CONFIG		"data/l4d_anti_rush.cfg"


ConVar g_hCvarAllow, g_hCvarMPGameMode, g_hCvarModes, g_hCvarModesOff, g_hCvarModesTog, g_hCvarFinale, g_hCvarFlags, g_hCvarFlash, g_hCvarIgnore, g_hCvarHealth, g_hCvarHealth2, g_hCvarIncap, g_hCvarPlayers, g_hCvarRangeLast, g_hCvarRangeLead, g_hCvarSound, g_hCvarSlow, g_hCvarTank, g_hCvarText, g_hCvarTime, g_hCvarType, g_hCvarType2, g_hCvarWarnLast, g_hCvarWarnLead, g_hCvarWarnTime;
float g_fCvarHealth, g_fCvarHealth2, g_fCvarRangeLast, g_fCvarRangeLead, g_fCvarSlow, g_fCvarTime, g_fCvarWarnLast, g_fCvarWarnLead, g_fCvarWarnTime;
int g_iCvarFinale, g_iCvarFlags, g_iCvarFlash, g_iCvarIgnore, g_iCvarIncap, g_iCvarPlayers, g_iCvarTank, g_iCvarText, g_iCvarType, g_iCvarType2;
bool g_bCvarAllow, g_bMapStarted, g_bLeft4Dead2;

bool g_bInhibit[MAXPLAYERS+1];
float g_fHintLast[MAXPLAYERS+1];
float g_fHintWarn[MAXPLAYERS+1];
float g_fLastFlow[MAXPLAYERS+1];
Handle g_hTimer;

char g_sCvarSound[PLATFORM_MAX_PATH];
char g_sMap[PLATFORM_MAX_PATH];
bool g_bFoundMap;
bool g_bEventStarted;
float g_fEventExtended;

ArrayList g_hElevators;

GlobalForward g_hForward;



// ====================================================================================================
//					FORWARDS
// ====================================================================================================
/**
 * @brief Called whenever a player or bot gives an item to someone
 *
 * @param client		The client receiving a warning or punishment
 * @param rushing		False = Player is slacking - too far behind. True = Player is rushing - too far ahead
 * @param punishment	Type of punishment: 0=None. 1=Slowed down. 2=Teleported. 3=Losing health
 *
 * @noreturn
 */
forward void Anti_Rush_Trigger(int client, bool rushing, int punishment);



// ====================================================================================================
//					PLUGIN INFO / START / END
// ====================================================================================================
public Plugin myinfo =
{
	name = "[L4D & L4D2] Anti Rush",
	author = "SilverShot",
	description = "Slowdown or teleport rushers and slackers back to the group. Uses flow distance for accuracy.",
	version = PLUGIN_VERSION,
	url = "https://forums.alliedmods.net/showthread.php?t=322392"
}

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion test = GetEngineVersion();

	if( test == Engine_Left4Dead ) g_bLeft4Dead2 = false;
	else if( test == Engine_Left4Dead2 ) g_bLeft4Dead2 = true;
	else
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}

	RegPluginLibrary("l4d_anti_rush");

	g_hForward = new GlobalForward("Anti_Rush_Trigger", ET_Event, Param_Cell, Param_Cell, Param_Cell, Param_Cell);

	return APLRes_Success;
}

public void OnPluginStart()
{
	LoadTranslations("anti_rush.phrases");

	g_hCvarAllow =		CreateConVar(	"l4d_anti_rush_allow",			"1",							"0=Plugin off, 1=Plugin on.", CVAR_FLAGS );
	g_hCvarModes =		CreateConVar(	"l4d_anti_rush_modes",			"",								"Turn on the plugin in these game modes, separate by commas (no spaces). (Empty = all).", CVAR_FLAGS );
	g_hCvarModesOff =	CreateConVar(	"l4d_anti_rush_modes_off",		"",								"Turn off the plugin in these game modes, separate by commas (no spaces). (Empty = none).", CVAR_FLAGS );
	g_hCvarModesTog =	CreateConVar(	"l4d_anti_rush_modes_tog",		"0",							"Turn on the plugin in these game modes. 0=All, 1=Coop, 2=Survival, 4=Versus, 8=Scavenge. Add numbers together.", CVAR_FLAGS );
	g_hCvarFinale =		CreateConVar(	"l4d_anti_rush_finale",			g_bLeft4Dead2 ? "2" : "0",		"Should the plugin activate in finales. 0=Off. 1=All finales. 2=Gauntlet type finales (L4D2 only).", CVAR_FLAGS );
	g_hCvarFlags =		CreateConVar(	"l4d_anti_rush_flags",			"",								"Players with these flags will be immune from teleporting forward when behind or slowing down when ahead.", CVAR_FLAGS );
	g_hCvarFlash =		CreateConVar(	"l4d_anti_rush_flash",			"1",							"0=Off. When rushing or slacking display a flash when health is being taken away: 1=Red flash, 2=White flash, 3=Black flash.", CVAR_FLAGS);
	g_hCvarHealth =		CreateConVar(	"l4d_anti_rush_health",			"0",							"0=Off. Amount of health to remove every second when someone is rushing.", CVAR_FLAGS);
	g_hCvarHealth2 =	CreateConVar(	"l4d_anti_rush_health2",		"0",							"0=Off. Amount of health to remove every second when someone is behind.", CVAR_FLAGS);
	g_hCvarIgnore =		CreateConVar(	"l4d_anti_rush_ignore",			"0",							"Should players with the immune flags be counted toward total flow distance. 0=Ignore them. 1=Count them.", CVAR_FLAGS );
	g_hCvarIncap =		CreateConVar(	"l4d_anti_rush_incapped",		"0",							"0=Off. How many survivors must be incapped before ignoring them in calculating rushers and slackers.", CVAR_FLAGS );
	g_hCvarPlayers =	CreateConVar(	"l4d_anti_rush_players",		"3",							"Minimum number of alive survivors before the function kicks in. Must be 3 or greater otherwise the lead/last and average cannot be detected.", CVAR_FLAGS, true, 3.0 );
	g_hCvarRangeLast =	CreateConVar(	"l4d_anti_rush_range_last",		"3000.0",						"0.0=Off. How far behind someone can travel from the average Survivor distance before being teleported forward or health drained.", CVAR_FLAGS );
	g_hCvarRangeLead =	CreateConVar(	"l4d_anti_rush_range_lead",		"3000.0",						"How far forward someone can travel from the average Survivor distance before being teleported, slowed down or health drained.", CVAR_FLAGS, true, MINIMUM_RANGE );
	g_hCvarSlow =		CreateConVar(	"l4d_anti_rush_slow",			"75.0",							"Maximum speed someone can travel when being slowed down.", CVAR_FLAGS, true, 20.0 );
	g_hCvarSound =		CreateConVar(	"l4d_anti_rush_sound",			"player/neck_snap_01.wav",		"Empty string = none. When rushing or slacking display play this sound when health is being taken away.", CVAR_FLAGS );
	g_hCvarTank =		CreateConVar(	"l4d_anti_rush_tanks",			"1",							"0=Off. 1=On. Should Anti-Rush be enabled when there are active Tanks.", CVAR_FLAGS );
	g_hCvarText =		CreateConVar(	"l4d_anti_rush_text",			"1",							"0=Off. 1=Print To Chat. 2=Hint Text. Display a message to someone rushing, or falling behind.", CVAR_FLAGS );
	g_hCvarTime =		CreateConVar(	"l4d_anti_rush_time",			"10",							"How often to print the message to someone if slowdown or health drain is enabled and affecting them.", CVAR_FLAGS );
	g_hCvarType =		CreateConVar(	"l4d_anti_rush_type",			"1",							"What to do with rushers. 0=Ignore (used for health drain only). 1=Slowdown player speed when moving forward. 2=Teleport back to group.", CVAR_FLAGS );
	g_hCvarType2 =		CreateConVar(	"l4d_anti_rush_type2",			"1",							"What to do with slackers. 0=Ignore (used for health drain only). 1=Teleport back to group.", CVAR_FLAGS );
	g_hCvarWarnLast =	CreateConVar(	"l4d_anti_rush_warn_last",		"2500.0",						"How far behind someone can travel from the average Survivor distance before being warned about being teleported.", CVAR_FLAGS, true, MINIMUM_RANGE );
	g_hCvarWarnLead =	CreateConVar(	"l4d_anti_rush_warn_lead",		"2500.0",						"How far forward someone can travel from the average Survivor distance before being warned about being teleported or slowed down.", CVAR_FLAGS, true, MINIMUM_RANGE );
	g_hCvarWarnTime =	CreateConVar(	"l4d_anti_rush_warn_time",		"15.0",							"0.0=Off. How often to print a message to someone warning them they are ahead or behind and will be teleported or slowed down.", CVAR_FLAGS );
	CreateConVar(						"l4d_anti_rush_version",		PLUGIN_VERSION,					"Anti Rush plugin version.", FCVAR_NOTIFY|FCVAR_DONTRECORD);
	AutoExecConfig(true,				"l4d_anti_rush");

	g_hCvarMPGameMode = FindConVar("mp_gamemode");
	g_hCvarMPGameMode.AddChangeHook(ConVarChanged_Allow);
	g_hCvarModes.AddChangeHook(ConVarChanged_Allow);
	g_hCvarModesOff.AddChangeHook(ConVarChanged_Allow);
	g_hCvarModesTog.AddChangeHook(ConVarChanged_Allow);
	g_hCvarAllow.AddChangeHook(ConVarChanged_Allow);
	g_hCvarFinale.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarFlags.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarFlash.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarHealth.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarHealth2.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarIgnore.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarIncap.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarPlayers.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarRangeLast.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarRangeLead.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarTank.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarText.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarSound.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarSlow.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarTime.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarType.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarType2.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarWarnLast.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarWarnLead.AddChangeHook(ConVarChanged_Cvars);
	g_hCvarWarnTime.AddChangeHook(ConVarChanged_Cvars);

	g_hElevators = new ArrayList();

	#if DEBUG_BENCHMARK
	g_Prof = CreateProfiler();
	#endif
}



// ====================================================================================================
//					CVARS
// ====================================================================================================
public void OnConfigsExecuted()
{
	IsAllowed();
}

void ConVarChanged_Allow(Handle convar, const char[] oldValue, const char[] newValue)
{
	IsAllowed();
}

void ConVarChanged_Cvars(Handle convar, const char[] oldValue, const char[] newValue)
{
	GetCvars();
}

void GetCvars()
{
	char sTemp[PLATFORM_MAX_PATH];
	g_hCvarFlags.GetString(sTemp, sizeof(sTemp));
	g_iCvarFlags = ReadFlagString(sTemp);

	g_hCvarSound.GetString(g_sCvarSound, sizeof(g_sCvarSound));

	g_iCvarIgnore = g_hCvarIgnore.IntValue;
	g_iCvarFlash = g_hCvarFinale.IntValue;
	g_iCvarFlash = g_hCvarFlash.IntValue;
	g_fCvarHealth = g_hCvarHealth.FloatValue;
	g_fCvarHealth2 = g_hCvarHealth2.FloatValue;
	g_iCvarIncap = g_hCvarIncap.IntValue;
	g_iCvarPlayers = g_hCvarPlayers.IntValue;
	g_fCvarTime = g_hCvarTime.FloatValue;
	g_iCvarTank = g_hCvarTank.IntValue;
	g_iCvarText = g_hCvarText.IntValue;
	g_fCvarSlow = g_hCvarSlow.FloatValue;
	g_iCvarType = g_hCvarType.IntValue;
	g_iCvarType2 = g_hCvarType2.IntValue;
	g_fCvarRangeLast = g_hCvarRangeLast.FloatValue;
	g_fCvarRangeLead = g_hCvarRangeLead.FloatValue;
	g_fCvarWarnLast = g_hCvarWarnLast.FloatValue;
	g_fCvarWarnLead = g_hCvarWarnLead.FloatValue;
	g_fCvarWarnTime = g_hCvarWarnTime.FloatValue;

	if( g_fCvarRangeLast && g_fCvarRangeLast < MINIMUM_RANGE ) g_fCvarRangeLast = MINIMUM_RANGE;
	if( g_fCvarRangeLead && g_fCvarRangeLead < MINIMUM_RANGE ) g_fCvarRangeLead = MINIMUM_RANGE;
	if( g_fCvarWarnLast && g_fCvarWarnLast < MINIMUM_RANGE ) g_fCvarWarnLast = MINIMUM_RANGE;
	if( g_fCvarWarnLead && g_fCvarWarnLead < MINIMUM_RANGE ) g_fCvarWarnLead = MINIMUM_RANGE;
}

void IsAllowed()
{
	bool bCvarAllow = g_hCvarAllow.BoolValue;
	bool bAllowMode = IsAllowedGameMode();
	GetCvars();

	if( g_bCvarAllow == false && bCvarAllow == true && bAllowMode == true )
	{
		g_bCvarAllow = true;

		HookEvent("round_start",	Event_RoundStart);
		HookEvent("round_end",		Event_RoundEnd);
		HookEvent("player_death",	Event_PlayerDeath);
		HookEvent("player_team",	Event_PlayerTeam);

		Event_RoundStart(null, "", false);
	}

	else if( g_bCvarAllow == true && (bCvarAllow == false || bAllowMode == false) )
	{
		g_bCvarAllow = false;

		UnhookEvent("round_start",	Event_RoundStart);
		UnhookEvent("round_end",	Event_RoundEnd);
		UnhookEvent("player_death",	Event_PlayerDeath);
		UnhookEvent("player_team",	Event_PlayerTeam);

		ResetSlowdown();
		ResetPlugin();
	}
}

int g_iCurrentMode;
public void L4D_OnGameModeChange(int gamemode)
{
	g_iCurrentMode = gamemode;
}

bool IsAllowedGameMode()
{
	if( g_hCvarMPGameMode == null )
		return false;

	int iCvarModesTog = g_hCvarModesTog.IntValue;
	if( iCvarModesTog != 0 )
	{
		if( g_iCurrentMode == 0 )
			g_iCurrentMode = L4D_GetGameModeType();

		if( g_iCurrentMode == 0 )
			return false;

		switch( g_iCurrentMode ) // Left4DHooks values are flipped for these modes, sadly
		{
			case 2:		g_iCurrentMode = 4;
			case 4:		g_iCurrentMode = 2;
		}

		if( !(iCvarModesTog & g_iCurrentMode) )
			return false;
	}

	char sGameModes[64], sGameMode[64];
	g_hCvarMPGameMode.GetString(sGameMode, sizeof(sGameMode));
	Format(sGameMode, sizeof(sGameMode), ",%s,", sGameMode);

	g_hCvarModes.GetString(sGameModes, sizeof(sGameModes));
	if( sGameModes[0] )
	{
		Format(sGameModes, sizeof(sGameModes), ",%s,", sGameModes);
		if( StrContains(sGameModes, sGameMode, false) == -1 )
			return false;
	}

	g_hCvarModesOff.GetString(sGameModes, sizeof(sGameModes));
	if( sGameModes[0] )
	{
		Format(sGameModes, sizeof(sGameModes), ",%s,", sGameModes);
		if( StrContains(sGameModes, sGameMode, false) != -1 )
			return false;
	}

	return true;
}



// ====================================================================================================
//					HOOK CUSTOM ARLARM EVENTS
// ====================================================================================================
int g_iSectionLevel;

void LoadEventConfig()
{
	g_bFoundMap = false;

	char sPath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, sizeof(sPath), EVENTS_CONFIG);
	if( FileExists(sPath) )
	{
		ParseConfigFile(sPath);
	}
}

bool ParseConfigFile(const char[] file)
{
	SMCParser parser = new SMCParser();
	SMC_SetReaders(parser, ColorConfig_NewSection, ColorConfig_KeyValue, ColorConfig_EndSection);
	parser.OnEnd = ColorConfig_End;

	char error[128];
	int line = 0, col = 0;
	SMCError result = parser.ParseFile(file, line, col);

	if( result != SMCError_Okay )
	{
		parser.GetErrorString(result, error, sizeof(error));
		SetFailState("%s on line %d, col %d of %s [%d]", error, line, col, file, result);
	}

	delete parser;
	return (result == SMCError_Okay);
}

SMCResult ColorConfig_NewSection(Handle parser, const char[] section, bool quotes)
{
	g_iSectionLevel++;

	// Map
	if( g_iSectionLevel == 2 && strcmp(section, g_sMap) == 0 )
	{
		g_bFoundMap = true;
	} else {
		g_bFoundMap = false;
	}

	return SMCParse_Continue;
}

SMCResult ColorConfig_KeyValue(Handle parser, const char[] key, const char[] value, bool key_quotes, bool value_quotes)
{
	// On / Off
	if( g_iSectionLevel == 2 && g_bFoundMap )
	{
		if( strcmp(key, "add") == 0 )
		{
			g_fEventExtended = StringToFloat(value);
		} else {
			static char sSplit[3][64];

			int len = ExplodeString(value, ":", sSplit, sizeof(sSplit), sizeof(sSplit[]));
			if( len != 3 )
			{
				LogError("Malformed string in l4d_anti_rush.cfg. Section [%s] key [%s] value [%s].", g_sMap, key, value);
			} else {
				int entity = FindByClassTargetName(sSplit[0], sSplit[1]);
				if( entity != INVALID_ENT_REFERENCE )
				{
					if( strcmp(key, "1") == 0 )
					{
						HookSingleEntityOutput(entity, sSplit[2], OutputStart);
					}
					else if( strcmp(key, "0") == 0 )
					{
						HookSingleEntityOutput(entity, sSplit[2], OutputStop);
					}
				}
			}
		}
	}

	return SMCParse_Continue;
}

void OutputStart(const char[] output, int caller, int activator, float delay)
{
	g_bEventStarted = true;
}

void OutputStop(const char[] output, int caller, int activator, float delay)
{
	g_bEventStarted = false;
}


SMCResult ColorConfig_EndSection(Handle parser)
{
	g_iSectionLevel--;
	return SMCParse_Continue;
}

void ColorConfig_End(Handle parser, bool halted, bool failed)
{
	if( failed )
		SetFailState("Error: Cannot load the config file: \"%s\"", EVENTS_CONFIG);
}

int FindByClassTargetName(const char[] sClass, const char[] sTarget)
{
	char sName[64];
	int entity = INVALID_ENT_REFERENCE;

	// Is targetname numeric?
	bool numeric = true;
	for( int i = 0; i < strlen(sTarget); i++ )
	{
		if( IsCharNumeric(sTarget[i]) == false )
		{
			numeric = false;
			break;
		}
	}

	// Search by hammer ID or targetname
	while( (entity = FindEntityByClassname(entity, sClass)) != INVALID_ENT_REFERENCE )
	{
		if( numeric )
		{
			if( GetEntProp(entity, Prop_Data, "m_iHammerID") == StringToInt(sTarget) ) return entity;
		} else {
			GetEntPropString(entity, Prop_Data, "m_iName", sName, sizeof(sName));
			if( strcmp(sTarget, sName) == 0 ) return entity;
		}
	}
	return INVALID_ENT_REFERENCE;
}



// ====================================================================================================
//					EVENTS
// ====================================================================================================
void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	delete g_hTimer;

	// Finales allowed, or not finale
	if( g_iCvarFinale || (g_iCvarFinale == 0 && L4D_IsMissionFinalMap() == false) )
	{
		// Gauntlet finale only
		if( g_iCvarFinale == 2 && g_bLeft4Dead2 )
		{
			int entity = FindEntityByClassname(-1, "trigger_finale");
			if( entity != -1 )
			{
				if( GetEntProp(entity, Prop_Data, "m_type") != 1 ) return;
			}
		}

		g_hTimer = CreateTimer(1.0, TimerTest, _, TIMER_REPEAT);

		LoadEventConfig();
	}

	// Get elevators
	// .Clear() is creating a memory leak
	// g_hElevators.Clear();
	delete g_hElevators;
	g_hElevators = new ArrayList();

	int entity = -1;
	while( (entity = FindEntityByClassname(entity, "func_elevator")) != INVALID_ENT_REFERENCE )
	{
		g_hElevators.Push(EntIndexToEntRef(entity));
	}
}

void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	ResetSlowdown();
	ResetPlugin();
}

void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if( client )
	{
		ResetClient(client);
	}
}

void Event_PlayerTeam(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if( client )
	{
		ResetClient(client);
	}
}

public void OnMapStart()
{
	GetCurrentMap(g_sMap, sizeof(g_sMap));
	g_bMapStarted = true;
}

public void OnMapEnd()
{
	g_bMapStarted = false;
	ResetPlugin();
}

void ResetPlugin()
{
	for( int i = 1; i <= MAXPLAYERS; i++ )
	{
		ResetClient(i);
	}

	delete g_hTimer;

	// .Clear() is creating a memory leak
	// g_hElevators.Clear();
	delete g_hElevators;
	g_hElevators = new ArrayList();

	g_fEventExtended = 0.0;
	g_bEventStarted = false;
}

void ResetClient(int i)
{
	g_bInhibit[i] = false;
	g_fHintLast[i] = 0.0;
	g_fHintWarn[i] = 0.0;
	g_fLastFlow[i] = 0.0;

	SDKUnhook(i, SDKHook_PreThinkPost, PreThinkPost);
}

void ResetSlowdown()
{
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( g_bInhibit[i] && IsClientInGame(i) )
		{
			SDKUnhook(i, SDKHook_PreThinkPost, PreThinkPost);
		}

		g_bInhibit[i] = false;
	}
}



// ====================================================================================================
//					LOGIC
// ====================================================================================================
Action TimerTest(Handle timer)
{
	if( !g_bMapStarted ) return Plugin_Continue;

	#if DEBUG_BENCHMARK
	StartProfiling(g_Prof);
	#endif

	static bool bTanks;
	if( g_iCvarTank == 0 )
	{
		if( L4D2_GetTankCount() > 0 )
		{
			if( !bTanks )
			{
				bTanks = true;
				ResetSlowdown();
			}

			return Plugin_Continue;
		} else {
			bTanks = false;
		}
	}

	float flow;
	int count, countflow, index;

	// Get survivors flow distance
	ArrayList aList = new ArrayList(2);

	// Account for incapped
	int clients[MAXPLAYERS+1];
	int incapped, client;

	// Check valid survivors, count incapped
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && GetClientTeam(i) == 2 && IsPlayerAlive(i) )
		{
			// Immune players - ignore from flow calculations
			if( g_iCvarFlags != 0 && g_iCvarIgnore == 0 && CheckCommandAccess(client, "", g_iCvarFlags, true) )
			{
				continue;
			}

			// Count
			clients[count++] = i;

			if( g_iCvarIncap )
			{
				if( GetEntProp(i, Prop_Send, "m_isIncapacitated", 1) )
					incapped++;
			}
		}
	}

	for( int i = 0; i < count; i++ )
	{
		client = clients[i];

		// Ignore incapped
		if( g_iCvarIncap && incapped >= g_iCvarIncap && GetEntProp(client, Prop_Send, "m_isIncapacitated", 1) )
			continue;

		// Ignore healing / using stuff
		if( g_bLeft4Dead2 && GetEntPropEnt(client, Prop_Send, "m_useActionTarget") > 0 )
			continue;

		// Ignore reviving
		if( GetEntPropEnt(client, Prop_Send, "m_reviveOwner") > 0 || GetEntPropEnt(client, Prop_Send, "m_reviveTarget") > 0 )
			continue;

		// Ignore queued pummel by Charger
		if( g_bLeft4Dead2 && L4D2_GetQueuedPummelAttacker(client) != -1 )
			continue;

		// Ignore pinned by Charger
		if( g_bLeft4Dead2 && GetEntPropEnt(client, Prop_Send, "m_carryAttacker") != -1 )
			continue;

		// Ignore in Elevator
		int lift = GetEntPropEnt(client, Prop_Send, "m_hGroundEntity");
		if( lift > MaxClients )
		{
			lift = EntIndexToEntRef(lift);
			if( g_hElevators.FindValue(lift) != -1 )
				continue;
		}

		// Get flow
		flow = L4D2Direct_GetFlowDistance(client);
		if( flow && flow != -9999.0 ) // Invalid flows
		{
			countflow++;
			index = aList.Push(flow);
			aList.Set(index, client, 1);
		}
		// Reset slowdown if players flow is invalid
		else if( g_bInhibit[client] == true )
		{
			g_bInhibit[client] = false;
			SDKUnhook(client, SDKHook_PreThinkPost, PreThinkPost);
		}
	}

	// In case not enough players or some have invalid flow distance, we still need an average.
	if( countflow >= g_iCvarPlayers )
	{
		aList.Sort(Sort_Descending, Sort_Float);

		int clientAvg;
		float lastFlow;
		float distance;



		// Detect rushers
		if( g_fCvarRangeLead )
		{
			// Loop through survivors from highest flow
			for( int i = 0; i < countflow; i++ )
			{
				client = aList.Get(i, 1);

				// Immune players
				if( g_iCvarFlags != 0 && g_iCvarIgnore == 1 && CheckCommandAccess(client, "", g_iCvarFlags, true) )
				{
					continue;
				}

				bool flowBack = true;

				// Only check nearest half of survivor pack.
				if( i < countflow / 2 )
				{
					flow = aList.Get(i, 0);

					// Loop through from next survivor to mid-way through the pack.
					for( int x = i + 1; x <= countflow / 2; x++ )
					{
						lastFlow = aList.Get(x, 0);
						distance = flow - lastFlow;
						if( g_bEventStarted ) distance -= g_fEventExtended;

						// Warn ahead hint
						if( g_iCvarText && g_fCvarWarnTime && g_fCvarWarnLead && distance > g_fCvarWarnLead && distance < g_fCvarRangeLead && g_fHintWarn[client] < GetGameTime() )
						{
							g_fHintWarn[client] = GetGameTime() + g_fCvarWarnTime;

							switch( g_iCvarType )
							{
								case 0: ClientHintMessage(client, "Warn_Health");
								case 1: ClientHintMessage(client, "Warn_Slowdown");
								case 2: ClientHintMessage(client, "Warn_Ahead");
							}

							// Forward
							Call_StartForward(g_hForward);
							Call_PushCell(client);
							Call_PushCell(true);
							Call_PushCell(0);
							Call_Finish();
						}

						// Compare higher flow with next survivor, they're rushing
						if( distance > g_fCvarRangeLead )
						{
							// PrintToServer("RUSH: %N %f", client, distance);
							flowBack = false;

							// Slowdown enabled?
							if( g_fCvarHealth || g_iCvarType == 1 )
							{
								// Inhibit moving forward
								// Only check > or < because when == the same flow distance, they're either already being slowed or running back, so we don't want to change/affect them within the same flow NavMesh.
								if( flow > g_fLastFlow[client] )
								{
									g_fLastFlow[client] = flow;

									if( g_iCvarType == 1 && g_bInhibit[client] == false )
									{
										g_bInhibit[client] = true;
										SDKHook(client, SDKHook_PreThinkPost, PreThinkPost);
									}

									// Hint
									if( g_iCvarText && g_fHintLast[client] < GetGameTime() )
									{
										g_fHintLast[client] = GetGameTime() + g_fCvarTime;

										switch( g_iCvarType )
										{
											case 0: ClientHintMessage(client, "Rush_Health");
											case 1: ClientHintMessage(client, "Rush_Slowdown");
										}
									}

									// Hurt for rushing?
									if( g_fCvarHealth )
									{
										DamageClient(client, g_fCvarHealth);
									}
								}
								else if( flow < g_fLastFlow[client] )
								{
									flowBack = true;
									g_fLastFlow[client] = flow;
								}
							}



							// Teleport enabled?
							if( g_iCvarType == 2 && IsClientPinned(client) == false )
							{
								clientAvg = aList.Get(x, 1);
								float vPos[3];
								GetClientAbsOrigin(clientAvg, vPos);

								// Hint
								if( g_iCvarText)
								{
									ClientHintMessage(client, "Rush_Ahead");
								}

								TeleportEntity(client, vPos, NULL_VECTOR, NULL_VECTOR);
							}

							// Forward
							Call_StartForward(g_hForward);
							Call_PushCell(client);
							Call_PushCell(true);
							Call_PushCell(g_iCvarType == 2 ? 2 : g_fCvarHealth ? 3 : 1);
							Call_Finish();

							break;
						}
					}
				}

				// Running back, allow full speed
				if( flowBack && g_bInhibit[client] == true )
				{
					g_bInhibit[client] = false;
					SDKUnhook(client, SDKHook_PreThinkPost, PreThinkPost);
				}
			}
		}



		// Detect slackers
		if( g_fCvarRangeLast )
		{
			// Loop through survivors from lowest flow to mid-way through the pack.
			for( int i = countflow - 1; i > countflow / 2; i-- )
			{
				client = aList.Get(i, 1);

				// Immune players
				if( g_iCvarFlags != 0 && g_iCvarIgnore == 1 && CheckCommandAccess(client, "", g_iCvarFlags, true) )
				{
					continue;
				}

				flow = aList.Get(i, 0);

				// Loop through from next survivor to mid-way through the pack.
				for( int x = i - 1; x < countflow; x++ )
				{
					lastFlow = aList.Get(x, 0);
					distance = lastFlow - flow;
					if( g_bEventStarted ) distance -= g_fEventExtended;

					// Warn behind hint
					if( g_iCvarText && g_fCvarWarnTime && g_fCvarWarnLast && distance > g_fCvarWarnLast && distance < g_fCvarRangeLast && g_fHintWarn[client] < GetGameTime() )
					{
						g_fHintWarn[client] = GetGameTime() + g_fCvarWarnTime;

						if( g_iCvarType2 == 0 ) ClientHintMessage(client, "Warn_Health2");
						else if( g_fCvarHealth2 ) ClientHintMessage(client, "Warn_Behind");

						// Forward
						Call_StartForward(g_hForward);
						Call_PushCell(client);
						Call_PushCell(false);
						Call_PushCell(0);
						Call_Finish();
					}

					// Compare lower flow with next survivor, they're behind
					if( distance > g_fCvarRangeLast )
					{
						// PrintToServer("SLOW: %N %f", client, distance);
						clientAvg = aList.Get(x, 1);
						float vPos[3];
						GetClientAbsOrigin(clientAvg, vPos);

						if( g_iCvarType2 == 1 && IsClientPinned(client) == false )
						{
							TeleportEntity(client, vPos, NULL_VECTOR, NULL_VECTOR);
						}

						// Hint
						if( g_iCvarText && g_fHintLast[client] < GetGameTime() )
						{
							g_fHintLast[client] = GetGameTime() + g_fCvarTime;

							if( g_iCvarType2 == 0 ) ClientHintMessage(client, "Warn_Health2");
							else if( g_fCvarHealth2 ) ClientHintMessage(client, "Rush_Behind");
						}

						// Hurt for slacking?
						if( g_fCvarHealth2 )
						{
							DamageClient(client, g_fCvarHealth2);
						}

						// Forward
						Call_StartForward(g_hForward);
						Call_PushCell(client);
						Call_PushCell(false);
						Call_PushCell(g_iCvarType2 == 1 ? 2 : g_fCvarHealth2 ? 3 : 0);
						Call_Finish();

						break;
					}
				}
			}
		}
	}
	else
	{
		ResetSlowdown();
	}

	delete aList;

	#if DEBUG_BENCHMARK
	StopProfiling(g_Prof);
	float speed = GetProfilerTime(g_Prof);
	if( speed < g_fBenchMin ) g_fBenchMin = speed;
	if( speed > g_fBenchMax ) g_fBenchMax = speed;
	g_fBenchAvg += speed;
	g_iBenchTicks++;

	PrintToServer("Anti Rush benchmark: %f (Min %f. Avg %f. Max %f)", speed, g_fBenchMin, g_fBenchAvg / g_iBenchTicks, g_fBenchMax);
	#endif

	return Plugin_Continue;
}

void DamageClient(int client, float damage)
{
	SDKHooks_TakeDamage(client, 0, 0, damage);

	if( g_iCvarFlash )
	{
		// Blind
		Handle message = StartMessageOne("Fade", client);
		BfWrite bf = UserMessageToBfWrite(message);
		bf.WriteShort(100);
		bf.WriteShort(100);
		bf.WriteShort(0x0001);
		switch( g_iCvarFlash )
		{
			case 1:
			{
				bf.WriteByte(255);
				bf.WriteByte(0);
				bf.WriteByte(0);
			}
			case 2:
			{
				bf.WriteByte(255);
				bf.WriteByte(255);
				bf.WriteByte(255);
			}
			case 3:
			{
				bf.WriteByte(0);
				bf.WriteByte(0);
				bf.WriteByte(0);
			}
		}

		bf.WriteByte(100);
		EndMessage();
	}

	if( g_sCvarSound[0] )
	{
		EmitSoundToClient(client, g_sCvarSound);
	}
}

/* Remove this line to enable, if you want to limit speed (slower) than default when walking/crouched.
public Action L4D_OnGetCrouchTopSpeed(int target, float &retVal)
{
	if( g_bInhibit[target] )
	{
		retVal = g_fCvarSlow;
		return Plugin_Handled;
	}

	return Plugin_Continue;
}

public Action L4D_OnGetWalkTopSpeed(int target, float &retVal)
{
	if( g_bInhibit[target] )
	{
		retVal = g_fCvarSlow;
		return Plugin_Handled;
	}

	return Plugin_Continue;
}
// */

void PreThinkPost(int client)
{
	SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", g_fCvarSlow);
}

void ClientHintMessage(int client, const char[] translation)
{
	static char sMessage[256];
	Format(sMessage, sizeof(sMessage), "%T", translation, client);

	if( g_iCvarText == 1 )
	{
		ReplaceColors(sMessage, sizeof(sMessage), false);
		PrintToChat(client, sMessage);
	} else {
		ReplaceColors(sMessage, sizeof(sMessage), true);
		PrintHintText(client, sMessage);
	}
}

void ReplaceColors(char[] translation, int size, bool hint)
{
	ReplaceString(translation, size, "{white}",		hint ? "" : "\x01");
	ReplaceString(translation, size, "{cyan}",		hint ? "" : "\x03");
	ReplaceString(translation, size, "{orange}",	hint ? "" : "\x04");
	ReplaceString(translation, size, "{green}",		hint ? "" : "\x05");
}

bool IsClientPinned(int client)
{
	if( GetEntProp(client, Prop_Send, "m_isIncapacitated", 1) ||
		GetEntProp(client, Prop_Send, "m_isHangingFromLedge", 1) ||
		GetEntPropEnt(client, Prop_Send, "m_tongueOwner") > 0 ||
		GetEntPropEnt(client, Prop_Send, "m_pounceAttacker") > 0
	) return true;

	if( g_bLeft4Dead2 &&
	(
		GetEntPropEnt(client, Prop_Send, "m_jockeyAttacker") > 0 ||
		GetEntPropEnt(client, Prop_Send, "m_carryAttacker") > 0 ||
		GetEntPropEnt(client, Prop_Send, "m_pummelAttacker") > 0
	)) return true;

	return false;
}
