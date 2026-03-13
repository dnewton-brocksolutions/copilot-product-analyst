#!/usr/bin/env bash
# ============================================================
# Business Analyst Agent — Install Script
# Usage: bash install.sh [TARGET_PROJECT_PATH]
#
# If TARGET_PROJECT_PATH is not provided, the current working
# directory is used as the target.
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$PWD}"

# ── Verify target directory exists ──────────────────────────
if [[ ! -d "$TARGET" ]]; then
  echo "ERROR: Target directory does not exist: $TARGET"
  exit 1
fi

echo ""
echo "=================================================="
echo "  Business Analyst Agent Installer"
echo "=================================================="
echo "  Source : $SCRIPT_DIR"
echo "  Target : $TARGET"
echo ""

# ── Ask for confirmation ─────────────────────────────────────
read -r -p "Install BA agent into '$TARGET'? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

echo ""

# ── 1. Copy agent file ───────────────────────────────────────
AGENT_SRC="$SCRIPT_DIR/agent/business-analyst-core.agent.md"
AGENT_DST="$TARGET/.github/agents/business-analyst-core.agent.md"

if [[ -f "$AGENT_DST" ]]; then
  read -r -p "  Agent file already exists at .github/agents/. Overwrite? [y/N] " ow_agent
  if [[ ! "$ow_agent" =~ ^[Yy]$ ]]; then
    echo "  Skipped: agent file"
  else
    mkdir -p "$(dirname "$AGENT_DST")"
    cp "$AGENT_SRC" "$AGENT_DST"
    echo "  ✔  Updated: .github/agents/business-analyst-core.agent.md"
  fi
else
  mkdir -p "$(dirname "$AGENT_DST")"
  cp "$AGENT_SRC" "$AGENT_DST"
  echo "  ✔  Created: .github/agents/business-analyst-core.agent.md"
fi

# ── 2. Copy prompt files ─────────────────────────────────────
PROMPTS_SRC="$SCRIPT_DIR/agent/prompts"
PROMPTS_DST="$TARGET/.github/prompts"

if [[ -d "$PROMPTS_DST" ]]; then
  read -r -p "  .github/prompts/ already exists. Overwrite prompt files? [y/N] " ow_prompts
  if [[ ! "$ow_prompts" =~ ^[Yy]$ ]]; then
    echo "  Skipped: prompt files"
  else
    mkdir -p "$PROMPTS_DST"
    cp "$PROMPTS_SRC/"*.prompt.md "$PROMPTS_DST/"
    echo "  ✔  Updated: .github/prompts/ (6 prompt files)"
  fi
else
  mkdir -p "$PROMPTS_DST"
  cp "$PROMPTS_SRC/"*.prompt.md "$PROMPTS_DST/"
  echo "  ✔  Created: .github/prompts/ (6 prompt files)"
fi

# ── 3. Copy documentation folder ────────────────────────────
DOC_SRC="$SCRIPT_DIR/documentation"
DOC_DST="$TARGET/documentation/business-analyst-workflow"

if [[ -d "$DOC_DST" ]]; then
  read -r -p "  documentation/business-analyst-workflow/ already exists. Overwrite? [y/N] " ow_docs
  if [[ ! "$ow_docs" =~ ^[Yy]$ ]]; then
    echo "  Skipped: documentation folder"
  else
    cp -r "$DOC_SRC/." "$DOC_DST/"
    echo "  ✔  Updated: documentation/business-analyst-workflow/"
  fi
else
  mkdir -p "$DOC_DST"
  cp -r "$DOC_SRC/." "$DOC_DST/"
  echo "  ✔  Created: documentation/business-analyst-workflow/"
fi

# ── 4. Create work-items output folder (empty) ───────────────
ITEMS_DIR="$TARGET/documentation/work-items"
if [[ ! -d "$ITEMS_DIR" ]]; then
  mkdir -p "$ITEMS_DIR"
  echo "  ✔  Created: documentation/work-items/  (work item output folder)"
fi

echo ""
echo "=================================================="
echo "  Installation complete!"
echo "=================================================="
echo ""
echo "  Next steps:"
echo ""
echo "  1. Edit your project config:"
echo "     $TARGET/documentation/business-analyst-workflow/project-config.json"
echo ""
echo "  2. Replace all TODO placeholders with your project details."
echo "     See: documentation/business-analyst-workflow/SETUP-CHECKLIST.md"
echo ""
echo "  3. Build your catalogs:"
echo "     documentation/business-analyst-workflow/catalogs/"
echo ""
echo "  4. Test in VS Code:"
echo "     Open Copilot Chat and type: @business-analyst /story Add a login page"
echo ""
