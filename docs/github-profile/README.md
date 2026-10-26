# Pretty Good Pigeon — end-to-end encrypted messaging (RSO 2026/27, UL FRI)

Pretty Good Pigeon is a messenger for 1:1 and group chats with rich text and images, where content is encrypted and decrypted only on the participants' devices (MLS, RFC 9420). The server stores and routes ciphertext; it never holds decryption keys.

ekipa 13: Tibor Koderman, Amar Mehić, Eva Vidic.

| Project | Role |
| --- | --- |
| [identity-service](https://github.com/rso-ekipa13/identity-service) | Identity provider (OAuth 2.0 / OIDC), accounts, organizations (tenants), devices, roles |
| [keys-service](https://github.com/rso-ekipa13/keys-service) | Public key directory, MLS KeyPackages, key-change log |
| [conversation-service](https://github.com/rso-ekipa13/conversation-service) | Conversations and groups — Event Sourcing, CQRS, gRPC |
| [message-service](https://github.com/rso-ekipa13/message-service) | Encrypted envelope store and ordering (ScyllaDB) |
| [realtime-service](https://github.com/rso-ekipa13/realtime-service) | WebSocket live delivery and presence |
| [media-service](https://github.com/rso-ekipa13/media-service) | Encrypted attachments via SAS (Azure Blob Storage) |
| [notification-service](https://github.com/rso-ekipa13/notification-service) | Content-free push notifications (Firebase Cloud Messaging) |
| [media-functions](https://github.com/rso-ekipa13/media-functions) | Azure Functions: attachment validation and expiry |
| [client-app](https://github.com/rso-ekipa13/client-app) | Flutter client (Android, iOS, web) |
| [platform](https://github.com/rso-ekipa13/platform) | Terraform, cluster platform, local dev environment |
| [docs](https://github.com/rso-ekipa13/docs) | Architecture, ADRs, compliance, reports |

Stack: .NET 10 · Flutter · ScyllaDB · PostgreSQL · NATS JetStream · Envoy Gateway · Azure Kubernetes Service · Helm · GitHub Actions · Terraform · OpenTelemetry, Prometheus, Grafana, Loki.

Every service project has the same layout (Clean Architecture, `helm/` chart, `.github/workflows/` calling the shared workflows) and branches `main` (protected) and `dev`.
