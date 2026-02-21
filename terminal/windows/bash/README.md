# Git bash for windows powerline theme

Light & simple theme for Git bash for windows

## Install

I recommend the following:

```bash
mkdir -p $HOME/.config
git clone https://github.com/xafarr/git_bash_windows_powerline.git $HOME/.config/bash
```

then add the following to your .bashrc:

```bash
export XDG_CONFIG_HOME=$HOME/.config
# Theme
THEME=$XDG_CONFIG_HOME/bash/theme.bash
if [ -f $THEME ]; then
   . $THEME
fi
unset THEME
```

## Requisites

  * In order for this theme to render correctly, you will need a [Nerd Font](https://www.nerdfonts.com/font-downloads).

## License

MIT
