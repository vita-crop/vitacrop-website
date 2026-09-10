#!/usr/bin/env bash
#
# Deploy the Vitacrop site to GitHub Pages (free hosting).
#
# ONE-TIME SETUP
#   1. Create a free account at https://github.com
#   2. Create a new EMPTY repository named:  vitacrop-website
#      https://github.com/new  ->  name it "vitacrop-website"
#      Do NOT add a README, .gitignore, or license (keep it empty).
#   3. Run this script from inside this folder, passing the repo URL it shows you:
#
#        ./deploy.sh https://github.com/YOUR-USERNAME/vitacrop-website.git
#
#   4. When it finishes, go to:
#        repo  ->  Settings  ->  Pages
#        "Build and deployment"  ->  Source: "Deploy from a branch"
#        Branch: main   /   Folder: / (root)   ->  Save
#      Your site goes live in ~1 minute at:
#        https://YOUR-USERNAME.github.io/vitacrop-website/
#
# LATER UPDATES
#   Edit index.html (or files in assets/), then just run:
#        ./deploy.sh
#   (no URL needed once the remote is set)

set -euo pipefail
cd "$(dirname "$0")"

REMOTE_URL="${1:-}"

if [ ! -d .git ]; then
  echo "==> Initializing git repository"
  git init
  git branch -M main
fi

if [ -n "$REMOTE_URL" ]; then
  if git remote | grep -qx origin; then
    git remote set-url origin "$REMOTE_URL"
  else
    git remote add origin "$REMOTE_URL"
  fi
  echo "==> Remote 'origin' set to $REMOTE_URL"
fi

if ! git remote | grep -qx origin; then
  echo "ERROR: no 'origin' remote configured."
  echo "Run once with your repo URL, e.g.:"
  echo "  ./deploy.sh https://github.com/YOUR-USERNAME/vitacrop-website.git"
  exit 1
fi

echo "==> Staging files"
git add -A

if git diff --cached --quiet; then
  echo "==> Nothing changed since last deploy."
else
  git commit -m "Deploy Vitacrop site ($(date '+%Y-%m-%d %H:%M'))"
fi

echo "==> Pushing to GitHub (you may be asked for your GitHub username + a"
echo "    Personal Access Token as the password: https://github.com/settings/tokens )"
git push -u origin main

cat <<'DONE'

============================================================
 Pushed.  Final step (only needed the first time):
   1. Open your repo on github.com
   2. Settings  ->  Pages
   3. Source: "Deploy from a branch"
   4. Branch: main   Folder: / (root)   ->  Save
   5. Wait ~1 min, then load:
        https://YOUR-USERNAME.github.io/vitacrop-website/
============================================================
DONE
