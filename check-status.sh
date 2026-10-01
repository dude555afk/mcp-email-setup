#!/bin/bash
# Check if email MCP server is running

if pgrep -f "mcp-email-server" > /dev/null; then
    echo "✅ Email MCP server is RUNNING"
    echo ""
    echo "🌐 Access URL:"
    IP=$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    echo "   http://$IP:8000/mcp"
    echo ""
    echo "📱 For MCP client config, use the URL above"
else
    echo "❌ Email MCP server is NOT running"
    echo ""
    echo "Start it with: cd mcp-email-setup && bash start.sh"
fi
