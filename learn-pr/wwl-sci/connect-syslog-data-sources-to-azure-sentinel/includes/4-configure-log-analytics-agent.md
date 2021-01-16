The Log Analytics agent for Linux will only collect events with the facilities and severities that are specified in its configuration. You can add a new facility in the Log Analytics workspace advanced settings.

To configure the Log Analytics agent for syslog facilities:

- To Access the Log Analytics Workspace Advanced Settings page:

  - From the Syslog Data connector page

    - Select Open your workspace advanced settings configuration >

  - From the Azure Sentinel portal

    - Select Settings in the Configuration area.

    - Select Workspace Settings Tab.

    - Select Advanced settings in the Settings area.

- Select Data.

- Select Syslog.

- Select the option Apply below configuration to my machines.

- Enter the facility name and select + for each facility.

![Syslog configuration](../media/syslogfac.png)

By default, all configuration changes are automatically pushed to all agents. If you want to configure Syslog manually on each Linux agent, then uncheck the box *Apply below configuration to my machines*.

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

