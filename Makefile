TEX = journal_article.tex
PDF = $(TEX:.tex=.pdf)
DOCX = $(TEX:.tex=.docx)
MARKDOWN = $(TEX:.tex=.md)

.PHONY: all clean export export-md export-docx

all: $(PDF)

# LaTeX requires two passes to resolve cross-references, citations, TOC, etc.
# Pass 1: Generates auxiliary files (.aux, .toc, .bbl, etc.)
# Pass 2: Reads those files to resolve references
$(PDF): $(TEX)
	pdflatex -interaction=nonstopmode $(TEX)
	pdflatex -interaction=nonstopmode $(TEX)

# Export to Markdown
export-md:
	pandoc $(TEX) --resource-path=./Figures --citeproc --bibliography=sample.bib -o $(TEX:.tex=.md)

# Export to Word (add --reference-doc=mytemplate.docx for custom Word styles)
export-docx:
	pandoc $(TEX) --resource-path=./Figures --citeproc --bibliography=sample.bib -o $(TEX:.tex=.docx)

# Export to both formats
export: export-md export-docx

clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.fls *.blg *.synctex.gz *.bcf *.run.xml *.fdb_latexmk  $(PDF) $(DOCX) $(MARKDOWN)
