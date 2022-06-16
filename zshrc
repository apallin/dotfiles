ZSH_DISABLE_COMPFIX="true"

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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Local source
source "$HOME"/.localrc

export PATH="/opt/homebrew/opt/m4/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/postgresql@12/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/libq/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/postgresql@12/include $CPPFLAGS"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

alias brew86="arch -x86_64 /usr/local/bin/brew"
alias brewm1="/opt/homebrew/bin/brew"
alias brew="brew86"
export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="/usr/local/opt/postgresql@13/bin:$PATH"
