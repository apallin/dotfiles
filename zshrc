bindkey -e

# Plugins
source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle tarruda/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

# Apply theme
antigen theme mortalscumbag

antigen apply

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source custom environment and aliases
source ~/.bashrc
