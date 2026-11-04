LATEXMK ?= latexmk
LATEXMKFLAGS ?= -pdf -halt-on-error -interaction=nonstopmode

COLOR_CYAN := \033[36m
COLOR_RESET := \033[0m

.DEFAULT_GOAL := help

ifneq ($(VERBOSE),1)
.SILENT:
endif

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make [options] $(COLOR_CYAN)[target] ...$(COLOR_RESET)\n\n"} \
	/^[a-zA-Z_-]+:.*##/ {printf "  $(COLOR_CYAN)%-16s$(COLOR_RESET) %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)

.PHONY: build
build: ## Build report.pdf and resolve cross-references
	$(LATEXMK) $(LATEXMKFLAGS) report.tex

.PHONY: watch
watch: ## Preview the PDF and rebuild when sources change
	$(LATEXMK) $(LATEXMKFLAGS) -pvc report.tex

.PHONY: clean
clean: ## Remove auxiliary files and keep the PDF
	$(LATEXMK) -c report.tex
	$(RM) report.lol

.PHONY: distclean
distclean: ## Remove auxiliary files and the PDF
	$(LATEXMK) -C report.tex
	$(RM) report.lol
