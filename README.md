# My .Dots

## OS Support

- macOS (Homebrew)
- Arch / CachyOS (native: pacman + paru + flatpak)
- Ubuntu Linux (linuxbrew)

`./install` detects the OS and, on Linux, the distro family via `/etc/os-release`.
Arch-family boxes are provisioned natively from the tracked package lists in
`packages/` — no Homebrew:

| List | Manager | Install |
| --- | --- | --- |
| `packages/pacman.txt` | `pacman` | official repos |
| `packages/aur.txt` | `paru` | AUR |
| `packages/flatpak.txt` | `flatpak` | Flathub |

Each list is plain text, one package per line; `#` comments and blank lines are
ignored. They hold an **essentials** set (what the dotfiles reference) — add more
by editing the files. Homebrew (and the `~/.Brewfile`) is used only on macOS and
Ubuntu.

#### Tracking / removing what was installed

`pacman` has no "installed by X" tag, so on Arch the installer writes a manifest
of the packages **it actually added** (never anything that pre-existed) to
`~/.local/state/dots/`:

- `installed-pacman.txt`, `installed-aur.txt`, `installed-flatpak.txt`

To remove exactly what the dots installed on a machine:

```sh
sudo pacman -Rns $(cat ~/.local/state/dots/installed-pacman.txt)
paru      -Rns $(cat ~/.local/state/dots/installed-aur.txt)
xargs -a ~/.local/state/dots/installed-flatpak.txt -r flatpak uninstall -y
```

**`./install --prune`** does this selectively: after installing, it removes only
the packages the dots previously installed that you've since **deleted from
`packages/*.txt`**. It lists them and asks before removing, and only ever touches
names already in the manifest — a normal `./install` stays additive and removes
nothing. (Drop `eza` from `pacman.txt`, run `./install --prune`, and it offers to
uninstall `eza`; packages you installed by hand are never in the manifest, so
they're never touched.)

## Getting started

1. Clone down the repo
1. run `./install`
1. done

### Tech used:

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
  - [antigen](https://github.com/zsh-users/antigen)
- [homebrew](https://brew.sh)
  - [brew-bundle](https://github.com/Homebrew/homebrew-bundle)
- [GNU Stow](https://www.gnu.org/software/stow/)

### Local overlays

To keep work- or host-specific config out of this public repo, every shell rc file sources an optional `*.local` counterpart from `$HOME`:

| Tracked file | Optional overlay |
| --- | --- |
| `~/.zshenv` | `~/.zshenv.local` |
| `~/.zprofile` | `~/.zprofile.local` |
| `~/.zshrc` | `~/.zshrc.local` |
| `~/.aliases` | `~/.aliases.local` |
| `~/.profile` | `~/.profile.local` |
| `~/.Brewfile` | `~/.Brewfile.local` (bundled at the end of `./install`) |
| `~/.gitconfig` (via `includeIf gitdir:~/git/work/**`) | `~/.gitconfig-work.local` |

`./install` creates empty stubs for each of these on first run and never overwrites them. For the overlays where seed content actually matters it prompts you interactively:

- `~/.gitconfig-work.local` — work git name, email, ssh signing key.
- `~/.zprofile.local` — work PATH entries (e.g. `~/git/work/<repo>/.bin`), one per line.

Skip a prompt by pressing enter. Set `DOTS_NONINTERACTIVE=1` or run without a TTY to scaffold empty stubs instead. Overlays live directly in `$HOME` (not under `dots/`) and are gitignored, so they can hold work emails, signing keys, private PATH entries, or company-specific Brewfile entries without risking a leak.

### Notes

It's possible to accidentally leak secrets if you're not paying attention to commit changes.
The install script will exclude any changes to `.aws`.
The command to use is `git update-index --assume-unchanged <files>` However this needs to be ran each time the project is cloned.
GNU Stow has an adopt feature which can pull in sensitive files if you're not careful. Specifically looking at `.ssh` given that folder is included in these dots.
It may be a good idea to include a .ssh/config entry in .gitignore to prevent this from happening.
