# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS and Ubuntu Linux. Configs are deployed via GNU Stow; packages are installed via Homebrew (Brewfile). Shell is zsh managed through antigen/oh-my-zsh with starship.

## Install / deploy

- `./install` — OS-detects, installs prerequisites, stows `dots/.config` into `~/.config`, marks `.aws`/`.ssh` as `assume-unchanged`.
  - **macOS**: xcode-select, Homebrew, `brew bundle install --global`.
  - **Linux**: detects distro family via `/etc/os-release`.
    - **Arch / CachyOS** (`install_arch`): native only — `pacman -Syu`, bootstraps `paru` if missing, adds the Flathub remote, then installs from `packages/pacman.txt` (repos), `packages/aur.txt` (AUR via paru), and `packages/flatpak.txt` (Flathub). **No Homebrew.** Lists hold an essentials set only.
    - **Debian / Ubuntu** (`install_apt`): apt for zsh/podman, then linuxbrew + `brew bundle`.
  - All `brew` steps are guarded by `command -v brew`, so they no-op on Arch.
- `packages/*.txt` are plain lists (one package per line; `#` comments and blank lines stripped by `pkg_list`), sibling to `uninstall.list`. When adding a Linux tool, add it to the right list; keep macOS-only tools in `dots/.Brewfile` only.
- **Install manifest** (Arch): `install_arch` snapshots the system before installing and records only newly-added packages (`record_new`, `new = declared ∩ current − before`, `base-devel` group filtered) to `~/.local/state/dots/installed-{pacman,aur,flatpak}.txt` (per-machine, untracked). Bare names, union-merged across runs; remove with `pacman -Rns $(cat …)` / `paru -Rns …` / `flatpak uninstall`. Pre-existing packages are never recorded.
- **`./install --prune`** (Arch): `prune_arch` removes packages in the manifest that are no longer declared in `packages/*.txt` (`delisted = manifest − declared`), lists them, `confirm`s, then `reconcile_manifest` rewrites each manifest to only what's still installed. Only ever considers manifest names — a normal run stays additive. Runs after `apply_uninstalls` (both no-op without `--prune` / off Arch).
- `scripts/mac-settings.sh` — macOS `defaults write` tweaks (run manually).

## Layout that matters

- `dots/` is the Stow source tree. Only `dots/.config` is stowed by `install` (`stow -t ~/.config ./.config`). Other top-level files under `dots/` (`.zshrc`, `.gitconfig`, `.aliases`, `.Brewfile`, `.vimrc`, `.profile`, `.ssh/`, `.aws/`, `.gnupg/`, `bin/`) are **not** auto-linked — they either live where Stow/tools expect via `$HOME` conventions or must be symlinked manually. When adding a new config, prefer placing it under `dots/.config/<app>/` so it gets picked up automatically.
- `dots/.Brewfile` is the global Brewfile (`brew bundle --global` reads `~/.Brewfile`).
- `dots/bin/` contains helper scripts referenced by shell config (e.g. `upfind` is used by the `aws_auto_profile_hook` in `.zshrc`).
- `dots/.gitconfig` includes OS-specific files (`.gitconfig-mac`, `.gitconfig-linux`, `.gitconfig-work`) — platform branching lives there, not in the main gitconfig.

## Secrets hygiene

- `.aws/` and `.ssh/` are checked in but marked `git update-index --assume-unchanged` by `install`. To intentionally commit changes to them, run `git update-index --no-assume-unchanged ./dots/.aws/**` (or `.ssh`) first.
- Stow's `--adopt` can pull secret files into the repo — avoid it, especially near `.ssh`.

## Local overlays

Anything work- or host-specific goes in a `*.local` overlay in `$HOME`, never in `dots/`. `install` scaffolds empty stubs on first run (guarded by `[ ! -f ]`, so existing overlays are never overwritten):

- `~/.zshenv.local`, `~/.zprofile.local`, `~/.zshrc.local`, `~/.aliases.local`, `~/.profile.local` — sourced at the end of their tracked counterparts with a `[ -f ... ] &&` guard.
- `~/.Brewfile.local` — bundled after `~/.Brewfile` at the end of `install`.
- `~/.gitconfig-work.local` — activated by `includeIf gitdir:~/git/work/**` in `dots/.gitconfig`. Holds work email + ssh signing key.

`*.local` is in `.gitignore`. When adding new config that touches work identity, paths, or company tools, put it in the relevant overlay — not the tracked file.

## Shell architecture

`.zshrc` branches on `uname` (Darwin vs Linux) for paths/plugins, loads antigen with oh-my-zsh + a curated bundle list, then initializes `zoxide`, `fzf`, `starship`, and sources `~/.aliases`. The `aws_auto_profile_hook` (chpwd hook) walks parents with `upfind` looking for an `.aws-profile` file and exports `AWS_PROFILE` accordingly — keep that behavior in mind when editing directory-change logic.

## Formatting

`.editorconfig` and `.prettierrc` at the repo root apply to any JS/JSON/MD edits.
