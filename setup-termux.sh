#!/bin/bash
# Termux setup for email MCP server
# Run this in Termux on your Android phone

echo "=== Termux Email MCP Setup ==="
echo ""

# Update packages
pkg update -y
pkg upgrade -y

# Install dependencies
pkg install -y python nodejs-lts curl

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Install email MCP server
echo "Installing email MCP server..."
uvx mcp-email-server@latest --version || true

# Create start script
cat > start.sh << 'EOF'
#!/bin/bash
# Start email MCP server in Termux
uvx mcp-email-server@latest --transport streamable-http --port 8000 --host 0.0.0.0
EOF

chmod +x start.sh

echo ""
echo "=== Termux Setup Complete! ==="
echo ""
echo "To start the server:"
echo "  ./start.sh"
echo ""
echo "Your laptop can connect to:"
echo "  http://<phone-ip>:8000/mcp"
echo ""
echo "Find your phone IP with: ip addr show wlan0"
echo ""
