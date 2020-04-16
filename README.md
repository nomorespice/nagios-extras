* [nagios-discord.sh](#nagios-discord.sh)
* [nagios-teams-host.sh](#nagios-teams-host.sh)
* [nagios-teams-service.sh](#nagios-teams-service.sh)

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
## <a name="nagios-teams-host.sh"></a>nagios-teams-host.sh

nagios-teams-host.sh will send Nagios host alerts to a to a Microsoft Teams channel via the incoming webhook connector. This has been tested using RHEL 8 and Nagios version 4.4.5.

__Usage__

On the Nagios server, place nagios-teams-host.sh into /usr/local/bin. Ensure this file is also executable. 

Next, configure Nagios to use this script for alerting:

__Example (nagios-object).conf__

```
define command {
      command_name     notify-host-teams
      command_line     /usr/local/bin/nagios-teams-host.sh "$HOSTNAME$" "$HOSTSTATEID$" "$HOSTOUTPUT$" "$HOSTNOTES$"
}

define contact {
        contact_name                    nagios-teams
        host_notification_period        24x7
        host_notification_options       d,r
        host_notification_commands      notify-host-teams
        }

define contactgroup{
        contactgroup_name       nagios-teams
        members                 nagios-teams
        }

define host{
        ~
        contact_groups                  nagios-teams
        ~
	}
```
## <a name="nagios-teams-service.sh"></a>nagios-teams-service.sh

nagios-teams-service.sh will send Nagios service alerts to a to a Microsoft Teams channel via the incoming webhook connector. This has been tested using RHEL 8 and Nagios version 4.4.5.

__Usage__

On the Nagios server, place nagios-teams-service.sh into /usr/local/bin. Ensure this file is also executable. 

Next, configure Nagios to use this script for alerting:

__Example (nagios-object).conf__

```
define command {
      command_name     notify-service-teams
      command_line     /usr/local/bin/nagios-teams-service.sh "$HOSTNAME$" "$SERVICEDESC$" "$SERVICESTATEID$" "$SERVICEOUTPUT$"
}

define contact {
        contact_name                    nagios-teams
        service_notification_period     24x7
        service_notification_options    w,u,c,r
        service_notification_commands   notify-service-teams
        }

define contactgroup{
        contactgroup_name       nagios-teams
        members                 nagios-teams
        }

define service{
        ~
        contact_groups                  nagios-teams
        ~
	}
```
