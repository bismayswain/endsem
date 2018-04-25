#gnuplot -c plot1.p ARG1 ARG2


inputfile=ARG1
outputfile=ARG2

set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color
set logscale x 10
set logscale y 10

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

#set format y "10^{%L}"
set xlabel "num of elements"
set ylabel "Time taken in microsec"
#set yrange[0:1000000]
set xrange[100:10000000]
set ytic auto
set xtic auto


set output outputfile
plot inputfile using ($1):($3) notitle  with points pt 1 ps 1.5