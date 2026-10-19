# Org profile refresh — design

Date: 2026-10-19
Repo: `Ownima/.github` (local `org-profile/`)
Status: approved for implementation

## Context

`Ownima/.github` is the public org profile plus `RELEASING.md`. The profile
was last overhauled on 2026-06-10, before the 2026-08-28 renames
(`rider-web` → `booking-web`, `ownima-admin` → `owner-admin`) and before
`rider-app`, `support-agent`, `pricing-oracle`, `ownima-blog` and
`ownima-workspace` became part of the org. It now links to a non-existent
repository, misses half the product surface, and describes the React 18 /
single-Vue-app world.

Audience: primarily the Ownima team and AI agents; secondarily external
visitors of `github.com/Ownima`. Product code is private except
`pricing-oracle` and `.github`.

GitHub community health for the repo is 37%: no security, contribution,
support or conduct files, no issue/PR templates.

## Goals

- Make the profile truthful: names, links, stacks, repositories.
- Keep repository links (they are useful for members and agents) and label
  private ones clearly.
- Give AI agents a single entry point.
- Raise the repository to a healthy community baseline.
- Prevent the same drift from recurring with an automated link check.

## Non-goals

- No code changes in product repositories.
- No repository visibility changes.
- No localization of the profile (English only).
- No stage or internal host names in the public profile.

## Decisions

| Question | Decision |
|---|---|
| Audience | Team and AI agents first, external visitors second |
| Private repo links | Keep, mark `(private)`, explain they work for org members |
| Scope | Docs + community files + GitHub settings |
| Team block | Keep, fix: `@zaebee`, `@ownima-ivan`, `@ReD1KC`; drop `@AlexandrovTLG` |
| Profile language | English |
| Canonical domains | `ownima.com`, `rider.ownima.com`, `booking.ownima.com`, `beta.ownima.com`, `admin.ownima.com` |
| Contacts | `contact@ownima.com`; vulnerabilities via GitHub advisories |
| `beta.ownima.com` | Replaces `app.ownima.com` in the profile |

## Deliverables

### 1. `profile/README.md`

1. Ownima — one sentence.
2. Live products — the five canonical domains, no stage hosts.
3. Platform — owner/rider/admin roles, multilingual, reservations, pricing,
   wallet, background jobs.
4. Repositories — table of repo, role, stack; private entries carry
   `(private)`; one line explaining members-only links.
5. Architecture — compact Mermaid diagram: frontends → API →
   PostgreSQL/OpenSearch/Redis/MinIO → workers; recognition, support-agent
   and pricing-oracle shown separately.
6. For AI agents — entry point `Ownima/ownima-workspace`, then `AGENTS.md`
   in each repository; `CLAUDE.md` only imports `AGENTS.md`.
7. Releasing — link to `RELEASING.md`.
8. Team — `@zaebee` (backend/architecture), `@ownima-ivan` (product/QA),
   `@ReD1KC` (frontend).
9. Contact — `contact@ownima.com` and GitHub advisories.

### 2. Other repository files

| File | Change |
|---|---|
| `README.md` | Purpose, contents, how to propose changes |
| `RELEASING.md` | Four release-please repos; correct force-version guidance; App token; note that `rider-app` deploys on Vercel |
| `SECURITY.md` | Reporting via GitHub advisories and `contact@ownima.com` |
| `SUPPORT.md` | Support channels and issue routing |
| `CONTRIBUTING.md` | Branches, conventional commits, PR gates, cross-repo routing |
| `CODE_OF_CONDUCT.md` | Contributor Covenant 2.1, enforcement contact `contact@ownima.com` |
| `ISSUE_TEMPLATE/bug.yml`, `feature.yml`, `config.yml` | Org-wide issue templates |
| `PULL_REQUEST_TEMPLATE.md` | Description and verification checklist |
| `.gitignore` | Minimal, replaces the Python template |

### 3. GitHub settings

Organization: description `Vehicle rental management platform for owners and
riders.`, website `https://ownima.com`, email `contact@ownima.com`.

Repository metadata (description / homepage / topics):

| Repo | Description | Homepage | Topics |
|---|---|---|---|
| `owner-api` | Ownima backend: REST API, SAQ workers, Telegram bot, protobuf schema | — | python, fastapi, postgresql, opensearch, saq |
| `owner-web` | Owner dashboard: fleet, reservations, finance, Capacitor mobile | `https://beta.ownima.com` | react, typescript, capacitor, tanstack, tailwindcss |
| `owner-admin` | Internal admin panel: users, operations, analytics | `https://admin.ownima.com` | react, typescript, vitest, tailwindcss |
| `booking-web` | Rider-facing booking storefront for a single owner | `https://booking.ownima.com` | nuxt, vue, typescript, tailwindcss |
| `rider-app` | Multi-owner rental marketplace for riders | `https://rider.ownima.com` | nuxt, vue, typescript, marketplace |
| `ownima-blog` | Astro SEO site for the Ownima Thailand market | — | astro, typescript, seo |
| `pricing-oracle` | Rental pricing market intelligence over REST, A2A and Fetch.ai uAgent | — | python, fastapi, a2a, fetch-ai |
| `support-agent` | AI support agent: knowledge base, n8n workflows and evals | — | python, n8n, anthropic, evals |
| `ansible` | Ownima infrastructure: deploy playbooks, monitoring, runbooks | — | ansible, docker, monitoring, prometheus |
| `ownima-workspace` | Workspace guide and shared agent skills | — | agents, developer-experience |
| `.github` | Org profile, release guide and community health files | — | — |

Enable private vulnerability reporting where available. Add the `.github`
repository to the org runner group `ci` so the guard workflow can run on the
self-hosted runner.

### 4. Guard workflow

`.github/workflows/profile-links.yml`, triggered on PR, push to `main` and
weekly:

- every `github.com/Ownima/<repo>` link in `profile/README.md` resolves
  (GitHub App token for private repos);
- every live domain in the profile returns 2xx;
- every non-archived org repository is mentioned in the profile.

## Acceptance criteria

- `profile/README.md` contains no reference to `rider-web` or `ownima-admin`.
- All five canonical domains are listed; no `*.ownima.com` stage host appears.
- Each of the ten product/service repositories (all except `.github`)
  appears once in the repository table.
- `RELEASING.md` lists exactly the four release-please repositories.
- `gh api repos/Ownima/.github/community/profile` reports the new files and
  a health percentage above 80%.
- Guard workflow passes on the PR and on a manual run.
- Existing `LICENSE` is unchanged.

## Risks

- Org settings and repository metadata are applied with `gh`; a mistake is
  visible org-wide. Each change is listed in the PR body before it is applied.
- GitHub App secrets may not be available to the `.github` repository; if
  they are missing, the guard falls back to public-link checking and reports
  the private-repo check as skipped instead of failing.
- A Mermaid diagram renders differently across GitHub clients; it stays
  small and text-readable in source.

## Out of scope

- Making product repositories public.
- Rewriting each repository's README.
- Adding a LICENSE to product repositories.
