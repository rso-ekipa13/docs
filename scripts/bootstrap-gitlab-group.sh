#!/usr/bin/env bash
# Alternative to bootstrap-github-org.sh when the team chooses GitLab (docs/decisions.md D-01).
#
#   scripts/bootstrap-gitlab-group.sh <group-path> [--dry-run]
#
# Needs: glab authenticated against gitlab.com (glab auth login) and an existing group.
set -euo pipefail

group="${1:?usage: $0 <group-path> [--dry-run]}"
mode="${2:-}"
run() { if [[ "$mode" == "--dry-run" ]]; then printf '+ %q ' "$@"; echo; else "$@"; fi; }

# same list as scripts/bootstrap-github-org.sh (name|description)
repos=(
  "identity-service|Accounts, organizations (tenants), devices and roles; links app accounts to Keycloak. .NET 10, PostgreSQL."
  "keys-service|Public key directory: device identity keys, one-time MLS KeyPackages and a hash-chained key-change log. .NET 10, PostgreSQL."
  "conversation-service|1:1 and group conversations with Event Sourcing and CQRS; GraphQL read model and gRPC membership API. .NET 10, Marten/PostgreSQL."
  "message-service|MLS delivery service: stores and orders end-to-end encrypted envelopes, device sync and disappearing messages. .NET 10, ScyllaDB."
  "realtime-service|WebSocket gateway for live delivery, presence and typing indicators. .NET 10, NATS."
  "media-service|End-to-end encrypted attachments: SAS upload and download (valet key), metadata, quotas and expiry. .NET 10, PostgreSQL, Azure Blob Storage."
  "notification-service|Content-free push notifications via Firebase Cloud Messaging; device push tokens and preferences. .NET 10, PostgreSQL."
  "media-functions|Azure Functions that validate uploaded encrypted attachments (Event Grid) and purge expired ones (timer)."
  "sepet-app|Flutter client (Android and web) with on-device MLS end-to-end encryption, rich text and encrypted images."
  "platform|Terraform for Azure, cluster platform (Envoy Gateway, Keycloak, NATS, ScyllaDB, CloudNativePG, observability) and the local dev environment."
  "docs|Architecture (C4, ADRs), requirements compliance, topic submission and the final technical report (Slovenian)."
)

for entry in "${repos[@]}"; do
  IFS='|' read -r name desc <<<"$entry"
  if glab repo view "$group/$name" >/dev/null 2>&1; then
    echo "exists: $group/$name"; continue
  fi
  if [[ "$name" == "docs" ]]; then
    run glab repo create "$group/$name" --public --description "$desc"
  else
    run glab repo create "$group/$name" --public --description "$desc" --readme
  fi
done

echo "done. Create the dev branch and protect main per project: Settings > Repository > Protected branches."
