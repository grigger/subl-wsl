#!/bin/bash

path=$(readlink -f $*);
cwd=$(pwd);
winpath=$(wslpath -w $path);

echo "Editing ${path}"
echo "Windows path is ${winpath}"


/mnt/c/Program\ Files\ \(x86\)/Sublime\ Text\ 3/subl.exe $winpath
