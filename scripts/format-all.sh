#!/bin/bash

set -e

source scripts/projects.sh

format() {
    echo "Formatting $1..."
    (cd $1 && MIX_TARGET=rpi0 mix format --migrate)
}

for project in $ELIXIR_PROJECTS; do
    format $project
done

echo "Success"

