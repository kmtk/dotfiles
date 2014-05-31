#!/usr/bin/env bash
#
# poderosa install script

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

rebuild_cygterm () {
  print_info "rebuild_cygterm"

  local cygterm_dir=$1
  cd $cygterm_dir
  make
}

install_poderosa () {
  print_info "install_poderosa"

  local tool_dir="$HOME/tool"
  local poderosa_dir="$tool_dir/poderosa"
  local poderosa_url="http://sourceforge.jp/frs/g_redir.php?m=jaist&f=%2Fpoderosa%2Fbeta%2F4.3.8b%2FPoderosa-4.3.8b-bin.zip"
  local poderosa_zip="Poderosa-4.3.8b-bin.zip"

  if [ ! -d $poderosa_dir ]; then
    mkdir -p $poderosa_dir
    wget -O "$poderosa_dir/$poderosa_zip" "$poderosa_url"

    if [ -f "$poderosa_dir/$poderosa_zip" ]; then
      unzip "$poderosa_dir/$poderosa_zip" -d "$tool_dir"
      rebuild_cygterm "$poderosa_dir/Protocols/Cygterm"
      print_success "poderosa is installed."
    else
      print_fail "poderosa archive is not found."
    fi

  else
    print_success "poderosa is already installed."
  fi
}

# Get the path where the file is located.
# Then resolve symbolic link just to make sure.
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

install_poderosa

