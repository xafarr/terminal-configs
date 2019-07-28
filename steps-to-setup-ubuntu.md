- install ubuntu drivers with following command
    ```shell
    $ ubuntu-drivers devices
    $ sudo ubuntu-drivers autoinstall
    ```
- install build-essential curl file git dconf-cli vim-gnome
- Remove Super+Number binding by executing following
```shell
# For 18.04 and 19.04
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false

# Additional only for 19.04
gsettings set org.gnome.shell.keybindings switch-to-application-1 []
gsettings set org.gnome.shell.keybindings switch-to-application-2 []
gsettings set org.gnome.shell.keybindings switch-to-application-3 []
gsettings set org.gnome.shell.keybindings switch-to-application-4 []
gsettings set org.gnome.shell.keybindings switch-to-application-5 []
gsettings set org.gnome.shell.keybindings switch-to-application-6 []
gsettings set org.gnome.shell.keybindings switch-to-application-7 []
gsettings set org.gnome.shell.keybindings switch-to-application-8 []
gsettings set org.gnome.shell.keybindings switch-to-application-9 []
```
- Remove bell sound by turning it of through dconf `org/gnome/settings-daemon/peripherals/keyboard/bell-mode`
- Turn on locate pointer through dconf `org/gnome/settings-daemon/peripherals/mouse`
- Remove Super key as mouse modifier through dconf `org/gnome/desktop/wm/preferences/mouse-button-modifier`
- Remove Super-d and Ctrl-Alt-d mapping through dconf `org/gnome/desktop/wm/keybindings/show-desktop`
- Remove Super-p keybinding through dconf `org/gnome/mutter/keybindings/switch-monitor`
- Set orientation setting to false in dconf `org/gnome/settings-daemon/plugins/orientation/active`
- Replace Super+L with Ctrl+Super+q (same as Mac) to lock screen in dconf `org/gnome/settings-daemon/plugins/media-keys/screensaver`
- Disable touch screen in xorg conf file
    - Check input devices with command `xinput`
    - Add `Option "Ignore" "on"` in touchscreen section of libinput/evdev file in directory `/usr/share/X11/xorg.conf.d`
- install Smyck color scheme from [here](https://github.com/Mayccoll/Gogh). Change background to #002833
- install linuxbrew
- run `git -C "$(brew --repo homebrew/core)" fetch --unshallow`
- install zsh using brew and execute following
    ```shell
    $ sudo usermod -s /home/linuxbrew/.linuxbrew/bin/zsh <username>
    ```
- install oh-my-zsh
- install powerlevel9k
- install Hack Nerd Fonts, download [here](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf) or "MesloLGLDZ Nerd Font" from repository
- change font with dconf editor
    - Create new profile in terminal preferences and delete old one
    - Open dconf-editor and go to org/gnome/terminal/legacy/profiles/<profile-id>/font
    - Change font value to "MesloLGLDZ Nerd Font 14"
- install fd using brew (fd is alternate to find)
- install fzf using brew (fuzzy finder)
- install zsh-autosuggestion using brew
- install zsh-syntax-highlighting using brew
- install zsh-completions using brew
- setup zsh-completions by putting following in zshrc
    ```shell
    $ echo 'fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)' >> ~/.zshrc
    ```
- install vscode snap
- install intellij snap
- install oracle jdk manually
- install maven
- install node
- install grunt-cli through npm
- install docker with installation instruction [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) 
    - run following commands to use docker without sudo
    ```shell
    $ sudo usermod -aG docker $USER
    $ newgrp docker
    
    ## check user groups ##
    $ id -nG
    ```
- install stacer from [here](https://github.com/oguzhaninan/Stacer)
- install gnome-shell-extensions
    ```shell
    $ sudo apt install gnome-shell-extensions -y
    ```
- install gnome-tweak-tool
    ```shell
    $ sudo apt install gnome-tweak-tool -y
    ```
- Change left win key to act as Meta in keyboard option of tweak tool
- Change Caps Lock to act as second Esc in keyboard option of tweak tool
- install 'chrome-gnome-shell' and 'gTile' for window tiling (similar to Magnet in macOS)
    ```shell
    $ sudo apt-get install chrome-gnome-shell
```
- install gnome extension from [here](https://extensions.gnome.org/extension/28/gtile/)
- change keybinding from `super+enter(keypad)` to `super+return`

- install terminator if desired
    ```shell
    $ sudo apt-get install -y terminator
    ```
- to install smyck theme for terminator go to [terminator-themes site](https://github.com/eliverlara/terminator-themes) for reference
    ```shell
    $ sudo apt-get install -y python-requests
    $ mkdir -p $home/.config/terminator/plugins
    $ wget https://git.io/v5zww -o $home"/.config/terminator/plugins/terminator-themes.py"
    ```
- to activate plugin, check the terminatorthemes option under `terminator > preferences > plugins`
- open the terminator context menu and select `Themes`
- select theme and install
- to make the newly installed theme default, replace the `[[default]]` theme with your preferred theme under the `[profiles]` in `~/.config/terminator/config`
