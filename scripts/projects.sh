#!/bin/bash

TARGETS="rpi0 rpi rpi2 rpi3 rpi3a rpi4 bbb x86_64 osd32mp1"
ELIXIR_PROJECTS="blinky \
    hello_gpio \
    minimal \
    hello_phoenix/firmware \
    hello_wifi \
    hello_zig \
    hello_sqlite \
    hello_snmp_manager \
    hello_snmp_agent"
PROJECTS="$ELIXIR_PROJECTS hello_erlang hello_lfe"
