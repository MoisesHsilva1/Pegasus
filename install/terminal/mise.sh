#!/bin/bash
set -euo pipefail

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$_DIR/required/app-mise.sh"

