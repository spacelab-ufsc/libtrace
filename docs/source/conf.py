# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "libtrace"
copyright = "2026, Libtrace Contributors"
author = "SpaceLab"
title = "Libtrace"

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

numfig = True
extensions = [
    "sphinxcontrib.bibtex",
    "sphinxcontrib.mermaid"
]

templates_path = ["_templates"]
exclude_patterns = []

# -- Options for sphinxcontrib-bibtex -----------------------------------------
# https://sphinxcontrib-bibtex.readthedocs.io/en/latest/usage.html

bibtex_bibfiles = ["references.bib"]

# -- Options for sphinxcontrib-mermaid ----------------------------------------
# https://github.com/mgaitan/sphinxcontrib-mermaid
# https://mermaid.js.org/syntax/packet.html

# The RTD theme has no dark mode, so render diagrams with the same theme
# regardless of the reader's OS preference.
mermaid_light_theme = "base"
mermaid_dark_theme = "base"

# Let each diagram keep its natural aspect ratio instead of a fixed 500px.
mermaid_height = "auto"

mermaid_init_config = {
    "startOnLoad": False,
    "packet": {
        # One 32-bit word per row, as in RFC-style packet diagrams. The bit
        # width keeps a full row (32 * 22px) within the content column.
        "bitsPerRow": 32,
        "bitWidth": 22,
        "rowHeight": 44,
        "showBits": True,
        "paddingX": 4,
        "paddingY": 12,
    },
    "themeVariables": {
        "fontFamily": "Lato, proxima-nova, Helvetica Neue, Arial, sans-serif",
        "packet": {
            "blockFillColor": "#eef1ff",
            "blockStrokeColor": "#0e1c3b",
            "blockStrokeWidth": "1",
            "labelColor": "#0e1c3b",
            "labelFontSize": "12px",
            "titleColor": "#0e1c3b",
            "titleFontSize": "15px",
            "startByteColor": "#5c6680",
            "endByteColor": "#5c6680",
            "byteFontSize": "10px",
        },
    },
}


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
html_logo = "_static/spacelab-logo-full-color-rgb-1000px@72ppi.png"
html_theme_options = {
    "logo_only": True,
}
