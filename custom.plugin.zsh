#
# My custom configuration and aliases
#

############################
# Configuration
#

export EDITOR='vim'
export LC_ALL=en_US.UTF-8
setopt no_share_history

bindkey -v # use like vim editor
bindkey "\e." insert-last-word

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^i^e' edit-command-line

zle-line-init () {
  zle -K viins
  #echo -ne "\033]12;Grey\007"
  #echo -n 'grayline1'
  echo -ne "\033]12;Gray\007"
  echo -ne "\033[5 q"
  #print 'did init' >/dev/pts/16
}
zle -N zle-line-init
zle-keymap-select () {
  if [[ $KEYMAP == vicmd ]]; then
    if [[ -z $TMUX ]]; then
      printf "\033]12;Green\007"
      printf "\033[2 q"
    else
      printf "\033Ptmux;\033\033]12;red\007\033\\"
      printf "\033Ptmux;\033\033[2 q\033\\"
    fi
  else
    if [[ -z $TMUX ]]; then
      printf "\033]12;Grey\007"
      printf "\033[5 q"
    else
      printf "\033Ptmux;\033\033]12;grey\007\033\\"
      printf "\033Ptmux;\033\033[5 q\033\\"
    fi
  fi
  #print 'did select' >/dev/pts/16
}
zle -N zle-keymap-select

export VISUAL='nvim'
export FZF_COMPLETION_OPTS='+c -x'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


############################
# Aliases
#

alias c='cat'
alias tx='tmux'
alias tcpu='top -o cpu'
alias tmem='top -o mem'
alias vv='vim'
alias nv='nvim'
alias cat='bat'
alias pwdx="pwd | pbcopy"

GITHUB_HOME="~/github"
FZF_BASE_DIR='/usr/local/Cellar/fzf/0.20.0'

jprofiler() {
    echo $1
    id=`jps | awk -v name=$1 '{ if ($2 == name) { print $1; } }' - `
    echo "Profiling pid = $id"
    shift
    sudo ${GITHUB_HOME}/async-profiler/profiler.sh $@ $id 
}

#
# Git
#
alias gfmb='git pull origin "$(git-branch-current 2> /dev/null)"'
alias gloa='glo --all'

#
# Maven
#
alias mpackTest='mvn package'
alias mpack='mvn package -DskipTests=True'
alias mrepackTest='mvn clean package'
alias mrepack='mvn clean package -DskipTests=True'

#
# Gradle
#
alias grl='gradle'
alias grlb='gradle build'
alias grlcb='gradle clean build'
alias grlt='gradle test'
alias grlct='gradle clean test'

#
# curl
#
mcurl() {
    curl $@ 2>/dev/null
}
alias cput='mcurl -X PUT'
alias cdel='mcurl -X DELETE'
export HJSON='Content-Type: application/json'
alias rget='mcurl -X GET -H $HJSON'
alias rpost='mcurl -X POST -H $HJSON'
alias rput='mcurl -X PUT -H $HJSON'

# python
alias py3='python3'

#
# kafka tools
#

KAFKA_BIN_DIR=${GITHUB_HOME}'/kafka_2.12-2.4.0/bin'
alias kk-consumer-grp="$KAFKA_BIN_DIR/kafka-consumer-groups.sh"
alias kk-cmd-consumer="$KAFKA_BIN_DIR/kafka-console-consumer.sh"
alias kk-cmd-producer="$KAFKA_BIN_DIR/kafka-console-producer.sh"
alias kk-tpc="$KAFKA_BIN_DIR/kafka-topics.sh"

#
# docker
#

alias dk='docker'
alias dkimg='docker image'
alias dkct='docker container'
alias dkb='docker build'
alias dkr='docker run'
alias dkex='docker exec'
alias dks='docker start'
alias dks='docker stop'

dk_ps() {
  docker ps | awk '{ if (NR != 1) print $0, "\t",  NR-1; else print $0; } '
}


get_docker_id() {
  docker ps -q | awk -v n=$1 'NR == n {print $0}'
}

dksId() {
  docker stop `get_docker_id $1`
}

dkssh() {
  docker exec -it `get_docker_id $1` /bin/bash
}

