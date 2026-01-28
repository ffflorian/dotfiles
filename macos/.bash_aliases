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
alias reload="source ~/.bash_profile"
alias rg="rg --ignore-case"
alias python="python3"
alias pip="pip3"
alias upgrade-all="brew upgrade; \
                   g self-upgrade; \
                   g install latest; \
                   g prune; \
                   rustup update; \
                   n i 24; \
                   npm install --registry https://registry.npmjs.org --global npm yarn http-server eslint @ffflorian/gh-open"
alias myip="curl http://checkip.amazonaws.com"
alias uuidgen="uuidgen | tr A-F a-f"
alias yt="yt-dlp --retries 1 --no-call-home --user-agent \"Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36\""

# use gnu utils
alias grep="ggrep"
alias find="gfind"
alias sed="gsed"
alias xargs="gxargs"
alias date="gdate"

# git aliases

alias check="git checkout"
alias checkout="git checkout"
alias ga="git add -A"
alias gagd="git add -A && git diff --cached"
alias gam="git commit -S --amend"
alias gamend="git commit -S --amend"
alias gb="git checkout -b"
alias gg="git log"
alias gs="git status"
alias gbranch="git rev-parse --abbrev-ref HEAD"
alias gc="git commit -S -m"
alias gd="git diff --cached"
alias gdn="git diff --cached --name-only"
alias gl="git log"
alias gm="git merge"
alias gr="git reset"
alias grh="git reset --hard"
alias grh1="git reset --hard HEAD~1"
alias gr1="git reset HEAD~1"
alias gt="git tag -a -s -m"
alias grd="git push origin -d"
alias merge="git merge"
alias pull="git pull --no-verify"
alias push="git push"
alias pushc="git push -o merge_request.create"
alias pish="push"
alias Push="push"
alias pushb="push"
alias prune="git prune && git remote prune origin"
alias pp="git pull --no-verify --prune"
alias pbc="git push -o merge_request.create"
alias pushbc="git push -o merge_request.create"
alias gsu="git submodule init && git submodule update"

alias create-mr="glab mr create --assignee florianimdahl --fill --web"

function docker-run() {
  docker run --rm -it $(docker build .)
}

function wttr() {
  curl -s http://wttr.in/Berlin #| head -7 | tail -5
}

function gh-open() {
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "${CURRENT_BRANCH}" == "${DEFAULT_BRANCH}" ]]; then
    gh repo view -w
  else
    gh pr view -w || gh repo view -w || gh-open
  fi
}

function is-merged {
  if [[ "$(glab mr view -F json | jq '.state == "merged"')" != "true" ]]; then
    echo "MR is not merged yet"
    return 1
  fi
}

function gl-open() {
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "${CURRENT_BRANCH}" == "${DEFAULT_BRANCH}" ]]; then
    glab repo view "$(git remote get-url origin)" -w
  else
    glab mr view -w || glab repo view "$(git remote get-url origin)" -w
  fi
}

function gmain() {
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  git checkout "${DEFAULT_BRANCH}"
  git pull --prune
  git checkout -
  git merge -S "${DEFAULT_BRANCH}"
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

function gdel() {
  REMOTE="origin"
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/${REMOTE}/HEAD 2>/dev/null | sed "s@^refs/remotes/${REMOTE}/@@")"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

  if [ "${CURRENT_BRANCH}" == "${DEFAULT_BRANCH}" ]; then
    echo "Already on default branch \"${DEFAULT_BRANCH}\"."
    return 0
  fi

  if [[ "$(glab mr view -F json | jq '.state == "merged"')" != "true" ]]; then
    read -p "MR is not merged yet. Do you want to delete anyway? [Y/n]: " CONFIRM
    if [[ "${CONFIRM}" =~ ^([nN][oO]|[nN])$ ]]; then
        echo "Not deleting branch."
        return 1
    fi
  fi

  git checkout "${DEFAULT_BRANCH}"
  git branch -D "${CURRENT_BRANCH}"
  git pull --prune
}

function update-all-non-main-repos() {
  find . -type d -name ".git" | while read gitdir; do
    REPO_DIR="$(dirname "${GIT_DIR}")"
    cd "${REPO_DIR}" > /dev/null

    DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
    CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

    if [ "${CURRENT_BRANCH}" != "${DEFAULT_BRANCH}" ]; then
      echo "${REPO_DIR##*/}: Not on default branch \"${DEFAULT_BRANCH}\" but instead on \"${CURRENT_BRANCH}\"."
      read -p "Try deleting branch and updating main? [Y/n]: " EXECUTE < /dev/tty

      if [[ -z "${EXECUTE}" || "${EXECUTE}" =~ ^[yY]$ ]]; then
        if [[ "$(glab mr view -F json | jq '.state == "merged"')" == "true" ]]; then
          git checkout "${DEFAULT_BRANCH}"
          git branch -D "${CURRENT_BRANCH}"
          git pull --prune
        else
          echo "MR is not merged yet. Not deleting branch."
          cd - > /dev/null
          continue
        fi
      fi
    elif [[ -z $(git status --porcelain) ]]; then
      git pull --prune
    fi
    cd - > /dev/null
  done
}
