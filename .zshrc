### .zshrc 25-01-25 ### 

### ZSH INIT ###
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit 
autoload -Uz promptinit
compinit
promptinit
prompt adam1

setopt histignorealldups sharehistory
bindkey -e
HISTSIZE=991000
SAVEHIST=991000
HISTFILE=~/.zsh_history

export FPATH="/home/pi/eza/completions/zsh:$FPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd) HISTFILE=~/.histfile

### OMZ ###
export ZSH="$HOME/.oh-my-zsh"
export FPATH="/home/pi/eza/completions/zsh:$FPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd) 
##plugins=(z zsh-navigation-tools zsh-interactive-cd git python virtualenv colorize dirhistory history ssh tailscale)
# rm ~/.zcompdump
# fpath=(${~/.asdf}/completions $fpath)

### ANTIGEN ###
source /usr/share/zsh-antigen/antigen.zsh

antigen init ~/.antigenrc
antigen apply
antigen init ~/.antigenrc

### FZF ###
source ~/fzf-tab/*plugin.zsh
source ~/fzf-tab-source/*.plugin.zsh

FZF_PREVIEW_ADVANCED=1
export FZF_DEFAULT_OPTS="--preview='batcat --color=always $realpath'"

### ALIASES ###
alias cat="batcat"
alias bt="sudo btop"
alias code="code-insiders"
alias ffnv="nvidia-run-mx firefox-nightly&"
alias code="code-insiders"
alias segger="exec /usr/share/segger_embedded_studio_for_arm_5.32/bin/emStudio"
alias usb="sudo -i ; echo disabled >/sys/bus/usb/devices/*/power/wakeup"
alias l="eza --long  --icons=automatic --all --show-symlinks --color-scale-mode gradient --color-scale size"
alias ll="eza --long  --recurse --tree --level=2 --icons=automatic --all --show-symlinks --color-scale-mode gradient --color-scale size"
alias lll="eza --long  --recurse --tree --level=3 --icons=automatic --all --show-symlinks --color-scale-mode gradient --color-scale size"

### BINDKEYS ###
bindkey "^S" "insert-fzy-path-in-command-line"
bindkey ";5C" forward-word
bindkey ";5D" backward-word

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes  
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup 
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 01
zstyle ':completion:*' max-errors 2
#zstyle ':completion:*' verbose true
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

unsetopt flowcontrol
function insert-fzy-path-in-command-line() {
    local selected_path
    echo
    selected_path=$(find * -type f | fzy) || return
    eval 'LBUFFER="$LBUFFER$selected_path "'
    zle reset-prompt
}
zle -N insert-selecta-path-in-command-line
