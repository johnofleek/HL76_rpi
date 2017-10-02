#!/bin/bash


## needs kill then restart
echo Killing dhcpcd

sudo dhcpcd -k
sleep 3

## STEP5 use dhcdcd to set dns and routing
echo restarting dhcpcd

sudo dhcpcd wwan1 \
--inform $WWAN1_IP \
--static routers=$WWAN1_IP \
--static domain_search=$WWAN1_IP \
--static domain_name_servers=$WWAN1_DNS

echo HL76 IP bringup - done