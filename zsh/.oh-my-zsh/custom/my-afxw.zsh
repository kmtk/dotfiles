# あふｗ を起動
# 引数にディレクトリを指定可。
# 指定しない場合はカレントディレクトリをオープンする。
function af()
{
if [ $1 ];
then
    $HOME/tool/afxw/AFXWCMD.EXE -L`cygpath -aw "$1"`\\ &
else
    $HOME/tool/afxw/AFXWCMD.EXE -L`cygpath -w \`pwd\``\\ &
fi
}

# あふｗ のアップデート
funciton afup()
{
   $HOME/tool/afxw/AFXWUPD64.EXE
}
