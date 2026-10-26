# Šepet — documentation

Šepet is an end-to-end encrypted messenger (1:1 and group chats, rich text, encrypted images) built as a cloud-native microservice application for the course *Računalniške storitve v oblaku* (UL FRI, 2026/27) by **Projektna ekipa 13 "Ključarji"**: Tibor Koderman, Amar Mehić, Eva Vidic.

This repository holds the documentation: architecture, decisions, requirement tracking and the reports. Source code lives in one repository per microservice in the GitHub organization <https://github.com/rso-ekipa13> (see `docs/repos.md`).

## Contents

| Path | What |
|---|---|
| `reports/` | Reports (topic submission, final report). Kept locally and out of git until they are final. |
| `COMPLIANCE.md` | Every course requirement, its status, interpretations and deviations |
| `PLAN.md` | Implementation plan: waves, owners, conventions, budget, risks |
| `docs/decisions.md` | Open and accepted team decisions with options and recommendations |
| `docs/adr/` | Architecture decision records (Slovenian) |
| `docs/repos.md` | Repository map, owners and descriptions |
| `docs/github-profile/README.md` | GitHub organization profile (in `rso-ekipa13/.github`) |
| `docs/gitlab-profile/README.md` | GitLab group README (mirror) |
| `scripts/` | Organization bootstrap (GitHub primary, GitLab mirror) |
| `project.md` | Course metadata for the team's tooling |

## Building the reports

Requirements: `lualatex` (TeX Live with `polyglossia`, TikZ, Libertinus and TeX Gyre fonts); Markdown-based reports also need `pandoc` ≥ 3 and the Inter font.

```bash
make -C reports/01-prijava-teme
```

## Repositories

Primary: the public GitHub organization <https://github.com/rso-ekipa13>, one repository per microservice (`docs/repos.md`), created with:

```bash
scripts/bootstrap-github-org.sh rso-ekipa13
```

After the first pushes, `main` is protected everywhere (pull request + 1 review):

```bash
scripts/bootstrap-github-org.sh rso-ekipa13 --protect
```

Mirror: the GitLab group <https://gitlab.koderverse.com/fri-mag/rso> (same project names, created with `scripts/bootstrap-gitlab-group.sh`). In this repository `origin` pushes to both.

## Branching

`main` is protected (pull request + 1 review) and always deployable; `dev` is the integration branch. Work happens on `feat/<issue>-<slug>` branches merged into `dev` by pull request; releases are pull requests from `dev` to `main`.

## Course material

`instructions/` (lecture slides, instructions) is copyrighted course material and is kept out of git.
