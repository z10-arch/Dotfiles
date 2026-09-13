# Dotfiles

GNU Stow-managed configuration packages. Each top-level directory mirrors the
path below your home directory, so Stow creates symlinks without copying files.

## Packages

| Package | Files installed |
| --- | --- |
| `tmux` | `~/.config/tmux/tmux.conf` |
| `yazi` | `~/.config/yazi/yazi.toml` |
| `zsh` | `~/.zshrc` |

Neovim will be added later as its own `nvim` package.

The Zsh package has no framework or plugin manager. It optionally uses the
distribution-provided `zsh-autosuggestions` and `zsh-syntax-highlighting`
files, plus `eza` and `zoxide` when those commands are installed.

## First-time setup

Install GNU Stow using your distribution's package manager, clone this
repository, then enter it:

```bash
git clone <repository-url> "$HOME/dotfiles"
cd "$HOME/dotfiles"
```

Preview the links before making changes:

```bash
stow --simulate --verbose=1 --target="$HOME" tmux yazi zsh
```

If the preview contains no unexpected conflicts, create the links:

```bash
stow --target="$HOME" tmux yazi zsh
```

If Stow reports a conflict, move the existing target file to a backup location
first; never overwrite it blindly. For example:

```bash
mv "$HOME/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf.backup"
stow --target="$HOME" tmux
```

## Day-to-day use

Edit files in this repository—the symlinks make the changes live immediately.

```bash
# Remove package links without deleting the repository files.
stow --delete --target="$HOME" yazi

# Recreate links after moving a package or repairing a conflict.
stow --restow --target="$HOME" tmux zsh
```

## Tmux plugins

The tmux configuration uses TPM. On first tmux startup it clones TPM to
`~/.tmux/plugins/tpm` and installs the declared plugins. This requires Git and
network access. Reload tmux after installation with `tmux source-file
~/.config/tmux/tmux.conf`.
