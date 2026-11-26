#!/usr/bin/env bash
# Replaces skills/ with the skills of one https://github.com/Webhose/skills release.
# skills/ is generated: change a skill in that repository, never here.
#   scripts/sync-skills.sh          rebuild skills/ from the tag pinned in SKILLS_VERSION
#   scripts/sync-skills.sh v1.2.0   pin another release
set -euo pipefail
cd "$(dirname "$0")/.."

tag="${1:-$(cat SKILLS_VERSION)}"
[[ "$tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Usage: $0 [vX.Y.Z]" >&2; exit 2; }

# Skills whose tool this plugin's server, https://mcp.webz.io/mcp, does not serve.
exclude="webz-news-search"

fresh="$(mktemp -d)"
trap 'rm -rf "$fresh"' EXIT
curl -fsSL "https://github.com/Webhose/skills/archive/refs/tags/$tag.tar.gz" \
  | tar -xz -C "$fresh" --strip-components=2 --wildcards '*/skills/*'
for name in $exclude; do rm -rf "${fresh:?}/$name"; done
[ -n "$(ls "$fresh")" ] || { echo "No skills in $tag" >&2; exit 1; }

rm -rf skills
mkdir skills
cp -r "$fresh"/. skills/
echo "$tag" > SKILLS_VERSION
echo "skills/ is now $tag: $(ls skills | tr '\n' ' ')"
