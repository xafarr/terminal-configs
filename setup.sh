#!/usr/bin/env bash

set -e

# Default location for user configuration
export XDG_CONFIG_HOME="$HOME/.config"

if ! [[ -d "${XDG_CONFIG_HOME-}" ]]; then
    mkdir -p "${XDG_CONFIG_HOME}"
fi

abort() {
    error "$@"
    exit 1
}

# Fail fast with a concise message when not using bash
# Single brackets are needed here for POSIX compatibility
if [ -z "${BASH_VERSION:-}" ]; then
    abort "Bash is required to interpret this script."
fi

# string formatters
if [[ -t 1 ]]; then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_yellow="$(tty_mkbold 33)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
    local arg
    printf "%s" "$1"
    shift
    for arg in "$@"; do
        printf " "
        printf "%s" "${arg// /\ }"
    done
}

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

info() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
    printf "${tty_yellow}==> ${tty_underline}${tty_yellow}Warning${tty_reset}${tty_bold}: %s\n" "$(chomp "$1")" >&2
}

error() {
    printf "${tty_red}==> ${tty_underline}${tty_red}Error${tty_reset}${tty_bold}: %s\n" "$(chomp "$1")" >&2
}

gen_ssh_keys() {
    read -rp "Enter the key algorithm (ed25519|rsa) [default: ed25519]: " algo

    case "${algo}" in
    rsa)
        info "Using RSA algorithm"
        ssh_keygen_str="ssh-keygen -t rsa -b 4096 -C"
        ;;
    *)
        info "Using ED25519 algorithm"
        ssh_keygen_str="ssh-keygen -t ed25519 -C"
        ;;
    esac
    read -rp "Enter the email to generate ssh keypairs [xafarr@gmail.com]: " email
    $ssh_keygen_str "${email:-'xafarr@gmail.com'}" || error "Failed to generate ssh keypair"
}

linux_font_install_dir="${HOME}/.local/share/fonts"
install_fonts_in_linux() {
    declare -a nerd_fonts=(
        "FiraCode"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
    )

    if [[ ! -d "$linux_font_install_dir" ]]; then
        mkdir -p "$linux_font_install_dir"
    fi

    # https://github.com/JetBrains/JetBrainsMono/releases/download/v<version>/JetBrainsMono-<version>.zip
    # https://github.com/tonsky/FiraCode/releases/download/<version>/Fira_Code_v<version>.zip
    jetbrains_latest_version=$(curl -s "https://api.github.com/repos/JetBrains/JetBrainsMono/tags" | jq -r '.[0].name' | tr -d v)
    firacode_latest_version=$(curl -s "https://api.github.com/repos/tonsky/FiraCode/tags" | jq -r '.[0].name')
    nerd_fonts_latest_version=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/tags" | jq -r '.[0].name')

    jetbrains_download_url="https://github.com/JetBrains/JetBrainsMono/releases/download/v$jetbrains_latest_version/JetBrainsMono-$jetbrains_latest_version.zip"
    firacode_download_url="https://github.com/tonsky/FiraCode/releases/download/$firacode_latest_version/Fira_Code_v$firacode_latest_version.zip"

    install_font "JetBrains Mono" "$jetbrains_download_url"
    install_font "FiraCode" "$firacode_download_url"

    for font_name in "${nerd_fonts[@]}"; do
        zip_file="${font_name}.zip"
        download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${nerd_fonts_latest_version}/${zip_file}"
        install_font "$font_name Nerd Font" "$download_url"
    done

    find "$linux_font_install_dir" -name '*Windows Compatible*' -delete

    if command -v fc-cache &>/dev/null; then
        fc-cache -f >/dev/null || error "Unable to update font cache."
        info "Font cache updated."
    else
        warn "Command 'fc-cache' not found. Make sure to have the necessary dependencies installed to update the font cache."
    fi
}

