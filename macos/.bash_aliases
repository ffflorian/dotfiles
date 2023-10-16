#!/usr/bin/env bash

alias "cd.."="cd .."
alias bwd="pwd | sed -e 's:/:🥖:g'"
alias close="wmctrl -c"
alias diff="diff --color"
alias dl="curl -LO"
alias l="ls -CFh"
alias la="ls -Ah"
alias ll="ls -AhlF"
alias n="nvm"
alias google-chrome-unsafe="open -a 'Google Chrome.app' \
                            --args \
                            --disable-web-security \
                            --disable-features=SameSiteByDefaultCookies \
                            --no-default-browser-check \
                            --no-first-run \
                            --user-data-dir='/tmp/ChromeDevSession'"
alias zarn="yarn"
alias reload="source ~/.bashrc"
alias rg="rg --ignore-case"
alias python="python3"
alias pip="pip3"
alias upgrade-all="brew upgrade; \
                   g self-upgrade; \
                   g install latest; \
                   g prune; \
                   rustup update; \
                   n i 18; \
                   npm i --registry https://registry.npmjs.org -g npm yarn"
alias myip="curl http://checkip.amazonaws.com"

# git aliases

alias git="LANG=en_US git"
alias check="LANG=en_US git checkout"
alias checkout="LANG=en_US git checkout"
alias ga="LANG=en_US git add -A"
alias gam="LANG=en_US git commit -S --amend"
alias gamend="LANG=en_US git commit -S --amend"
alias gb="LANG=en_US git checkout -b"
alias gbranch="LANG=en_US git rev-parse --abbrev-ref HEAD"
alias gc="LANG=en_US git commit -S -m"
alias gd="LANG=en_US git diff --cached"
alias gdn="LANG=en_US git diff --cached --name-only"
alias ghome="LANG=en_US \
             git config user.name 'Florian Imdahl' && \
             git config user.email 'git@ffflorian.de' && \
             git config user.signingkey '4B98BD1A'"
alias gl="LANG=en_US git log"
alias gm="LANG=en_US git merge"
alias gr="LANG=en_US git reset"
alias grh="LANG=en_US git reset --hard"
alias grh1="LANG=en_US git reset --hard HEAD~1"
alias gr1="LANG=en_US git reset HEAD~1"
alias gt="LANG=en_US git tag -a -s -m"
alias merge="LANG=en_US git merge"
alias pull="LANG=en_US git pull --no-verify"
alias push="LANG=en_US git push --no-verify"
alias pushb="gpushb"
alias prune="LANG=en_US git prune && git remote prune origin"
alias pp="LANG=en_US git pull --no-verify --prune"
alias pbc="gpushb -o merge_request.create"
alias pushbc="gpushb -o merge_request.create"
alias gsu="git submodule init && git submodule update"

function wttr() {
  curl -4 -s http://wttr.in/Berlin #| head -7 | tail -5"
}

function gh-open() {
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "${CURRENT_BRANCH}" == "main" ]]; then
    gh repo view -w
  else
    gh pr view -w || gh repo view -w || gh-open
  fi
}

function gl-open() {
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "${CURRENT_BRANCH}" == "main" ]]; then
    glab repo view "$(git remote get-url origin)" -w
  else
    glab mr view -w || glab repo view "$(git remote get-url origin)" -w
  fi
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
  [ -z "$1" ] && du -hsx * | sort -rh || du -hsx * | sort -rh | head -n $1
}

function gpushb() {
  REMOTE="origin"
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  LANG=en_US git push --set-upstream "${REMOTE}" "${BRANCH}" "$@"
}

function gdel() {
  REMOTE="origin"
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [ "${CURRENT_BRANCH}" == "${DEFAULT_BRANCH}" ]; then
    echo "Already on default branch \"${DEFAULT_BRANCH}\"."
  else
    git checkout "${DEFAULT_BRANCH}"
    git branch -D "${CURRENT_BRANCH}"
    git pull --prune
  fi
}
