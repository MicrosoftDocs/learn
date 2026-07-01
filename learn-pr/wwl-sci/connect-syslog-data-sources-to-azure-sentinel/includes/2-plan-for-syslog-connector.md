> [!CAUTION]
> This article references CentOS, a Linux distribution that is End Of Life (EOL) status. Consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

You can stream events from Linux-based, Syslog-supporting machines or appliances into Microsoft Sentinel using the Azure Monitor Agent for Linux and Data Collection Rules. You can do this streaming for any device that allows you to install the agent directly on the host. The host's native Syslog daemon collects local events of the specified types and forward them locally to the agent, which streams them to your Log Analytics workspace.

Log Analytics supports collecting messages sent by the **rsyslog** or **syslog-ng** daemons, where rsyslog is the default.

## How it works

**Syslog** is an event logging protocol that's common to Linux. When the agent is installed on your VM or appliance, the installation routine configures the local Syslog daemon (rsyslog or syslog-ng) to forward messages to the agent via a local Unix domain socket. The agent then sends the messages to your Log Analytics workspace over HTTPS, where they're parsed into event log entries in the Syslog table in **Microsoft Sentinel > Logs**.
