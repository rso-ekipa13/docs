# Compliance report: topic submission

Checked against `instructions/Navodila_prijava projekta.md` (the učilnica assignment text) on 2026-10-26.
Document: `prijava-teme.pdf` (3 pages; source `prijava-teme.tex`, diagram `diagrams/arhitektura.tex`).

## Required content of the submission

| # | Instruction | Where in the PDF | Status |
|---|---|---|---|
| 1 | Project title | title on page 1 | ✅ |
| 2 | Group members | header table | ✅ |
| 3 | Project group number | header table ("13") | ✅ |
| 4 | Group name | header table ("Ključarji") | ✅ |
| 5 | Short description in **one paragraph**: purpose, goals, the problem and how the solution solves it | sec. 1 (one paragraph) | ✅ |
| 6 | Frameworks, technologies and development environments | sec. 2 (table) | ✅ |
| 7 | Architecture diagram showing interactions between microservices | sec. 3 + Fig. 1 | ✅ |
| 8 | Communication protocols marked on the diagram | Fig. 1 (REST, OIDC, WebSocket, gRPC/Protobuf, NATS events, SAS, Event Grid, HTTPS) | ✅ |
| 9 | List of functionalities for each microservice | sec. 4 (table, 7 services) | ✅ |
| 10 | List of use cases | sec. 5 (9 use cases) | ✅ |
| 11 | One more complex use case involving several microservices | sec. 5, "Kompleksnejši primer" (media, message, conversation, realtime, notification + Azure Function) | ✅ |
| 12 | Submitted as **PDF** | `prijava-teme.pdf` | ✅ |
| 13 | Submitted by **one person** per group | upload to učilnica | ⏳ pending (deadline 26. 10. 2026 23:59) |

## Preparation steps the instructions ask for

| # | Instruction | Evidence | Status |
|---|---|---|---|
| 14 | Design the project in line with the requirements, using a microservice architecture | 7 microservices + GUI, sec. 3–4 | ✅ |
| 15 | Use cases cover basic and more advanced functionality | sec. 5 (basic: login, messaging; advanced: groups, QR verification, disappearing messages, organizations) | ✅ |
| 16 | Number of microservices fits the team size | 7 microservices for 3 members (≥ 2 per member required) | ✅ |
| 17 | Different communication types and suitable protocols considered | sync REST/gRPC, async NATS events, WebSocket push; explained in sec. 3 | ✅ |
| 18 | Plan per microservice, links between them, responsibilities, protocols | sec. 4 table + Fig. 1 | ✅ |
| 19 | Organization and repositories created (GitHub or similar) | public GitLab group `fri-mag/rso`, 13 projects, one per microservice, `main` protected + `dev` | ✅ |
| 20 | Development environment prepared | Tibor: .NET 10, Flutter, Docker, kubectl, helm, terraform, kind installed. Amar and Eva: accounts on the GitLab instance and local tools not yet set up | 🔵 partial |

**Submission: 18 of 20 checks done.** Remaining: the upload by one person, and Amar's and Eva's GitLab accounts and local tools.

## Deliberately left out of the submission

The instructions list what the submission must contain, so the PDF holds only that. These topics stay in the repository instead: security model, autoscaling plan, cost and budget, team ownership (`PLAN.md`, `docs/decisions.md` D-19..D-29).

## Whole project at a glance (from `COMPLIANCE.md`)

| Group | Done | Partial | Not started |
|---|---|---|---|
| Topic submission (SUB) | 12 | 1 (upload) | 0 |
| Environment setup (ENV) | 2 | 2 | 1 (Azure account and cluster) |
| Graded requirements 1–20 (GR) | 0 | 1 (repository) | 19 |
| Bonus requirements 21–24 (OPT) | 0 | 0 | 4 |
| Process requirements (REQ) | 0 | 0 | 11 |

Implementation starts with wave W1 (27. 10.–8. 11. 2026) in `PLAN.md`.
