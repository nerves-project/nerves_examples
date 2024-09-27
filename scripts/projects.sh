#!/bin/sh

TARGETS="rpi0 rpi rpi2 rpi3 rpi3a rpi4 bbb x86_64 osd32mp1 mangopi_mq_pro"
ELIXIR_PROJECTS="blinky \
    hello_gpio \
    minimal \
    poncho_phoenix/firmware \
    hello_live_view \
    hello_wifi \
    hello_sqlite \
    hello_snmp_manager \
    hello_snmp_agent \
    hello_scenic"
PROJECTS="$ELIXIR_PROJECTS hello_erlang hello_lfe"
