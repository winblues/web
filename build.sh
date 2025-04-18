#!/bin/bash
set -e

echo "Building MkDocs..."
cd src
mkdocs build -d ../static/95/docs
cd ..

if [ ! -d main/themes/re-terminal ]; then
  git clone --depth 1 https://github.com/mirus-ua/hugo-theme-re-terminal.git winblues/themes/re-terminal
fi

echo "Building Hugo..."
cd main
hugo -d ../static
cd ..
