# ----- Python environment ----------------------------
local PYTHON_WINPATH='D:\dev\Python33'
local PYTHON_PATH=`cygpath -u $PYTHON_WINPATH`
local PYTHON_SCRIPT_PATH="${PYTHON_PATH}/Scripts"
PATH=$PYTHON_PATH:$PYTHON_SCRIPT_PATH:$PATH
export PYTHONPATH=$PYTHON_PATH/Lib/site-packages

# for cygwin console
export PYTHONBUFFER=1