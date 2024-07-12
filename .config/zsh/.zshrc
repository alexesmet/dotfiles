# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '~/.zshrc'

# Basic completion. replaced by zsh-completion
autoload -Uz compinit; compinit
_comp_options+=(globdots)		# Include hidden files.

# === CONFIG ==============================================================
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.cache/zsh/history
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Completion files: Use XDG dirs
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

# === VIM =================================================================
bindkey -v
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char
# Yank to the system clipboar#f38ba8d
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | xclip -sel clip
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# === VARIABLES ===========================================================
export PROMPT="%B%F{4}%m %f%1~%F{4}%# %f%b"
export RANGER_LOAD_DEFAULT_RC=FALSE
fpath+=~/.zfunc

# === ALIAS ===============================================================
alias less='less -R'
alias exa='exa --color=always --group-directories-first'
alias ls='exa --color=always --group-directories-first'
alias ll='exa -la --time-style=long-iso --color=always --group-directories-first'
alias tree='exa -T --time-style=long-iso --color=always --group-directories-first'
alias diff='diff -u --color=always'
alias ip='ip -color=always'
alias watch='watch -c'
alias dd='dd status=progress'
alias xclip='xclip -sel clip'
alias tfswitchb='tfswitch -b $HOME/.local/bin/terraform'
alias vim='nvim'
alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv --reflink=auto'
alias ln='ln -iv'
alias cal='cal -m'
alias drop='dragon-drop'
alias bt='bluetuith --no-warning'
alias rescan='nmcli dev wifi list --rescan yes | cat'
alias bing='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias duf='duf -only local'

eval "$(zoxide init zsh)"
source ~/.config/zsh-window-title/zsh-window-title.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=9


# zellij_tab_name_update() {
#     if [[ -n $ZELLIJ ]]; then
#         local current_dir=$PWD
#         if [[ $current_dir == $HOME ]]; then
#             current_dir="~"
#         else
#             current_dir=${current_dir##*/}
#         fi
#         command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
#     fi
# }
#
# zellij_tab_name_update
# chpwd_functions+=(zellij_tab_name_update)


# source /usr/share/nvm/init-nvm.sh
