- install ubuntu drivers with following command
    ```
    $ ubuntu-drivers devices
    $ sudo ubuntu-drivers autoinstall
- install build-essential curl file git dconf-cli vim
- install Smyck color scheme from [here](https://github.com/Mayccoll/Gogh). Change background to #002833
- install linuxbrew
- install zsh using brew and execute following
    ```
    $ sudo usermod -s /home/linuxbrew/.linuxbrew/bin/zsh <username>
- install oh-my-zsh
- install powerlevel9k
- install Hack Nerd Fonts, download [here](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
- change font with dconf editor
- install zsh-autosuggestion using brew
- install zsh-syntax-highlighting using brew
- install zsh-completions using brew
- setup zsh-completions by putting following in zshrc
    ```
    $ echo 'fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)' >> ~/.zshrc
- install vscode snap
- install intellij snap
- install oracle jdk manually
- install maven
- install node
- install grunt-cli through npm
- install docker with installation instruction [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) 
    - run following commands to use docker without sudo
    ```
    $ sudo usermod -aG docker $USER
    $ newgrp docker
    
    ## check user groups ##
    $ id -nG
- install stacer from [here](https://github.com/oguzhaninan/Stacer)
- install gnome-shell-extensions
    ```
    $ sudo apt install gnome-shell-extensions -y
- install gnome-tweak-tool
    ```
    $ sudo apt install gnome-tweak-tool -y
- install 'chrome-gnome-shell' and 'gTile' for window tiling (similar to Magnet in macOS)
    ```
    $ sudo apt-get install chrome-gnome-shell
    ```
    - install gnome extension from [here](https://extensions.gnome.org/extension/28/gtile/)
    - change keybinding from `Super+Enter(keypad)` to `Super+return`

- install Terminator if desired
    ```
    $ sudo apt-get install -y terminator

    ### To install Smyck theme
    $ sudo apt-get install -y python-requests
    $ mkdir -p $HOME/.config/terminator/plugins
    $ wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"
    ```
    - to activate plugin, check the TerminatorThemes option under `terminator > preferences > plugins`
    - open the terminator context menu and select `Themes`
    - select theme and install
    - to make the newly installed theme default, replace the `[[default]]` theme with your preferred theme under the `[profiles]` in `~/.config/terminator/config`