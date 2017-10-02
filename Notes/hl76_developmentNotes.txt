## run power on pilot script


## configure dhcpcd.conf so that new interfaces pick up dns server addresses
sudo nano /etc/dhcpcd.conf

## add

interface wwan0

interface wwan1

interface wwan2




## AT commands

AT+CMEE=2

AT+COPS=0

AT+CGPIAF=1,0,0,0

AT+CGDCONT=3,"IPV4V6","three.co.uk"

AT+CGDCONT=3,"IP","three.co.uk"

AT+XDATACHANNEL=1,1,"/USBCDC/0","/USBHS/NCM/0",2,3

AT+XDATACHANNEL=1,1,"/USBCDC/0","/USBHS/NCM/1",2,3

AT+CGACT=1,3

# read the address
AT+CGPADDR=3

# read the dns server address
AT+XDNS?


# Start the data connection by the following command
AT+CGDATA="M-RAW_IP",3

### the following are shell commands - use actual IP address from cgpaddr
sudo ifconfig wwan1 -arp 10.53.3.42

### add wwan as route
sudo route add default wwan1

# test
ping -I wwan1 8.8.8.8





## more notes on automation script
exec 5</dev/ttyACM2
exec 6>/dev/ttyACM2

echo "AT+CGMI" >&6

# Eat the echo, then eat the blank line
read <&5 ; read <&5
# Read the actual response
read RESPONSE <&5
echo "Response was $RESPONSE"

# close the files
exec 5<&-
exec 6>&-


## more more notes on automation script
exec 5</dev/ttyACM2
exec 6>/dev/ttyACM2

echo "AT+CGMI" >&6

# Eat the echo, then eat the blank line
read <&5 ; read <&5
# Read the actual response
read RESPONSE <&5
echo "Response was $RESPONSE"

# close the files
exec 5<&-
exec 6>&-

#### more notes on chat script execution from command line

## notes on running chat direct to serial port
## chat -V -s '' 'AT+creg?' '' > /dev/ttyACM0 < /dev/ttyACM0

# giving 
chat -v -f ./pilot/HL76ipUp.chat > /dev/ttyACM2 < /dev/ttyACM2

## get ip address
chat -v -f ./pilot/HL76ipReport.chat > /dev/ttyACM2 < /dev/ttyACM2

## following doesn't capture the IP add because the OP is to stderr
WWAN3_IP = "(chat -v -f ./pilot/HL76ipReport.chat > /dev/ttyACM2 < /dev/ttyACM2)"

## this appends the REPORT OP to the .txt file # need to rm the file first
rm wwan3ipAddress.txt
chat -v -r wwan3ip_Address.txt -f ./pilot/HL76ipReport.chat > /dev/ttyACM2 < /dev/ttyACM2

# get dns address 
rm wwan3dnsAddress.txt
chat -v -r wwan3dnsAddress.txt -f ./pilot/HL76ipDnsReport.chat > /dev/ttyACM2 < /dev/ttyACM2



