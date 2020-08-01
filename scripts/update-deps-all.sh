#!/bin/bash

set -e

source scripts/projects.sh

update_deps() {
    echo "Updating deps for $1..."
    (cd $1 && MIX_TARGET=rpi0 mix deps.update --all)
}

# Clean everything up
echo "Cleaning project directory..."
git clean -fdx
find . -name deps | xargs rm -fr
find . -name _build | xargs rm -fr
find . -name mix.lock -delete

# Now update all deps
for project in $PROJECTS; do
    update_deps $project
done
update_deps hello_phoenix/ui

echo "Success"

