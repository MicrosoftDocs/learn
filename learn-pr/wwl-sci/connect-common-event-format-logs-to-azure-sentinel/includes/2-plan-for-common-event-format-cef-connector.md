The CEF Connector deploys a Syslog Forwarder server to support the communication between the appliance and Azure Sentinel. The server consists of a dedicated Linux machine with the Log Analytics agent for Linux installed.  Many of the Azure Sentinel Data Connectors that are vendor-specific utilize CEF Connector.

The following diagram displays the setup in the case of a Linux VM in Azure.  The on-premise Syslog sources send securely send events to an Azure Linux VM.  The Linux VM with the Log Analytics agent installed then forwards the logs to the Azure Sentinel workspace.

:::image type="content" source="../media/learn-path5-01.png" alt-text="Azure VM hosting connector.":::

Alternatively, the following diagram displays the setup if you use a VM in another cloud or an on-premises machine.  The on-premise Syslog sources send securely send events to a Linux VM.  The Linux VM with the Log Analytics agent installed then securely forwards the logs to the Azure Sentinel workspace.

:::image type="content" source="../media/learn-path5-02.png" alt-text="on-premise connector architecture":::

## Security considerations

Make sure to configure the machine's security according to your organization's security policy. For example, you can configure your network to align with your corporate network security policy and change the daemon's ports and protocols to align with your requirements.

To use TLS communication between the Syslog source and the Syslog Forwarder, you will need to configure the Syslog daemon (rsyslog or syslog-ng) to communicate in TLS.

## Prerequisites

Make sure the Linux machine you use as a log forwarder is running one of the following operating systems:

- 64-bit

  - CentOS 7 and 8, including minor versions (not 6)

  - Amazon Linux 2017.09

  - Oracle Linux 7

  - Red Hat Enterprise Linux (RHEL) Server 7 and 8, including minor versions (not 6)

  - Debian GNU/Linux 8 and 9

  - Ubuntu Linux 14.04 LTS, 16.04 LTS, and 18.04 LTS

  - SUSE Linux Enterprise Server 12, 15

- 32-bit

  - CentOS 7 and 8, including minor versions (not 6)

  - Oracle Linux 7

  - Red Hat Enterprise Linux (RHEL) Server 7 and 8, including minor versions (not 6)

  - Debian GNU/Linux 8 and 9

  - Ubuntu Linux 14.04 LTS and 16.04 LTS

  - Daemon versions

  - Syslog-ng: 2.1 - 3.22.1

  - Rsyslog: v8

  - Syslog RFCs supported

  - Syslog RFC 3164

  - Syslog RFC 5424

Make sure your machine also meets the following requirements:

Permissions

- You must have elevated permissions (sudo) on your machine.

Software requirements

- Make sure you have python 2.7 or 3 running on your machine.

