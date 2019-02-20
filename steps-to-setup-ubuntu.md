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
