#!/usr/bin/env bash
set -e
TMUX_DIR="$(cd "$(dirname "$0")" && pwd)"

symlink() {
  local src="$TMUX_DIR/$1"
  local dst="$HOME/$2"
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "  linked $dst -> $src"
}

echo "Installing tmux config..."
symlink "tmux.conf" ".tmux.conf"
symlink "bin/tmux-sessionizer" ".local/bin/tmux-sessionizer"
symlink "bin/tmux-windowizer" ".local/bin/tmux-windowizer"
symlink "bin/tmux-session-lister" ".local/bin/tmux-session-lister"
symlink "tmux-sessionizer.conf" ".config/tmux-sessionizer/tmux-sessionizer.conf"

# Install TPM (tmux plugin manager) if missing; plugins live in ~/.tmux/plugins (gitignored)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "DONE."
echo "Next: open tmux, run 'tmux source-file ~/.tmux.conf', then press prefix+I to install plugins."