install_font() {
    font_name=$1
    download_url=$2
    zip_file="$font_name.zip"
    info "Downloading and installing '$font_name'..."
    wget -O "$zip_file" "$download_url" || error "Unable to download '$font_name'."
    unzip -j "$zip_file" "*.ttf" -d "$linux_font_install_dir"
    rm "$zip_file"
    info "'$font_name' installed successfully."

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
        (sudo apt-get update && sudo apt-get upgrade -y) || error "Failed to update apt packages."
        (sudo apt-get install -y build-essential zip unzip make curl wget git fontconfig tar jq libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev \
            libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev) || error "Failed to install dependencies for $(uname -s)."
    elif [[ -x "$(command -v dnf)" ]]; then
        sudo dnf upgrade -y || error "Failed to update dnf packages."
        sudo dnf group install -y 'Development Tools' || error "Failed to install dnf development tools."
        sudo dnf install -y zip unzip curl wget git fontconfig tar jq || error "Failed to install dependencies for $(uname -s)."
    elif [[ -x "$(command -v pacman)" ]]; then
        sudo pacman -S base-devel || error "Failed to install base-devel."
    elif [[ -x "$(command -v apk)" ]]; then
        sudo apk add build-base || error "Failed to install build-base."
    fi
fi

# Check if curl exists
if ! command -v curl >/dev/null; then
    abort "You must install cURL before running automated setup."
fi

# Generate SSH keypairs
read -r -p "Would you like to generate ssh keypairs? [Y/n]: " response
if [[ $response =~ ^(y|Y| ) ]] || [[ -z $response ]]; then
    gen_ssh_keys
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

# Install Homebrew
if ! [ -f "$BREW" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREW_BIN="$HOMEBREW_PREFIX/bin"
BREW="$BREW_BIN/brew"

if ! [ -f "$BREW_BIN/git" ]; then
    $BREW install git || error "Failed to install git."
fi
if ! [ -f "$BREW_BIN/curl" ]; then
    $BREW install curl || error "Failed to install curl."
fi
if ! [ -f "$BREW_BIN/wget" ]; then
    $BREW install wget || error "Failed to install wget."
fi
if ! [ -f "$BREW_BIN/gpg" ]; then
    $BREW install gnupg || error "Failed to install gnupg."
fi
if ! [ -f "$BREW_BIN/vivid" ]; then
    $BREW install vivid || error "Failed to install vivid."
fi
if ! echo $BREW_BIN/gcc-* &>/dev/null; then
    $BREW install gcc || error "Failed to install gcc."
fi
if ! [ -f "$BREW_BIN/fd" ]; then
    $BREW install fd || error "Failed to install fd."
fi
if ! [ -f "$BREW_BIN/rg" ]; then
    $BREW install ripgrep || error "Failed to install ripgrep."
fi
if ! [ -f "$BREW_BIN/tree" ]; then
    $BREW install tree || error "Failed to install tree."
fi
if ! [ -f "$BREW_BIN/tmux" ]; then
    $BREW install tmux || error "Failed to install tmux."
fi
if ! [ -f "$BREW_BIN/fzf" ]; then
    $BREW install fzf || error "Failed to install fzf."
fi
if ! [ -f "$BREW_BIN/jq" ]; then
    $BREW install jq || error "Failed to install jq."
fi
if ! [ -f "$BREW_BIN/bash" ]; then
    $BREW install bash || error "Failed to install bash."
fi
if ! [ -f "$BREW_BIN/zsh" ]; then
    $BREW install zsh || error "Failed to install zsh."
fi
if ! [ -f "$BREW_BIN/delta" ]; then
    $BREW install git-delta || error "Failed to install git-delta."
fi
if ! [ -f "$BREW_BIN/lazygit" ]; then
    $BREW install lazygit || error "Failed to install lazygit."
fi
if ! [ -f "$BREW_BIN/asdf" ]; then
    $BREW install asdf || error "Failed to install asdf."
fi
if ! [ -f "$BREW_BIN/starship" ]; then
    $BREW install starship || error "Failed to install starship."
fi
if ! [ -f "$BREW_BIN/nvim" ]; then
    $BREW install neovim || error "Failed to install neovim."
fi
if ! [ -f "$BREW_BIN/bat" ]; then
    $BREW install bat || error "Failed to install bat."
fi
if [[ $($BREW list | grep -iwc coreutils) -eq 0 ]]; then
    $BREW install coreutils || error "Failed to install coreutils."
fi
if [[ $($BREW list | grep -iwc bzip2) -eq 0 ]]; then
    $BREW install bzip2 || error "Failed to install bzip2."
fi
if [[ $($BREW list | grep -iwc zlib) -eq 0 ]]; then
    $BREW install zlib || error "Failed to install zlib."
fi
if [[ $($BREW list | grep -iwc readline) -eq 0 ]]; then
    $BREW install readline || error "Failed to install readline."
fi
if [[ $($BREW list | grep -iwc gettext) -eq 0 ]]; then
    $BREW install gettext || error "Failed to install gettext."
fi
if [[ $($BREW list | grep -iwc openssl) -eq 0 ]]; then
    $BREW install openssl || error "Failed to install openssl."
fi
if [[ $($BREW list | grep -iwc llvm) -eq 0 ]]; then
    $BREW install llvm || error "Failed to install llvm."
fi

# For zsh
if [[ $($BREW list | grep -iwc zsh-syntax-highlighting) -eq 0 ]]; then
    $BREW install zsh-syntax-highlighting || error "Failed to install zsh-syntax-highlighting."
fi
if [[ $($BREW list | grep -iwc zsh-autosuggestions) -eq 0 ]]; then
    $BREW install zsh-autosuggestions || error "Failed to install zsh-autosuggestions."
fi
if [[ $($BREW list | grep -iwc z) -eq 0 ]]; then
    $BREW install z || error "Failed to install z."
fi
# For bash
if [[ $($BREW list | grep -iwc bash-completion@2) -eq 0 ]]; then
    $BREW install bash-completion@2 || error "Failed to install bash-completion@2."
fi

# Install Fonts
if [[ -n "${SETUP_ON_MACOS-}" ]]; then
    if [[ $($BREW list | grep -iwxc font-jetbrains-mono-nerd-font) -eq 0 ]]; then
        $BREW install font-jetbrains-mono-nerd-font || error "Failed to install font-jetbrains-mono-nerd-font."
    fi
    if [[ $($BREW list | grep -iwxc font-fira-code-nerd-font) -eq 0 ]]; then
        $BREW install font-fira-code-nerd-font || error "Failed to install font-fira-code-nerd-font."
    fi
    if [[ $($BREW list | grep -iwxc font-symbols-only-nerd-font) -eq 0 ]]; then
        $BREW install font-symbols-only-nerd-font || error "Failed to install font-symbols-only-nerd-font."
    fi
    if [[ $($BREW list | grep -iwxc font-fira-code) -eq 0 ]]; then
        $BREW install font-fira-code || error "Failed to install font-fira-code."
    fi
    if [[ $($BREW list | grep -iwxc font-jetbrains-mono) -eq 0 ]]; then
        $BREW install font-jetbrains-mono || error "Failed to install font-jetbrains-mono."
    fi
elif [[ -n "${SETUP_ON_LINUX-}" ]]; then
    install_fonts_in_linux
fi

# Clone terminal-configs
PROJECTS_DIR="$HOME/Documents/Projects"

read -r -p "Please enter the directory to clone terminal-configs to [${PROJECTS_DIR}]: " response
if [[ -n $response ]]; then
    PROJECTS_DIR=$response
fi

if ! [ -d "$PROJECTS_DIR" ]; then
    mkdir -p "$PROJECTS_DIR"
fi
if ! [ -d "$PROJECTS_DIR/terminal-configs" ]; then
    git clone https://github.com/xafarr/terminal-configs.git "$PROJECTS_DIR/terminal-configs"
    info "terminal-configs cloned"
else
    git --work-tree="$PROJECTS_DIR/terminal-configs" --git-dir="$PROJECTS_DIR/terminal-configs/.git" pull
fi

# Create symlinks in HOME directory
if [ -h "$HOME/.tmux.conf" ]; then
    rm "$HOME/.tmux.conf"
elif [ -f "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/tmux/tmux.conf" "$HOME/.tmux.conf" && info ".tmux.conf link created"

if [ -h "$HOME/.commonrc" ]; then
    rm "$HOME/.commonrc"
elif [ -f "$HOME/.commonrc" ]; then
    mv "$HOME/.commonrc" "$HOME/.commonrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/common/commonrc" "$HOME/.commonrc" && info ".commonrc link created"

if [ -h "$HOME/.shell_functions" ]; then
    rm "$HOME/.shell_functions"
elif [ -f "$HOME/.shell_functions" ]; then
    mv "$HOME/.shell_functions" "$HOME/.shell_functions.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/common/shell_functions" "$HOME/.shell_functions" && info ".shell_functions link created"

if [ -h "$HOME/.bashrc" ]; then
    rm "$HOME/.bashrc"
elif [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/bash/bashrc" "$HOME/.bashrc" && info ".bashrc link created"

if [ -h "$HOME/.zshrc" ]; then
    rm "$HOME/.zshrc"
elif [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/zsh/zshrc" "$HOME/.zshrc" && info ".zshrc link created"

if [ -h "$HOME/.asdfrc" ]; then
    rm "$HOME/.asdfrc"
elif [ -f "$HOME/.asdfrc" ]; then
    mv "$HOME/.asdfrc" "$HOME/.asdfrc.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/asdf/asdfrc" "$HOME/.asdfrc" && info ".asdfrc link created"

if [ -h "$HOME/.gitconfig" ]; then
    rm "$HOME/.gitconfig"
elif [ -f "$HOME/.gitconfig" ]; then
    mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/git/gitconfig" "$HOME/.gitconfig" && info ".gitconfig link created"

if [ -n "${SETUP_ON_MACOS-}" ]; then
    if [ -h "$HOME/.bashrc_profile" ]; then
        rm "$HOME/.bashrc_profile"
    elif [ -f "$HOME/.bash_profile" ]; then
        mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
    fi
    ln -s "$PROJECTS_DIR/terminal-configs/terminal/bash/bash_profile" "$HOME/.bash_profile" && info ".bash_profile link created"
fi

# Create symlinks in .config directory
if [ -h "$XDG_CONFIG_HOME/nvim" ]; then
    rm "$XDG_CONFIG_HOME/nvim"
elif [ -d "$XDG_CONFIG_HOME/nvim" ]; then
    mv "$XDG_CONFIG_HOME/nvim" "$XDG_CONFIG_HOME/nvim.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/nvim" "$XDG_CONFIG_HOME/nvim" && info "neovim link created"

if [ -h "$XDG_CONFIG_HOME/starship.toml" ]; then
    rm "$XDG_CONFIG_HOME/starship.toml"
elif [ -f "$XDG_CONFIG_HOME/starship.toml" ]; then
    mv "$XDG_CONFIG_HOME/starship.toml" "$XDG_CONFIG_HOME/starship.toml.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/starship/starship.toml" "$XDG_CONFIG_HOME/starship.toml" && info "starship.toml link created"

if [ -h "$XDG_CONFIG_HOME/kitty" ]; then
    rm "$XDG_CONFIG_HOME/kitty"
elif [ -d "$XDG_CONFIG_HOME/kitty" ]; then
    mv "$XDG_CONFIG_HOME/kitty" "$XDG_CONFIG_HOME/kitty.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/kitty" "$XDG_CONFIG_HOME/kitty" && info "kitty link created"

if [ -h "$XDG_CONFIG_HOME/delta" ]; then
    rm "$XDG_CONFIG_HOME/delta"
elif [ -d "$XDG_CONFIG_HOME/delta" ]; then
    mv "$XDG_CONFIG_HOME/delta" "$XDG_CONFIG_HOME/delta.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/delta" "$XDG_CONFIG_HOME/delta" && info "delta link created"

if [ -h "$XDG_CONFIG_HOME/bat" ]; then
    rm "$XDG_CONFIG_HOME/bat"
elif [ -d "$XDG_CONFIG_HOME/bat" ]; then
    mv "$XDG_CONFIG_HOME/bat" "$XDG_CONFIG_HOME/bat.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/bat" "$XDG_CONFIG_HOME/bat" && info "bat link created"
$BREW_BIN/bat cache --build

if [ -h "$XDG_CONFIG_HOME/lazygit" ]; then
    rm "$XDG_CONFIG_HOME/lazygit"
elif [ -d "$XDG_CONFIG_HOME/lazygit" ]; then
    mv "$XDG_CONFIG_HOME/lazygit" "$XDG_CONFIG_HOME/lazygit.bak"
fi
ln -s "$PROJECTS_DIR/terminal-configs/terminal/lazygit" "$XDG_CONFIG_HOME/lazygit" && info "lazygit link created"

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

# Install Kitty terminal emulator
info "Installing Kitty terminal emulator..."
if [ -n "${SETUP_ON_MACOS-}" ]; then
    if ! [ -f "$BREW_BIN/kitty" ]; then
        $BREW install --cask kitty || error "Failed to install Kitty terminal emulator."
    else
        info "Kitty is already installed. Skipping installation."
    fi
else
    linux_font_install_dir="${HOME}/.local/bin"
    local_share_app="${HOME}/.local/share/applications"
    if [[ ! -d "$linux_font_install_dir" ]]; then
        mkdir -p "$linux_font_install_dir"
    fi
    if [[ ! -d "$local_share_app" ]]; then
        mkdir -p "$local_share_app"
    fi
    # Install kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
    # your system-wide PATH)
    ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/kitty.app/bin/kitten" "$linux_font_install_dir"
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
    # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
    cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications/"
    # Update the paths to the kitty and its icon in the kitty desktop file(s)
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
fi

# Add shell installed through homebrew and change the current user shell
info "Adding shell installed through Homebrew in /etc/shells"
zsh_shell="$HOMEBREW_PREFIX/bin/zsh"
bash_shell="$HOMEBREW_PREFIX/bin/bash"
grep -xF -- "$zsh_shell" /etc/shells || echo "$zsh_shell" | sudo tee -a /etc/shells
grep -xF -- "$bash_shell" /etc/shells || echo "$bash_shell" | sudo tee -a /etc/shells

info "Changing the current user shell to Homebrew installed shells"
read -rp "Choose your shell (zsh|bash) [default: zsh]: " shell
case "$shell" in
bash)
    shell=$bash_shell
    ;;
*)
    shell=$zsh_shell
    ;;
esac

sudo chsh -s "$shell" "$USER"
info "User shell changed to $shell"

echo
info "*** END ***"
echo
