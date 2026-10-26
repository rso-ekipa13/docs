# Repositories (GitHub organization `rso-ekipa13`)

Primary: <https://github.com/rso-ekipa13> (public). Mirror: <https://gitlab.koderverse.com/fri-mag/rso>. One public repository per deployable unit; name and description = microservice name and description (env-setup gist). Created by `scripts/bootstrap-github-org.sh` (GitLab: `scripts/bootstrap-gitlab-group.sh`).

| Project | Kind | Owner | Description |
|---|---|---|---|
| `identity-service` | microservice | Tibor Koderman | Identity provider (OAuth 2.0 / OpenID Connect with passkeys) and account service: users, organizations (tenants), devices, roles; read-only admin GraphQL. .NET 10, PostgreSQL. |
| `keys-service` | microservice | Tibor Koderman | Public key directory: device identity keys, one-time MLS KeyPackages and a hash-chained key-change log. .NET 10, PostgreSQL. |
| `conversation-service` | microservice | Amar Mehić | 1:1 and group conversations with Event Sourcing and CQRS; gRPC membership API. .NET 10, Marten/PostgreSQL. |
| `message-service` | microservice | Amar Mehić | MLS delivery service: stores and orders end-to-end encrypted envelopes, device sync and disappearing messages. .NET 10, ScyllaDB. |
| `realtime-service` | microservice | Amar Mehić | WebSocket gateway for live delivery, presence and typing indicators. .NET 10, NATS. |
| `media-service` | microservice | Eva Vidic | End-to-end encrypted attachments: SAS upload and download (valet key), metadata, quotas and expiry. .NET 10, PostgreSQL, Azure Blob Storage. |
| `notification-service` | microservice | Eva Vidic | Content-free push notifications via Firebase Cloud Messaging; device push tokens and preferences. .NET 10, PostgreSQL. |
| `media-functions` | serverless | Eva Vidic | Azure Functions that validate uploaded encrypted attachments (Event Grid) and purge expired ones (timer). |
| `client-app` | GUI | Eva Vidic (+ all) | Flutter client (Android, iOS and web) with on-device MLS end-to-end encryption, rich text and encrypted images. |
| `platform` | infrastructure | Tibor Koderman | Terraform for Azure, cluster platform (Envoy Gateway, NATS, ScyllaDB, CloudNativePG, observability) and the local dev environment. |
| `docs` | documentation | all | Architecture (C4, ADRs), requirements compliance, topic submission and the final technical report (Slovenian). This repository. |
| `.github` | org meta | Tibor Koderman | Organization profile and reusable GitHub Actions workflows (GitLab mirror: `ci-templates`). |
| `gitlab-profile` | group meta (GitLab only) | Tibor Koderman | GitLab group README (source: `docs/gitlab-profile/README.md`). |

Branches in every repository: `main` (protected by a ruleset: pull request + 1 approval, no force push or deletion) and `dev` (integration).

Team access: invite Amar and Eva to the GitHub organization (and, for the mirror, create their GitLab accounts).
