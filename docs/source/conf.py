# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'INCITE DATA'
copyright = '2022, Geodynamo Working Group of the Computational Infrastructure for Geodynamics'
author = 'Geodynamo Working Group of the Computational Infrastructure for Geodynamics'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = []

templates_path = ['_templates']
exclude_patterns = []

html_logo = "_static/images/cig_logo_dots.png"
html_title = "CIG INCITE data"
html_theme = 'sphinx_book_theme'
html_theme_options = {
    "collapse_navigation": True,
    "navigation_depth": 2,
    "show_toc_level": 2,
    "repository_url": "https://github.com/geodynamics/INCITE_data_docs/",
    "repository_branch": "main",
    "path_to_docs":"docs/source/",
    "icon_links": [
        {
            "name": "GitHub",
            "url": "https://github.com/geodynamics/INCITE_data_docs/",
            "icon": "fab fa-github-square",
        },
    ],
    "show_navbar_depth": 1,
    "use_repository_button": True,
    "use_edit_page_button": False,
    "use_issues_button": False,
    "home_page_in_toc": True,
}


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_static_path = ['_static']
