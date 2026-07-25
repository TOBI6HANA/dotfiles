############################
# EDITOR
############################
export EDITOR=nvim
export VISUAL=nvim

export SUDO_ASKPASS=/usr/bin/ksshaskpass

############################
# PATH
############################
export PATH="$HOME/.local/bin:$PATH"

############################
# ALIASES
############################
alias vim="nvim"

############################
# OPTIONS
############################
# Include hidden files in globbing/completion
setopt GLOB_DOTS
# Let fzf-tab handle the completion menu
unsetopt AUTO_MENU
unsetopt MENU_COMPLETE
unsetopt AUTO_LIST

############################
# PLUGINS
############################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# ---- fzf-tab preview ------------------------------------------------------
# Directories -> recursive tree, images/pdf -> kitty graphics, text -> bat
# with Tokyo Night highlighting, everything else -> empty. See fzf-preview.sh
zstyle ':fzf-tab:complete:*' fzf-preview '$HOME/.local/bin/fzf-preview.sh $realpath'
# zstyle ':fzf-tab:complete:*' fzf-flags '--preview-window=right,55%,border-rounded'
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#283457,bg:#1a1b26,spinner:#bb9af7,hl:#7dcfff \
  --color=fg:#c0caf5,header:#e0af68,info:#7aa2f7,pointer:#bb9af7 \
  --color=marker:#9ece6a,fg+:#ffffff,prompt:#bb9af7,hl+:#7dcfff \
  --color=border:#7aa2f7,preview-border:#7aa2f7,label:#c0caf5 \
  --color=query:#c0caf5,disabled:#565f89 \
  --color=scrollbar:#bb9af7,preview-scrollbar:#bb9af7 \
  --border=rounded \
  --height=50%

autoload -U compinit && compinit

############################
# FZF
############################
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
--color=bg+:#283457,bg:#1a1b26,spinner:#bb9af7,hl:#7dcfff
--color=fg:#c0caf5,header:#e0af68,info:#7aa2f7,pointer:#bb9af7
--color=marker:#9ece6a,fg+:#ffffff,prompt:#bb9af7,hl+:#7dcfff
--color=border:#7aa2f7,preview-border:#7aa2f7,label:#c0caf5
--color=query:#c0caf5,disabled:#565f89
--color=scrollbar:#bb9af7,preview-scrollbar:#bb9af7
--border=rounded
--preview-window=border-rounded
--layout=reverse
--height=50%
--margin=0,1
--padding=1
"

# Standalone fzf widgets (Ctrl-T file finder, Alt-C cd finder) get the same
# universal preview as fzf-tab.
export FZF_CTRL_T_OPTS="--preview '$HOME/.local/bin/fzf-preview.sh {}' --preview-window=right,55%,border-rounded"
export FZF_ALT_C_OPTS="--preview '$HOME/.local/bin/fzf-preview.sh {}' --preview-window=right,55%,border-rounded"
export BAT_THEME="tokyonight_night"

############################
# ZOXIDE
############################
eval "$(zoxide init --cmd cd zsh)"

############################
# STARSHIP
############################
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

############################
# VI MODE (jeffreytse/zsh-vi-mode)
############################
# Replaces the plain `bindkey -v` from before. Fixes the two big pain points
# with zsh's built-in vi mode:
#   1. "feels slow"          -> built-in vi mode waits on $KEYTIMEOUT (0.4s)
#                               to resolve key sequences. This plugin uses its
#                               own faster reader; ZVM_KEYTIMEOUT below tunes it.
#   2. "can't delete in insert mode" -> plain `bindkey -v` leaves backspace,
#                               ctrl-w, ctrl-u, home/end etc. unbound in insert
#                               mode on many systems. This plugin binds all of
#                               that properly, plus adds real vim extras
#                               (surround, text objects, cursor per mode, etc).

# How long (seconds) to wait for a multi-key sequence before giving up.
# Default is 0.4s, which is what made mode-switching feel sluggish.
ZVM_KEYTIMEOUT=0.05

# The plugin overwrites keymaps set by other plugins on init, so fzf's own
# Ctrl-R / Ctrl-T / Alt-C bindings need to be re-applied afterward. This
# function is auto-called by the plugin once it finishes loading.
function zvm_after_init() {
  eval "$(fzf --zsh)"
}

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export GTK_THEME=Tokyonight-Dark
export PAGER=less
export SYSTEMD_PAGER=less

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && cd -- "$cwd"
	command rm -f -- "$tmp"
}
