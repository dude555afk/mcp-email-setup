# Email MCP Server Setup

Ready-to-run self-hosted email MCP server. Supports Gmail, Outlook, iCloud, and any IMAP/SMTP provider.

## What This Gives You

- 24 email tools via MCP: search, read, send, organize, batch operations
- OAuth2 for Gmail/Outlook
- IMAP/SMTP for any other provider
- Multi-account support
- Can be exposed to your phone/laptop via HTTP

## Quick Start

### Option 1: Automated Setup (Linux/Mac/Termux)

```bash
git clone https://github.com/dude555afk/mcp-email-setup.git
cd mcp-email-setup
chmod +x setup.sh
./setup.sh
```

### Option 2: Manual Setup

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uvx mcp-email-server@latest ui
```

Follow the UI to add your email account.

## Running

### Local only
```bash
uvx mcp-email-server@latest
```

### HTTP (accessible from other devices)
```bash
uvx mcp-email-server@latest --transport streamable-http --port 8000
```

Point your MCP client to: `http://localhost:8000/mcp`

## Expose to Phone

### Tailscale (recommended)
Install Tailscale everywhere, then use `http://<tailscale-ip>:8000/mcp`

### ngrok
```bash
ngrok http 8000
```
Use the generated URL.

### Same WiFi
Use `http://<laptop-local-ip>:8000/mcp`

## MCP Client Config

```json
{
  "mcpServers": {
    "email": {
      "type": "streamable-http",
      "url": "http://localhost:8000/mcp"
    }
  }
}
```

## Security

- Don't expose directly to internet without auth
- Use Tailscale/ngrok for remote access
- Credentials stored in OS keyring

## Credits

Built on [ai-zerolab/mcp-email-server](https://github.com/ai-zerolab/mcp-email-server).
