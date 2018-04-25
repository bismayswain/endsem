#insert analyse
#gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=report.pdf *.eps


FLAGS =-o
OBJS = prog.o thread_function.o
LFLAGS= -lpthread -lm
LATEXPDF=r1.eps r2.eps r4.eps r8.eps r16.eps
LINEEPS=avg1.eps
AVGOUT=avg1.out avg2.out avg4.out avg8.out avg16.out
OUT=r1.out r2.out r4.out r8.out r16.out

report: report.pdf report.tex

report.pdf: $(LATEXPDF) $(LINEEPS) speedup.eps speedup_err.eps report.tex
	pdflatex report.tex


plot: $(LATEXPDF) $(LINEEPS) speedup.eps speedup_err.eps


speedup.eps: speedup.out speedup.gp
	gnuplot speedup.gp

speedup_err.eps: speedup.out speedup.gp
	gnuplot speedup.gp


analyse: runtest

runtest: $(AVGOUT) $(OUT)

%.out: prog.ex params.txt
	./runtest.sh

App: prog.ex

prog.ex: $(OBJS)
	gcc $(FLAGS) prog.ex $(OBJS)  $(LFLAGS)

#$(OBJS):common.h



%.eps:%.out
	gnuplot -c plot_scatter.p $< $@


avg1.eps:$(AVGOUT) plot_line.gp
	gnuplot plot_line.gp



%.o: %.c common.h
	gcc -c -I. $< $(FLAGS) $@ $(LFLAGS)

clean:
	rm -f *.o prog.ex *.out *.eps *.pdf *.log *.aux *.blg *.bbl
