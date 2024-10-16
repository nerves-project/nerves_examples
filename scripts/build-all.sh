#!/bin/sh

set -e

if [ "$MIX_TARGET" = "" ]; then
    echo "Set MIX_TARGET to the desired target"
    echo "For example:"
    echo
    echo "export MIX_TARGET=rpi0"
    echo "./build-all.sh"
    exit 1
fi

. scripts/projects.sh

build() {
    if [ -e ".skip-$MIX_TARGET" ]; then
        return
    fi

    # Retry fetching dependencies since sometimes the network is flaky on CI
    n=0
    until [ $n -ge 5 ]; do
        mix deps.get && break
        n=$((n+1))
        echo "Error while fetching deps. Retrying in 5 seconds"
        sleep 5
    done

    if [ -e ".requires-zig" ]; then
        MIX_TARGET=host mix zig.get
    fi

    if [ -e ".requires-gleam" ]; then
        mix archive.install mix_gleam
    fi

    mix firmware
}

for project in $PROJECTS; do
    echo "===  $project  ==="
    (cd $project && build)
done

echo "Success"

