-- specs/tooltip_spec.lua
-- Unit tests for Tooltip module
-- Run with: busted specs/tooltip_spec.lua

-- Mock WoW API globals for testing
_G.GetItemInfo = function(itemID)
  if itemID == 12345 then
    return "Test Item", "link", 4, 60, 50, "Armor", "Plate"
  elseif itemID == 67890 then
    return "Legendary Sword", "link", 5, 70, 60, "Weapon", "Sword"
  end
  return nil
end

_G.select = select or function(index, ...)
  local args = {...}
  return args[index]
end

-- Load the addon namespace
local GearPilot = {}

-- GearPilot functions to test
function GearPilot:ExtractItemIDFromLink(link)
  if not link then return nil end
  local itemID = link:match("item:(%d+)")
  return tonumber(itemID)
end

function GearPilot:GetItemNameFromLink(link)
  if not link then return nil end
  local name = link:match("%[(.-)%]")
  return name
end

function GearPilot:CalculateProofString(itemID, itemName)
  if not itemID then return nil end
  local proofValue = (itemID * 7) % 1000
  local proofString = string.format("GP Proof: %d", proofValue)
  return proofString
end

-- Test suite
describe("GearPilot Tooltip Module", function()
  
  describe("ExtractItemIDFromLink", function()
    
    it("should extract item ID from valid link", function()
      local link = "|cffFFFFFF|Hitem:12345:0:0:0:0:0:0:0|h[Test Item]|h|r"
      local result = GearPilot:ExtractItemIDFromLink(link)
      assert.are.equal(12345, result)
    end)
    
    it("should return nil for nil input", function()
      local result = GearPilot:ExtractItemIDFromLink(nil)
      assert.is_nil(result)
    end)
    
    it("should return nil for empty string", function()
      local result = GearPilot:ExtractItemIDFromLink("")
      assert.is_nil(result)
    end)
    
    it("should extract large item IDs", function()
      local link = "|cffFFFFFF|Hitem:999999:0:0:0:0:0:0:0|h[Item]|h|r"
      local result = GearPilot:ExtractItemIDFromLink(link)
      assert.are.equal(999999, result)
    end)
    
    it("should handle multiple colons in link", function()
      local link = "|cffFFFFFF|Hitem:67890:1:2:3:4:5:6:7|h[Legendary]|h|r"
      local result = GearPilot:ExtractItemIDFromLink(link)
      assert.are.equal(67890, result)
    end)
    
  end)
  
  describe("GetItemNameFromLink", function()
    
    it("should extract item name from valid link", function()
      local link = "|cffFFFFFF|Hitem:12345:0:0:0:0:0:0:0|h[Test Item]|h|r"
      local result = GearPilot:GetItemNameFromLink(link)
      assert.are.equal("Test Item", result)
    end)
    
    it("should return nil for nil input", function()
      local result = GearPilot:GetItemNameFromLink(nil)
      assert.is_nil(result)
    end)
    
    it("should extract single word names", function()
      local link = "|cffFFFFFF|Hitem:12345:0:0:0:0:0:0:0|h[Sword]|h|r"
      local result = GearPilot:GetItemNameFromLink(link)
      assert.are.equal("Sword", result)
    end)
    
    it("should extract multi-word names", function()
      local link = "|cffFFFFFF|Hitem:12345:0:0:0:0:0:0:0|h[Crown of the Eternal King]|h|r"
      local result = GearPilot:GetItemNameFromLink(link)
      assert.are.equal("Crown of the Eternal King", result)
    end)
    
  end)
  
  describe("CalculateProofString", function()
    
    it("should generate proof string for valid item ID", function()
      local result = GearPilot:CalculateProofString(12345, "Test Item")
      assert.is_truthy(result)
      assert.matches("GP Proof:", result)
    end)
    
    it("should return nil for nil item ID", function()
      local result = GearPilot:CalculateProofString(nil, "Item Name")
      assert.is_nil(result)
    end)
    
    it("should calculate consistent values", function()
      local result1 = GearPilot:CalculateProofString(12345, "Item")
      local result2 = GearPilot:CalculateProofString(12345, "Item")
      assert.are.equal(result1, result2)
    end)
    
    it("should calculate different values for different IDs", function()
      local result1 = GearPilot:CalculateProofString(100, "Item1")
      local result2 = GearPilot:CalculateProofString(200, "Item2")
      assert.are_not_equal(result1, result2)
    end)
    
    it("should use modulo 1000 for proof value", function()
      -- itemID * 7 % 1000
      -- 12345 * 7 = 86415
      -- 86415 % 1000 = 415
      local result = GearPilot:CalculateProofString(12345, "Item")
      assert.matches("GP Proof: 415", result)
    end)
    
    it("should handle zero item ID", function()
      local result = GearPilot:CalculateProofString(0, "Item")
      assert.matches("GP Proof: 0", result)
    end)
    
    it("should handle large item IDs", function()
      local result = GearPilot:CalculateProofString(999999, "Item")
      assert.is_truthy(result)
      assert.matches("GP Proof:", result)
    end)
    
  end)
  
  describe("Integration", function()
    
    it("should extract and calculate for complete item link", function()
      local link = "|cffFFFFFF|Hitem:12345:0:0:0:0:0:0:0|h[Test Item]|h|r"
      local itemID = GearPilot:ExtractItemIDFromLink(link)
      local itemName = GearPilot:GetItemNameFromLink(link)
      local proofString = GearPilot:CalculateProofString(itemID, itemName)
      
      assert.are.equal(12345, itemID)
      assert.are.equal("Test Item", itemName)
      assert.matches("GP Proof:", proofString)
    end)
    
  end)
  
end)
