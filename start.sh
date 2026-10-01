#!/bin/bash
# Start email MCP server as HTTP (accessible from other devices)
uvx mcp-email-server@latest --transport streamable-http --port 8000
