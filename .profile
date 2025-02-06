export PATH="$PATH:$HOME/.local/bin"
export EDITOR=/usr/bin/nvim
export XORGCONFIG="$HOME/.config/xorg.conf"
export FONTCONFIG_PATH=/etc/fonts

# Lockscreen
export XSECURELOCK_BLANK_TIMEOUT=1
export XSECURELOCK_AUTH_TIMEOUT=10
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=1
export XSECURELOCK_FONT="Cozette"
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_SHOW_DATETIME=1

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export COVER_LETTER_GENERATOR_TEMPLATE_TEX="$HOME/Documents/Docs/cover_letter.j2.tex"
export COVER_LETTER_GENERATOR_TEMPLATE_TXT="$HOME/Documents/Docs/cover_letter.j2.txt"
export COVER_LETTER_GENERATOR_OUTPUT_DIR="$HOME/Downloads/Cover Letter/"

# Configs
export NEOVIDE_FORK=1

# $HOME clean-up:
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export BARTIB_FILE="$XDG_DATA_HOME/activities.bartib"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CGDB_DIR=$XDG_CONFIG_HOME/cgdb
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export HISTFILE="${XDG_DATA_HOME}/history"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export LEIN_HOME="$XDG_DATA_HOME"/lein 
export LESSHISTFILE="-"
export LESSHISTSIZE=0
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mariadb/mysql_history
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NVM_DIR="$XDG_DATA_HOME"/nvm
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PATH="${PATH}:${CARGO_HOME}/bin"
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export UNISON="${XDG_DATA_HOME}/unison"
export UPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/packages"
export UPM_NPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/npm"
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# export CARGO_TARGET_DIR="${XDG_CACHE_HOME}/cargo/target"


# Added by Toolbox App
export PATH="$PATH:/home/alexesmet/.local/share/JetBrains/Toolbox/scripts"
