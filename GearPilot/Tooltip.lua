-- Gear Pilot - Tooltip enhancement module
-- This file handles tooltip modifications for items

local _addonName, addonTable = ...
local GearPilot = addonTable

-- Hook into the GameTooltip to add custom information
--luacheck: ignore 211
function GearPilot:SetupTooltipHooks(_)
    -- Store original SetHyperlink function
    local originalSetHyperlink = GameTooltip.SetHyperlink

    function GameTooltip:SetHyperlink(link, ...) --luacheck: ignore 421
        -- Call original function
        local result = originalSetHyperlink(self, link, ...)
        -- Add custom tooltip information
        if link and GearPilot.db.enabled then
            GearPilot:AddCustomTooltipInfo(self, link)
        end
        return result
    end

    -- Also hook SetBagItem for bag tooltips
    local originalSetBagItem = GameTooltip.SetBagItem

    function GameTooltip:SetBagItem(containerID, slotID, ...) --luacheck: ignore 421
        local result = originalSetBagItem(self, containerID, slotID, ...)
        if GearPilot.db.enabled then
            GearPilot:AddBagItemTooltipInfo(self, containerID, slotID)
        end
        return result
    end

    -- Hook for bank items
    local originalSetBankItem = GameTooltip.SetBankItem

    --luacheck: ignore 421
    function GameTooltip:SetBankItem(containerID, slotID, ...) --luacheck: ignore 421slotID, ...)
        if GearPilot.db.enabled then
            GearPilot:AddBankItemTooltipInfo(self, containerID, slotID)
        end
        return result
    end
end

-- Add custom information to item tooltips
--luacheck: ignore 211
function GearPilot:AddCustomTooltipInfo(_, tooltip, link)
    if not link then return end

    -- Extract item ID and name from link
    local itemID = self:ExtractItemIDFromLink(link)
    local itemName = self:GetItemNameFromLink(link)

    GearPilot:Print("DEBUG: itemID=" .. tostring(itemID) ..
        ", showProofString=" .. tostring(GearPilot.db.showProofString))

    if itemID then
        -- Add custom calculation as proof
        local proofString = self:CalculateProofString(itemID, itemName)
        GearPilot:Print("DEBUG: proofString=" .. tostring(proofString))

        if proofString and GearPilot.db.showProofString then
            tooltip:AddLine(proofString, 0.2, 1, 0.2)  -- Green text
            tooltip:Show()
        end
    end
end

--luacheck: ignore 211
-- Add custom information for bag items
function GearPilot:AddBagItemTooltipInfo(_, tooltip, containerID, slotID)
    local itemLink = C_Container.GetContainerItemLink(containerID, slotID)
    if itemLink then
        self:AddCustomTooltipInfo(tooltip, itemLink)
    end
end

--luacheck: ignore 211
-- Add custom information for bank items
function GearPilot:AddBankItemTooltipInfo(_, tooltip, containerID, slotID)
    local itemLink = C_Bank.GetBankItemLink(containerID, slotID)
    if itemLink then
        self:AddCustomTooltipInfo(tooltip, itemLink)
    end
end

-- Extract item ID from item link
--luacheck: ignore 211
-- Format: |cffFFFFFF|Hitem:itemID:enchantID:gemID1:gemID2:gemID3:gemID4:
-- suffixID:uniqueID:linkLevel:specializationID:modifiedCrafting|h[Item Name]|h|r
function GearPilot:ExtractItemIDFromLink(_, link)
    if not link then return nil end

    local itemID = link:match("item:(%d+)")
    return tonumber(itemID)
end
--luacheck: ignore 211

-- Extract item name from item link
function GearPilot:GetItemNameFromLink(_, link)
    if not link then return nil end

    local name = link:match("%[(.-)%]")
    return name
--luacheck: ignore 211
end

-- Calculate custom proof string (your custom logic goes here)
function GearPilot:CalculateProofString(_, itemID, _itemName)
    -- Example: Create a custom string as proof of concept
    -- You can modify this to add any calculations you need

    if not itemID then return nil end

    -- Example calculation: combine item ID with modulo for demonstration
    local proofValue = (itemID * 7) % 1000
    local proofString = string.format("Mike you Noob get a better item! %d",
        proofValue)

    return proofString
end
