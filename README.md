* [nagios-discord.sh](#nagios-discord.sh)

## <a name="nagios-discord.sh"></a>nagios-discord.sh

nagios-discord.sh will send Nagios alerts to a Discord channel configured with a webhook.
This has been tested using RHEL 7 and OSSEC version 3.2.0.

__Usage__

On the OSSEC server, place nagios-discord.sh into your /usr/local/bin. Ensure this file is also executable. 

Next, configure Nagios to use this script for alerting:

__Example (nagios-object).conf__

```
define command {
        command_name     notify-ossec-discord
        command_line     /usr/local/bin/nagios-discord.sh "$HOSTNAME$" "$SERVICEDESC$" "$SERVICESTATEID$" "$SERVICEOUTPUT$"
	}

define contact {
        contact_name                    ossec-discord
        alias                           Ossec-Discord
        service_notification_period     work
        service_notification_options    w,u,c,r
        service_notification_commands   notify-ossec-discord
        }

define contactgroup{
        contactgroup_name       ossec-discord
        alias                   OSSEC Discord
        members                 ossec-discord
        }

define service {
        name                            service-passive
        check_period                    24x7
        max_check_attempts              1
        check_interval                  10
        retry_interval                  2
        contact_groups                  ossec-discord
        flap_detection_enabled          0
        notification_options            w,u,c
        notification_interval           720
        notification_period             work
        active_checks_enabled           0
        passive_checks_enabled          1
        parallelize_check               1
        notifications_enabled           1
        event_handler_enabled           1
        register                        0
        is_volatile                     1
        check_command                   check_dummy_unix!0
	}

define service{
        use                             service-passive
        host_name                       nagios-host
        service_description             OSSEC UNIX
        }
```
