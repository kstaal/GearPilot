# Publishing Guide: Curse, WoWUp, and GitHub

This guide walks you through publishing the Gear Pilot addon to popular addon distribution platforms.

## Prerequisites

- GitHub account (free at https://github.com/signup)
- CurseForge account (free at https://www.curseforge.com/auth/register)
- Git installed on your computer (https://git-scm.com)
- VS Code or text editor to manage files

## Step 1: Create a GitHub Repository

### 1.1 Create New Repository

1. Log in to GitHub at https://github.com
2. Click the **+** icon in top right → **New repository**
3. Fill in details:
   - **Repository name**: `GearPilot`
   - **Description**: `A World of Warcraft addon that enhances item tooltips with custom values`
   - **Public**: Select this (required for CurseForge)
   - **Add a README file**: Check this
   - **Choose a license**: Select MIT or Apache 2.0

4. Click **Create repository**

### 1.2 Add Your Files

Option A: Using Command Line (Recommended)

```powershell
# Navigate to your project
cd s:\VSCodeProjects\GearPilot

# Initialize git repository
git init
git add .
git commit -m "Initial commit: GearPilot v1.0.0"

# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/GearPilot.git

# Rename branch to main (GitHub default)
git branch -M main

# Push to GitHub
git push -u origin main
```

Option B: Using GitHub Desktop

1. Download GitHub Desktop from https://desktop.github.com
2. File → New Repository
3. Select your GearPilot folder
4. Publish to GitHub

### 1.3 Verify Files on GitHub

Go to your repository: `https://github.com/YOUR_USERNAME/GearPilot`

You should see:
- GearPilot/ folder containing all addon files
- README.md
- CHANGELOG.md
- DEVELOPMENT.md
- LICENSE
- .pkgmeta

## Step 2: Create Release on GitHub

### 2.1 Tag and Release

```powershell
# Create a git tag
git tag -a v1.0.0 -m "Initial release"

# Push the tag
git push origin v1.0.0
```

Or via GitHub Website:

1. Go to your repository
2. Click **Releases** on the right sidebar
3. Click **Create a new release**
4. Fill in:
   - **Tag version**: `v1.0.0`
   - **Release title**: `Gear Pilot v1.0.0 - Initial Release`
   - **Description**:
     ```
     ## Initial Release

     ### Features
     - Custom values displayed in item tooltips
     - Configurable via slash commands
     - Supports bag, bank, and linked items
     - Green-colored proof string for easy identification

     ### Commands
     - /gp toggle - Enable/disable addon
     - /gp proof - Toggle proof string display

     ### Installation
     1. Download GearPilot.zip from the attachments below
     2. Extract to World of Warcraft\Interface\AddOns\
     3. Restart WoW and enable addon
     ```

5. Click **Publish release**

### 2.2 Prepare Release Package

When you publish a release, GitHub automatically creates a ZIP file. However, you can also manually create it:

1. In your GearPilot folder, right-click the `GearPilot` subfolder
2. Send to → Compressed (zipped) folder
3. Rename to `GearPilot-1.0.0.zip`
4. Remove the outer `GearPilot` folder from the ZIP (only the addon folder should be top-level)

## Step 3: Register on CurseForge

### 3.1 Create Addon Project

1. Go to https://www.curseforge.com/wow/addons/create
2. Log in or create account
3. Fill in project details:

   **Project Name**: Gear Pilot
   
   **Project Summary**: Enhances item tooltips with custom calculated values for better gear evaluation
   
   **Description**: 
   ```
   Gear Pilot enhances item tooltips to display custom calculated values when hovering over items. Perfect for evaluating gear upgrades at a glance.

   ## Features
   - Custom values in item tooltips
   - Works with bag items, bank items, and chat links
   - Fully configurable
   - Saved preferences

   ## Commands
   - /gp toggle - Enable/disable
   - /gp proof - Toggle proof string display
   - /gp help - Show help

   ## Links
   - GitHub: https://github.com/YOUR_USERNAME/GearPilot
   
   See README for full documentation.
   ```

4. Select appropriate categories:
   - **Category**: Tooltip/Information (or similar)
   - **Game Version**: World of Warcraft - Retail
   - **License**: MIT License (or your choice)

5. Click **Save Draft**

### 3.2 Upload Your Addon

Option A: Automatic from GitHub (Recommended)

1. In your CurseForge project, go to **Links**
2. Add your GitHub repository:
   - **Type**: GitHub Repository
   - **URL**: `https://github.com/YOUR_USERNAME/GearPilot`
3. Click **Connected and Configure**
4. Enable "Automatically upload releases"
5. CurseForge will now automatically pick up releases from GitHub

Option B: Manual Upload

1. Go to **Files** tab
2. Click **Add File**
3. Upload your `GearPilot-1.0.0.zip`
4. Fill in:
   - **Release Type**: Release
   - **Game Version**: Retail
   - **Changelog**: Copy from CHANGELOG.md

### 3.3 Submit for Review

1. Ensure all required fields are filled
2. Click **Submit Project**
3. CurseForge will review (usually 24 hours)
4. Once approved, it will be visible on CurseForge

### 3.4 Create Addon Icon (Optional but Recommended)

1. Create a 256×256 pixel PNG image for your addon
2. Make it visually distinctive
3. In project settings, upload as **Project Avatar**

Good icon tips:
- Use clear, readable text/symbols
- Include "GP" or "Gear Pilot" initials
- Use WoW-appropriate colors

## Step 4: List on WoWUp (Alternative)

### 4.1 Register Addon

1. Go to https://wowup.io/addons
2. Click **Submit Addon**
3. Enter details:
   - **Name**: Gear Pilot
   - **GitHub URL**: `https://github.com/YOUR_USERNAME/GearPilot`
   - **Description**: Enhances item tooltips with custom values
   - **License**: MIT
   - **Website**: https://github.com/YOUR_USERNAME/GearPilot

4. Submit form
5. Usually approved within 24-48 hours

WoWUp automatically pulls updates from GitHub releases.

## Step 5: Maintaining Your Addon

### 5.1 Making Updates

When you fix bugs or add features:

1. Update files in your local directory
2. Update `CHANGELOG.md`:
   ```markdown
   ## [1.0.1] - 2026-03-15

   ### Fixed
   - Fixed tooltip not appearing for some items

   ### Added
   - New chat command `/gp settings`
   ```

3. Update version in `GearPilot/GearPilot.toc`:
   ```lua
   ## Version: 1.0.1
   ```

4. Commit and push:
   ```powershell
   git add .
   git commit -m "v1.0.1: Fix tooltip bug"
   git tag -a v1.0.1 -m "Version 1.0.1"
   git push origin main
   git push origin v1.0.1
   ```

5. Create GitHub release with changelog
6. CurseForge and WoWUp automatically update

### 5.2 Update Cycle

1. **Test** - Use `/reload` in-game to test changes
2. **Version** - Update version numbers (semantic versioning: Major.Minor.Patch)
3. **Document** - Update CHANGELOG.md
4. **Commit** - Push to GitHub with meaningful commit messages
5. **Release** - Create GitHub release with notes
6. **Verify** - Check CurseForge/WoWUp picked up your update (may take 24 hours)

### 5.3 Responding to Issues

Users will report bugs or request features via:
- **CurseForge**: Comments section
- **GitHub**: Issues tab
- **WoWUp**: Community feedback

Respond promptly:
1. Thank them for feedback
2. Provide update timeline
3. Tag issues as bug/enhancement
4. Close with version that fixes issue

## Step 6: Best Practices

### Version Numbering

Use Semantic Versioning: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes (1.0.0 → 2.0.0)
- **MINOR**: New features (1.0.0 → 1.1.0)
- **PATCH**: Bug fixes (1.0.0 → 1.0.1)

### Changelog Format

```markdown
## [1.0.1] - 2026-03-15

### Added
- New feature description

### Fixed
- Bug fix description

### Changed
- Change description

### Removed
- Removed feature description
```

### TOC File Updates

If you add new Lua files or change the addon structure, update `GearPilot.toc`:

```lua
## Interface: 110100    # Update if WoW version changes
## Version: 1.0.1       # Update version
## Title: Gear Pilot    # Keep consistent

Core.lua
Tooltip.lua
Config.lua
NewFile.lua            # Add new files here
```

### Testing Before Release

```powershell
# Test on fresh WoW installation
# 1. Create test character
# 2. Delete any GearPilot folders
# 3. Extract your ZIP file to AddOns
# 4. Load in WoW
# 5. Test all features

# Run through checklist:
# - [ ] Addon loads
# - [ ] No errors in console
# - [ ] Chat commands work
# - [ ] Tooltips display
# - [ ] Settings persist
# - [ ] Works in dungeons/raids
```

## Troubleshooting

### Addon Rejected on CurseForge

Common reasons:
- **Missing TOC file**: Ensure `.toc` file is formatted correctly
- **Broken code**: Test with `/console scriptErrors 1`
- **Copyright issues**: Ensure you own/have permission for all code
- **Low-effort addon**: Should provide meaningful functionality

**Solution**: 
1. Fix issues locally
2. Create new release on GitHub
3. Resubmit to CurseForge

### Addon Not Appearing in Managers

- **GitHub not public**: Change repository to public
- **Wrong folder structure**: Verify folder is named exactly `GearPilot`
- **No release tags**: Create proper GitHub releases (v1.0.0)
- **Waiting for sync**: Give CurseForge/WoWUp 24 hours

### Version Not Updating in Managers

- **TOC version mismatch**: Ensure version matches GitHub tag
- **Release type wrong**: Mark as "Release" not "Alpha/Beta"
- **Cache not cleared**: Clear addon cache in manager
- **Wait for sync**: Managers sync every 24 hours

## Additional Resources

- **CurseForge Author Dashboard**: https://authors.curseforge.com
- **WoWUp Support**: https://wowup.io/help
- **GitHub Help**: https://docs.github.com
- **Semantic Versioning**: https://semver.org

## Support

For publishing issues:
1. Check CurseForge author documentation
2. Look for GitHub Issues in popular addons
3. Ask in r/wowaddons on Reddit
4. Contact CurseForge support directly
