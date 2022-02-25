#!/bin/bash
# Created by: Rohit Sharma
# Date: 25-02-2022
#Internet connection check script. If connection is down then it will 
#send email to the particular mail that host is down.
##############################################
########## How to run #######################
# chmod +x monitor.sh
# ./monitor.sh google.com
#--------- or ------------
# ./monitor.sh 192.1.1.1 yahoo.com and so on...
########################################################################

LOG=/tmp/monitor_log.log #create log file first
SECONDS=60 #script will run every 60 seconds

EMAIL=email-id@gmail.com  #put any email id

for i in $@; do
	echo "$i-UP!" > $LOG.$in
done

while true; do
	for i in $@; do

ping -c l $i > /dev/null
if [ $? -ne 0 ]; then
	STATUS=$(cat $LOG.$i)
	       if [ $STATUS != "$i-DOWN!" ]; then
	       	echo "`date`: ping failed, $i host is down!" | mail -s "$i host is down!" $EMAIL
	       fi
	    echo "$i-DOWN!" > $LOG.$i
else
	STATUS=$(cat $LOG.$i)
	       if [ $STATUS != "$i-UP!" ]; then
	       	echo "`date`: ping OK, $i host is up!"
	       fi
	    echo "$i-UP!" > $LOG.$i
fi
done

sleep $SECONDS
done
