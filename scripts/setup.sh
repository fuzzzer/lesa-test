#!/usr/bin/env bash
set -e  # exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

find_python() {
  for cmd in python3 python3.11 python3.10 python; do
    if command -v "$cmd" >/dev/null 2>&1; then
      "$cmd" -c 'import sys; exit(0) if sys.version_info >= (3, 10) else exit(1)' && {
        echo "$cmd"
        return
      }
    fi
  done
  return 1
}

echo "→ Looking for Python ≥ 3.10 …"
PYBIN=$(find_python) || {
  echo "✗ Python 3.10+ not found."
  echo "👉 Please install Python 3.10 or newer:"
  echo "   https://www.python.org/downloads/"
  exit 1
}

echo "✓ Found Python: $PYBIN"

VENV_DIR="$SCRIPT_DIR/.venv"
if [ ! -d "$VENV_DIR" ]; then
  echo "→ Creating virtual environment in $VENV_DIR …"
  "$PYBIN" -m venv "$VENV_DIR"
fi

source "$VENV_DIR/bin/activate"

echo "→ Installing/Updating dependencies …"
python -m pip install --upgrade pip
pip install -r "$SCRIPT_DIR/requirements.txt"

echo "✓ Setup complete."
echo "   To activate manually later: source $VENV_DIR/bin/activate"
