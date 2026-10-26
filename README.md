# Šepet — documentation

Šepet is an end-to-end encrypted messenger (1:1 and group chats, rich text, encrypted images) built as a cloud-native microservice application for the course *Računalniške storitve v oblaku* (UL FRI, 2026/27) by **Projektna ekipa 13 "Ključarji"**: Tibor Koderman, Amar Mehić, Eva Vidic.

This repository holds the documentation: architecture, decisions, requirement tracking and the reports. Source code lives in one repository per microservice (see `docs/repos.md`).

## Contents

| Path | What |
|---|---|
| `reports/01-prijava-teme/` | Topic submission (Slovenian, LaTeX) — `prijava-teme.tex` + TikZ diagram `diagrams/arhitektura.tex` → `prijava-teme.pdf` |
| `reports/_predloga/` | Pandoc/LaTeX template for Markdown-based reports |
| `COMPLIANCE.md` | Every course requirement, its status, interpretations and deviations |
| `PLAN.md` | Implementation plan: waves, owners, conventions, budget, risks |
| `docs/decisions.md` | Open and accepted team decisions with options and recommendations |
| `docs/adr/` | Architecture decision records (Slovenian) |
| `docs/repos.md` | Repository map, owners and descriptions |
| `docs/gitlab-profile/README.md` | Group README (pushed to the `gitlab-profile` project) |
| `scripts/` | Group bootstrap (GitLab; GitHub variant for a mirror) |
| `project.md` | Course metadata for the team's tooling |

## Building the reports

Requirements: `lualatex` (TeX Live with `polyglossia`, TikZ, Libertinus and TeX Gyre fonts); Markdown-based reports also need `pandoc` ≥ 3 and the Inter font.

```bash
make -C reports/01-prijava-teme
```

## Repositories

All projects live in the public GitLab group <https://gitlab.koderverse.com/fri-mag/rso> (one project per microservice, see `docs/repos.md`). They were created with:

```bash
scripts/bootstrap-gitlab-group.sh --dry-run
```

```bash
scripts/bootstrap-gitlab-group.sh
```

After the first pushes, `main` is protected in every project (no direct push, merge requests only):

```bash
scripts/bootstrap-gitlab-group.sh --protect
```

`scripts/bootstrap-github-org.sh` creates the same layout in a GitHub organization, for a later mirror.

## Branching

`main` is protected (merge requests only, one review by team rule) and always deployable; `dev` is the integration branch. Work happens on `feat/<issue>-<slug>` branches merged into `dev` by merge request; releases are merge requests from `dev` to `main`.

## Course material

`instructions/` (lecture slides, instructions) is copyrighted course material and is kept out of git.
