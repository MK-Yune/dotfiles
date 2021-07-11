#!/bin/zsh

[[ -x "$(command -v nvim)" ]] && alias vim="nvim" vimdiff="nvim -d"

# ls
alias \
	ls="exa -g --time-style='long-iso' --classify" \
	ll='ls -al' \
	la='ls -a' \
	l.='ls -a | grep -E "^\." --color=never'

# Make commands verbose
alias \
	cp='cp --interactive --verbose' \
	mv='mv --interactive --verbose' \
	rm='rm -I --verbose' \
	mkd='mkdir --parent --verbose' \
	bc='bc --mathlib --quiet'

# Change directory
alias \
	.2='cd ../..' \
	.3='cd ../../..' \
	..2='cd ../..' \
	..3='cd ../../..' \
	sb='cd ~/sandbox' \
	box='cd ~/box'

# chmod
alias \
	600='chmod 600' \
	644='chmod 644' \
	700='chmod 700' \
	755='chmod 755' \
	777='chmod 777'

# Colors
alias \
	grep='grep --color=auto' \
	diff='diff --color=auto'

# Global aliases
alias -g \
	@b='| bat' \
	@g='| grep' \
	@l='| less' \
	@f='| fzf' \
	@c='| xclip -selection clipboard'

# Editor
alias \
	e=$EDITOR \
	v=$EDITOR

# Config files
alias \
	zshrc="$EDITOR $ZDOTDIR/.zshrc" \
	vimrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim"

alias \
	cf="$EDITOR \$(fd --type file --hidden '' $HOME/dotfiles/config | fzf)" \
	se="$EDITOR \$(fd --type executable '' $HOME/dotfiles/local/bin | fzf)"
