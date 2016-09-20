bindkey -e

# Path to dotfiles repo
export DOTFILES="$(dirname "$(readlink "$HOME/.zshrc")")"

configs=($DOTFILES/*/*.bash)
for file in "${configs[@]}"
do
  source "$file"
done


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

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# added by travis gem
[ -f /Users/adampallin/.travis/travis.sh ] && source /Users/adampallin/.travis/travis.sh
source '/Users/adampallin/src/blessclient/lyftprofile' # bless ssh alias
