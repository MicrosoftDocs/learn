You can stream events from Linux-based, Syslog-supporting machines or appliances into Microsoft Sentinel using the Azure Monitor Agent for Linux and Data Collection Rules. You can do this streaming for any device that allows you to install the agent directly on the host. The host's native Syslog daemon collects local events of the specified types and forward them locally to the agent, which streams them to your Log Analytics workspace.

Log Analytics supports collecting messages sent by the **rsyslog** or **syslog-ng** daemons, where rsyslog is the default. The default syslog daemon on version 5 of Red Hat Enterprise Linux (RHEL), CentOS, and Oracle Linux version (sysklog) isn't supported for Syslog event collection. The rsyslog daemon should be installed and configured to replace sysklog for these versions of Linux.

## How it works

**Syslog** is an event logging protocol that is common to Linux. When the agent is installed on your VM or appliance, the installation routine configures the local Syslog daemon to forward messages to the agent on TCP port 25224. The agent then sends the message to your Log Analytics workspace over HTTPS, where it's parsed into an event log entry in the Syslog table in **Microsoft Sentinel > Logs**.
