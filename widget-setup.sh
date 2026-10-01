#!/bin/bash
# TERMUX HOME SCREEN WIDGET SETUP
# Run this to create a one-tap widget on your phone's home screen

# Create widget script
mkdir -p ~/.shortcuts/targets
cat > ~/.shortcuts/targets/start-email-mcp.sh << 'EOF'
#!/bin/bash
termux-open-termux-app() {
  am start -n com.termux/.TermuxActivity >/dev/null 2>&1 || true
}
termux-open-termux-app
sleep 2
cd ~/mcp-email-setup 2>/dev/null || {
  echo "❌ mcp-email-setup folder not found. Run one-tap-install.sh first!"
  exit 1
}
bash start.sh
EOF

chmod +x ~/.shortcuts/targets/start-email-mcp.sh

# Create shortcut
mkdir -p ~/.shortcuts
cat > ~/.shortcuts/start-email-mcp.shortcut << EOF
{
  "name": "Start Email MCP",
  "target": "start-email-mcp.sh",
  "type": "shell",
  "icon": "email"
}
EOF

echo "✅ Widget setup complete!"
echo ""
echo "📱 To add to home screen:"
echo "1. Long press your home screen"
echo "2. Select 'Widgets' or 'Shortcuts'"
echo "3. Find 'Start Email MCP' and drag it to your home screen"
echo "4. Tap it anytime to start the email MCP server!"
echo ""
echo "💡 If you don't see the widget, restart Termux once."
