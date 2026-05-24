#!/usr/bin/env sh
set -eu

repo_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$config_dir"

for app in fish hypr kitty nvim; do
    src="$repo_dir/$app"
    dest="$config_dir/$app"

    [ -e "$src" ] || continue

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$backup_dir"
        mv "$dest" "$backup_dir/$app"
        echo "Backed up $app"
    fi

    ln -s "$src" "$dest"
    echo "Linked $app"
done
