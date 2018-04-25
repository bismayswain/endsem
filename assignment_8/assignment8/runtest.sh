#!/bin/bash

for elements in $(cat params.txt);
do

	for thread_no in $(cat threads.txt)
	do
		for i in {1..10}
		do
			outfile='r'$thread_no'.out'
			A=`./prog.ex $elements $thread_no`
			#echo $A
			num=$(echo "$A" | tr -dc '0-9');
			echo "$elements $thread_no $num" &>> $outfile
		done
	done
done
