# Ownima — Vehicle Rental Management Platform

**Empowering rental businesses through modern, scalable technology.**

---

## What We Build

Ownima is a full-stack vehicle rental platform connecting rental businesses with their customers:

| Product | Description | Stack |
|---------|-------------|-------|
| [**Owner API**](https://github.com/Ownima/owner-api) | Backend powering all business logic, REST API, background workers | Python · FastAPI · PostgreSQL · OpenSearch |
| [**Owner Web**](https://github.com/Ownima/owner-web) | Owner dashboard — fleet management, reservations, finance | React 18 · TypeScript · Capacitor (mobile) |
| [**Rider Web**](https://github.com/Ownima/rider-web) | Customer-facing app — vehicle browsing, booking, multilingual | Vue 3 · TypeScript · i18n (EN/RU/TH/VI/ID) |
| [**Admin Panel**](https://github.com/Ownima/ownima-admin) | Internal admin — analytics, user management, operations | React 19 · TypeScript |

---

## Infrastructure

```
PostgreSQL  — transactional data (users, wallets, transactions)
OpenSearch  — vehicle/reservation documents + event log
Redis       — background job queue (SAQ) + metrics cache
MinIO       — vehicle images and file uploads
```

Deployed via **Docker + Ansible**. CI/CD on **GitHub Actions**. Releases automated with **Release Please**.

---

## Key Features

- Multi-language support: English, Russian, Thai, Vietnamese, Indonesian
- Role-based access control (Owner / Rider / Admin)
- Flexible pricing templates (seasonal, duration-based)
- Real-time availability and reservation management
- Financial dashboards, wallet system, transaction history
- Web + native mobile (iOS/Android via Capacitor)
- Background processing via SAQ worker queue
- MCP server for vehicle image recognition

---

## Development

Each repo has a `CLAUDE.md` with detailed development guidance. Quick links:

- **Backend**: `cd owner-api/ownima-backend && docker compose watch`
- **Owner Web**: `cd owner-web && bun dev`
- **Rider Web**: `cd rider-web && bun dev`

See [RELEASING.md](../RELEASING.md) for the release process and conventional commit conventions.

---

## Team

| Role | GitHub |
|------|--------|
| Backend / Architecture | [@zaebee](https://github.com/zaebee) |
| Product / QA | [@ownima-ivan](https://github.com/ownima-ivan) |
| Frontend | [@AlexandrovTLG](https://github.com/AlexandrovTLG) · [@ReD1KC](https://github.com/ReD1KC) |

---

🌐 [beta.ownima.com](https://beta.ownima.com) · 📧 support@ownima.com
