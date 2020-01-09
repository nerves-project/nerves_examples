#!/bin/bash

set -e

source scripts/projects.sh

update_deps() {
    echo "Updating deps for $1..."
    (cd $1 && rm -f mix.lock && MIX_TARGET=rpi0 mix deps.update --all)
}

for project in $PROJECTS; do
    update_deps $project
done

echo "Success"

