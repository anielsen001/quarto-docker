# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Container build definitions (no application code, no tests) for a Quarto authoring environment: Quarto, Pandoc, TinyTeX/TeX Live, LibreOffice, R, Julia, and a uv-managed Python env (packages in `requirements.txt`) plus BibTool. Works with both docker and podman.

## Commands

Build / run via `compose.yml` (service names are `quarto-<ver>`, e.g. `quarto-1-10`, `quarto-19`, `quarto-12`):

```bash
podman-compose -f compose.yml build quarto-1-10      # or docker-compose
podman-compose -f compose.yml build --no-cache quarto-1-10
podman-compose -f compose.yml run quarto-1-10        # bash shell; verify with `quarto check`
```

Images are tagged `quarto-XX:develop`. Publishing to ghcr is manual (`tag` + `push` to `ghcr.io/anielsen001/quarto-docker/quarto-XX-texlive-python-julia:latest`); see README.md.

## Architecture

- One Dockerfile per supported Quarto series, mapped to a compose service in `compose.yml`. **Naming changed at 1.10:** new files are `Containerfile-X-Y` (`Containerfile-1-10`, `Containerfile-19`); older ones are `Dockerfile-NN` (12–18). `Dockerfile-18-multi` is the 1.8 multi-stage build; `Dockerfile.old` is legacy.
- `Containerfile-1-10` is the current release and is nearly identical to `Containerfile-19`; they differ only in the top `ARG`s (`JULIA_VERSION`, `PANDOC_VERSION`, `QUARTO_VERSION`). A new Quarto series is typically created by copying the latest Containerfile, bumping those ARGs, and adding a service to `compose.yml`.
- Build structure: stage 1 compiles BibTool on ubuntu:24.04 and the final stage copies `/opt/bibtool`. The final stage then installs apt deps + MS fonts, R, Pandoc (.deb from GitHub), Quarto (.deb), `quarto install chrome-headless-shell` and `tinytex`, Julia (tarball into `/opt`), uv, and Python deps from `requirements.txt` (`uv add -r` in `/opt/pyenv`). It finishes with `tlmgr` repo setup/update, extra LaTeX packages (add new ones to the `tlmgr install` list at the end), and `quarto check all` as a build-time verification.
- The compose services share an `x-default` anchor (X11 socket passthrough for `DISPLAY`, `/data`, `$PWD` -> `/opt/project`, host networking, bash command). Services for 1.5 and older (`quarto-12`–`15`) predate the anchor and duplicate that config inline.
- `requirements.txt` is shared by all Dockerfiles that copy it.

## Notes

- `.gitignore` excludes emacs backups (`*~`) and `*.tar` archives; ignore stray emacs files like `#README.md#` and `.#README.md`.
- README.md is somewhat out of date relative to the Dockerfiles (e.g. it mentions a venv at `/opt/venv`, but the current Containerfiles use uv in `/opt/pyenv`).
