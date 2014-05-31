#!/usr/bin/env bash
#
# .oh-my-zsh install script

# Print functions
#
print_debug() {
  echo "$1"
}

print_info() {
  echo -e "\033[33m$1\033[0m"
}

print_usage () {
  echo -e "\r  \033[37m$1\033[0m"
}

print_success() {
  echo -e "\r\033[2K  [ \033[00;32mOK\033[0m ] $1"
}

print_fail() {
  echo -e "\r\033[2K  [\033[0;31mFAILED\033[0m] $1"
  echo ''
  exit
}

# Setup functions
#
install_ohmyzsh () {
  print_info "install_ohmyzsh"
  local workdir="$DOTFILES_ROOT/tmp_ohmyzsh"

  if [ ! -d $HOME/.oh-my-zsh ]; then
    mkdir $workdir
    wget -P $workdir https://github.com/robbyrussell/oh-my-zsh/archive/master.zip

    if [ -f $workdir/master.zip ]; then
      unzip $workdir/master.zip -d $workdir
      mv $workdir/oh-my-zsh-master $HOME/.oh-my-zsh
      rm -rf $workdir
    else
      print_fail "oh-my-zsh archive is not found."
    fi

    print_success "$HOME/.oh-my-zsh is installed."
  else
    print_success "$HOME/.oh-my-zsh is already installed."
  fi
}

# Get the path where the file is located.
# Then resolve symbolic link just to make sure.
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

install_ohmyzsh

