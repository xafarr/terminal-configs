#!/bin/bash
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Primary><Super>q' &&
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Super>d']" &&
gsettings set org.gnome.mutter.keybindings switch-monitor [] &&
gsettings set org.gnome.settings-daemon.peripherals.mouse locate-pointer true &&
gsettings set org.gnome.settings-daemon.peripherals.keyboard bell-mode 'off' &&
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '' &&
gsettings set org.gnome.desktop.wm.keybindings begin-resize [''] &&
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader '' &&
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu [''] &&
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier '' &&
gsettings set org.gnome.desktop.wm.keybindings begin-resize [] &&
gsettings set org.gnome.desktop.wm.keybindings maximize [] &&
gsettings set org.gnome.desktop.wm.keybindings minimize [] &&
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog [] &&
gsettings set org.gnome.desktop.wm.keybindings switch-input-source [] &&
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward [] &&
gsettings set org.gnome.desktop.wm.keybindings unmaximize [] &&
gsettings set org.gnome.shell.keybindings focus-active-notification [] &&
gsettings set org.gnome.shell.keybindings open-application-menu [] &&
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts [] &&
gsettings set org.gnome.shell.keybindings toggle-application-view [] &&
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal '' &&
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']" &&
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view' &&
gsettings set org.gnome.nautilus.preferences search-view 'list-view' &&
gsettings set org.gnome.mutter.keybindings toggle-tiled-left [] &&
gsettings set org.gnome.mutter.keybindings toggle-tiled-right [] &&
gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']" &&
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true &&
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true &&
gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on' &&
gsettings set org.gtk.Settings.FileChooser clock-format '12h' &&
gsettings set org.gnome.desktop.interface clock-format '12h' &&
gsettings set org.gnome.desktop.interface clock-show-date true &&
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ paste '<Super>v' &&
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ copy '<Super>c' &&
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]" &&
gsettings set org.gnome.desktop.input-sources xkb-options "['altwin:left_meta_win', 'caps:escape']" &&
gsettings set org.gnome.desktop.interface show-battery-percentage true &&
gsettings set org.gnome.settings-daemon.plugins.orientation active false &&
gsettings set org.gnome.shell.keybindings toggle-message-tray [] &&
gsettings set org.gnome.shell disable-user-extensions false &&
gsettings set org.gnome.shell enabled-extensions "['gTile@vibou']" &&
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false &&
gsettings set org.gnome.mutter overlay-key 'Super_R'

