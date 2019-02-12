rm -rf _build/
make html
sphinx-autobuild . _build/html
