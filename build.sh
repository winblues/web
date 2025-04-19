#!/bin/bash
set -e

if [ "$CONTEXT" = "production" ]; then
  BASE_URL="https://blues.win"
else
  BASE_URL="$DEPLOY_PRIME_URL"
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
