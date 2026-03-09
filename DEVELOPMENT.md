# Gear Pilot - Development Guide

## Setting Up Your Development Environment

### 1. Installation for Development

Clone the repository and set up a symbolic link to your WoW AddOns folder for faster testing:

```powershell
# Navigate to your AddOns directory
cd "C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\"

# Create a symbolic link to your development folder
# Run PowerShell as Administrator
New-Item -ItemType SymbolicLink -Path "GearPilot" -Target "s:\VSCodeProjects\GearPilot\GearPilot"
```

This way, changes you make in VS Code are immediately reflected in WoW without needing to copy files.

### 2. Enable AddOn Development Tools

1. Launch World of Warcraft
2. Go to System → Advanced → Enable Addon Errors (shows errors in-game)
3. Use `/etrace` command to show detailed error traces

## Code Structure

### GearPilot.toc (Table of Contents)
- Lists all Lua files the addon loads
- Specifies interface version for WoW compatibility
- Defines saved variables (persistent data)
- Marks optional dependencies

### Core.lua
- Addon initialization and event handling
- Creates main addon frame
- Sets up event listeners
- Prints welcome message

### Tooltip.lua
- Hooks into GameTooltip functions
- Adds custom information to tooltips
- Handles item ID extraction
- Implements custom calculation logic

### Config.lua
- Slash command registration
- User settings and preferences
- Help text display

## Extending the Addon

### Adding New Tooltip Information

Edit `Tooltip.lua` and modify the `CalculateProofString` function:

```lua
function GearPilot:CalculateProofString(itemID, itemName)
    -- Get item rarity
    local itemRarity = select(3, GetItemInfo(itemID))
    
    -- Get item level
    local itemLevel = select(4, GetItemInfo(itemID))
    
    -- Create custom string
    local customValue = "IL: " .. (itemLevel or "N/A")
    
    return customValue
end
```

### Adding New Chat Commands

Edit `Config.lua` and add new cases to `SlashCmdList.GEARPILOT`:

```lua
elseif cmd == "customize" then
    GearPilot:OpenCustomizationPanel()
end
```

### Accessing Item Information

Common GetItemInfo return values:
```lua
local name, link, rarity, level, minLevel, type, subType, stackCount, 
      texture, vendorPrice = GetItemInfo(itemID)

-- Other useful functions:
local durability, maxDurability = GetInventoryItemDurability(slotID)
local itemStats = GetItemStats(itemLink)
```

### Working with Item Links

Item links have the format:
```
|cffFFFFFF|Hitem:itemID:enchantID:gemID1:gemID2:gemID3:gemID4:suffixID:uniqueID:linkLevel:specializationID:modifiedCrafting|h[Item Name]|h|r
```

Extract parts:
```lua
local itemID = itemLink:match("item:(%d+)")
local gemIDs = {itemLink:match("item:%d+:%d+:(%d+):(%d+):(%d+):(%d+)")}
```

## Testing Your Addon

### In-Game Testing

1. Make changes to your Lua files
2. Use `/reload` in-game to reload the addon
3. Check chat for error messages
4. Verify tooltip changes appear

### Testing Checklist

- [ ] Addon loads without errors
- [ ] Chat commands work `/gp`, `/gp toggle`, `/gp proof`
- [ ] Tooltips display custom values
- [ ] Works with bag items
- [ ] Works with linked items in chat
- [ ] Saved variables persist after logout/login
- [ ] No errors with rare/epic/legendary items

### Debug Printing

Add debug output to your code:

```lua
GearPilot:Print("Debug: itemID = " .. tostring(itemID))
```

Check WoW's error console: `/console scriptErrors 1`

## Unit Testing (Automated)

### Setup

Install dependencies:

```powershell
# Install Lua testing framework
luarocks install busted

# Install code quality checker
luarocks install luacheck
```

### Running Tests

```powershell
# Run all tests
busted specs/

# Run specific test file
busted specs/tooltip_spec.lua

# Run with verbose output
busted specs/ --verbose

# Run with coverage report
busted specs/ --coverage
```

### Test Files

Located in `specs/` directory:

- **tooltip_spec.lua** - Tests for tooltip logic (item ID extraction, proof string calculation)
- **config_spec.lua** - Tests for configuration and chat commands
- **core_spec.lua** - Tests for addon initialization and version handling

Each test file includes:
- Mock WoW API globals for isolated testing
- Test cases for happy paths and error conditions
- Integration tests for multiple functions working together

### Linting Code

Check for code quality issues:

```powershell
# Lint entire addon
luacheck GearPilot/

# Show detailed output
luacheck GearPilot/ --verbose

# Fix simple issues automatically
luacheck GearPilot/ --fix
```

