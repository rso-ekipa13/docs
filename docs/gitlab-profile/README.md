# Pretty Good Pigeon — end-to-end encrypted messaging (RSO 2026/27, UL FRI)

Pretty Good Pigeon is a messenger for 1:1 and group chats with rich text and images, where content is encrypted and decrypted only on the participants' devices (MLS, RFC 9420). The server stores and routes ciphertext; it never holds decryption keys.

ekipa 13: Tibor Koderman, Amar Mehić, Eva Vidic.

| Project | Role |
| --- | --- |
| [identity-service](https://gitlab.koderverse.com/fri-mag/rso/identity-service) | Identity provider (OAuth 2.0 / OIDC), accounts, organizations (tenants), devices, roles |
| [keys-service](https://gitlab.koderverse.com/fri-mag/rso/keys-service) | Public key directory, MLS KeyPackages, key-change log |
| [conversation-service](https://gitlab.koderverse.com/fri-mag/rso/conversation-service) | Conversations and groups — Event Sourcing, CQRS, gRPC |
| [message-service](https://gitlab.koderverse.com/fri-mag/rso/message-service) | Encrypted envelope store and ordering (ScyllaDB) |
| [realtime-service](https://gitlab.koderverse.com/fri-mag/rso/realtime-service) | WebSocket live delivery and presence |
| [media-service](https://gitlab.koderverse.com/fri-mag/rso/media-service) | Encrypted attachments via SAS (Azure Blob Storage) |
| [notification-service](https://gitlab.koderverse.com/fri-mag/rso/notification-service) | Content-free push notifications (Firebase Cloud Messaging) |
| [media-functions](https://gitlab.koderverse.com/fri-mag/rso/media-functions) | Azure Functions: attachment validation and expiry |
| [client-app](https://gitlab.koderverse.com/fri-mag/rso/client-app) | Flutter client (Android, iOS, web) |
| [platform](https://gitlab.koderverse.com/fri-mag/rso/platform) | Terraform, cluster platform, local dev environment |
| [docs](https://gitlab.koderverse.com/fri-mag/rso/docs) | Architecture, ADRs, compliance, reports |
| [ci-templates](https://gitlab.koderverse.com/fri-mag/rso/ci-templates) | Shared GitLab CI/CD templates |

Stack: .NET 10 · Flutter · ScyllaDB · PostgreSQL · NATS JetStream · Envoy Gateway · Azure Kubernetes Service · Helm · GitLab CI · Terraform · OpenTelemetry, Prometheus, Grafana, Loki.

Every service project has the same layout (Clean Architecture, `helm/` chart, `.gitlab-ci.yml` including the shared templates) and branches `main` (protected) and `dev`.
