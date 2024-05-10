#!/usr/bin/env bash

set -e

# Default location for user configuration
export XDG_CONFIG_HOME="$HOME/.config"

if ! [[ -d "${XDG_CONFIG_HOME-}" ]]; then
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

gen_ssh_keys() {
    read -rp "Enter the email to generate ssh keypairs [xafarr@gmail.com]: " email
    ssh-keygen -t ed25519 -C "${email:-'xafarr@gmail.com'}" || true
}

# USER isn't always set so provide a fall back for the installer and subprocesses.
current_user="$(id -un)"
if [[ "$current_user" = "root" ]]; then
    abort "Homebrew cannot be installed as root. Please run the script as a user other than root"
fi
export USER="$current_user"

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
    SETUP_ON_LINUX=1
elif [[ "${OS}" == "Darwin" ]]; then
    SETUP_ON_MACOS=1
else
    abort "Setup is only supported on macOS and Linux."
fi

# Install dev tools in linux
if [ -n "${SETUP_ON_LINUX-}" ]; then
    if [[ -x "$(command -v apt-get)" ]]; then
        (sudo apt-get update && sudo apt-get upgrade -y) || true
        (sudo apt-get install -y build-essential zip unzip make curl wget git libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev \
            libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev) || true
    elif [[ -x "$(command -v yum)" ]]; then
        sudo yum upgrade -y || true
        sudo yum groupinstall 'Development Tools' || true
        sudo yum install zip unzip curl wget git || true
    elif [[ -x "$(command -v pacman)" ]]; then
        sudo pacman -S base-devel || true
    elif [[ -x "$(command -v apk)" ]]; then
        sudo apk add build-base || true
    fi
fi

# Check if curl exists
if ! command -v curl >/dev/null; then
    abort "You must install cURL before running automated setup."
fi

# Generate SSH keypairs
gen_ssh_keys

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

# Install Homebrew
if ! [ -f "$BREW" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install SDKMAN and Java
if ! command -v sdk >/dev/null; then
    echo "Installing SDKMAN"
    curl -s "https://get.sdkman.io" | bash || true
fi

BREW_BIN="$HOMEBREW_PREFIX/bin"
BREW="$BREW_BIN/brew"

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
if ! [ -f "$BREW_BIN/tree" ]; then
    $BREW install tree || true
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
if ! [ -f "$BREW_BIN/bat" ]; then
    $BREW install bat || true
fi
if ! [ -f "$BREW_BIN/kitty" ] && [ -n "${SETUP_ON_MACOS-}" ]; then
    $BREW install --cask kitty || true
fi
if [[ $($BREW list | grep -iwc bzip2) -eq 0 ]]; then
    $BREW install bzip2 || true
fi
if [[ $($BREW list | grep -iwc zlib) -eq 0 ]]; then
    $BREW install zlib || true
fi
if [[ $($BREW list | grep -iwc readline) -eq 0 ]]; then
    $BREW install readline || true
fi
if [[ $($BREW list | grep -iwc gettext) -eq 0 ]]; then
    $BREW install gettext || true
fi
if [[ $($BREW list | grep -iwc openssl) -eq 0 ]]; then
    $BREW install openssl || true
fi
if [[ $($BREW list | grep -iwc llvm) -eq 0 ]]; then
    $BREW install llvm || true
fi
if [[ $($BREW list | grep -iwc font-jetbrains-mono-nerd-font) -eq 0 ]]; then
    $BREW install font-jetbrains-mono-nerd-font || true
fi
if [[ $($BREW list | grep -iwc font-fira-code-nerd-font) -eq 0 ]]; then
    $BREW install font-fira-code-nerd-font || true
fi

# For zsh
if [[ $($BREW list | grep -iwc zsh-syntax-highlighting) -eq 0 ]]; then
    $BREW install zsh-syntax-highlighting || true
fi
if [[ $($BREW list | grep -iwc zsh-autosuggestions) -eq 0 ]]; then
    $BREW install zsh-autosuggestions || true
fi
if [[ $($BREW list | grep -iwc z) -eq 0 ]]; then
    $BREW install z || true
fi
# For bash
if [[ $($BREW list | grep -iwc bash-completion@2) -eq 0 ]]; then
    $BREW install bash-completion@2 || true
fi

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
ln -s "$PROJECTS_DIR/terminal-configs/terminal/zsh/zshrc" "$HOME/.zshrc" && echo ".zshrc link created"

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

export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -Wl,\
-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++ \
-L$HOMEBREW_PREFIX/lib \
-L$HOMEBREW_PREFIX/opt/curl/lib \
-L$HOMEBREW_PREFIX/opt/gettext/lib \
-L$HOMEBREW_PREFIX/opt/bzip2/lib \
-L$HOMEBREW_PREFIX/opt/zlib/lib \
-L$HOMEBREW_PREFIX/opt/readline/lib \
-L$HOMEBREW_PREFIX/opt/openssl@1.1/lib \
-L$HOMEBREW_PREFIX/opt/openssl@3/lib \
-L$HOMEBREW_PREFIX/opt/libffi/lib"

export CPPFLAGS="-I$HOMEBREW_PREFIX/include \
-I$HOMEBREW_PREFIX/opt/llvm/include \
-I$HOMEBREW_PREFIX/opt/curl/include \
-I$HOMEBREW_PREFIX/opt/gettext/include \
-I$HOMEBREW_PREFIX/opt/bzip2/include \
-I$HOMEBREW_PREFIX/opt/zlib/include \
-I$HOMEBREW_PREFIX/opt/readline/include \
-I$HOMEBREW_PREFIX/opt/openssl@1.1/include \
-I$HOMEBREW_PREFIX/opt/openssl@3/include \
-I$HOMEBREW_PREFIX/opt/libffi/include"

export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/libffi/lib/pkgconfig \
$HOMEBREW_PREFIX/opt/openssl@1.1/lib/pkgconfig \
$HOMEBREW_PREFIX/opt/openssl@3/lib/pkgconfig \
$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig \
$HOMEBREW_PREFIX/opt/zlib/lib/pkgconfig \
$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig \
$HOMEBREW_PREFIX/share/pkgconfig"

# Prepend Homebrew bin and LLVM binaries to PATH
export PATH="$BREW_BIN:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"

echo "Initializing SDKMAN"
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo "SDKMAN version"
sdk version || true
echo "Installing Java using SDKMAN"
sdk install java || true

# Installing Python, nodejs and Golang using asdf
ASDF="$BREW_BIN/asdf"
echo "Installing NodeJS"
($ASDF plugin-add nodejs && $ASDF install nodejs latest:20 && $ASDF global nodejs latest:20) || true
echo "Installing Golang"
($ASDF plugin-add golang && $ASDF install golang latest && $ASDF global golang latest) || true
