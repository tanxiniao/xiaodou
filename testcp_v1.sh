#!/bin/bash 

CurrentPath=`pwd`

mkdir $1&&cd $1

bce bos ls -r "bos:/"$1 >results
LEN=`awk '{print NR}' results |tail -n1`
echo "##########################################################"
echo "##########################################################"
echo "##There will be " $LEN " objects copied from BOS server.##"
echo "##########################################################"
echo "##########################################################"
echo "You have 10 seconds to interrupt..."
sleep 10

Count=1

for  object in `awk '{print $4}' results`; do
	echo "------------------- No." $Count "-------------------" 
	echo  "-------------------" $object "-------------------" 
	
    c=`echo $object | awk -F'/' '{print NF}'`
	if [ $c == 1 ]
	then
		bce bos cp  bos:/$1/$object $CurrentPath/$1/$object
	else
		Fname=($(tr "/" " " <<< $object))		
		for((i=0; i<c;i++)); do
			mkdir ${Fname[i]}
			cd ${Fname[i]}
		done
		bce bos cp  bos:/$1/$object ${Fname[i-1]}
		cd $CurrentPath/$1
	fi
	((Count++));
done

rm results

