#!/bin/bash
#socat TCP-LISTEN:4214,fork TCP:[::1]:4213 &
ttyd --writable bash &
#duckdb -ui
