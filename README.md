# dotfiles

Config shared between my work and personal Macs.

| In this repo      | Linked to                 |
| ----------------- | ------------------------- |
| `nvim/`           | `~/.config/nvim`          |
| `ghostty/`        | `~/.config/ghostty`       |
| `.tmux.conf`      | `~/.tmux.conf`            |
| `starship.toml`   | `~/.config/starship.toml` |
| `.aerospace.toml` | `~/.aerospace.toml`       |

`nvim/` used to be its own repo, [nvimrc](https://github.com/Jalil32/nvimrc);
the old history lives there.
`alacritty/` is tracked here but not managed by `install.sh`.

## Setup on a machine

```sh
git clone https://github.com/Jalil32/dotfiles.git ~/.config/dotfiles
~/.config/dotfiles/install.sh --dry-run   # see what it would do
~/.config/dotfiles/install.sh
```

Existing files are moved to `~/.dotfiles-backup/<timestamp>/`, never deleted.
Re-running is safe.

## Day to day

The targets are symlinks into this repo, so editing `~/.tmux.conf`,
`~/.config/nvim/...` and the rest edits the repo. Commit and push on one
machine, `git pull` on the other.
