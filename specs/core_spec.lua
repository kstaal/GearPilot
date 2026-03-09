-- specs/core_spec.lua
-- Unit tests for Core module
-- Run with: busted specs/core_spec.lua

local GearPilot = {}
GearPilot.version = "1.0.0"
GearPilot.db = {
  enabled = true,
  showProofString = true,
}

-- Mock saved variables
_G.GearPilotDB = nil

-- Core functions to test
function GearPilot:IsVersionValid(version)
  if not version then return false end
  -- Match semver: X.Y.Z
  return version:match("^%d+%.%d+%.%d+$") ~= nil
end

function GearPilot:ParseVersion(versionStr)
  if not versionStr then return nil end
  local major, minor, patch = versionStr:match("^(%d+)%.(%d+)%.(%d+)$")
  if not major then return nil end
  return { major = tonumber(major), minor = tonumber(minor), patch = tonumber(patch) }
end

function GearPilot:CompareVersions(v1, v2)
  local ver1 = GearPilot:ParseVersion(v1)
  local ver2 = GearPilot:ParseVersion(v2)
  
  if not ver1 or not ver2 then return nil end
  
  if ver1.major ~= ver2.major then
    return ver1.major > ver2.major and 1 or -1
  elseif ver1.minor ~= ver2.minor then
    return ver1.minor > ver2.minor and 1 or -1
  elseif ver1.patch ~= ver2.patch then
    return ver1.patch > ver2.patch and 1 or -1
  else
    return 0
  end
end

describe("GearPilot Core Module", function()
  
  describe("Version validation", function()
    
    it("should validate proper semver", function()
      local result = GearPilot:IsVersionValid("1.0.0")
      assert.is_true(result)
    end)
    
    it("should validate large version numbers", function()
      local result = GearPilot:IsVersionValid("999.999.999")
      assert.is_true(result)
    end)
    
    it("should reject invalid format", function()
      local result = GearPilot:IsVersionValid("1.0")
      assert.is_false(result)
    end)
    
    it("should reject text in version", function()
      local result = GearPilot:IsVersionValid("1.0.0-beta")
      assert.is_false(result)
    end)
    
    it("should reject nil", function()
      local result = GearPilot:IsVersionValid(nil)
      assert.is_false(result)
    end)
    
  end)
  
  describe("ParseVersion", function()
    
    it("should parse version string", function()
      local result = GearPilot:ParseVersion("1.2.3")
      assert.are.equal(1, result.major)
      assert.are.equal(2, result.minor)
      assert.are.equal(3, result.patch)
    end)
    
    it("should handle zero values", function()
      local result = GearPilot:ParseVersion("0.0.0")
      assert.are.equal(0, result.major)
      assert.are.equal(0, result.minor)
      assert.are.equal(0, result.patch)
    end)
    
    it("should return nil for invalid format", function()
      local result = GearPilot:ParseVersion("invalid")
      assert.is_nil(result)
    end)
    
  end)
  
  describe("CompareVersions", function()
    
    it("should identify equal versions", function()
      local result = GearPilot:CompareVersions("1.0.0", "1.0.0")
      assert.are.equal(0, result)
    end)
    
    it("should identify newer major version", function()
      local result = GearPilot:CompareVersions("2.0.0", "1.0.0")
      assert.are.equal(1, result)
    end)
    
    it("should identify older major version", function()
      local result = GearPilot:CompareVersions("1.0.0", "2.0.0")
      assert.are.equal(-1, result)
    end)
    
    it("should compare minor versions", function()
      local result = GearPilot:CompareVersions("1.5.0", "1.2.0")
      assert.are.equal(1, result)
    end)
    
    it("should compare patch versions", function()
      local result = GearPilot:CompareVersions("1.0.5", "1.0.2")
      assert.are.equal(1, result)
    end)
    
    it("should return nil for invalid versions", function()
      local result = GearPilot:CompareVersions("invalid", "1.0.0")
      assert.is_nil(result)
    end)
    
  end)
  
end)
