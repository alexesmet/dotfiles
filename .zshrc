# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/alexesmet/.zshrc'

autoload -Uz compinit
compinit
_comp_options+=(globdots)		# Include hidden files.

# Lines configured by zsh-newuser-install
# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# VIM
bindkey -v
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char
# Yank to the system clipboard
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | xclip -sel clip
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# VARIABLES
export PROMPT="%B%F{4}%m %f%1~%F{4}%# %f%b"
export RANGER_LOAD_DEFAULT_RC=FALSE
fpath+=~/.zfunc

# ALIAS
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
alias sudo='doas'

# idiot-proof protection
alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv --reflink=auto'
alias ln='ln -iv'

# WORK
aws-login() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <token>"
        return 1
    fi
    token="$1"
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    MFA="arn:aws:iam::349928753634:mfa/aliaksei.miatlitski@tui.be"
    creds=`aws sts get-session-token --duration-seconds 43200 --serial-number $MFA --token-code $token --output text`
    if [ $? -ne 0 ]; then
        echo 'An error occured during authentication'
        return 1
    fi
    export AWS_ACCESS_KEY_ID=`echo $creds | awk {'print $2'}`
    export AWS_SECRET_ACCESS_KEY=`echo $creds | awk {'print $4'}`
    export AWS_SESSION_TOKEN=`echo $creds | awk {'print $5'}`
}
source /home/alexesmet/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=9
