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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5000

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE="${LANG}"
export LC_ALL="${LANG}"

export BASH_SILENCE_DEPRECATION_WARNING=1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS_EXIT_CODE="\$([ \$? != 0 ] && echo '\e[01;31m!\e[00m ' || echo '. ')"
PS_TIME="\[\033[01;37m\]\A"
PS_DIR="\[\033[01;34m\]\w"
PS_GIT="\[\033[33m\]\$(parse_git_branch)\[\033[00m\]"
PS1="${PS_TIME} ${PS_DIR}${PS_GIT} \$ "

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
  . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

# Go
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="${HOME}/go"

export PATH="${GOPATH}:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export PATH="${GOROOT}:${PATH}"
export PATH="/usr/local/bin:${PATH}"
export PATH="/${HOME}/bin:${PATH}"
export PATH="/${HOME}/.yarn/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# ggrep
export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# Created by `pipx` on 2024-11-06 19:20:41
export PATH="$PATH:/${HOME}/.local/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# glab
export GLAB_SEND_TELEMETRY="false"

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_private ]; then
  . ~/.bash_aliases_private
fi
