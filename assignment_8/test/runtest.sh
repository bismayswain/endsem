#!/bin/bash


#change 10 to 100
for elements in $(cat params.txt);
do
	avg=""
	std=""

	for thread_no in $(cat threads.txt)
	do
		average=0
		stddev=0
		for i in {1..100}
		do
			outfile='r'$thread_no'.out'
			A=`./prog.ex $elements $thread_no`
			#echo $A
			num=$(echo "$A" | tr -dc '0-9');
			echo "$elements $thread_no $num" &>> $outfile
			average=`expr $average + $num`
			square=`echo "$num*$num" | bc`
			#echo $square
			stddev=`expr $stddev + $square`
		done
		average=`expr $average / 100`
    		stddev=`expr $stddev / 100`
		meansquare=`echo "$average*$average" | bc`
		stddev=`expr $stddev - $meansquare`
		stddev=`echo "sqrt($stddev)" | bc`
		echo "$elements $thread_no $average" &>> avg$thread_no.out
		#echo "$thread_no $average $stddev" &>> paramavg$elements.out
		avg="$avg $average"
		std="$std $stddev"
	done
	echo "$elements $avg $std" &>> speedup.out

done
