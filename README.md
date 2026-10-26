# Pretty Good Pigeon: docs

Architecture and design decisions for [Pretty Good Pigeon](https://github.com/rso-ekipa13), the end-to-end encrypted messenger that ekipa 13 (Tibor Koderman, Amar Mehić, Eva Vidic) is building for the Cloud Computing course at UL FRI, 2026/27.

The code lives in separate repositories, one per service; [repos.md](docs/repos.md) lists them. This repository holds the architecture and the decisions behind it. Our week-to-week planning is kept in a private project on GitLab.

## What's here

- [docs/adr/](docs/adr/): architecture decision records, in Slovenian, used later in the final report.
- [docs/repos.md](docs/repos.md): the repositories, their owners and descriptions.
- `scripts/`: scripts that created the repositories on GitHub and the GitLab mirror.
- `reports/`: the topic submission and later the final report. These stay on our machines until they are final, so the folder is ignored by git.

## Repositories and mirror

GitHub ([rso-ekipa13](https://github.com/rso-ekipa13)) is where development happens. The same projects are mirrored on our GitLab ([fri-mag/rso](https://gitlab.koderverse.com/fri-mag/rso)), which we may later use for CI. In this repository, `origin` pushes to both.

## How we work

`main` is protected and only changes through pull requests. Day-to-day work goes to `dev` or to a feature branch merged into `dev`, and `dev` is merged into `main` when something is ready.

Course material from učilnica stays in `instructions/`, which is not committed because it is copyrighted.
