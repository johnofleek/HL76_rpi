# HL76_rpi
Project to automate IP connections on the Raspberry Pi with the Sierra Wireless HL76

# Assumptions 
The scripts are installed in folder
~/pilot/

The scripts are executed from 
~


## Tested on (ATi9)
 Pilot board 000-586-02A
 Module WP7692
 BHL769x.2.11.154401.201611011730.x7120m_1
 HL7692
 HL769x.2.11
 x7120m
 FUSED
 2016-11-01 17:32:04
 r6274

## Rasbian
uname -a
Linux raspberrypi 4.9.35-v7+ #1014 SMP Fri Jun 30 14:47:43 BST 2017 armv7l GNU/Linux

## HW - Raspberry pi
Pi 2 model B v1.1

## Settings
Note that ttyACM0 has been used in this example. This is because with if ttyACM2 is used
 the  AT+CGDATA="M-RAW_IP",3 fails or crashes the HL device.
File commandPort.cfg contains the path to the tty to use for commands.
Edit commandPort.cfg to change the port used.

# Base scripts to run to control the pilot (HL76) board

## Restart the HL76
. ./pilot/pilotRestart.sh

## Start IP on the HL76
. ./pilot/pilotIp.sh

## Power on the HL76 (if connected to a RPi via the header)
. ./pilot/pilotOn.sh

Note the . or source is needed because variables are globally shared by some of the scripts


