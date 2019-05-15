local fuzzy_selector=fzf

# pyclean: Clean all Python caches recursivly
pyclean () {
    find . -name "*.pyc" -exec rm -rf {} \;
    find . -name "__pycache__" -exec rm -rf {} \;
    find . -name ".cache" -exec rm -rf {} \;
    find . -name "build" -exec rm -rf {} \;
    find . -name ".mypy_cache" -exec rm -rf {} \;
}

# showa: To remind yourself of an alias (given some part of it)
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder

# extract: Extract most know archives with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

ff () { /usr/bin/find . -name "$@" ; }      # ff: Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs: Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe: Find file whose name ends with a given string

make_pr() {
  if [[ -n $1 ]]; then
      branch=$1
  else
      branch=master
  fi
  hub pull-request -b $branch -o
}

function wo() {
    code_dirs=(
        ~/src
    )
    dir_list=$(find "${code_dirs[@]}" -type d -maxdepth 3 | grep -v /Pods)

    if [[ -n $1 ]]; then
        cd "$(grep --max-count=1 -i "$*" <<< $dir_list)"
    else
        if [ -x "$(which $fuzzy_selector)" ]; then
            cd "$(grep -v /Pods <<< $dir_list | $fuzzy_selector)"
        else
            echo "You need to install '$fuzzy_selector' to get the fuzzy finder"
        fi
    fi
}

function rage_delete_branches() {
    for branch in $(git branch | grep -Ev '\smaster$|^\*'); do
        echo "Delete branch '$branch'?"
        read -r confirm
        if [[ $confirm = 'y' ]]; then
            git branch -D "$branch"
        fi
    done
}

function container_py_shell () {
  control enter "${current_proj_name}.legacy"
  service_venv pip install ptpython
  service_venv ptpython
}

function container_service_logs() {
  control enter "${current_proj_name}.legacy"
  tail -f "/var/log/${current_proj_name}-web/current"
}

function launch_lyft_code_session() {
  current_proj_name=${PWD##*/}
  subl .

  tmux new-session -t $current_proj_name
  control ensure -g "${current_proj_name}.dev"
  tmux split-pane -h
  tmux split-window -v
  tmux select-pane -t 0
  container_py_shell
  tmux select-pane -t 1
  container_service_logs
}

function launch_code_session(){
  current_proj_name=${PWD##*/}
  subl .
  tmux new-session -A -t $current_proj_name
}

function new_code_session() {
    code_dirs=(
        ~/src
    )
    dir_list=$(find "${code_dirs[@]}" -type d -maxdepth 1 | grep -v /Pods)
    if [ -x "$(which $fuzzy_selector)" ]; then
        cd "$(grep -v /Pods <<< $dir_list | $fuzzy_selector)"
    else
        echo "You need to install '$fuzzy_selector' to get the fuzzy finder"
    fi

    if if [ -f ./manifest.yaml ]; then
       launch_lyft_code_session
    else
       launch_code_session
    fi
}
