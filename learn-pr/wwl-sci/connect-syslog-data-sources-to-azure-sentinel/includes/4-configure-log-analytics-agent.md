The agent to only collect events with the facilities and severities that are specified in its configuration. You can add a new facility in the Log Analytics workspace advanced settings.

To configure the agent for syslog facilities:

1. Access the Log Analytics Workspace Advanced Settings page:

    - From the Syslog Data connector page, select Open your workspace advanced settings configuration.

    - From the Microsoft Sentinel portal, select **Settings** in the Configuration area. Select **Workspace Settings** Tab. Select **Advanced settings** in the Settings area.

1. Select **Agents Configuration**.

1. Select **Syslog**.

1. Enter the facility name and select **+** for each facility.

By default, all configuration changes are automatically pushed to all agents. 

The following facilities are supported with the Syslog collector:

- kern

- user

- mail

- daemon

- auth

- syslog

- lpr

- news

- uucp

- cron

- authpriv

- ftp

- local0-local7

