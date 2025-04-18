#!/bin/bash
set -e

if [ -n "$DEPLOY_PRIME_URL" ]; then
  # Netlify preview/deploy URL
  BASE_URL="$DEPLOY_PRIME_URL"
else
  # Production URL
  BASE_URL="https://blues.win"
fi

echo "Building MkDocs..."
cd src
mkdocs build -d ../static/95/docs
cd ..

if [ ! -d main/themes/re-terminal ]; then
  git clone --depth 1 https://github.com/mirus-ua/hugo-theme-re-terminal.git main/themes/re-terminal
fi

echo "Building Hugo..."
cd main
hugo --baseURL "$BASE_URL" -d ../static
cd ..
