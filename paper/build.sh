DOC=paper
latex $DOC
bibtex $DOC
latex $DOC
latex $DOC
dvips $DOC.dvi
ps2pdf $DOC.ps

rm -rf *.aux *.bbl *.log *.blg *.lot *.lof *.ps *.dvi
