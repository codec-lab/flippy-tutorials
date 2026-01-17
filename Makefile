# Makefile for FlipPy tutorials
# Run all notebooks cleanly from the command line

NOTEBOOKS = $(wildcard notebooks/*.ipynb)
CONDA_ENV = flippy

# Auto-detect conda environment path
CONDA_PREFIX := $(shell conda run -n $(CONDA_ENV) printenv CONDA_PREFIX)
PYTHON = $(CONDA_PREFIX)/bin/python

# Override PATH to prioritize conda env
export PATH := $(CONDA_PREFIX)/bin:$(PATH)

.PHONY: all clean run help

# Default target: run all notebooks
all: run

# Run all notebooks (clear outputs first, then execute)
run:
	@echo "Running all notebooks..."
	@for nb in $(NOTEBOOKS); do \
		echo "  Running $$nb..."; \
		$(PYTHON) -m jupyter nbconvert --to notebook --execute --inplace \
			--ExecutePreprocessor.timeout=600 \
			"$$nb" || exit 1; \
	done
	@echo "Done!"

# Clear all notebook outputs
clean:
	@echo "Clearing notebook outputs..."
	@for nb in $(NOTEBOOKS); do \
		echo "  Clearing $$nb..."; \
		$(PYTHON) -m jupyter nbconvert --clear-output --inplace "$$nb"; \
	done
	@echo "Done!"

# Run a single notebook (usage: make notebook NB=notebooks/00-intro.ipynb)
notebook:
	@if [ -z "$(NB)" ]; then \
		echo "Usage: make notebook NB=notebooks/00-intro.ipynb"; \
		exit 1; \
	fi
	@echo "Running $(NB)..."
	$(PYTHON) -m jupyter nbconvert --to notebook --execute --inplace \
		--ExecutePreprocessor.timeout=600 \
		"$(NB)"

# Run notebooks and export to HTML
html:
	@echo "Running notebooks and exporting to HTML..."
	@mkdir -p docs
	@for nb in $(NOTEBOOKS); do \
		echo "  Processing $$nb..."; \
		$(PYTHON) -m jupyter nbconvert --to html --execute \
			--ExecutePreprocessor.timeout=600 \
			--output-dir=docs \
			"$$nb" || exit 1; \
	done
	@echo "Done! HTML files in docs/"

# Check notebooks can run without errors (doesn't save outputs)
check:
	@echo "Checking all notebooks..."
	@for nb in $(NOTEBOOKS); do \
		echo "  Checking $$nb..."; \
		$(PYTHON) -m jupyter nbconvert --to notebook --execute \
			--ExecutePreprocessor.timeout=600 \
			--stdout "$$nb" > /dev/null || exit 1; \
	done
	@echo "All notebooks passed!"

help:
	@echo "FlipPy Tutorials Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make run      - Run all notebooks (default)"
	@echo "  make clean    - Clear all notebook outputs"
	@echo "  make check    - Check notebooks run without errors"
	@echo "  make html     - Run notebooks and export to HTML"
	@echo "  make notebook NB=<path>  - Run a single notebook"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Examples:"
	@echo "  make"
	@echo "  make clean && make run"
	@echo "  make notebook NB=notebooks/00-intro.ipynb"
