#!/bin/bash
# ONE-TAP INSTALLER FOR TERMUX
# Just paste this entire block into Termux and hit enter:
# bash <(curl -s https://raw.githubusercontent.com/dude555afk/mcp-email-setup/main/one-tap-install.sh)

set -e

echo "🫩🫩 ONE-TAP EMAIL MCP SETUP 🫩🫩"
echo ""

# Install Termux dependencies if missing
if ! command -v git &> /dev/null; then
    echo "📦 Installing git..."
    pkg install git -y
fi

if ! command -v curl &> /dev/null; then
    echo "📦 Installing curl..."
    pkg install curl -y
fi

# Clone repo if not already present
if [ ! -d "mcp-email-setup" ]; then
    echo "⬇️ Downloading setup files..."
    git clone https://github.com/dude555afk/mcp-email-setup.git
fi

cd mcp-email-setup

# Run Termux setup
echo "⚙️ Running setup..."
bash setup-termux.sh

# Start server automatically
echo "🚀 Starting email MCP server..."
bash start.sh &

echo ""
echo "✅ DONE! Server running on port 8000"
echo ""
echo "📱 Your laptop can connect to: http://$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1):8000/mcp"
echo ""
echo "💡 To stop the server later: pkill -f mcp-email-server"
echo "💡 To start again: cd mcp-email-setup && bash start.sh"
