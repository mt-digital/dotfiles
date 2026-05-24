# dotfiles

My personal Linux configuration files.

## Included

- fish
- hypr
- kitty
- nvim

## Installation

**_WARNING:_**
Since the configs are symlinked, changes take effect immediately.

```sh
git clone https://github.com/USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./link.sh
```

The installer:

1. Backs up existing configs in a timestamped directory with the pattern
`~/.config-backup-YYYYMMDD-HHMMSS/`
2. Creates symlinks into `~/.config`
3. Leaves all files managed from this repository

## Reverting

To revert, copy the backups back to `~/.config`

```sh
cp -r ~/.config-backup-YYYYMMDD-HHMMSS/* ~/.config/
```

## Updating

```sh
git pull origin main
```

