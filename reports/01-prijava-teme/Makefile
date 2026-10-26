# Izris prijave teme: make  (potrebuje lualatex z IEEEtran in TeX Gyre ter graphviz)
all: prijava-teme.pdf

diagrams/%.pdf: diagrams/%.dot
	dot -Tpdf $< -o $@

prijava-teme.pdf: prijava-teme.tex diagrams/arhitektura.pdf
	mkdir -p build
	lualatex -interaction=nonstopmode -halt-on-error -output-directory=build $< >/dev/null
	lualatex -interaction=nonstopmode -halt-on-error -output-directory=build $< >/dev/null
	cp build/prijava-teme.pdf $@

clean:
	rm -rf build prijava-teme.pdf diagrams/*.pdf

.PHONY: all clean
