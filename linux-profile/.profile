#!/bin/zsh

# Adds `~/.local/bin` to $PATH
[ -s "$HOME/.local/bin/" ] && export PATH="$PATH:${$(echo $(echo $(du -L $HOME/.local/bin | cut -f2)) | sed -e "s/ /:/g")}"
[ -s "$HOME/.local/scripts/" ] && export PATH="$PATH:${$(echo $(echo $(du -L $HOME/.local/scripts | cut -f2)) | sed -e "s/ /:/g")}"
[ -s "$HOME/.config/rofi/bin" ] && export PATH="$PATH:$HOME/.config/rofi/bin/"

# Default programs:
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"
export TERM=xterm-256color

## "nvim" as manpager
export MANPAGER="nvim -c 'set ft=man' -"

# ~/ Clean-up:
[ -f "$HOME/.config/xdg-dirs/xdgdirs" ] && source "$HOME/.config/xdg-dirs/xdgdirs"

# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
# export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export LESSHISTFILE="-"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"

#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
#export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

# Other program settings:
export SUDO_ASKPASS="$HOME/.config/rofi/scripts/askpass-rofi"
# export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

if pacman -Qs libxft-bgra >/dev/null 2>&1; then
  # Start graphical server on tty1 if not already running.
  [ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx
else
  echo "Note that \`libxft-bgra\` must be installed for this build of dwm. Please run: yay -S libxft-bgra-git and replace \`libxft\`"
fi

# Switch escape and caps if tty and no passwd required:
# sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
