# Claude Code Configuration Export

Clean configuration export - all secrets replaced with placeholders.

## Files

| File | Description |
|------|-------------|
| `global-config.json` | Global Claude Code settings (MCP servers, preferences) |
| `project-settings.json` | Project-level settings (plugins, permissions) |
| `project-settings-local.json` | Local project overrides |

## MCP Servers Configured

| Server | Type | Auth Required |
|--------|------|---------------|
| Supabase | Plugin (OAuth) | Yes - run `/mcp` |
| Notion | Plugin (OAuth) | Yes - run `/mcp` |
| Figma | Plugin (OAuth) | Yes - run `/mcp` |
| Jam | HTTP (OAuth) | Yes - run `/mcp` |
| GitHub | Local (Token) | Set `GITHUB_PERSONAL_ACCESS_TOKEN` |
| Obsidian | Local (API Key) | Set `OBSIDIAN_API_KEY` |
| Context7 | HTTP | Set `CONTEXT7_API_KEY` |
| Playwright | Plugin | No |

## Import Instructions

### 1. Install Claude Code
```bash
npm install -g @anthropic-ai/claude-code
```

### 2. Copy Global Config
```bash
# Backup existing config first
cp ~/.claude.json ~/.claude.json.backup

# Copy new config
cp global-config.json ~/.claude.json
```

### 3. Update Paths
Replace `/home/YOUR_USER` with your actual home directory path.

### 4. Add Your Secrets
Edit `~/.claude.json` and replace placeholders:
- `YOUR_GITHUB_TOKEN_HERE` → Your GitHub PAT from github.com/settings/tokens
- `YOUR_CONTEXT7_KEY_HERE` → Your Context7 API key
- `YOUR_OBSIDIAN_KEY_HERE` → Your Obsidian REST API key

### 5. Copy Project Settings
```bash
mkdir -p your-project/.claude
cp project-settings.json your-project/.claude/settings.json
```

### 6. Authenticate OAuth Plugins
Run `/mcp` in Claude Code to authenticate:
- Supabase
- Notion
- Figma
- Jam

## Enabled Plugins

- `supabase@claude-plugins-official` - Database management
- `security-guidance@claude-plugins-official` - Security best practices
- `playwright@claude-plugins-official` - Browser automation
- `figma@claude-plugins-official` - Design integration
- `claude-mem@thedotmack` - Session memory
- `Notion@claude-plugins-official` - Notion workspace

## Permissions Pre-configured

Safe bash commands auto-approved:
- `date`, `echo`, `cat`, `ls`, `mkdir`, `wc`, `head`, `tail`, `sort`, `grep`, `tr`
- Git: `add`, `commit`, `status`, `log`, `diff`, `tag`

---
Exported: 2026-01-11
