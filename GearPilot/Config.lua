-- Gear Pilot - Configuration and chat commands
-- This file handles addon configuration and commands

local _addonName, addonTable = ...
local GearPilot = addonTable

-- Register slash commands
SLASH_GEARPILOT1 = "/gp"
SLASH_GEARPILOT2 = "/gearpilot"

function SlashCmdList.GEARPILOT(msg, _editBox)
    local cmd, _args = msg:match("^(%S*)%s*(.*)$")
    cmd = cmd:lower()

    if cmd == "toggle" or cmd == "" then
        GearPilot:ToggleAddon()
    elseif cmd == "proof" then
        GearPilot:ToggleProofString()
    elseif cmd == "help" then
        GearPilot:PrintHelp()
    elseif cmd == "version" then
        GearPilot:Print("Version: " .. GearPilot.version)
    else
        GearPilot:PrintHelp()
    end
end

--luacheck: ignore 211
function GearPilot:ToggleAddon(_)
    GearPilot.db.enabled = not GearPilot.db.enabled
    if GearPilot.db.enabled then
        GearPilot:Print("Addon |cff00ff00enabled|r")
    else
        GearPilot:Print("Addon |cffff0000disabled|r")
    end
end

--luacheck: ignore 211
function GearPilot:ToggleProofString(_)
    GearPilot.db.showProofString = not GearPilot.db.showProofString
    if GearPilot.db.showProofString then
        GearPilot:Print("Proof string display |cff00ff00enabled|r")
    else
        GearPilot:Print("Proof string display |cffff0000disabled|r")
    end
end
--luacheck: ignore 211

function GearPilot:PrintHelp(_)
    print("|cff00ff00=== Gear Pilot Help ===|r")
    print("|cff00ff00/gp|r or |cff00ff00/gearpilot|r - Show this help")
    print("|cff00ff00/gp toggle|r - Toggle addon on/off")
    print("|cff00ff00/gp proof|r - Toggle proof string display")
    print("|cff00ff00/gp version|r - Show addon version")
end
