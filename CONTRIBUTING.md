# Contributing

## Branches

Use `<type>/<issue>-<slug>`, for example `fix/1219-time-slot-parse`. The default
branch is `main` in every repository.

## Commits

Conventional Commits: `type(scope): subject`. Types in use: `feat`, `fix`,
`refactor`, `chore`, `ci`, `test`, `docs`, `perf`, `style`, `build`, `revert`.

## Pull requests

- Keep a PR to one change.
- Link the issue when one exists.
- Make CI green before asking for review: tests, lint, typecheck and build for
  the repository you touched.
- A backend request from a frontend repository is an issue on
  `Ownima/owner-api`, not a task file in the frontend repository.
- Cross-repository references are full URLs.

## Types and schemas

Frontends generate their API types from the backend OpenAPI schema. Never
hand-edit generated directories (`gen`, `gen_types`). Regenerate and commit the
snapshot instead.

## Where to ask

See [SUPPORT.md](SUPPORT.md).
