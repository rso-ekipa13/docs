# Šepet — documentation

Šepet is an end-to-end encrypted messenger (1:1 and group chats, rich text, encrypted images) built as a cloud-native microservice application for the course *Računalniške storitve v oblaku* (UL FRI, 2026/27) by **Projektna ekipa 13 "Ključarji"**: Tibor Koderman, Amar Mehić, Eva Vidic.

This repository holds the documentation: architecture, decisions, requirement tracking and the reports. Source code lives in one repository per microservice (see `docs/repos.md`).

## Contents

| Path | What |
|---|---|
| `reports/01-prijava-teme/` | Topic submission (Slovenian) — `prijava-teme.md` → `prijava-teme.pdf` |
| `reports/_predloga/` | Shared pandoc/LaTeX template for all reports |
| `COMPLIANCE.md` | Every course requirement, its status, interpretations and deviations |
| `PLAN.md` | Implementation plan: waves, owners, conventions, budget, risks |
| `docs/decisions.md` | Open and accepted team decisions with options and recommendations |
| `docs/adr/` | Architecture decision records (Slovenian) |
| `docs/repos.md` | Repository map, owners and descriptions |
| `scripts/` | Organization bootstrap (GitHub or GitLab) |
| `project.md` | Course metadata for the team's tooling |

## Building the reports

Requirements: `pandoc` ≥ 3, `lualatex` (TeX Live with `polyglossia`, `pdflscape`, `ragged2e`), Graphviz `dot`, the Inter font.

```bash
make -C reports/01-prijava-teme
```

## Creating the organization repositories

1. Create the organization `sepet-chat` at <https://github.com/organizations/plan> (Free plan) and invite the team.
2. Authenticate: `gh auth login -s admin:org`.
3. Preview, then create:

```bash
scripts/bootstrap-github-org.sh sepet-chat --dry-run
```

```bash
scripts/bootstrap-github-org.sh sepet-chat
```

4. Push this repository as `docs`, then protect `main` everywhere:

```bash
git remote add origin https://github.com/sepet-chat/docs.git
```

```bash
git push -u origin main dev
```

```bash
scripts/bootstrap-github-org.sh sepet-chat --protect
```

## Branching

`main` is protected (pull request + 1 review) and always deployable; `dev` is the integration branch. Work happens on `feat/<issue>-<slug>` branches merged into `dev` by pull request; releases are pull requests from `dev` to `main`.

## Course material

`instructions/` (lecture slides, instructions) is copyrighted course material and is kept out of git.
