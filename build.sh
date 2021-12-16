#!/bin/bash
set -x
set -a

export DOLLAR='$'

for theenv in *.env; do
    . $theenv
    folder=${theenv::-4}
    cd public
    mkdir -p $folder
    for template in *.template; do
        [ -f "$template" ] || continue
        conf=${template::-9}
        cat $template | sed -e 's/\${/＄/g' | sed 's/\$/${DOLLAR}/g' | sed 's/＄/${/g' | envsubst > $folder/$conf
    done
    cd ..
done
