# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SOURCEDIR     = source
BUILDDIR      = build

# Python virtual environment holding the documentation dependencies.
PYTHON        ?= python3
VENV          = .venv
VENVSTAMP     = $(VENV)/.installed
REQUIREMENTS  = requirements.txt
SPHINXBUILD   ?= $(VENV)/bin/sphinx-build

# Put it first so that "make" without argument is like "make help".
help: $(VENVSTAMP)
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Create the venv and install the dependencies.
setup: $(VENVSTAMP)

$(VENVSTAMP): $(REQUIREMENTS)
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r $(REQUIREMENTS)
	@touch $@

# Keep the catch-all rule below from trying to "build" the requirements file.
$(REQUIREMENTS): ;

# Full pipeline: set up the venv, then build HTML from scratch, treating
# warnings as errors.
build: $(VENVSTAMP)
	@$(SPHINXBUILD) -M clean "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" -W --keep-going $(SPHINXOPTS) $(O)

# Remove the build output and the venv.
distclean:
	rm -rf "$(BUILDDIR)" "$(VENV)"

.PHONY: help setup build distclean Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile $(VENVSTAMP)
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
