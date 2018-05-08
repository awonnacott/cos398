PAPER = paper
TEX = $(wildcard *.tex)
BIB = references.bib
FIGS = $(wildcard figures/*.pdf figures/*.png graphs/*.pdf graphs/*.png)


.PHONY: all clean

$(PAPER).pdf: $(TEX) $(BIB) $(FIGS) jpaper.cls
	echo $(FIGS)
	pdflatex -shell-escape $(PAPER)
	biber $(PAPER)
	pdflatex -shell-escape $(PAPER)
	pdflatex -shell-escape $(PAPER)

written_final_report.pdf: $(PAPER).pdf
	cp $(PAPER).pdf written_final_report.pdf

clean:
	rm -f *.aux *.bbl *.blg *.log *.out $(PAPER).pdf

