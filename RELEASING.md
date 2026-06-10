# Releasing

Ownima uses [Release Please](https://github.com/googleapis/release-please) to automate versioning and changelog generation across all repos.

## How it works

Release Please watches commits on `main` and determines the next version from **conventional commit prefixes**:

| Commit prefix | Version bump | Example |
|---------------|-------------|---------|
| `fix: ...` | patch | `0.2.28` → `0.2.29` |
| `feat: ...` | minor | `0.2.28` → `0.3.0` |
| `feat!: ...` or `BREAKING CHANGE:` in body | major | `0.2.28` → `1.0.0` |
| `chore:`, `docs:`, `refactor:`, `ci:`, etc. | none | no release PR created |

On every push to `main` it either:
1. **Creates/updates a release PR** — titled `chore(main): release X.Y.Z` with an auto-generated CHANGELOG
2. **Tags and releases** — when the release PR is merged, it creates the git tag and GitHub Release

## Repos with Release Please

| Repo | Config | Current version |
|------|--------|----------------|
| `owner-api` | `release-please-config.json` + `.release-please-manifest.json` | see manifest |
| `rider-web` | `release-please-config.json` + `.release-please-manifest.json` | see manifest |

Both use a **GitHub App token** (`OWNIMA_BOT_APP_ID` + `OWNIMA_BOT_PRIVATE_KEY`) instead of `GITHUB_TOKEN` because the org restricts PR creation for Actions.

## Workflow

```
push to main
    └─► release-please runs
            ├─ no releasable commits → nothing happens
            └─ releasable commits found
                    ├─ release PR already open → updates it
                    └─ no open release PR → creates one
                                └─ merge release PR
                                        └─ creates git tag + GitHub Release
```

## Tips

- **Force a specific version**: update `.release-please-manifest.json` manually and merge to main — Release Please will pick it up on the next run
- **Skip a release**: add `Release-As: skip` to the release PR description
- **Always patch bumps**: set `"versioning-strategy": "always-bump-patch"` in `release-please-config.json`
- **Non-releasable commits** (`chore:`, `ci:`, `docs:`) do not block a release PR from accumulating — they just don't trigger one on their own
