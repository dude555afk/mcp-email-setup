#!/bin/bash
# Quick pre-commit check: refuse to commit obvious secret files
# Usage: ./check-secrets.sh

RED='\033[0;31m'
NC='\033[0m'

SUSPECT_PATTERNS=(
  "credentials.json"
  "token.json"
  "secrets.json"
  ".env"
  "*.pem"
  "*.p12"
  "*.pfx"
  "*.key"
)

FOUND=0

for pattern in "${SUSPECT_PATTERNS[@]}"; do
  matches=$(git ls-files | grep -E "$pattern" || true)
  if [ -n "$matches" ]; then
    echo -e "${RED}[BLOCKED]${NC} Possible secret files detected:"
    echo "$matches"
    FOUND=1
  fi
done

if [ "$FOUND" -eq 1 ]; then
  echo ""
  echo "Remove these files from git tracking before committing."
  echo "If they were already pushed, rotate those credentials immediately."
  exit 1
fi

echo "No obvious secret files found in git tracking. Proceed with caution."
