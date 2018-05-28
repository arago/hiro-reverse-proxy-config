#!/bin/bash

FILE_TO_PATCH=/etc/nginx/nginx.conf
declare -a PARAMETER
declare -a MIN_VALUE
PARAMETER=([0]=server_names_hash_bucket_size [1]=worker_connections [2]=worker_processes)
MIN_VALUE=([0]=128 [1]=5000 [2]=1)
SECTION=([0]=http [1]=events [2]="")
# increase min number of worker_processes to 2?

if [ -e $FILE_TO_PATCH ]; then
    TMP_FILE=$FILE_TO_PATCH.tmp
    cp -p $FILE_TO_PATCH $TMP_FILE
    for i in $(seq 1 ${#PARAMETER[@]}); do
	IDX=$(( $i - 1 ))
	L_PARAMETER=${PARAMETER[$IDX]}
	L_MIN_VALUE=${MIN_VALUE[$IDX]}
	L_SECTION=${SECTION[$IDX]}

	grep $L_PARAMETER $TMP_FILE >/dev/null
	RC=$?
	if [ $RC == 0 ]; then
	    # check value
	    VALUE=$(grep $L_PARAMETER $TMP_FILE)
	    VALUE=${VALUE%% }
	    VALUE=${VALUE%;}
	    VALUE=$(echo $VALUE | cut -d' ' -f 2)
	    if [ $VALUE -lt $L_MIN_VALUE ]; then
		# modify line
		sed -i "s/$L_PARAMETER.*;/$L_PARAMETER $L_MIN_VALUE;/" $TMP_FILE
	    fi
	else
	    # add line in correct section
	    if [ -z "$L_SECTION" ]; then
		# main context
		echo "$L_PARAMETER $L_MIN_VALUE;" >> $TMP_FILE
	    else
 		sed -i "s/^$L_SECTION *{/$L_SECTION {\n\t$L_PARAMETER $L_MIN_VALUE;/" $TMP_FILE
	    fi
	fi
    done
    diff $FILE_TO_PATCH $TMP_FILE >/dev/null 2>&1
    RC=$?
    if [ $RC == 0 ]; then
	echo "No update required on $FILE_TO_PATCH"
    else
	echo "patch file $FILE_TO_PATCH"
	cp -p $FILE_TO_PATCH $FILE_TO_PATCH.bak
	mv  $TMP_FILE $FILE_TO_PATCH
    fi
else
    echo "File $FILE_TO_PATCH not found"
    exit 1
fi
