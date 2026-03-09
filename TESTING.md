# Gear Pilot - Testing Guide

Quick reference for running tests and checking code quality.

## Quick Start

```powershell
# Run all tests
busted specs/

# Check code quality
luacheck GearPilot/
```

## Setup (One Time)

```powershell
# Install test framework
luarocks install busted

# Install code linter
luarocks install luacheck
```

## Commands Reference

### Run Tests

```powershell
# All tests
busted specs/

# Specific module
busted specs/tooltip_spec.lua

# With details
busted specs/ --verbose

# Show coverage
busted specs/ --coverage
```

### Check Code

```powershell
# Find issues
luacheck GearPilot/

# Detailed report
luacheck GearPilot/ --verbose

# Auto-fix simple issues
luacheck GearPilot/ --fix
```

## Test Modules

| File | Tests | Purpose |
|------|-------|---------|
| `specs/tooltip_spec.lua` | Item link parsing, proof string calculation | Core tooltip functionality |
| `specs/config_spec.lua` | Message formatting, command validation | Configuration system |
| `specs/core_spec.lua` | Version parsing and comparison | Addon initialization |

## Common Patterns

### Test a new function

```lua
it("should do something", function()
  local result = MyFunction(input)
  assert.are.equal(expected, result)
end)
```

### Test error cases

```lua
it("should handle nil input", function()
  local result = MyFunction(nil)
  assert.is_nil(result)
end)
```

### Test multiple scenarios

```lua
describe("Function Name", function()
  it("should work with valid input", function()
    -- test passed
  end)
  
  it("should fail with invalid input", function()
    -- test failure
  end)
end)
```

## CI/CD

Tests run automatically on GitHub:
- On every push
- On pull requests
- **Lint** → **Unit Tests** → **Validation**

Check status in GitHub → **Actions** tab

## Debugging Tests

```powershell
# Run single test with output
busted specs/tooltip_spec.lua:10
```

**Add prints to test:**
```lua
it("debug test", function()
  print("Debug info here")
  assert.is_true(true)
end)
```

## Test Coverage

View what you're testing:

```powershell
# Generate coverage report
busted specs/ --coverage
```

Look for:
- **High coverage** on critical functions (>80%)
- **All edge cases** tested
- **Error paths** validated

## Tips

✅ **DO:**
- Test pure functions (no WoW API calls)
- Mock WoW globals in test setup
- Test edge cases (nil, empty, large values)
- Use descriptive test names
- Run tests before committing

❌ **DON'T:**
- Mock the WoW API in addon code (use in tests only)
- Skip error case testing
- Ignore failing tests
- Commit without running tests

## Resources

- [Busted Testing Framework](https://olivinelabs.com/busted/)
- [Luacheck Linter](https://github.com/mpeterv/luacheck)
- [Lua Test Patterns](https://olivinelabs.com/busted/index.html#basic-usage)
