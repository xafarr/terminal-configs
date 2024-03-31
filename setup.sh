#!/usr/bin/env bash

set -e

# Default location for user configuration
export XDG_CONFIG_HOME="$HOME/.config"

if [[ -d "${XDG_CONFIG_HOME-}" ]]; then
    mkdir -p "${XDG_CONFIG_HOME}"
fi

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

# Fail fast with a concise message when not using bash
# Single brackets are needed here for POSIX compatibility
if [ -z "${BASH_VERSION:-}" ]; then
    abort "Bash is required to interpret this script."
fi

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

# USER isn't always set so provide a fall back for the installer and subprocesses.
if [[ -z "${USER-}" ]]; then
    USER="$(chomp "$(id -un)")"
    export USER
fi

major_minor() {
    echo "${1%%.*}.$(
        x="${1#*.}"
        echo "${x%%.*}"
    )"
}

version_gt() {
    [[ "${1%.*}" -gt "${2%.*}" ]] || [[ "${1%.*}" -eq "${2%.*}" && "${1#*.}" -gt "${2#*.}" ]]
}
version_ge() {
    [[ "${1%.*}" -gt "${2%.*}" ]] || [[ "${1%.*}" -eq "${2%.*}" && "${1#*.}" -ge "${2#*.}" ]]
}
version_lt() {
    [[ "${1%.*}" -lt "${2%.*}" ]] || [[ "${1%.*}" -eq "${2%.*}" && "${1#*.}" -lt "${2#*.}" ]]
}

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
    SETUP_ON_LINUX=1
elif [[ "${OS}" == "Darwin" ]]; then
    SETUP_ON_MACOS=1
else
    abort "Setup is only supported on macOS and Linux."
fi

# Check if curl exists
if ! command -v curl >/dev/null; then
    abort "You must install cURL before running automated setup."
fi

# Required installation paths.
if [[ -n "${SETUP_ON_MACOS-}" ]]; then
    UNAME_MACHINE="$(/usr/bin/uname -m)"

    if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
        # On ARM macOS, this script installs to /opt/homebrew only
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        # On Intel macOS, this script installs to /usr/local only
        HOMEBREW_PREFIX="/usr/local"
    fi
else
    # On Linux, this script installs to /home/linuxbrew/.linuxbrew only
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

BREW="$HOMEBREW_PREFIX/bin/brew"
BREW_BIN="$HOMEBREW_PREFIX/bin"

# Install Homebrew
if ! command -v "$BREW" >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! [ -f "$BREW_BIN/git" ]; then
    $BREW install git || true
fi

if ! echo "$BREW_BIN/gcc-*" &>/dev/null; then
    $BREW install gcc || true
fi
if ! [ -f "$BREW_BIN/fd" ]; then
    $BREW install fd || true
fi
if ! [ -f "$BREW_BIN/rg" ]; then
    $BREW install ripgrep || true
fi
if ! [ -f "$BREW_BIN/tmux" ]; then
    $BREW install tmux || true
fi
if ! [ -f "$BREW_BIN/fzf" ]; then
    $BREW install fzf || true
fi
if ! [ -f "$BREW_BIN/jq" ]; then
    $BREW install jq || true
fi
if ! [ -f "$BREW_BIN/bash" ]; then
    $BREW install bash || true
fi
if ! [ -f "$BREW_BIN/zsh" ]; then
    $BREW install zsh || true
fi
if ! [ -f "$BREW_BIN/delta" ]; then
    $BREW install git-delta || true
fi
if ! [ -f "$BREW_BIN/lazygit" ]; then
    $BREW install lazygit || true
fi
if ! [ -f "$BREW_BIN/asdf" ]; then
    $BREW install asdf || true
fi
if ! [ -f "$BREW_BIN/starship" ]; then
    $BREW install starship || true
fi
if ! [ -f "$BREW_BIN/nvim" ]; then
    $BREW install neovim || true
fi
if ! [ -f "$BREW_BIN/kitty" ] && [ -z "${SETUP_ON_LINUX-}" ]; then
    $BREW install --cask kitty || true
fi
# For zsh
$BREW install zsh-syntax-highlighting zsh-autosuggestions || true
# For bash
$BREW install bash-completion || true

# Clone terminal-configs
PROJECTS_DIR="$HOME/Documents/Projects"
if ! [ -d "$PROJECTS_DIR" ]; then
    mkdir -p "$PROJECTS_DIR"
