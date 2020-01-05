#!/bin/sh

set -e

source scripts/projects.sh

build() {
    echo "Updating deps for $2/$1..."
    (cd $2 && rm -f mix.lock && MIX_TARGET=$1 mix deps.update --all)
}

for target in $TARGETS; do
    for project in $PROJECTS; do
        build $target $project
    done
done

echo "Success"

