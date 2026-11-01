#!/bin/bash
# Publishes a new release of the portal page through Git.
# Usage: ./release.sh v4 "Results are now published."
set -euo pipefail

VERSION="${1:?Give a version, for example v4}"
MESSAGE="${2:?Give a message for the page}"

cd "$(dirname "$0")"
sed -i "s|<p>Welcome to the student portal\..*</p>|<p>Welcome to the student portal. $MESSAGE</p>|" k8s/configmap.yaml
sed -i "s|Release: <code>v[0-9]*</code>|Release: <code>$VERSION</code>|" k8s/configmap.yaml
sed -i "s|release: v[0-9]*|release: $VERSION|" k8s/deployment.yaml

git add k8s
git commit -q -m "Update portal to release $VERSION"
git push -q origin main
git --no-pager log --oneline -1
