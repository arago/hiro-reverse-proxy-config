#!/bin/bash

FILE_TO_PATCH=/etc/nginx/nginx.conf
PARAMETER=server_names_hash_bucket_size
MIN_VALUE=128

if [ -e $FILE_TO_PATCH ]; then
    grep $PARAMETER $FILE_TO_PATCH >/dev/null
    RC=$?
    if [ $RC == 0 ]; then
	# check value
	VALUE=$(grep $PARAMETER $FILE_TO_PATCH)
	VALUE=${VALUE%% }
	VALUE=${VALUE%;}
	VALUE=$(echo $VALUE | cut -d' ' -f 2)
	if [ $VALUE -lt $MIN_VALUE ]; then
	    # modify line
	    cp -p $FILE_TO_PATCH $FILE_TO_PATCH.tmp
	    cp -p $FILE_TO_PATCH $FILE_TO_PATCH.bak
	    sed "s/$PARAMETER.*;/$PARAMETER $MIN_VALUE;/" $FILE_TO_PATCH > $FILE_TO_PATCH.tmp
	    mv $FILE_TO_PATCH.tmp $FILE_TO_PATCH
	fi
    else
	# add line
	cp -p $FILE_TO_PATCH $FILE_TO_PATCH.tmp
	cp -p $FILE_TO_PATCH $FILE_TO_PATCH.bak
	sed "s/http *{/http {\n\t$PARAMETER $MIN_VALUE;/" $FILE_TO_PATCH > $FILE_TO_PATCH.tmp
	mv $FILE_TO_PATCH.tmp $FILE_TO_PATCH
    fi
fi
