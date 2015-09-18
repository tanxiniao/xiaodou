#!/bin/bash

bce bos ls -r "bos:/$1" >results
LEN=`awk '{print NR}' results |tail -n1`
echo $LEN
for  object in `awk '{print $4}' results`; do
   bce bos cp  bos:/$1/$object bos:/$2/$object
done


