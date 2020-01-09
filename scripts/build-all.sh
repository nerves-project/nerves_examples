#!/bin/bash

set -e

source scripts/projects.sh

build() {
    echo "Building $2 for target $1..."
    (cd $2 && MIX_TARGET=$1 mix do deps.update --all, firmware)
}

for target in $TARGETS; do
    for project in $PROJECTS; do
        build $target $project
    done
done

echo "Success"

