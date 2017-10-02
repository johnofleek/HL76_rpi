#!/bin/bash

printf "2. using port %s\n" "$COMMAND_PORT"

####
## STEP2 start the hl76 IP wwan1
chat -v -f ./pilot/HL76ipUpStep2.chat > $COMMAND_PORT < $COMMAND_PORT

sleep 3
