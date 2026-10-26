#!/usr/bin/env bash
# Creates the same repositories in an existing GitHub organization (idempotent) — for a later mirror of fri-mag/rso.
#
#   scripts/bootstrap-github-org.sh <org> [--dry-run]     create repos, descriptions, topics, dev branch
#   scripts/bootstrap-github-org.sh <org> --protect       add the main-branch ruleset (run after the first pushes)
#
# Needs: gh (authenticated: gh auth login -s admin:org), an existing organization
# (create it at https://github.com/organizations/plan, Free plan).
set -euo pipefail

org="${1:?usage: $0 <org> [--dry-run|--protect]}"
mode="${2:-}"

run() {
  if [[ "$mode" == "--dry-run" ]]; then printf '+'; printf ' %q' "$@"; echo; else "$@"; fi
}

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
  "client-app|Flutter client (Android and web) with on-device MLS end-to-end encryption, rich text and encrypted images.|flutter,dart,mls,e2ee"
  "platform|Terraform for Azure, cluster platform (Envoy Gateway, NATS, ScyllaDB, CloudNativePG, observability) and the local dev environment.|terraform,kubernetes,helm,aks"
  "docs|Architecture (C4, ADRs), requirements compliance, topic submission and the final technical report (Slovenian).|documentation,architecture"
  ".github|Organization profile and reusable CI/CD workflows.|github-actions"
)
common_topics="rso-2026,sepet,uni-lj-fri"

gh auth status >/dev/null || { echo "gh is not authenticated: run gh auth login -s admin:org"; exit 1; }
gh api "orgs/$org" --jq .login >/dev/null || { echo "organization '$org' not found — create it first"; exit 1; }

protect_main() {
  local repo="$1"
  if gh api "repos/$org/$repo/rulesets" --jq '.[].name' 2>/dev/null | grep -qx protect-main; then
    echo "ruleset exists: $org/$repo"; return
  fi
  run gh api -X POST "repos/$org/$repo/rulesets" --input - <<'JSON'
{
  "name": "protect-main",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["refs/heads/main"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "pull_request", "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": false } }
  ]
}
JSON
}

for entry in "${repos[@]}"; do
  IFS='|' read -r name desc topics <<<"$entry"

  if [[ "$mode" == "--protect" ]]; then
    protect_main "$name"; continue
  fi

  if gh repo view "$org/$name" >/dev/null 2>&1; then
    echo "exists: $org/$name"
  elif [[ "$name" == "docs" ]]; then
    # docs is pushed from the existing local repository, so it starts empty
    run gh repo create "$org/$name" --public --description "$desc"
  else
    run gh repo create "$org/$name" --public --description "$desc" --add-readme
  fi

  run gh repo edit "$org/$name" --description "$desc" --add-topic "$common_topics,$topics" \
    --enable-wiki=false --delete-branch-on-merge

  # dev branch from main (skipped for empty repos and when it already exists)
  if [[ "$mode" != "--dry-run" ]] && sha=$(gh api "repos/$org/$name/git/ref/heads/main" --jq .object.sha 2>/dev/null); then
    gh api "repos/$org/$name/git/ref/heads/dev" >/dev/null 2>&1 \
      || gh api -X POST "repos/$org/$name/git/refs" -f ref=refs/heads/dev -f sha="$sha" >/dev/null
  fi
done

echo "done. Next: push the docs repo, then run: $0 $org --protect"
