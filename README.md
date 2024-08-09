# My .Dots

## OS Support

- MacOS
- Ubuntu Linux

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

### Notes

It's possible to accidentally leak secrets if you're not paying attention to commit changes.
The install script will exclude any changes to `.aws`.
The command to use is `git update-index --assume-unchanged <files>` However this needs to be ran each time the project is cloned.
GNU Stow has an adopt feature which can pull in sensitive files if you're not careful. Specifically looking at `.ssh` given that folder is included in these dots.
It may be a good idea to include a .ssh/config entry in .gitignore to prevent this from happening.
