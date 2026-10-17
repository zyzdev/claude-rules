#!/usr/bin/env bash
# SessionStart hook: prints the user's working rules. Claude Code adds a SessionStart hook's
# plain-text stdout to the session context, so nothing here needs JSON escaping.
set -euo pipefail

ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

printf '%s\n\n' "以下是使用者 zyzdev 設定、要在所有專案套用的工作規則。它們由 execution-planning-rules 外掛（github.com/zyzdev/claude-rules）在每個 session 開始時載入。"
cat "$ROOT/rules.md"
