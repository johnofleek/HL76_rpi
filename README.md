# HL76_rpi
## Project to automate IP connections on the Raspberry Pi with the Sierra Wireless HL76

## Assumptions 
The scripts are installed in 
~/pilot/

The scripts are executed from 
~



# Tested on (ATi9)
 Pilot board 000-586-02A
 Module WP7692
 BHL769x.2.11.154401.201611011730.x7120m_1
 HL7692
 HL769x.2.11
 x7120m
 FUSED
 2016-11-01 17:32:04
 r6274


Note that ttyACM0 has been used in this example. This is because with if ttyACM2 is used
 the  AT+CGDATA="M-RAW_IP",3 fails or crashes the HL device.

# Restart the HL76
. ./pilot/pilotRestart.sh

# Start IP on the HL76
. ./pilot/pilotIp.sh

# Power on the HL76 (if connected to a RPi via the header)
. ./pilot/pilotOn.sh

