document = main
SOURCES = $(wildcard *.tex)  $(document).bib

SVG_FIGURES = $(wildcard svg-figs/*.svg)
FIGURES = $(patsubst svg-figs/%.svg, figs/%.pdf, $(SVG_FIGURES)) \
	  $(wildcard figs/*.pdf)

all: $(document).pdf

pdf : $(document).pdf

$(document).pdf : $(SOURCES) $(FIGURES)
	pdflatex $(document)
	bibtex $(document)
	pdflatex $(document)
	pdflatex $(document)

once:
	pdflatex $(document)

figs/%.pdf : svg-figs/%.svg
	inkscape -D -z --file=$< --export-pdf=$@ --export-area-drawing

clean:
	rm -f *.aux *.bbl *.log *.blg *.lot *.lof $(document).pdf
