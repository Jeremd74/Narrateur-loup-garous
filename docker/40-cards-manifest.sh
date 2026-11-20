#!/bin/sh
set -e
DIR=/usr/share/nginx/html/cards
[ -d "$DIR" ] || exit 0
cd "$DIR"
{
  printf '{\n'
  first=1
  for f in *.jpg *.jpeg *.png *.webp; do
    [ -f "$f" ] || continue
    h=$(sha256sum "$f" | cut -c1-16)
    [ "$first" -eq 1 ] || printf ',\n'
    printf '  "%s": "%s"' "$f" "$h"
    first=0
  done
  printf '\n}\n'
} > manifest.json