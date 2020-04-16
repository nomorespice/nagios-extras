#!/bin/bash
# nagios-discord.sh
#
# URL is provided by the Discord's WebHook: https://discordapp.com/api/webhooks/TOKEN
#
AWK=/bin/awk
CAT=/bin/cat
CURL=/bin/curl
CUT=/bin/cut
ECHO=/bin/echo
PRINTF=/bin/printf
SED=/bin/sed
TR=/bin/tr
#
TYPE=`$ECHO '"Content-Type: application/json"'`
URL="WEBHOOK"
#
STA=$3
if [ "$STA" = 0 ]; then STATE="OK"; CLR="32768";
elif [ "$STA" = 1 ]; then STATE="WARNING"; CLR="16776960";
elif [ "$STA" = 2 ]; then STATE="CRITICAL"; CLR="16711680";
elif [ "$STA" = 3 ]; then STATE="UNKNOWN"; CLR="255";
fi
#
OUT=$4
OUTPUT=`$ECHO -e "$OUT" | $SED -e 's/[;,()'\''<>]//g;s/\[/ /;s/\]//' | $CUT -c 1-421`
CONTENT="$1 $2 $STATE - $OUTPUT"
CON1=`$ECHO "\"$CONTENT\""`
$PRINTF "$CURL -s -X POST --data '{ \"embeds\": [{\"color\": \"$CLR\", \"description\": $CON1 }] }' -H $TYPE $URL" | $TR -d "\n\r" | /bin/bash
#
exit
