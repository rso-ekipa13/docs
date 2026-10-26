#!/usr/bin/env bash
# Creates the project repositories as a public subgroup on a GitLab instance (idempotent).
#
#   scripts/bootstrap-gitlab-group.sh [--dry-run]     subgroup, projects, descriptions, topics, dev branch
#   scripts/bootstrap-gitlab-group.sh --protect       protect main (no direct push, maintainers merge); run after first pushes
#
# Defaults: GITLAB_HOST=gitlab.koderverse.com, PARENT_GROUP=fri-mag, SUBGROUP=rso.
# Needs: glab authenticated for GITLAB_HOST.
set -euo pipefail

host="${GITLAB_HOST:-gitlab.koderverse.com}"
parent="${PARENT_GROUP:-fri-mag}"
sub="${SUBGROUP:-rso}"
mode="${1:-}"
export GITLAB_HOST="$host"

api() { glab api --hostname "$host" "$@"; }
run() { if [[ "$mode" == "--dry-run" ]]; then printf '+'; printf ' %q' "$@"; echo; else "$@"; fi; }
enc() { python3 -c 'import sys,urllib.parse; print(urllib.parse.quote(sys.argv[1], safe=""))' "$1"; }

# name|description|topics   (description = microservice description, see docs/repos.md)
repos=(
  "identity-service|Identity provider (OAuth 2.0 / OpenID Connect with passkeys) and account service: users, organizations (tenants), devices, roles; read-only admin GraphQL. .NET 10, PostgreSQL.|microservice,dotnet,postgresql,oidc"
  "keys-service|Public key directory: device identity keys, one-time MLS KeyPackages and a hash-chained key-change log. .NET 10, PostgreSQL.|microservice,dotnet,postgresql,mls,e2ee"
  "conversation-service|1:1 and group conversations with Event Sourcing and CQRS; gRPC membership API. .NET 10, Marten/PostgreSQL.|microservice,dotnet,event-sourcing,cqrs,graphql,grpc"
  "message-service|MLS delivery service: stores and orders end-to-end encrypted envelopes, device sync and disappearing messages. .NET 10, ScyllaDB.|microservice,dotnet,scylladb,nats,e2ee"
  "realtime-service|WebSocket gateway for live delivery, presence and typing indicators. .NET 10, NATS.|microservice,dotnet,websocket,nats"
  "media-service|End-to-end encrypted attachments: SAS upload and download (valet key), metadata, quotas and expiry. .NET 10, PostgreSQL, Azure Blob Storage.|microservice,dotnet,azure-blob-storage,postgresql"
  "notification-service|Content-free push notifications via Firebase Cloud Messaging; device push tokens and preferences. .NET 10, PostgreSQL.|microservice,dotnet,fcm,postgresql"
  "media-functions|Azure Functions that validate uploaded encrypted attachments (Event Grid) and purge expired ones (timer).|serverless,azure-functions,dotnet"
  "client-app|Flutter client (Android, iOS and web) with on-device MLS end-to-end encryption, rich text and encrypted images.|flutter,dart,mls,e2ee"
  "platform|Terraform for Azure, cluster platform (Envoy Gateway, NATS, ScyllaDB, CloudNativePG, observability) and the local dev environment.|terraform,kubernetes,helm,aks"
  "docs|Architecture (C4, ADRs), requirements compliance, topic submission and the final technical report (Slovenian).|documentation,architecture"
  "ci-templates|Reusable GitLab CI/CD templates shared by all service repositories.|gitlab-ci"
  "gitlab-profile|Group README shown on the group page.|documentation"
)
common_topics="rso-2026,uni-lj-fri"

parent_id=$(api "groups/$(enc "$parent")" | python3 -c 'import json,sys; print(json.load(sys.stdin)["id"])')

if ! group_json=$(api "groups/$(enc "$parent/$sub")" 2>/dev/null); then
  run api groups -X POST -f name="RSO" -f path="$sub" -f parent_id="$parent_id" -f visibility=public \
    -f description="Računalniške storitve v oblaku 2026/27 — Projektna ekipa 13: E2E-encrypted messenger (microservices on AKS)."
  [[ "$mode" == "--dry-run" ]] && group_id=0 || group_id=$(api "groups/$(enc "$parent/$sub")" | python3 -c 'import json,sys; print(json.load(sys.stdin)["id"])')
else
  group_id=$(python3 -c 'import json,sys; print(json.loads(sys.argv[1])["id"])' "$group_json")
  echo "exists: group $parent/$sub ($group_id)"
fi

for entry in "${repos[@]}"; do
  IFS='|' read -r name desc topics <<<"$entry"
  path="$parent/$sub/$name"

  if [[ "$mode" == "--protect" ]]; then
    pid=$(enc "$path")
    api -X DELETE "projects/$pid/protected_branches/main" >/dev/null 2>&1 || true
    api -X POST "projects/$pid/protected_branches" -f name=main -f push_access_level=0 \
      -f merge_access_level=40 -f allow_force_push=false >/dev/null && echo "protected: $path main"
    continue
  fi

  if api "projects/$(enc "$path")" >/dev/null 2>&1; then
    echo "exists: $path"
  else
    # docs is pushed from the existing local repository, so it starts empty
    body=$(python3 - "$name" "$group_id" "$desc" "$common_topics,$topics" <<'PY'
import json, sys
name, ns, desc, topics = sys.argv[1:5]
print(json.dumps({"name": name, "path": name, "namespace_id": int(ns), "visibility": "public",
                  "description": desc, "default_branch": "main", "topics": topics.split(","),
                  "initialize_with_readme": name != "docs"}))
PY
)
    if [[ "$mode" == "--dry-run" ]]; then echo "+ create $path: $body"; else
      api projects -X POST -H 'Content-Type: application/json' --input - <<<"$body" >/dev/null
      echo "created: $path"
    fi
  fi

  if [[ "$mode" != "--dry-run" ]] && api "projects/$(enc "$path")/repository/branches/main" >/dev/null 2>&1; then
    api "projects/$(enc "$path")/repository/branches/dev" >/dev/null 2>&1 \
      || api -X POST "projects/$(enc "$path")/repository/branches" -f branch=dev -f ref=main >/dev/null
  fi
done

echo "done: https://$host/$parent/$sub"
