# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: thesis.pdf all clean show

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: thesis.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

thesis.pdf: thesis.tex
	latexmk -pdf   \
	-jobname=thesis        \
	-pdflatex="pdflatex --file-line-error --shell-escape --synctex=1 %O '\input{%S}'" thesis.tex

hardcover: thesis.tex
	latexmk -pdf       \
	-jobname=thesis-hardcopy   \
	-pdflatex="pdflatex --file-line-error --shell-escape --synctex=1 %O '\def\hardcopy{}\input{%S}'" thesis.tex


thesis.acr: thesis.aux
	makeglossaries thesis

clean:
	latexmk -C
	rm -f thesis.acn thesis.acr thesis.alg thesis.bbl thesis.run.xml thesis.xdy

show: thesis.pdf
	zathura thesis.pdf &
