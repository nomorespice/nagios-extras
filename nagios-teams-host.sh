#!/bin/bash
# nagios-teams-host.sh
#
CURL=/bin/curl
CUT=/bin/cut
ECHO=/bin/echo
GREP=/bin/grep
SED=/bin/sed
#
WEBHOOK="WEBHOOK_URL_HERE"
#
STA=$2
if [ "$STA" = 0 ]; then STATE="host UP"; CLR="00FF00";
elif [ "$STA" = 1 ]; then STATE="host DOWN"; CLR="FF0000";
elif [ "$STA" = 2 ]; then STATE="host Unreachable"; CLR="FFA500";
fi
#
OUT=$3
OUTPUT=`$ECHO -e "$OUT" | $SED -e 's/[;,()'\''<>]//g;s/\[/ /;s/\]//' | $CUT -c 1-421`
TITLE="$1 $STATE"
MESSAGE="$OUTPUT"
TYPE='"Content-Type: application/json"'
$CURL -s H $TYPE -d "{\"@type\": \"MessageCard\",\"themeColor\": \"$CLR\",\"title\": \"$TITLE\",\"text\": \"$MESSAGE\"}" $WEBHOOK
#
exit
