#!/bin/bash

#Pass the first argument 
bce bos ls -r "bos:/"$1 >results

#get object number
LEN=`awk '{print NR}' results |tail -n1`
echo "##There will be " $LEN " objects will delete from BOS server.##"
echo "You have 10 seconds to interrupt..."
sleep 10

for object in `awk '{print $4}' results`; do
	bce bos rm -y bos:/$1/$object
done
