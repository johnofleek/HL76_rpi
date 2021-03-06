## Notes on HL7692 IP up procedures
```
Pilot board 000-586-02A
Module WP7692
BHL769x.2.11.154401.201611011730.x7120m_1
```

##HL7692
```
HL769x.2.11
x7120m
FUSED
2016-11-01 17:32:04
r6274
```

## Notes on crazy Jessie dhcpcd dhcpcd.conf and INFORM instead of static

www.raspberrypi.org/forums/viewtopic.php?f=36&t=130015

## following is a snippit I added to dhcpcd.conf
```
interface wwan1  
static domain_name_servers=8.8.8.8  
```

## this adds a route
```
static routers=10.190.226.51
inform 10.190.226.51
```

## Note that I connected the Pilot via USB only
This has the advantage that the HL is power cycled everytime time the RPi

## DEBUGGING
The following is useful to run in another shell to debug the process
```
sudo tail -f /var/log/syslog
```

## To Talk to the modem directly [CTRL A X to exit]
```
sudo minicom -D /dev/ttyACM0
```

 



## configure dhcpcd.conf so that new interfaces pick up dns server addresses
```
sudo nano /etc/dhcpcd.conf
```

## add
```
interface wwan0

interface wwan1

interface wwan2
```

## The following AT commands are automated in ##
```
sudo chat -v -f ./pilot/HL76ipUp.chat > /dev/ttyACM2 < /dev/ttyACM2
```

## AT commands Start
```
AT+CMEE=2

AT+COPS=0

AT+CGPIAF=1,0,0,0

AT+CGDCONT=3,"IPV4V6","three.co.uk"

AT+CGDCONT=3,"IP","three.co.uk"

AT+XDATACHANNEL=1,1,"/USBCDC/0","/USBHS/NCM/0",2,3

AT+XDATACHANNEL=1,1,"/USBCDC/0","/USBHS/NCM/1",2,3

#AT+CGACT=1,3 ## turned out to be not necessary
```


# Start the data connection by the following command 
# - sometimes fails with +CME ERROR: operation not allowed
```
AT+CGDATA="M-RAW_IP",3
```
expect CONNECT returned


## AT commands end


## read the address
```
AT+CGPADDR=3
```

## read the dns server address
```
AT+XDNS?
```

## the following are shell commands - use actual IP address from cgpaddr

```
WWAN1_IP=10.35.115.72
sudo ifconfig wwan1 down
sudo ifconfig wwan1 -arp $WWAN1_IP
```

## add wwan as route - ? not needed when dhcpcd configured correctly 
sudo route add default wwan1




## get ip address
chat -v -f ./pilot/HL76ipReport.chat > /dev/ttyACM2 < /dev/ttyACM2

## get dns address 
chat -v -f ./pilot/HL76ipDnsReport.chat > /dev/ttyACM2 < /dev/ttyACM2




## this works appended to /etc/dhcpcd.conf
```
interface wwan1
static domain_name_servers=8.8.8.8
static routers=10.141.18.211
inform 10.141.18.211
static domain_search=10.141.18.211
```

## needs kill then restart
sudo dhcpcd -k

## then (add -d for debug output)
```
sudo dhcpcd 
```

## or to avoid editing /etc/dhcpcd.conf
```
sudo dhcpcd wwan1 --inform 10.141.18.211 --static routers=10.141.18.211 --static domain_search=10.141.18.211 --static domain_name_servers=8.8.8.8

WWAN1_IP=10.35.115.72


WWAN1_DNS=8.8.8.8
```

## try variables and static setting
```
sudo dhcpcd wwan1 \
--inform $WWAN1_IP \
--static routers=$WWAN1_IP \
--static domain_search=$WWAN1_IP \
--static domain_name_servers=$WWAN1_DNS
```
