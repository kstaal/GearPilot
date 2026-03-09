-- Gear Pilot - Core addon initialization
-- This file sets up the addon and its event handlers

local addonName, addonTable = ...
GearPilot = addonTable

-- Addon namespace and configuration
GearPilot.version = "1.0.0"
GearPilot.db = GearPilotDB or {
    enabled = true,
    showProofString = true,
}

-- Create main addon frame
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

function frame:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == addonName then
            self:Initialize()
        end
    elseif event == "PLAYER_LOGIN" then
        self:OnPlayerLogin()
    end
end

function frame:Initialize()
    -- Initialize saved variables
    if not GearPilotDB then
        GearPilotDB = GearPilot.db
    else
        GearPilot.db = GearPilotDB
    end
    
    print("|cff00ff00Gear Pilot|r v" .. GearPilot.version .. " loaded")
end

function frame:OnPlayerLogin()
    -- Additional initialization after player login
    GearPilot:SetupTooltipHooks()
end

frame:SetScript("OnEvent", frame.OnEvent)

-- Helper function to print addon messages
function GearPilot:Print(msg)
    print("|cff00ff00Gear Pilot|r: " .. tostring(msg))
end
