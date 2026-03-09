-- .luacheckrc
-- Lua code quality configuration

-- WoW API globals
globals = {
  -- Frame API
  "CreateFrame",
  "GetScreenWidth",
  "GetScreenHeight",
  "UIParent",
  
  -- Tooltip API
  "GameTooltip",
  "ItemRefTooltip",
  
  -- Item API
  "GetItemInfo",
  "GetItemStats",
  "GetItemSpells",
  "GetContainerItemLink",
  "GetBankItemLink",
  "GetInventoryItemLink",
  "GetInventoryItemDurability",
  
  -- Event API
  "ADDON_LOADED",
  "PLAYER_LOGIN",
  "TOOLTIP_UPDATE",
  "ITEM_LOCK_CHANGED",
  
  -- Chat/Print
  "print",
  
  -- Slash commands
  "SLASH_GEARPILOT1",
  "SLASH_GEARPILOT2",
  "SlashCmdList",
  
  -- Global saved variables
  "GearPilotDB",
  "GearPilot",
}

-- Allow addon table unpacking
std = "lua51"

-- Exclude spec files from linting (they use mocks)
exclude_files = {
  "specs/",
  ".git/",
  "build/",
}

-- Settings
max_line_length = 120
max_code_line_length = 120
max_string_line_length = 120
max_comment_line_length = 120
