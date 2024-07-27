-----------------------------
------Incentive Program------
----Created by: Jacob Beu----
-----Xubera @ US-Alleria-----
-----------Grubsey-----------
-------------Syl-------------
--------r22 | 2024/07/27-----
-----------------------------

local addonName, IncentiveProgram = ...

--Core
IncentiveProgram.VERSION_NUMBER = C_AddOns.GetAddOnMetadata(addonName, "Version") 
IncentiveProgram.ADDON_DISPLAY_NAME = addonName.." (|cFF69CCF0"..IncentiveProgram.VERSION_NUMBER.."|r)"

IncentiveProgram.Flair = {
    [849] = "HM1 - ",
    [850] = "HM2 - ",
    [851] = "HM3 - ",
    [847] = "BRF1 - ",
    [846] = "BRF2 - ",
    [848] = "BRF3 - ",
    [823] = "BRF4 - ",
    [982] = "HC1 - ",
    [983] = "HC2 - ",
    [984] = "HC3 - ",
    [985] = "HC4 - ",
    [986] = "HC5 - ",
    [1287] = "EN1 - ",
    [1288] = "EN2 - ",
    [1289] = "EN3 - ",
	[1411] = "TV1 - ",
    [1290] = "NH1 - ",
    [1291] = "NH2 - ",
    [1292] = "NH3 - ",
    [1293] = "NH4 - ",
	[1494] = "TS1 - ",
	[1495] = "TS2 - ",
	[1496] = "TS3 - ",
	[1497] = "TS4 - ",
	[1610] = "ANT1 - ",
	[1611] = "ANT2 - ",
	[1612] = "ANT3 - ",
	[1613] = "ANT4 - ",
	[1731] = "ULD1 - ",
	[1732] = "ULD2 - ",
	[1733] = "ULD3 - "
    
}

--Icon File Paths
IncentiveProgram.Icons = {
    ["INCENTIVE_NONE"] = "Interface\\ICONS\\Ability_Malkorok_BlightofYshaarj_Red",
    ["INCENTIVE_RARE"] = "Interface\\Icons\\INV_Misc_Coin_17",
    ["INCENTIVE_UNCOMMON"] = "Interface\\Icons\\INV_Misc_Coin_18",
    ["INCENTIVE_PLENTIFUL"] = "Interface\\Icons\\INV_Misc_Coin_19",
    ----------------------
    ["CONTEXT_MENU_DIVIDER"] = "Interface\\Common\\UI-TooltipDivider-Transparent",
    ["CONTEXT_MENU_RED_X"] = "Interface\\Common\\VOICECHAT-MUTED"
  }
  
--Settings
IncentiveProgram.Settings = {
    QA_TANK = "queueAsTank",
    QA_HEALER = "queueAsHealer",
    QA_DAMAGE = "queueAsDamage",
    IGNORE = "ignore",
    DUNGEON_NAME = "dungeonName",
    DUNGEON_TYPE = "dungeonType",
    HIDE_IN_PARTY = "hideInParty",
    HIDE_ALWAYS = "hideAlways", --still shows in databroker
	HIDE_EMPTY = "hideEmpty",
    HIDE_MINIMAP = "hideMinimap",
    ALERT = "alert",
    ALERT_TOAST = "toastAlert",
    COUNT_EVEN_IF_NOT_SELECTED = "countEvenIfNotSelected",
    COUNT_EVEN_IF_NOT_ROLE_ELIGIBLE = "countEvenIfNotRoleEligible",
	IGNORE_COMPLETED_LFR = "ignoreCompletedLFR",
    
    ROLE_TANK = "roleTank",
    ROLE_HEALER = "roleHealer",
    ROLE_DAMAGE = "roleDamage",
    
    FRAME_TOP = "frameTop",
    FRAME_LEFT = "frameLeft",
    TOAST_TOP = "toastTop",
    TOAST_LEFT = "toastLeft",
    MINIMAP = "minimap",
	
	ALERT_PING = "alertPing",
	ALERT_SOUND = "alertSound",
	ALERT_REPEATS = "alertRepeats",
	TOAST_PING = "toastPing",
	TOAST_SOUND = "toastSound",
	TOAST_REPEATS = "toastRepeats",
	CYCLE_COUNT = "cycleCount",
	CONTINUOUSLY_CYCLE = "continuouslyCycle",
	CHANNEL = "channel",
	CHANNEL_SFX = "SFX",
	CHANNEL_MUSIC = "MUSIC",
	CHANNEL_AMBIENT = "AMBIENT",
	CHANNEL_MASTER = "MASTER"
}

