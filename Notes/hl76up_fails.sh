#!/bin/bash

echo HL76 IP bringup - should connect WWAN1 to the internet

## run as sudo ./pilot/hl76up.sh

## STEP_ restart dhcpcd
## STEP1 configure the hl76 

## STEP3 read back the hl76 IP addresses using AT commands
## STEP4 set the wwan1 IP using hl76 IP address
## STEP5 use dhcdcd to set dns and routing

## STEP1 configure the hl76 
chat -v -f ./pilot/HL76ipUp.chat > /dev/ttyACM2 < /dev/ttyACM2

sleep 3

####
## STEP2 start the hl76 IP wwan1
chat -v -f ./pilot/HL76ipUpStep2.chat > /dev/ttyACM2 < /dev/ttyACM2

sleep 3

####
## STEP3 read back the hl76 IP addresses using AT commands
## get ip address and write to wwan3ipAddress.txt
rm ./wwan3ip_Address.txt
chat -v -r ./wwan3ip_Address.txt -f ./pilot/HL76ipReport.chat > /dev/ttyACM2 < /dev/ttyACM2

# get dns addresses and write to wwan3dnsAddress.txt
rm ./wwan3dnsAddress.txt
chat -v -r ./wwan3dnsAddress.txt -f ./pilot/HL76ipDnsReport.chat > /dev/ttyACM2 < /dev/ttyACM2

# get wwan3ipAddress.txt and write wwan3Ip.txt and wwan3DnsIp.txt
python ./pilot/processIpAddresses.py
WWAN1_IP=$(< wwan3Ip.txt)
WWAN1_DNS=8.8.8.8

echo $WWAN1_IP

####
## STEP4 set the wwan1 IP using hl76 IP address

echo ifconfig
sudo ifconfig wwan1 down
sleep 3
sudo ifconfig wwan1 -arp $WWAN1_IP
sleep 3


## needs kill then restart
echo Kill dhcpcd

sudo dhcpcd -k
sleep 3

## STEP5 use dhcdcd to set dns and routing
echo restart dhcpcd

sudo dhcpcd wwan1 \
--inform $WWAN1_IP \
--static routers=$WWAN1_IP \
--static domain_search=$WWAN1_IP \
--static domain_name_servers=$WWAN1_DNS

echo HL76 IP bringup - done