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
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen apply

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Blessclient
source "$HOME"/src/blessclient/lyftprofile

# Local source
source "$HOME"/.localrc
source '/Users/apallin/src/awsaccess/awsaccess2.sh' # awsaccess
source '/Users/apallin/src/awsaccess/oktaawsaccess.sh' # oktaawsaccess
export PS1="\$(ps1_mfa_context)$PS1" # awsaccess
source ~/.kube-cache/bin/lyftlearn_profile
eval "$(/lyft/brew/bin/aactivator init)"
