# Claude Code Configuration

A reproducible Claude Code configuration optimized for TypeScript/Next.js/Strapi development workflows.

## Overview

This repository provides a complete Claude Code setup with:
- **MCP Servers**: Context7 for documentation and Zen for AI-powered development
- **Development Workflow**: Research → Plan → Implement methodology
- **Automated Hooks**: Quality gates for linting, formatting, and building
- **CLAUDE.md Templates**: Project-specific configuration files

## Quick Setup

```bash
# Clone this repository
git clone https://github.com/yourusername/claude-config.git
cd claude-config

# Run the setup script
chmod +x setup.sh
./setup.sh
```

## What's Included

- **CLAUDE.md template**: Adaptable to any TypeScript/Next.js project
- **MCP server configurations**: Pre-configured for Context7 and Zen
- **Hook scripts**: Automated quality gates
- **Setup automation**: One-command installation
- **Documentation**: Complete usage guide

## Manual Installation

### Prerequisites

- Node.js >= 18.0.0
- Claude Code CLI
- Git

### 1. Install MCP Servers

```bash
# Context7 (no API key required)
npm install -g @upstash/context7-mcp

# Zen MCP Server (requires Gemini API key)
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server
cp .env.example .env
# Edit .env with your Gemini API key
```

### 2. Configure Your Project

```bash
# Copy CLAUDE.md to your project root
cp CLAUDE.md /path/to/your/project/

# Set up hooks
mkdir -p ~/.config/claude-code/hooks
cp hooks/* ~/.config/claude-code/hooks/
chmod +x ~/.config/claude-code/hooks/*
```

### 3. API Keys

For Zen MCP Server, get a Gemini API key from [Google AI Studio](https://aistudio.google.com/):

```env
GEMINI_API_KEY=your-gemini-api-key-here
```

## Usage

### Mandatory Phrase

**ALWAYS use zen gemini** for complex problems and architectural decisions  
**ALWAYS check Context7** for library documentation and best practices

**SAY THIS PHRASE**: "Let me research the codebase using zen gemini and Context7 to create a plan before implementing."

### Development Workflow

1. **Research**: Use Context7 and Zen to understand codebase
2. **Plan**: Create detailed implementation plan
3. **Implement**: Execute with continuous validation

## License

MIT