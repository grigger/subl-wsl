#!/bin/bash

link=$(readlink -f $*);

echo "Editing ${link}"

if [[ $link == *"/mnt"* ]]; 
then
    drive=${link:5:1}
    winlink=${link:6:9999}
    sublpath="${drive}:${winlink}"
    # drive=$(echo $link| cut -d'/' -f 3)
    # echo "is windows path ${drive}"
    # sublpath=$(echo $link| cut -d'/' -f 4+)
    # #sublpath="${drive}"
else
    sublpath="C:\Users\GriG\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\rootfs${cwd}\\$*"
fi

echo "Windows path is ${sublpath}"

/mnt/c/Program\ Files\ \(x86\)/Sublime\ Text\ 3/subl.exe $sublpath
