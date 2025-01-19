#autoload -Uz compinit
# compinit

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
##plugins=(z zsh-navigation-tools zsh-interactive-cd git python virtualenv colorize dirhistory history ssh tailscale)
plugins=(asdf z zsh-syntax-highlighting zsh-autosuggestions zsh-navigation-tools zsh-interactive-cd git python virtualenv colorize dirhistory history ssh tailscale fzf history-substring-search dircycle fzf-tab fzf-zsh-plugin)

setopt histignorealldups sharehistory
autoload -Uz promptinit
promptinit
prompt adam1

bindkey -e

HISTSIZE=991000
SAVEHIST=991000
HISTFILE=~/.zsh_history

fpath=(${~/.asdf}/completions $fpath)
compinit

eval "$(dircolors -b)"
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source /usr/share/zsh-antigen/antigen.zsh
antigen init ~/.antigenrc

alias lll="eza --long --mounts --recurse --tree --level=2 --icons=automatic --git --all --show-symlinks --color-scale-mode gradient --color-scale size"
alias cat="batcat"
alias bt="sudo btop"
alias code="code-insiders"  

export FPATH="/home/pi/eza/completions/zsh:$FPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd) HISTFILE=~/.histfile

unsetopt flowcontrol
function insert-fzy-path-in-command-line() {
    local selected_path
    echo
    selected_path=$(find * -type f | fzy) || return
    eval 'LBUFFER="$LBUFFER$selected_path "'
    zle reset-prompt
}
zle -N insert-selecta-path-in-command-line

bindkey "^S" "insert-fzy-path-in-command-line"
bindkey ";5C" forward-word
bindkey ";5D" backward-word

