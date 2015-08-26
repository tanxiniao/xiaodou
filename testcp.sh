#!/bin/bash

bce bos ls -r "bos:/zxdtestbae" >results
LEN=`awk '{print NR}' results |tail -n1`
echo $LEN
for  object in `awk '{print $4}' results`; do
   bce bos cp  bos:/zxdtestbae/$object /tmp/bos/$object
done


