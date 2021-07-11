[[ -h "$ZDOTDIR/aliases.sh" ]] && source "$ZDOTDIR/aliases.sh"
[[ -h "$ZDOTDIR/functions.sh" ]] && source "$ZDOTDIR/functions.sh"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# zshoptions
setopt autocd # change directory without prefixing with the `cd` command
setopt histignorealldups sharehistory
setopt histignorespace # forget about the command prefixed with a space
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
setopt correct # try to correct a typed command
# setopt correctall

autoload -U colors && colors

fpath+="$XDG_DATA_HOME/zsh/zfunc"
autoload -Uz compinit &&
	compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' menu select

bindkey '^r' history-incremental-pattern-search-backward

# prompt
PS1='%K{235}'
PS1+='%F{93}%2~%f ' # shows the current and its parent directory, except for $HOME
PS1+='%(?.%F{green}✔.%F{red}✗)%f ' # green when the status ($?) of the last command is 0
PS1+='%k'
PS1+='%# '

# Edit command in vim buffer
autoload -U edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
bindkey -M vicmd '^v' edit-command-line

# Plugin(s)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
