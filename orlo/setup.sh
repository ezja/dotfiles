sudo apt install zsh zsh-antigen -y
source /usr/share/zsh-antigen/antigen.zsh
antigen restore ~/dotfiles/orlo/antigen-snapshot
antigen init ~/dotfiles/orlo/.antigenrc
antigen cache-gen