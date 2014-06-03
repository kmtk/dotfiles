#!/usr/bin/env bash
#
# afxw and support tools install script

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

download () {
  local file_path=$1
  local url=$2
  print_info "wget -> $(basename $file_path)"
  wget -O "$file_path" "$url"
}

unpack () {
  local unpack_file=$1
  local unpack_dir=$2

  print_info "unpack $(basename $unpack_file) -> $unpack_dir"
  mkdir -p "$unpack_dir"
  if [ -f "$unpack_file" ]; then
    unzip "$unpack_file" -d "$unpack_dir"
    print_success "$unpack_file unpacked."
  else
    print_fail "$unpack_file not found."
  fi
}

unpack_dll () {
  local unpack_file=$1
  local unpack_dir=$2

  print_info "unpack_dll $(basename $unpack_file) -> $unpack_dir"
  mkdir -p "$unpack_dir"
  if [ -f "$unpack_file" ]; then
    unzip -j "$unpack_file" "*.dll" -d "$unpack_dir"
    print_success "$unpack_file unpacked."
  else
    print_fail "$unpack_file not found."
  fi
}

unpack_rename () {
  local unpack_file=$1
  local unpack_root=$(dirname $2)
  local new_dirname=$2
  local old_dirname=`zipinfo -1 $unpack_file | head -n1`

  print_info "unpack_dll $(basename $unpack_file) -> $new_dirname"
  mkdir -p "$unpack_root"
  if [ -f "$unpack_file" ]; then
    unzip "$unpack_file" -d "$unpack_root"
    mv "$unpack_root/$old_dirname" "$new_dirname"
    print_success "$unpack_file unpacked."
  else
    print_fail "$unpack_file not found."
  fi
}

donwload_afxw_archives () {
  print_info "donwload_afxw_archives"

  mkdir -p $archive_dir
  for ((i=0; ${#install_param[*]}>$i; i++))
    do
      value=(${install_param[$i]})
      local file_path=$archive_dir/${value[0]}
      local url=${value[3]}
      download "$file_path" "$url"
    done
}

unpack_afxw_archives () {
  print_info "unpack_afxw_archives"

  for ((i=0; ${#install_param[*]}>$i; i++))
    do
      value=(${install_param[$i]})
      local file_path=$archive_dir/${value[0]}
      local unpack_dir=${value[1]}
      local unpack_func=${value[2]}
      "$unpack_func" "$file_path" "$unpack_dir"
    done
}

install_afxw () {
  print_info "install_afxw"
  donwload_afxw_archives
  unpack_afxw_archives
}

# Get the path where the file is located.
# Then resolve symbolic link just to make sure.
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

# afxw setup value
tool_dir="$HOME/tool"
afxw_dir="$tool_dir/afxw"
archive_dir="$afxw_dir/archives"
install_param=(
  "afxw.zip      $afxw_dir/                        unpack         http://www.h5.dion.ne.jp/~akt/lzh/afxw64_157.zip"
  "afxwupd.zip   $afxw_dir/                        unpack         http://www.h5.dion.ne.jp/~akt/lzh/afxwupd64_11a.zip"
  "afxwcmd.zip   $afxw_dir/                        unpack         http://www.h5.dion.ne.jp/~akt/lzh/afxwcmd08.zip"
  "7z64.zip      $afxw_dir/                        unpack_dll     http://homepage1.nifty.com/Ayakawa/bin/7z920002_64.zip"
  "tar64.zip     $afxw_dir/                        unpack_dll     http://homepage1.nifty.com/Ayakawa/bin/tar64_242.zip"
  "cmigemo.zip   $afxw_dir/afxwtool/cmigemo/       unpack_rename  http://files.kaoriya.net/cmigemo/cmigemo-default-win64-20110227.zip"
  "bron.zip      $afxw_dir/afxwtool/bregonig/      unpack         https://bitbucket.org/k_takata/bregonig/downloads/bron305.zip"
  "sed-bin.zip   $afxw_dir/afxwtool/sed/           unpack         http://downloads.sourceforge.net/project/gnuwin32/sed/4.2.1/sed-4.2.1-bin.zip"
  "sed-dep.zip   $afxw_dir/afxwtool/sed/bin/       unpack_dll     http://downloads.sourceforge.net/project/gnuwin32/sed/4.2.1/sed-4.2.1-dep.zip"
  "ffc.zip       $afxw_dir/afxwtool/firefilecopy/  unpack         http://www.k3.dion.ne.jp/~kitt/pc/sw/ffc/ffc4_9_1u.zip"
  "rncpy.zip     $afxw_dir/afxwtool/renamecopy/    unpack         http://www.geocities.jp/enpanpy/rc/rncpy137.zip"
  "fasthash.zip  $afxw_dir/afxwtool/fasthash/      unpack         http://ftp.vector.co.jp/pack/win95/util/bin/fasthash039b.zip"
  "afxfind.zip   $afxw_dir/afxwtool/afxfind/       unpack         http://yuratomo.up.seesaa.net/image/afxfind_v0.3.2.zip"
)

install_afxw