fi
if ! [ -d "$PROJECTS_DIR/terminal-configs" ]; then
    git clone https://github.com/xafarr/terminal-configs.git "$PROJECTS_DIR/terminal-configs"
    echo "terminal-configs cloned"
fi

# Create symlinks in HOME directory
if [ -h "$HOME/.tmux.conf" ]; then
    rm "$HOME/.tmux.conf"
elif [ -f "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/tmux/tmux.conf" "$HOME/.tmux.conf" && echo ".tmux.conf link created"

if [ -h "$HOME/.bashrc" ]; then
    rm "$HOME/.bashrc"
elif [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/bash/bashrc" "$HOME/.bashrc" && echo ".bashrc link created"

if [ -h "$HOME/.zshrc" ]; then
    rm "$HOME/.zshrc"
elif [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/zsh/zshrc-m1-mac" "$HOME/.zshrc" && echo ".zshrc link created"

if [ -n "${SETUP_ON_MACOS-}" ]; then
    if [ -f "$HOME/.bash_profile" ]; then
        mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
    fi
    ln -s "$PROJECTS_DIR/terminal-configs/terminal/bash/bash_profile" "$HOME/.bash_profile" && echo ".bash_profile link created"
fi

# Create symlinks in .config directory
if [ -h "$XDG_CONFIG_HOME/nvim" ]; then
    rm "$XDG_CONFIG_HOME/nvim"
elif [ -d "$XDG_CONFIG_HOME/nvim" ]; then
    mv "$XDG_CONFIG_HOME/nvim" "$XDG_CONFIG_HOME/nvim.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/nvim" "$XDG_CONFIG_HOME/nvim" && echo "neovim link created"

if [ -h "$XDG_CONFIG_HOME/starship.toml" ]; then
    rm "$XDG_CONFIG_HOME/starship.toml"
elif [ -f "$XDG_CONFIG_HOME/starship.toml" ]; then
    mv "$XDG_CONFIG_HOME/starship.toml" "$XDG_CONFIG_HOME/starship.toml.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/starship/starship.toml" "$XDG_CONFIG_HOME/starship.toml" && echo "starship.toml link created"

if [ -h "$XDG_CONFIG_HOME/get_git_host.py" ]; then
    rm "$XDG_CONFIG_HOME/get_git_host.py"
elif [ -f "$XDG_CONFIG_HOME/get_git_host.py" ]; then
    mv "$XDG_CONFIG_HOME/get_git_host.py" "$XDG_CONFIG_HOME/get_git_host.py.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/starship/get_git_host.py" "$XDG_CONFIG_HOME/get_git_host.py" && echo "get_git_host.py link created"

if [ -h "$XDG_CONFIG_HOME/kitty" ]; then
    rm "$XDG_CONFIG_HOME/kitty"
elif [ -d "$XDG_CONFIG_HOME/kitty" ]; then
    mv "$XDG_CONFIG_HOME/kitty" "$XDG_CONFIG_HOME/kitty.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/kitty" "$XDG_CONFIG_HOME/kitty" && echo "kitty link created"

if [ -h "$XDG_CONFIG_HOME/delta" ]; then
    rm "$XDG_CONFIG_HOME/delta"
elif [ -d "$XDG_CONFIG_HOME/delta" ]; then
    mv "$XDG_CONFIG_HOME/delta" "$XDG_CONFIG_HOME/delta.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/delta" "$XDG_CONFIG_HOME/delta" && echo "delta link created"

if [ -h "$XDG_CONFIG_HOME/bat" ]; then
    rm "$XDG_CONFIG_HOME/bat"
elif [ -d "$XDG_CONFIG_HOME/bat" ]; then
    mv "$XDG_CONFIG_HOME/bat" "$XDG_CONFIG_HOME/bat.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/bat" "$XDG_CONFIG_HOME/bat" && echo "bat link created"

if [ -h "$XDG_CONFIG_HOME/lazygit" ]; then
    rm "$XDG_CONFIG_HOME/lazygit"
elif [ -d "$XDG_CONFIG_HOME/lazygit" ]; then
    mv "$XDG_CONFIG_HOME/lazygit" "$XDG_CONFIG_HOME/lazygit.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/git/lazygit" "$XDG_CONFIG_HOME/lazygit" && echo "lazygit link created"
