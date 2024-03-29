#!/bin/bash

alias "cd.."="cd .."
alias bwd="pwd | sed -e 's:/:🥖 :g'"
alias close="wmctrl -c"
alias conn="sudo netstat -pan --inet"
alias duf="sudo du -sh * | sort -rh"
alias diff="diff --color"
alias gpg="gpg2"
alias dl="curl -LO"
alias inst="sudo apt install"
alias l="ls -CFh"
alias la="ls -Ah"
alias ll="ls -AhlF"
alias myip="curl http://checkip.amazonaws.com"
alias n="nvm"
alias open="xdg-open"
alias please="sudo --prompt \"[please] password for ${USER}\":"
alias reboot="systemctl reboot"
alias reload="source ~/.bashrc"
alias shutdown="systemctl poweroff"
alias temp="watch -n 1 -d sensors"
alias upd="sudo apt update -qq"
alias upgr="sudo apt upgrade"
alias upgrd="sudo apt dist-upgrade"
alias google-chrome-unsafe="google-chrome --disable-web-security --disable-features=SameSiteByDefaultCookies --no-default-browser-check --no-first-run --user-data-dir=\"/tmp/ChromeDevSession\""
alias wp="ps aux | grep -v grep | grep"
alias xclip="xclip -selection c"
alias upgrade-all="upd && upgr; \
                   sudo apt-get autoremove; \
                   ~/bin/nvm-update.sh; \
                   nvm i 16; \
                   npm i -g npm yarn generate-changelog electron-info; \
                   exercism upgrade; \
                   rustup update; \
                   g self-upgrade && \
                   g install latest && \
                   g prune; \
                   go install github.com/ffflorian/go-tools/gh-open@latest; \
                   yt --update"
alias yt="youtube-dl \
          --retries 1 \
          --no-call-home \
          --user-agent \"Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36\""
alias zarn="yarn"
alias rg="rg --ignore-case"
alias python="python3"
alias pip="pip3"

# git aliases

alias check="git checkout"
alias checkout="git checkout"
alias ga="git add -A"
alias gam="git commit -S --amend"
alias gamend="git commit -S --amend"
alias gb="git checkout -b "
alias gbranch="git rev-parse --abbrev-ref HEAD"
alias gc="git commit -S -m"
alias gd="git diff --cached"
alias gdn="git diff --cached --name-only"
alias ghome="git config user.name \"Florian Imdahl\" && git config user.email \"git@ffflorian.de\" && git config user.signingkey \"4B98BD1A\""
alias gl="git log"
alias gm="git merge"
alias gpull="git pull --no-verify"
alias gpush="git push --no-verify"
alias gps="gpush"
alias gpl="gpull"
alias gprune="git prune && git remote prune origin"
alias gr="git reset"
alias grh="gr --hard"
alias grh1="grh HEAD~1"
alias gr1="gr HEAD~1"
alias gt="git tag -a -s -m"
alias merge="gm"
alias pull="gpull"
alias push="gpush"
alias pushb="gpushb"
alias prune="gprune"
alias p="pull"
alias pp="pull --prune"
alias gsu="git submodule init && git submodule update"

function gl-open() {
  glab mr view -w || glab repo view "$(git remote get-url origin)" -w
}

function wttr() {
  curl -4 -s http://wttr.in/Berlin #| head -7 | tail -5"
}

function gupdate() {
  COMMIT_MESSAGE="$(git log -1 --pretty=%B)"
  git reset HEAD~1
  git add .
  git stash
  git pull
  git stash pop
  git add .
  git commit -S -m "${COMMIT_MESSAGE}"
}

function biggest() {
  if [[ $# -eq 0 ]]; then
    du -hd1 | sort -rh | tail -n +2
  else
    du -hd1 | sort -rh | tail -n +2 | head -n${1}
  fi
}

function json_prettyprint() {
  FILENAME="${1%.*}"
  EXTENSION="${1##*.}"
  cat "${1}" | python -mjson.tool
}

function debchangelog() {
  zless "/usr/share/doc/${1}/changelog.Debian.gz"
}

function gpushb() {
  #REMOTE="$(git remote show)"
  #if [[ "${REMOTE}" =~ (\ ) ]]; then
  #  echo "Multiple remotes."
  #else
  REMOTE="origin"
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  git push --set-upstream "${REMOTE}" "${BRANCH}" "$@"
  #fi
}

function gdel() {
  REMOTE="origin"
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [ "${CURRENT_BRANCH}" == "${DEFAULT_BRANCH}" ]; then
    echo "Already on default branch "${DEFAULT_BRANCH}"."
  else
    git checkout "${DEFAULT_BRANCH}"
    git branch -D "${CURRENT_BRANCH}"
    git pull --prune
  fi
}

function matrix() {
  echo -e "\e[1;40m"
  clear
  while :; do
    echo ${LINES} ${COLUMNS} $((${RANDOM} % ${COLUMNS})) $((${RANDOM} % 72))
    sleep 0.05
    #  done | gawk '{ letters="ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ"; c=$4; letter=substr(letters,c,1);a[$3]=0; for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s", o, x, letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H", a[x], x, letter; if (a[x] >= $1) { a[x]=0; } }}'
  done | gawk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

function nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

function ytl() {
  URL="$(yt --get-url ${1})"
  if [ ! -z "${URL}" ]; then
    vlc --quiet "${URL}" &
  fi
}

function =() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  echo "$(($calc))"
}

# wrapper for easy extraction of compressed files
function extract() {
  if [ -f ${1} ]; then
    case ${1} in
    *.7z) 7z x ${1} ;;
    *.apk) unzip ${1} ;;
    *.bz2) bunzip2 ${1} ;;
    *.epub) unzip ${1} ;;
    *.gz) gunzip ${1} ;;
    *.jar) unzip ${1} ;;
    *.rar) unrar e ${1} ;;
    *.tar) tar xvf ${1} ;;
    *.tar.bz2) tar xvjf ${1} ;;
    *.tar.gz) tar xvzf ${1} ;;
    *.tar.xz) tar xvJf ${1} ;;
    *.tbz2) tar xvjf ${1} ;;
    *.tgz) tar xvzf ${1} ;;
    *.war) unzip ${1} ;;
    *.xpi) unzip ${1} ;;
    *.Z) uncompress ${1} ;;
    *.zip) unzip ${1} ;;
    *) echo "don't know how to extract '${1}'..." ;;
    esac
  else
    echo "'${1}' is not a valid archive"
  fi
}
