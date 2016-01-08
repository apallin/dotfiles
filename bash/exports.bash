export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export BLOCKSIZE=1k
export ANDROID_HOME=/usr/local/opt/android-sdk
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export WORKON_HOME=$HOME/pythonenvs

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
