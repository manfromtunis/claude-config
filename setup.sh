#!/bin/bash

# Claude Code Configuration Setup Script

set -e

echo "🛠️  Setting up Claude Code configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed. Please install Node.js >= 18.0.0${NC}"
    exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//')
REQUIRED_VERSION="18.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo -e "${RED}❌ Node.js version $NODE_VERSION is too old. Please install >= 18.0.0${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Node.js $NODE_VERSION is compatible${NC}"

# Check npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ npm is available${NC}"

# Create Claude Code config directory
echo "📁 Setting up Claude Code directories..."
mkdir -p ~/.config/claude-code/hooks

# Install MCP Servers
echo "📦 Installing MCP servers..."

# Install Context7
echo "🔧 Installing Context7..."
if npm install -g @upstash/context7-mcp; then
    echo -e "${GREEN}✅ Context7 installed successfully${NC}"
else
    echo -e "${YELLOW}⚠️  Context7 installation failed, but continuing...${NC}"
fi

# Clone and setup Zen MCP Server
echo "🔧 Setting up Zen MCP Server..."
if [ ! -d "zen-mcp-server" ]; then
    if git clone https://github.com/BeehiveInnovations/zen-mcp-server.git; then
        echo -e "${GREEN}✅ Zen MCP Server cloned${NC}"
    else
        echo -e "${YELLOW}⚠️  Zen MCP Server clone failed${NC}"
    fi
else
    echo -e "${GREEN}✅ Zen MCP Server already exists${NC}"
fi

# Setup Zen environment
if [ -d "zen-mcp-server" ]; then
    cd zen-mcp-server
    if [ ! -f ".env" ]; then
        if [ -f ".env.example" ]; then
            cp .env.example .env
            echo -e "${YELLOW}📝 Created .env file - please add your API keys:${NC}"
            echo "   - Visit https://aistudio.google.com/ for Gemini API key"
            echo "   - Edit zen-mcp-server/.env with your keys"
        fi
    fi
    cd ..
fi

# Copy hooks
echo "🎣 Installing hooks..."
cp hooks/* ~/.config/claude-code/hooks/
chmod +x ~/.config/claude-code/hooks/*
echo -e "${GREEN}✅ Hooks installed and made executable${NC}"

# Create MCP config
echo "⚙️  Creating MCP configuration..."
cat > ~/.config/claude-code/mcp-config.json << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["@upstash/context7-mcp"],
      "env": {}
    },
    "zen": {
      "command": "./zen-mcp-server/run-server.sh",
      "args": [],
      "env": {}
    }
  }
}
EOF

echo -e "${GREEN}✅ MCP configuration created${NC}"

# Final instructions
echo ""
echo -e "${GREEN}🎉 Claude Code configuration setup complete!${NC}"
echo ""
echo "📋 Next steps:"
echo "1. Copy CLAUDE.md to your project root:"
echo "   cp CLAUDE.md /path/to/your/project/"
echo ""
echo "2. Configure API keys for Zen MCP Server:"
echo "   cd zen-mcp-server"
echo "   nano .env  # Add your Gemini API key"
echo ""
echo "3. Test the setup:"
echo "   cd /path/to/your/project"
echo "   claude-code"
echo ""
echo -e "${YELLOW}📝 Remember to always use this phrase:${NC}"
echo '   "Let me research the codebase using zen gemini and Context7 to create a plan before implementing."'
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"