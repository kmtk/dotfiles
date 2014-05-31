#!/usr/bin/env bash
#
# sublime3 install script

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
install_package_control () {
  print_info "install_package_control"
  local pc_url="https://sublime.wbond.net/Package%20Control.sublime-package"
  local pc_dst="$HOME/tool/sublime3/Data/Installed Packages/"
  local pc_name="Package Control.sublime-package"
  wget -P "$pc_dst" $pc_url

  if [ -f "$pc_dst/$pc_name" ]; then
      print_success "Package Control is installed."
  else
      print_fail "Package Control archive is not found."
  fi
}

install_sublime3 () {
  print_info "install_sublime3"
  local sublime3="$HOME/tool/sublime3"
  local sublime3_x64_url="http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059%20x64.zip"
  local sublime3_zip="Sublime Text Build 3059 x64.zip"

  if [ ! -d $sublime3 ]; then
  	mkdir -p $sublime3
	  wget -P $sublime3 $sublime3_x64_url

	if [ -f "$sublime3/$sublime3_zip" ]; then
      unzip "$sublime3/$sublime3_zip" -d $sublime3
      mkdir -p "$sublime3/Data/Packages"
      mkdir -p "$sublime3/Data/Installed Packages/"
      install_package_control
      print_success "sublime3 is installed."
    else
      print_fail "sublime3 archive is not found."
    fi

  else
    print_success "sublime3 is already installed."
  fi
}

# Get the path where the file is located.
# Then resolve symbolic link just to make sure.
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

install_sublime3

