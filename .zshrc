# ------------------------------- PATH ------------------------------- #
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ---------------------------- Completions ---------------------------- #
# brew shellenv (~/.zprofile) exports HOMEBREW_PREFIX; fall back for non-login shells
: "${HOMEBREW_PREFIX:=/opt/homebrew}"
fpath=("$HOMEBREW_PREFIX/share/zsh-completions" "$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

autoload -Uz compinit
# Full compinit (with security audit) at most once a day; cached -C otherwise.
if [[ -n ~/.zcompdump(#qN.mh-24) ]]; then
  compinit -C
else
  compinit
  touch ~/.zcompdump   # compinit skips the rewrite (and mtime bump) when nothing changed
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ------------------------------ Options ------------------------------ #
setopt correct                     # command auto-correction (was ENABLE_CORRECTION)
setopt auto_cd                     # `dirname` instead of `cd dirname`
setopt auto_pushd pushd_ignore_dups pushdminus

# History (oh-my-zsh-like defaults)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt share_history hist_ignore_dups hist_ignore_space hist_verify
setopt extended_history hist_expire_dups_first

# Up/down arrows search history by typed prefix (oh-my-zsh behavior)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]:-^[[A}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]:-^[[B}" down-line-or-beginning-search

# ------------------------------ Plugins ------------------------------ #
source ~/.zsh/omz-git.zsh                # oh-my-zsh git aliases (vendored)
source ~/.zsh/colored-man-pages.zsh      # colored man pages (vendored)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ------------------------------ Prompt ------------------------------ #
eval "$(starship init zsh)"

# -------------------------- Git Aliases (custom) --------------------- #
# These intentionally override omz-git.zsh: gd (git diff), gl (git pull!), glog
alias gd="git diff --color-words"
alias gl="git log --oneline --decorate"
alias glog="git log --oneline --all --graph --decorate -n 30"
alias gslog="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Auto-ls on cd (hook array so future plugins' chpwd hooks compose)
autoload -Uz add-zsh-hook
_auto_ls() { ls --color=auto }
add-zsh-hook chpwd _auto_ls

# Aliases
alias cl="clear"
alias pip="pip3"
alias mexec="chmod a+x"
alias vi="vim"
alias vim="nvim"
alias reb="reboot"
alias sd="shutdown now"
### file browsing
# list files
alias ll="ls -Ahl"

# fast find
ff() {
    find . -name "$1"
}

### file manipulation
# remove
alias rm="rm -rfv"
alias rmi="rm -rfvi"

# copy
alias cp="cp -rfv"

# move
alias mv="mv -fv"
alias mvi="mv -fvi"

# History directory navigation (was provided by oh-my-zsh)
alias d='dirs -v | head -10'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Automatically start a tmux session when connecting with SSH
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux -u attach-session -t ssh_tmux || tmux -u new-session -s ssh_tmux
fi

alias tmux="tmux -u"

# Syntax highlighting must be sourced last
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
