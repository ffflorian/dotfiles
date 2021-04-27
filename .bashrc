# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# add git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
linux|xterm*|rxvt*)
  #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w \$ \[\033[00m\]'
  PS1="\[\033[01;37m\]\A \[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$ "
  ;;
*)
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
  fi
fi

## Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
## if we're coming from a remote SSH connection, in an interactive session
## then automatically put us into a screen(1) session.   Only try once
## -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
## if screen fails for some reason.
#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]
#then
#  STARTED_SCREEN=1 ; export STARTED_SCREEN
#  [ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
#  sleep 1
#  screen -U -RR && exit 0
#  # normally, execution of this rc script ends here...
#  echo "Screen failed! continuing with normal bash startup"
#fi
## [end of auto-screen snippet]

export EDITOR="vim"

export NPM_PACKAGES="/home/florian/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export NVM_DIR="${HOME}/.nvm"
export NODE_BIN=$(echo ${NVM_DIR}/versions/node/v*/bin)
#export NODE_BIN=$(echo ${NVM_DIR}/versions/node/v12.0.0/bin)

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
export MANPATH="${NPM_PACKAGES}/share/man:$(manpath)"
export _JAVA_AWT_WM_NONREPARENTING=1

export DENO_INSTALL="/home/florian/.deno"

PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="/usr/sbin:${PATH}"
PATH="${NPM_PACKAGES}/bin:${PATH}"
PATH="${NODE_BIN}:${PATH}"
PATH="${HOME}/.yarn/bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/.gem/ruby/2.3.0/bin:${PATH}"
PATH="${DENO_INSTALL}/bin:${PATH}"
PATH="/home/florian/src/emsdk:/home/florian/src/emsdk/fastcomp/emscripten:${PATH}"
#/home/florian/src/emsdk/node/12.9.1_64bit/bin

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
source "$HOME/.cargo/env"
