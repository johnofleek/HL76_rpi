#!/bin/bash

## default global values
COMMAND_PORT="/dev/ttyACM0"

WWAN1_IP=0.0.0.0
WWAN1_DNS=8.8.8.8

. ./pilot/1_ipHL.sh

. ./pilot/2_ipHL.sh

. ./pilot/3_ipOS.sh

echo IP  ADDRESS: $WWAN1_IP
echo DNS ADDRESS: $WWAN1_IP

. ./pilot/4_ipDNS.sh

