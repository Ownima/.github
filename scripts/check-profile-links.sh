#!/usr/bin/env bash
# Checks profile/README.md: repository links resolve, live domains answer,
# every non-archived org repository is mentioned.
#
# Usage: check-profile-links.sh [--strict]
#   --strict  a repository link that cannot be resolved is a failure
#             (default: warn, because anonymous callers cannot see private repos)
set -uo pipefail
export PATH="/usr/bin:/bin:$PATH"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README="$ROOT/profile/README.md"
STRICT=0
[ "${1:-}" = "--strict" ] && STRICT=1

[ -f "$README" ] || { echo "missing $README" >&2; exit 2; }

fail=0
warn=0
ok=0

echo "== repository links =="
for name in $(grep -oE 'https://github\.com/Ownima/[A-Za-z0-9._-]+' "$README" | sed 's#.*/##' | sort -u); do
    if gh api "repos/Ownima/$name" >/dev/null 2>&1; then
        echo "  ok   $name"
        ok=$((ok + 1))
    elif [ "$STRICT" -eq 1 ]; then
        echo "  FAIL $name does not resolve"
        fail=$((fail + 1))
    else
        echo "  warn $name not visible to this token"
        warn=$((warn + 1))
    fi
done

echo "== live domains =="
for url in $(grep -oE 'https://([a-z0-9-]+\.)*ownima\.com' "$README" | sort -u); do
    code="$(curl -sI -o /dev/null -w '%{http_code}' --max-time 20 "$url")" || code=000
    case "$code" in
        2*|3*) echo "  ok   $url $code"; ok=$((ok + 1)) ;;
        *)     echo "  FAIL $url $code"; fail=$((fail + 1)) ;;
    esac
done

echo "== coverage =="
listed="$(grep -oE 'https://github\.com/Ownima/[A-Za-z0-9._-]+' "$README" | sed 's#.*/##' | sort -u)"
for name in $(gh repo list Ownima --limit 100 --json name,isArchived \
        --jq '.[] | select(.isArchived == false) | .name' 2>/dev/null | sort); do
    [ "$name" = ".github" ] && continue
    if printf '%s\n' "$listed" | grep -qx "$name"; then
        echo "  ok   $name"
        ok=$((ok + 1))
    else
        echo "  FAIL $name is not mentioned in profile/README.md"
        fail=$((fail + 1))
    fi
done

echo
echo "ok=$ok warn=$warn fail=$fail"
[ "$fail" -eq 0 ]
