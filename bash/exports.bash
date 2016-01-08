export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export BLOCKSIZE=1k
export ANDROID_HOME=/usr/local/opt/android-sdk
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export WORKON_HOME=$HOME/pythonenvs

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh


# Autocomplete for git and bash commands
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion                                                                                                                                                                
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done
