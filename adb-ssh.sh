#!/bin/sh
#Connect to ssh server through adb device

ADBDEVICE="HT06XPL04183"
ANDROIDFIFOFILE="/data/pipe"

SSHUSER="ronane"
SSHSERVER="enanor.fr"
SSHPORT="22"
SSHCOMMAND="screen -dR"


echo "forward"
adb -s $ADBDEVICE forward tcp:2222 tcp:2223

echo "nc"
adb -s $ADBDEVICE shell "nc -l 2223 < $ANDROIDFIFOFILE | nc $SSHSERVER $SSHPORT > $ANDROIDFIFOFILE" &

sleep 1
echo "ssh"
ssh -t $SSHUSER@localhost -p 2222 $SSHCOMMAND
