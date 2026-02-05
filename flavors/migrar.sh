#!/bin/sh

for PASTA in *.yazi; do
    cp -r --remove-destination "$(readlink $PASTA)" .
    cp -r --remove-destination "$(readlink $PASTA)" .
    rm -rf "$PASTA"
done
