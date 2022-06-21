#!/usr/bin/env bash

#       Salt-Minion-Setup.nsi
#        the config directory will be renamed to

grep -nr 'index2 = (key\[index1 + off\] + state\[k\] + index2) & 255'

read -p "Enter the file name: " FILENAME
read -p "Enter the grep: " VULNGREP

#FILENAME="Salt-Minion-Setup.nsi"

for FIXVERSION in $(grep -lr "the config directory will be renamed to" | sort -V); do
    ARRAYFIXVERSION+=("./$FIXVERSION")
done

for VULVERSION in $VULNGREP; do
    ARRAYVULVERSION+=("./$VULVERSION")
done

echo ""
echo "FIXED | VULN |  PATH"

for LINE in $(find -name "$FILENAME" | sort -V ); do
    if [[ " ${ARRAYFIXVERSION[@]} " =~ " ${LINE} " ]]; then
        FIX=X
    else
        FIX=" "
    fi
    if [[ " ${ARRAYVULVERSION[@]} " =~ " ${LINE} " ]]; then
        VULN=X
    else
        VULN=" "
    fi
    echo "   $FIX  |   $VULN  | $LINE"
done
echo ""

for TOTVERSION in $(grep -lr "the config directory will be renamed to" | sort -V); do
    ARRAYVULVERSION+=("./$TOTVERSION")
done

IFS=$'\n' SORTED=($(sort <<<"${ARRAYVULVERSION[*]}"))
unset IF

tLen=${#SORTED[@]}

for (( i=0; i<${tLen}; i++ )); do
    if [ ${SORTED[$i]} = ${SORTED[$i+1]} ]; then
        echo ${SORTED[$i]}  
    fi

done

echo ""