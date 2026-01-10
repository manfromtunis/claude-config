# Claude Code Configuration Export

## Files Included

1. **global-config.json** - Your global Claude Code settings
   - MCP server configurations
   - Preferences and tips history
   
2. **project-settings.json** - Project-level settings
   - Enabled plugins
   - Permission rules

3. **project-settings-local.json** - Local overrides (don't share if contains secrets)

## Import Instructions

### On New Machine:
```bash
# 1. Install Claude Code first
npm install -g @anthropic-ai/claude-code

# 2. Copy global config
cp global-config.json ~/.claude.json

# 3. For project settings, copy to your project
mkdir -p your-project/.claude
cp project-settings.json your-project/.claude/settings.json
```

### MCP Servers to Re-authenticate:
- Supabase: Run `/mcp` and authenticate
- Notion: Run `/mcp` and authenticate  
- Figma: Run `/mcp` and authenticate
- Jam: Run `/mcp` and authenticate
- GitHub: Update token in config
- Obsidian: Update API key in config

## Sensitive Data Warning
⚠️ Before sharing, remove these from global-config.json:
- GITHUB_PERSONAL_ACCESS_TOKEN
- OBSIDIAN_API_KEY
- Any other API keys/tokens
