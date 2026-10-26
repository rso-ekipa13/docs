# Repositories (GitLab group `fri-mag/rso`)

Group: <https://gitlab.koderverse.com/fri-mag/rso> (public). One public project per deployable unit. Project name and description = microservice name and description (env-setup gist). Created by `scripts/bootstrap-gitlab-group.sh`; `scripts/bootstrap-github-org.sh` is kept for a later GitHub mirror.

| Project | Kind | Owner | Description |
|---|---|---|---|
| `identity-service` | microservice | Tibor Koderman | Identity provider (OAuth 2.0 / OpenID Connect) and account service: users, organizations (tenants), devices and roles. .NET 10, PostgreSQL. |
| `keys-service` | microservice | Tibor Koderman | Public key directory: device identity keys, one-time MLS KeyPackages and a hash-chained key-change log. .NET 10, PostgreSQL. |
| `conversation-service` | microservice | Amar Mehić | 1:1 and group conversations with Event Sourcing and CQRS; GraphQL read model and gRPC membership API. .NET 10, Marten/PostgreSQL. |
| `message-service` | microservice | Amar Mehić | MLS delivery service: stores and orders end-to-end encrypted envelopes, device sync and disappearing messages. .NET 10, ScyllaDB. |
| `realtime-service` | microservice | Amar Mehić | WebSocket gateway for live delivery, presence and typing indicators. .NET 10, NATS. |
| `media-service` | microservice | Eva Vidic | End-to-end encrypted attachments: SAS upload and download (valet key), metadata, quotas and expiry. .NET 10, PostgreSQL, Azure Blob Storage. |
| `notification-service` | microservice | Eva Vidic | Content-free push notifications via Firebase Cloud Messaging; device push tokens and preferences. .NET 10, PostgreSQL. |
| `media-functions` | serverless | Eva Vidic | Azure Functions that validate uploaded encrypted attachments (Event Grid) and purge expired ones (timer). |
| `client-app` | GUI | Eva Vidic (+ all) | Flutter client (Android and web) with on-device MLS end-to-end encryption, rich text and encrypted images. |
| `platform` | infrastructure | Tibor Koderman | Terraform for Azure, cluster platform (Envoy Gateway, NATS, ScyllaDB, CloudNativePG, observability) and the local dev environment. |
| `docs` | documentation | all | Architecture (C4, ADRs), requirements compliance, topic submission and the final technical report (Slovenian). This repository. |
| `ci-templates` | CI | Tibor Koderman | Reusable GitLab CI/CD templates (`include: project: fri-mag/rso/ci-templates`). |
| `gitlab-profile` | group meta | Tibor Koderman | Group README shown on the group page (source: `docs/gitlab-profile/README.md`). |

Branches in every project: `main` (protected: no direct push, maintainers merge via merge request) and `dev` (integration). Required approvals are a paid GitLab feature, so "1 review before merge" is a team rule, not an enforced setting.

Team accounts: sign-up is disabled on the instance, so Amar and Eva need accounts created by the admin and Maintainer access to the group.
