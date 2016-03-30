#!/bin/bash

# for file in "$@"
# do
# 	base_name=$(basename $file)
# 	scp naf6:/nfs/dust/cms/user/gsieber/dijetana/plot/plots/$file .
# done
LOCALFILES=( "$@" )
echo $LOCALFILES
REMOTEFILES=${LOCALFILES[@]/#//nfs/dust/cms/user/gsieber/dijetana/plot/plots/}
scp naf6:"$REMOTEFILES" .
