#!/usr/bin/env bash
# Source list of the classics pack: prints the absolute path of every candidate source, one
# per line, in the order the pack is built (earlier byte-identical copies win). With
# `--palette` it prints the Office palette source instead (MSO97.DLL of the Office 97 CD).
# All Microsoft-specific file and folder names of this pack live here.
#   BENTWIRE_REFERENCE=$BENTWIRE_REFERENCE BENTWIRE_SOURCES=~/Sources/bentwire sources.sh
set -euo pipefail
: "${BENTWIRE_REFERENCE:?NOT RUN: set BENTWIRE_REFERENCE}" "${BENTWIRE_SOURCES:?NOT RUN: set BENTWIRE_SOURCES}"
R=$BENTWIRE_REFERENCE
if [ "${1:-}" = "--palette" ]; then
  echo "$R/MSO97.DLL"
  exit 0
fi
files() { find "$1" -maxdepth 1 -type f -iname "$2" | LC_ALL=C sort; }
files "$BENTWIRE_SOURCES" '*.acs'                       # Agent 2.0 ACS (the 12 files)
for d in $(find "$R/acf/downloads" -mindepth 1 -maxdepth 1 -type d | LC_ALL=C sort); do
  files "$d" '*.acf' | head -n 1                          # Agent 2.0 web characters
done
files "$R/Characters" '*.acs'   # Agent 1.5
files "$R/source-files" '*.acs'                                # Agent 1.5, third party
files "$R/source-files" '*.act'        # Office 97 and Microsoft Bob actors
files "$R/source-files" '*.act'           # Office 97 CD (act-format 2.1)
