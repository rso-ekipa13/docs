# Izris prijave teme: make  (potrebuje pandoc, xelatex, graphviz in pisavo Inter)
PANDOC ?= pandoc

all: prijava-teme.pdf

diagrams/%.pdf: diagrams/%.dot
	dot -Tpdf $< -o $@

diagrams/%.png: diagrams/%.dot
	dot -Tpng -Gdpi=160 $< -o $@

prijava-teme.pdf: prijava-teme.md diagrams/arhitektura.pdf diagrams/arhitektura.png ../_predloga/header.tex ../_predloga/defaults.yaml
	$(PANDOC) $< --defaults ../_predloga/defaults.yaml -o $@

clean:
	rm -f prijava-teme.pdf diagrams/*.pdf diagrams/*.png

.PHONY: all clean
