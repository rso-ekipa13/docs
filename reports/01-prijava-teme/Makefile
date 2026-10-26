# Izris prijave teme: make  (lualatex; pisave Libertinus in TeX Gyre iz TeX Live)
LATEX = lualatex -interaction=nonstopmode -halt-on-error -output-directory=build

all: prijava-teme.pdf

build/arhitektura.pdf: diagrams/arhitektura.tex
	mkdir -p build
	$(LATEX) $< >/dev/null
	cp build/arhitektura.pdf diagrams/arhitektura.pdf

prijava-teme.pdf: prijava-teme.tex build/arhitektura.pdf
	$(LATEX) $< >/dev/null
	$(LATEX) $< >/dev/null
	cp build/prijava-teme.pdf $@

clean:
	rm -rf build prijava-teme.pdf

.PHONY: all clean
