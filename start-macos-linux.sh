#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
if [ ! -f .env ]; then
  cp .env.example .env
  echo "A new .env file has been created. Add your API keys, save it, then run this script again."
  exit 0
fi
if [ ! -d node_modules ]; then
  npm install
fi
npm start
