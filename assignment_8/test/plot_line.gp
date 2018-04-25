#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "Num of elements"
set ylabel "Time taken in microsec"
#set yrange[0:750]
set xrange[0:]
set ytic auto
set xtic auto

set key bottom right

set title "Change in time with increase in no of elements for different threads"

set output "avg1.eps"
plot 'avg1.out'  using ($1):($3) title "Thread 1" with linespoints, \
     'avg2.out'  using ($1):($3) title "Thread 2" with linespoints pt 5 lc 4,\
     'avg4.out'  using ($1):($3) title "Thread 4" with linespoints lc 3,\
     'avg8.out'  using ($1):($3) title "Thread 8" with linespoints lc 6,\
     'avg16.out'  using ($1):($3) title "Thread 16" with linespoints lc 7,\
#set key top right
#set output "musage_single_line.eps"
#plot 'usage.out' using 1:($2/256) title "Application 1" with lines lw 2
