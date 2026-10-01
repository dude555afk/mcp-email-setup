#!/bin/bash
set -e

echo "=== Email MCP Server Setup ==="
echo ""

# Check OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "Detected OS: $MACHINE"

# Install uv if not present
if ! command -v uv &> /dev/null; then
    echo "Installing uv (Python package manager)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Add uv to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"
    
    echo "uv installed successfully!"
else
    echo "uv already installed: $(uv --version)"
fi

# Install the email MCP server
echo ""
echo "Installing email MCP server..."
uvx mcp-email-server@latest --version || true

# Create a convenient start script
cat > start.sh << 'EOF'
#!/bin/bash
# Start email MCP server as HTTP (accessible from other devices)
uvx mcp-email-server@latest --transport streamable-http --port 8000
EOF

chmod +x start.sh

# Create a local-only start script
cat > start-local.sh << 'EOF'
#!/bin/bash
# Start email MCP server as stdio (local only)
uvx mcp-email-server@latest
EOF

chmod +x start-local.sh

# Optional: Create systemd service for Linux
if [ "$MACHINE" = "Linux" ] && [ -d "$HOME/.config/systemd/user" ]; then
    echo ""
    echo "Creating systemd user service for auto-start..."
    
    mkdir -p "$HOME/.config/systemd/user"
    
    cat > "$HOME/.config/systemd/user/email-mcp.service" << EOF
[Unit]
Description=Email MCP Server
After=network.target

[Service]
Type=simple
ExecStart=$HOME/.local/bin/uvx mcp-email-server@latest --transport streamable-http --port 8000
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

    systemctl --user daemon-reload
    echo "Systemd service created. Enable with: systemctl --user enable --now email-mcp"
fi

# Optional: Create launchd plist for Mac
if [ "$MACHINE" = "Mac" ]; then
    echo ""
    echo "Creating launchd plist for auto-start..."
    
    mkdir -p "$HOME/Library/LaunchAgents"
    
    cat > "$HOME/Library/LaunchAgents/com.user.email-mcp.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.email-mcp</string>
    <key>ProgramArguments</key>
    <array>
        <string>$HOME/.local/bin/uvx</string>
        <string>mcp-email-server@latest</string>
        <string>--transport</string>
        <string>streamable-http</string>
        <string>--port</string>
        <string>8000</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

    echo "LaunchAgent created. Load with: launchctl load ~/Library/LaunchAgents/com.user.email-mcp.plist"
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Next steps:"
echo "1. Run ./start.sh to start the server"
echo "2. Run ./start-local.sh for local-only mode"
echo "3. Configure your MCP client to point to http://localhost:8000/mcp"
echo ""
echo "For remote access from your phone:"
echo "- Use Tailscale (recommended)"
echo "- Or ngrok: ngrok http 8000"
echo "- Or use your laptop's local IP on the same WiFi"
echo ""
