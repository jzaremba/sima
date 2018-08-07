#!/bin/bash

TRAVIS_PYTHON_VERSION=$1

if [[ "$TRAVIS_PYTHON_VERSION" == "py27" ]]; then export PY_VERSION="python2"; fi
if [[ "$TRAVIS_PYTHON_VERSION" == "py35" ]]; then export PY_VERSION="python3"; fi

brew update
brew outdated cmake || brew upgrade cmake
if [[ "$PY_VERSION" == "python3" ]]; then
    # Pin to Python3.5
    brew outdated $PY_VERSION || brew upgrade https://raw.githubusercontent.com/Homebrew/homebrew-core/ec545d45d4512ace3570782283df4ecda6bb0044/Formula/python3.rb
else
    brew outdated $PY_VERSION || brew upgrade $PY_VERSION
fi

if [[ "$TRAVIS_PYTHON_VERSION" == "py35" ]]; then brew prune; fi
if [[ "$TRAVIS_PYTHON_VERSION" == "py35" ]]; then brew linkapps python3; fi

brew install hdf5

if [[ "$TRAVIS_PYTHON_VERSION" == "py27" ]]; then
    sudo pip2 install numpy scipy matplotlib scikit-image shapely scikit-learn Pillow future toolz nose h5py Cython flake8 sphinx numpydoc picos
else
    sudo pip3 install numpy Cython scipy matplotlib scikit-image shapely scikit-learn Pillow future toolz nose h5py flake8 sphinx numpydoc picos
fi
