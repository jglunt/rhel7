#!/bin/bash

yum list updates | awk '{print $1 }' > updates.txt
yum list installed > installed.txt
sed -i -e '1,2d' updates.txt

## The variable ROWS is going to represent a counter in this script, determined by the update list length
## We only need the first column from the updates, not the version number.
## This is going to grab the first line of the updates and use it to search the installed for its corresponding partner

ROWS=$(wc -l < updates.txt)


while [ $ROWS -gt 0 ]

do

 FIND=$(awk '{if(NR=='$ROWS') print $0}' updates.txt)
 RESULT=$(grep "$FIND" installed.txt)
 echo $RESULT >> needsticket.txt
 echo "Generating line $ROWS"

 ROWS=$(( $ROWS - 1 ))

done

sort needsticket.txt