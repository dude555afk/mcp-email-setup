# Security Policy

## Reporting a Vulnerability

If you find a security issue in these setup scripts, please open an issue or reach out directly.

## Important: Your Credentials Stay Local

- **Never** commit `.env`, `credentials.json`, `token.json`, or any file containing passwords / OAuth tokens to this repo.
- The email MCP server stores credentials in your **OS keyring**, not in plaintext files.
- If you ever accidentally commit a secret, treat it as compromised and rotate it immediately.

## Safe Usage

- Run the server behind Tailscale, ngrok, or your local LAN only.
- Do not expose `http://0.0.0.0:8000/mcp` directly to the public internet without authentication.
- Use a dedicated app password or OAuth client with minimum required scopes.
- Prefer a throwaway / secondary email account for testing.

## If You Want This Repo Private

1. Open the repo on GitHub.
2. Go to **Settings → General → Danger Zone**.
3. Click **Change repository visibility → Make private**.
4. Confirm.

This keeps the code available to you without exposing it publicly.
