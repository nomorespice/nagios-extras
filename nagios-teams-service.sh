#!/bin/bash
# nagios-teams-service.sh
#
CURL=/bin/curl
CUT=/bin/cut
ECHO=/bin/echo
GREP=/bin/grep
SED=/bin/sed
#
WEBHOOK="WEBHOOK_URL_HERE"
#
STA=$3
if [ "$STA" = 0 ]; then STATE="OK"; CLR="00FF00";
elif [ "$STA" = 1 ]; then STATE="WARNING"; CLR="FFFF00";
elif [ "$STA" = 2 ]; then STATE="CRITICAL"; CLR="FF0000";
elif [ "$STA" = 3 ]; then STATE="UNKNOWN"; CLR="0000FF";
fi
#
OUT=$4
OUTPUT=`$ECHO -e "$OUT" | $SED -e 's/[;,()'\''<>]//g;s/\[/ /;s/\]//' | $CUT -c 1-421`
TITLE="$1 $2 $STATE"
MESSAGE="$OUTPUT"
TYPE='"Content-Type: application/json"'
$CURL -s H $TYPE -d "{\"@type\": \"MessageCard\",\"themeColor\": \"$CLR\",\"title\": \"$TITLE\",\"text\": \"$MESSAGE\"}" $WEBHOOK
#
exit
