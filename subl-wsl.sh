#!/bin/bash

if [ $# -eq 0  ]; then
    /mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe -w
    exit 0
elif [[ "$(file "$*")" == *"(No such file or directory)"*  ]]; then
    touch "$*"
fi

path=$(readlink -f $*);
winpath=$(wslpath -w $path);

echo "Editing ${path}"
echo "Windows path is ${winpath}"

/mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe -w $winpath
