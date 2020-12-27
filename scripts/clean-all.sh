#!/bin/bash

set -e

source scripts/projects.sh

clean() {
    echo "Cleaning $1..."
    (cd $1 && rm -fr deps _build)
}

for project in $PROJECTS; do
    clean $project
done

echo "Success"

