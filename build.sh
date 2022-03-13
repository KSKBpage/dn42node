#!/bin/bash
set -x
set -a

export DOLLAR='$'
export BTN_AUTOPEER_TEXT="Auto Peer"

for theenv in *.env; do
eval $( source $theenv;
        folder=${theenv::-4};
        cd public;
        mkdir -p $folder;
        for template in *.template; do
            [ -f "$template" ] || continue
            conf=${template::-9}
            cat $template | sed -e 's/\${/＄/g' | sed 's/\$/${DOLLAR}/g' | sed 's/＄/${/g' | envsubst > $folder/$conf
        done
    )

done