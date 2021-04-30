#!/bin/bash

# Adapted from https://github.com/commercialhaskell/stack

set -eux

mkdir -p $HOME/.local/bin;

travis_retry() {
  cmd=$*
  $cmd || (sleep 2 && $cmd) || (sleep 10 && $cmd)
}

fetch_z3_linux() {
  VER="$1"
  wget "https://github.com/Z3Prover/z3/releases/download/z3-$VER/z3-$VER-x64-ubuntu-18.04.zip"
  unzip "z3-$VER-x64-ubuntu-18.04"
  chmod +x z3-$VER-x64-ubuntu-18.04/bin/z3
  mv "z3-$VER-x64-ubuntu-18.04/bin/z3" "$HOME/.local/bin/z3"
  echo "Downloaded z3 $VER"
}

if [ "$HOST_OS" = "Linux" ]; then
    travis_retry fetch_z3_linux "4.8.10"
fi