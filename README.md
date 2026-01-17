# FlipPy tutorials

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/codec-lab/flippy-tutorials/main?urlpath=%2Fdoc%2Ftree%2Fnotebooks%2F00-intro.ipynb)

This repository contains the tutorial notebooks for [FlipPy](https://github.com/codec-lab/flippy).

Notebooks are rendered in HTML [here](https://codec-lab.github.io/flippy-tutorials/).

## Getting Started

### Option 1: Binder (no installation)

Click the Binder badge above to run the tutorials in your browser.

### Option 2: Local installation

```bash
# Clone the repository
git clone https://github.com/codec-lab/flippy-tutorials.git
cd flippy-tutorials

# Create conda environment
conda create -n flippy python=3.12
conda activate flippy

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter lab
```

## Running Notebooks from Command Line
A Makefile is provided for batch execution:

```bash
make run      # Execute all notebooks
make clean    # Clear all outputs
make check    # Verify notebooks run without errors
make html     # Export to HTML in docs/
make help     # Show all commands
```