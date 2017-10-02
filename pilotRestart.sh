#!/bin/bash

COMMAND_PORT="/dev/ttyACM0"

chat -v -f ./pilot/HL76reboot.chat > $COMMAND_PORT < $COMMAND_PORT

## we haven't captured the HL76 ready so an arbitary wait for now
sleep 30

## needs kill then restart
echo Killing dhcpcd

sudo dhcpcd -k
sleep 3

sudo dhcpcd 
sleep 3






