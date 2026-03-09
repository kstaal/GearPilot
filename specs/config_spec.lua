-- specs/config_spec.lua
-- Unit tests for Config module
-- Run with: busted specs/config_spec.lua

local GearPilot = {}

-- Mock global slash command system
_G.SLASH_GEARPILOT1 = "/gp"
_G.SLASH_GEARPILOT2 = "/gearpilot"
_G.SlashCmdList = {}

-- Config functions to test
function GearPilot:Print(msg)
  return "|cff00ff00Gear Pilot|r: " .. tostring(msg)
end

function GearPilot:ValidateCommand(cmd)
  if not cmd then return nil end
  return cmd:lower()
end

function GearPilot:IsValidToggleCommand(cmd)
  return cmd == "toggle" or cmd == ""
end

describe("GearPilot Config Module", function()
  
  describe("Print function", function()
    
    it("should format print message", function()
      local result = GearPilot:Print("Test message")
      assert.matches("Gear Pilot", result)
      assert.matches("Test message", result)
    end)
    
    it("should handle numbers", function()
      local result = GearPilot:Print(123)
      assert.matches("123", result)
    end)
    
    it("should handle empty string", function()
      local result = GearPilot:Print("")
      assert.matches("Gear Pilot", result)
    end)
    
  end)
  
  describe("ValidateCommand", function()
    
    it("should convert command to lowercase", function()
      local result = GearPilot:ValidateCommand("TOGGLE")
      assert.are.equal("toggle", result)
    end)
    
    it("should handle mixed case", function()
      local result = GearPilot:ValidateCommand("ToGgLe")
      assert.are.equal("toggle", result)
    end)
    
    it("should return nil for nil input", function()
      local result = GearPilot:ValidateCommand(nil)
      assert.is_nil(result)
    end)
    
    it("should preserve single character commands", function()
      local result = GearPilot:ValidateCommand("H")
      assert.are.equal("h", result)
    end)
    
  end)
  
  describe("IsValidToggleCommand", function()
    
    it("should accept toggle command", function()
      local result = GearPilot:IsValidToggleCommand("toggle")
      assert.is_true(result)
    end)
    
    it("should accept empty string", function()
      local result = GearPilot:IsValidToggleCommand("")
      assert.is_true(result)
    end)
    
    it("should reject other commands", function()
      local result = GearPilot:IsValidToggleCommand("help")
      assert.is_false(result)
    end)
    
    it("should reject nil", function()
      local result = GearPilot:IsValidToggleCommand(nil)
      assert.is_false(result)
    end)
    
  end)
  
end)
