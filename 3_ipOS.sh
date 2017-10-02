#!/bin/bash



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

echo 3_ : $WWAN1_IP
####
## STEP4 set the wwan1 IP using hl76 IP address

sudo ifconfig wwan1 down
sleep 3
sudo ifconfig wwan1 -arp $WWAN1_IP
sleep 3
