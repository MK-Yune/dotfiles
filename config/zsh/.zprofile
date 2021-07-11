typeset -U PATH path
export PATH="$HOME/.local/bin:$PATH"

export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='brave'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export LESSHISTFILE=-

export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"

export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"

# TeX Live
#export TEXMFHOME="${XDG_DATA_HOME:-$HOME/.local/share}"/texmf
export TEXMFVAR="${XDG_CACHE_HOME:-$HOME/.cache}"/texlive/texmf-var
#export TEXMFCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/texlive/texmf-config

# Rust
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

# Node.js
export VOLTA_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/volta"
export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.config}/node_repl_history"

# Python
export PYENV_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/pyenv"
[[ -x "$(command -v pyenv)" ]] && eval "$(pyenv init -)"
export POETRY_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/pypoetry"

export PATH="$VOLTA_HOME/bin:$POETRY_HOME/bin:$PATH"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pidof -q dwm || startx "$XINITRC"
fi
