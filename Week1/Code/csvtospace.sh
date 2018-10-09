#!/bin/bash

echo "Creating a tab separated version of $1 ..."
for file in *csv ; do mv -b $1 `echo $1 | sed 's/\(.*\.\)csv/\1tsv/'` ; done
echo "Done!"
exit

# Work out how to remove old .csv