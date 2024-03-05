export PATH="$PATH:$HOME/.local/bin"

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XORGCONFIG="$HOME/.config/xorg.conf"
export FONTCONFIG_PATH=/etc/fonts

export XSECURELOCK_BLANK_TIMEOUT=1
export XSECURELOCK_AUTH_TIMEOUT=10
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_FONT="Cozette"
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_SHOW_DATETIME=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# $HOME clean-up:
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# export CARGO_TARGET_DIR="${XDG_CACHE_HOME}/cargo/target"
export PATH="${PATH}:${CARGO_HOME}/bin"
export GOPATH="${XDG_DATA_HOME}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME}/unison"
export HISTFILE="${XDG_DATA_HOME}/history"
export UPM_NPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/npm"
export UPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/packages"
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator
# export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mariadb/mysql_history
# export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup
export CGDB_DIR=$XDG_CONFIG_HOME/cgdb
export LESSHISTSIZE=0


# Added by Toolbox App
export PATH="$PATH:/home/alexesmet/.local/share/JetBrains/Toolbox/scripts"

