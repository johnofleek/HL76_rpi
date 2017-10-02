#!/bin/bash

# COMMAND_PORT="/dev/ttyACM0"

# changed to the below so that we have a universal command ports setting
COMMAND_PORT=$(<./pilot/commandPort.cfg)

chat -v -f ./pilot/HL76reboot.chat > $COMMAND_PORT < $COMMAND_PORT

## we haven't captured the HL76 ready so an arbitary wait for now
sleep 20

## needs kill then restart
echo Killing dhcpcd

sudo dhcpcd -k
sleep 3

sudo dhcpcd 
sleep 3