IncentiveProgram.TickRate  = 20
IncentiveProgram.SoundRate = 1
IncentiveProgram.CycleRate = 1.5

IncentiveProgram.ALERT = 1
IncentiveProgram.TOAST = 2

--Dungeon Constants
IncentiveProgram.DUNGEON_REMOVED = 1
IncentiveProgram.DUNGEON_ADDED = 2
IncentiveProgram.DUNGEON_DIFFERENCE = 3

IncentiveProgram.TOAST_TANK = "\124TInterface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES:20:20:0:0:64:64:0:19:22:41\124t Tank"
IncentiveProgram.TOAST_HEALER = "\124TInterface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES:20:20:0:0:64:64:20:39:1:20\124t Healer"
IncentiveProgram.TOAST_DAMAGE = "\124TInterface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES:20:20:0:0:64:64:20:39:22:41\124t Damage"


--Context Menu
IncentiveProgram.ContextMenu = {
    TANK = 2,
    HEALER = 3,
    DAMAGE = 4,
    
    ROLES = "roles",
    IGNORE = "ignore",
    SETTINGS = "settings",
    
    QUEUE = "queue",
    JOIN = "join",
	
	INTERFACE_PANEL = "interfacePanel"
}

IncentiveProgram.ContextLabels = {
    ROLES = "Roles",
    TANK = "Tank",
    HEALER = "Healer",
    DAMAGE = "Damage",
    
    IGNORED = "Ignored",
    NO_IGNORED = "No Ignored Dungeons",
    
    SETTINGS = "Settings",
    HIDE_IN_PARTY = "Hide in Party",
    HIDE_ALWAYS = "Hide Always",
	HIDE_EMPTY = "Hide When Empty",
    HIDE_MINIMAP = "Hide Minimap Icon",
    ALERT = "Alert When New",
    ALERT_TOAST = "Alert With Toast",
	IGNORE_COMPLETED_LFR = "Ignore Completed LFRs",
	INTERFACE_PANEL = "Interface Panel",
    
    IGNORE = "Ignore",
    UNIGNORE = "Unignore",
    
    JOIN_QUEUE = "Join Queue",
	
	TOOLTIP_IGNORE_LFR = "LFRs with all encounters defeated no longer alert or show in count, but still show up in left click menu.",
	TOOLTIP_HIDE_ALWAYS = "Hide's the frame always.  This is intended for use with Data Brokers.  Type /ip to undo.",
	TOOLTIP_SOUND_ID_1 = "You can find Sound IDs at http://www.wowhead.com/sounds. When you find a sound, the ID is in the address bar (i.e. http://www.wowhead.com/sound=47615/ui-groupfinderreceiveapplication)",
	TOOLTIP_SOUND_ID_2 = "You can find Sound IDs at http://www.wowhead.com/sounds. When you find a sound, the ID is in the address bar (i.e. http://www.wowhead.com/sound=18019/ui-bnettoast)",
	TOOLTIP_SOUND_REPEATS = "Number of times the sound effect plays.",
	TOOLTIP_CYCLE_COUNT = "Number of times the three coin images rotate when a new alert appears.",
	TOOLTIP_CONTINUOUSLY_CYCLE = "The frame will continuously cycle the coin images while an alert is active.",
	
	SOUNDS = "Sounds",
	SOUND_ID = "Sound ID",
	REPEATS = "Repeats",
	ALERT_PING = "Alert Ping",
	TOAST_PING = "Toast Ping",
	TEST = "Test",
	
	ANIM_CYCLES = "Cycles",
	CONTINUOUSLY_CYCLE = "Continuously Cycle",
	
	RESET_POSITION = "Reset Position"
}