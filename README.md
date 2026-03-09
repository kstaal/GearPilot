# Gear Pilot

A World of Warcraft addon that enhances item tooltips with custom values for better gear evaluation.

## Features

- ✨ Displays custom calculated values when you hover over items
- 🎯 Works with bag items, bank items, and linked items
- ⚙️ Fully configurable via chat commands
- 💾 Saves your preferences between sessions
- 📱 Easy slash command interface

## Installation

### From Addon Manager (Recommended)
1. Open Curse Client, WoWUp, or your preferred addon manager
2. Search for "Gear Pilot"
3. Click Install
4. Restart World of Warcraft

### Manual Installation
1. Download the latest release
2. Extract the `GearPilot` folder to your WoW AddOns directory:
   - **Windows**: `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\`
   - **Mac**: `/Applications/World of Warcraft/_retail_/Interface/AddOns/`
3. Restart World of Warcraft

## Usage

### Chat Commands
```
/gp                  - Show help menu
/gp toggle           - Enable/disable the addon
/gp proof            - Toggle proof string display in tooltips
/gp version          - Show addon version
```

### How It Works
1. Hover over any item in your bags, bank, or in chat links
2. The addon displays a custom "GP Proof" value in the tooltip
3. This value is calculated based on the item's ID

## Configuration

The addon saves its settings to `GearPilotDB` in your WoW saved variables. You can modify settings via `SavedVariables/GearPilot.lua` or use the chat commands above.

Current settings:
- `enabled` - Toggle addon on/off
- `showProofString` - Toggle proof value display

## Development

### Project Structure
```
GearPilot/
├── GearPilot/           # Main addon folder (goes in AddOns directory)
│   ├── GearPilot.toc   # Addon metadata
│   ├── Core.lua        # Core addon initialization
│   ├── Tooltip.lua     # Tooltip hooking and enhancements
│   └── Config.lua      # Configuration and slash commands
├── .pkgmeta            # Packaging metadata for Curse/WoWUp
├── CHANGELOG.md        # Version history
└── README.md           # This file
```

### Modifying Tooltip Values

Edit the `CalculateProofString` function in `GearPilot/Tooltip.lua` to implement your custom calculations:

```lua
function GearPilot:CalculateProofString(itemID, itemName)
    -- Add your custom logic here
    -- Return a string to display in the tooltip
    return "Your custom value"
end
```

## Publishing to Curse/WoWUp

### Step 1: Prepare Your Repository

1. Create a GitHub repository: https://github.com/new
   - Name it `GearPilot` (or similar)
   - Add a description
   - Initialize with LICENSE and README (already have these)

2. Initialize git and push:
```bash
cd s:\VSCodeProjects\GearPilot
git init
git add .
git commit -m "Initial commit: GearPilot v1.0.0"
git remote add origin https://github.com/YOUR_USERNAME/GearPilot.git
git push -u origin main
```

### Step 2: Create a Release

1. In GitHub, go to Releases → Create new release
2. Tag version: `v1.0.0`
3. Set title: `Gear Pilot v1.0.0`
4. Add release notes (include key features and fixes)
5. Publish release

### Step 3: Register on Curse

1. Go to https://www.curseforge.com/wow/addons/create
2. Fill in addon details:
   - **Name**: Gear Pilot
   - **Summary**: Enhances item tooltips with custom values
   - **Description**: Use your README content
   - **Category**: Tooltip/Information
   - **Game Version**: World of Warcraft - Retail
   - **License**: Select appropriate license (MIT/GPL/etc.)

3. Link your GitHub repository:
   - Under "Links", add your GitHub repository URL
   - Enable "Automatically upload releases from GitHub"

4. Upload your addon
5. Submit for review (usually approved within 24 hours)

### Step 4: List on WoWUp (Alternative/Additional)

1. Go to https://wowup.io/addons
2. Click "Submit Addon"
3. Provide:
   - GitHub repository URL
   - License information
   - Addon description

4. Submit for review

### Step 5: Maintain and Update

When you make updates:

1. Update `GearPilot.toc` Interface version if needed
2. Update `CHANGELOG.md` with changes
3. Commit changes: `git commit -am "Update: description of changes"`
4. Create new GitHub release:
   - Tag: `v1.0.1` (increment version)
   - Release name: `Gear Pilot v1.0.1`
   - Description: Copy from CHANGELOG
5. Curse/WoWUp will automatically pick up the new release

## Troubleshooting

### Addon not showing values
- Make sure the addon is enabled: `/gp toggle`
- Verify proof string display is on: `/gp proof`
- Check that AddOns are enabled in WoW launcher

### Values not calculating correctly
- Check the `CalculateProofString` function for errors
- Ensure the item ID is being extracted correctly
- Check WoW chat for error messages

## Requirements

- World of Warcraft: Retail (Patch 11.0+)
- No dependencies required (optional: LibStub for advanced features)

## License

See [LICENSE](LICENSE) file for details.

## Support

For issues, feature requests, or questions:
1. Create an issue on GitHub
2. Leave a comment on CurseForge
3. Visit the WoWUp Discord

## Credits

Created with ❤️ for the WoW community

---

**Note**: Before publishing, make sure to:
- Test thoroughly in-game
- Update author name in GearPilot.toc
- Choose and finalize your LICENSE
- Update version numbers consistently
