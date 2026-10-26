# Pretty Good Pigeon: docs

Design notes, decisions and planning for [Pretty Good Pigeon](https://github.com/rso-ekipa13), the end-to-end encrypted messenger that ekipa 13 (Tibor Koderman, Amar Mehić, Eva Vidic) is building for the Cloud Computing course at UL FRI, 2026/27.

The code lives in separate repositories, one per service; [repos.md](docs/repos.md) lists them. This repository is where we keep track of what we are building and why.

## What's here

- [PLAN.md](PLAN.md): the implementation plan, week by week, with owners and conventions.
- [COMPLIANCE.md](COMPLIANCE.md): every course requirement and how far along we are with it.
- [docs/decisions.md](docs/decisions.md): decisions we made, the alternatives, and why.
- [docs/adr/](docs/adr/): architecture decision records, in Slovenian, used later in the final report.
- [docs/demo-script.md](docs/demo-script.md): what we will show for each requirement at the final presentation.
- [docs/repos.md](docs/repos.md): the repositories, their owners and descriptions.
- `scripts/`: scripts that created the repositories on GitHub and the GitLab mirror.
- `reports/`: the topic submission and later the final report. These stay on our machines until they are final, so the folder is ignored by git.

## Repositories and mirror

GitHub ([rso-ekipa13](https://github.com/rso-ekipa13)) is where development happens. The same projects are mirrored on our GitLab ([fri-mag/rso](https://gitlab.koderverse.com/fri-mag/rso)), which we may later use for CI. In this repository, `origin` pushes to both.

## How we work

`main` is protected and only changes through pull requests. Day-to-day work goes to `dev` or to a feature branch merged into `dev`, and `dev` is merged into `main` when something is ready.

Course material from učilnica stays in `instructions/`, which is not committed because it is copyrighted.