The `.luacheckrc` file configures:
- WoW API globals (GameTooltip, CreateFrame, etc.)
- Code style rules (line length, etc.)
- Which files to check/exclude

### Continuous Integration

GitHub Actions automatically runs tests on every push:

1. **Linting** - Checks code quality
2. **Unit Tests** - Runs Busted test suite
3. **TOC Validation** - Verifies addon metadata
4. **CHANGELOG Validation** - Ensures version history is updated

View results in GitHub: **Actions** tab → Latest workflow

### Writing New Tests

Example test structure:

```lua
describe("Module Name", function()
  
  describe("Function Name", function()
    
    it("should do something", function()
      local result = MyFunction(arg)
      assert.are.equal(expected, result)
    end)
    
    it("should handle edge cases", function()
      local result = MyFunction(nil)
      assert.is_nil(result)
    end)
    
  end)
  
end)
```

Common assertions:

```lua
assert.are.equal(expected, actual)        -- Equality
assert.are_not_equal(val1, val2)          -- Not equal
assert.is_true(value)                     -- Boolean true
assert.is_false(value)                    -- Boolean false
assert.is_nil(value)                      -- nil value
assert.is_truthy(value)                   -- Truthy (not nil/false)
assert.matches("pattern", string)         -- Regex match
```

Refer to [Busted Documentation](https://olivinelabs.com/busted/) for more assertion types.

## WoW API Reference

### Useful Functions

**Item Information:**
- `GetItemInfo(itemID or itemLink)` - Get item details
- `GetItemStats(itemLink)` - Get item stat values
- `GetItemSpells(itemID)` - Get spells on item

**Container Functions:**
- `GetContainerItemLink(bag, slot)` - Get item in bag
- `GetBankItemLink(tab, slot)` - Get bank item
- `GetInventoryItemLink(unitToken, slot)` - Get equipped item

**Events:**
- `ADDON_LOADED` - Addon is loading
- `PLAYER_LOGIN` - Player logged in
- `TOOLTIP_UPDATE` - Tooltip updated
- `ITEM_LOCK_CHANGED` - Item locked/unlocked

### Tooltip Methods

```lua
local tooltip = GameTooltip

-- Add line to tooltip
tooltip:AddLine("Text", red, green, blue)

-- Add two-column line
tooltip:AddDoubleLine("Left", "Right", 1, 1, 1, 1, 1, 1)

-- Show/hide tooltip
tooltip:Show()
tooltip:Hide()

-- Get tooltip size
numLines = tooltip:NumLines()
```

## Performance Considerations

1. **Minimize Calculations**: Cache results when possible
2. **Avoid Repeated Lookups**: Store itemID once, reuse it
3. **Limit Tooltip Updates**: Only update when necessary
4. **Use Local Variables**: Faster than global lookups

```lua
-- ❌ Slow - repeated lookups
for i = 1, 5 do
    local name = GetItemInfo(itemID)
end

-- ✅ Fast - cache the result
local name = GetItemInfo(itemID)
for i = 1, 5 do
    -- reuse name
end
```

## Common Issues

### Tooltip Hook Not Working
- Ensure `SetupTooltipHooks()` is called after `PLAYER_LOGIN`
- Check that GameTooltip still exists and isn't protected

### Item ID Not Extracting
- Verify link format with `print(itemLink)` debug output
- Check regex pattern in `ExtractItemIDFromLink()`

### Saved Variables Not Persisting
- Ensure `SavedVariables: GearPilotDB` is in .toc file
- Check that you're writing to `GearPilotDB`, not local variable

### Errors on Reload
- Use `/reload` instead of relogging
- Check for Lua syntax errors
- Look for "attempt to index nil" errors

## Publishing Checklist

Before submitting to CurseForge/WoWUp:

- [ ] No error messages in-game
- [ ] Works with current WoW patch
- [ ] Update version in `.toc` file
- [ ] Update `CHANGELOG.md`
- [ ] Test on clean WoW installation
- [ ] Verify GitHub repository is public
- [ ] Fill out all CurseForge fields
- [ ] Add addon icon (256x256 PNG is ideal)
- [ ] Provide detailed description

## Resources

- **Official WoW API Docs**: https://wowpedia.fandom.com/wiki/Widget_API
- **Curse Documentation**: https://authors.curseforge.com/wow/addons
- **WoWUp Documentation**: https://wowup.io/help
- **WoW Addon Development Community**: r/wowaddons

## Support

For questions about WoW addon development, check:
- [World of Warcraft Subreddit](https://reddit.com/r/wow)
- [WoW Addon Development Forums](https://www.wowace.com/forums)
- [GitHub Issues](https://github.com/YOUR_USERNAME/GearPilot/issues)
