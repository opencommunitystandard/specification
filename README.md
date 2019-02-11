# HSDS: OpenCommunity Fork

Human Services Data Specification defines a minimal set of data for publishing machine-readable directory information about health, human, and social services; their locations and accessibility details; and the organizations that provide them.

This is a fork of the specification documentation created by the OpenReferral initiative in the US. Information about the Open Referral Initiative is available at [https://openreferral.org](https://openreferral.org).

Information and notes on the [OpenCommunity project can be found here](https://opencommunity.org.uk/).


## Licence

The Human Services Data Specification and its documentation are [licensed](LICENSE) under the Creative Commons Attribution-ShareAlike (CC BY-SA) license.

We encourage you to use an [open license](http://licenses.opendefinition.org/) for any data you publish using the specification.

Earlier versions were licensed under CC0.

## Building the documentation

### Building locally

Assuming a unix based system with Python 3 installed, set up an environment:

```
python3 -m venv .ve    
source .ve/bin/activate
pip install -r requirements.txt
```

To build the docs:

```
cd docs
make dirhtml
```

You can also use sphinx-autobuild to have an auto-refreshing local build.

```
pip install sphinx-autobuild
cd docs
sphinx-autobuild . _build
```

Autobuild also provides a local server to view the documentation.

## Deploying to Github Pages

Build docs:

```
cd docs
sphinx-autobuild . _build/
```

Add changes:

```
cd ..
git add -f docs/_build && git commit -m "Update pages for deploy"
```

Push to branch:

```
git subtree push --prefix docs/_build/ origin gh-pages
```