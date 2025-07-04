#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)/scripts"

if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: scripts directory not found at $SCRIPT_DIR"
    exit 1
fi

python3 "$SCRIPT_DIR/exporter.py" "../lib/src"
