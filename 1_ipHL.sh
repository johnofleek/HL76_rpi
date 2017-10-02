#!/bin/bash



printf "1_ using port %s\n" "$COMMAND_PORT"


## Needs a pass test adding
## STEP1 configure the hl76 
chat -v -f ./pilot/HL76ipUp.chat > $COMMAND_PORT < $COMMAND_PORT

sleep 2