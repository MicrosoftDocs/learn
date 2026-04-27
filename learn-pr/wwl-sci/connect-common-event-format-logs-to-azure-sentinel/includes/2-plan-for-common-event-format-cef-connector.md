The **Common Event Format (CEF) via AMA** connector uses the **Azure Monitor Agent (AMA)** on a dedicated Linux log forwarder to support communication between your network appliances and Microsoft Sentinel. Many vendor-specific Microsoft Sentinel data connectors use CEF via AMA as their collection mechanism.

The following diagram illustrates the setup when you use a Linux VM in Azure as the forwarder. On-premises Syslog sources securely send events to the Azure Linux VM. AMA on the Linux VM then forwards the logs to your Microsoft Sentinel workspace.

:::image type="content" source="../media/learn-path5-01.png" alt-text="Diagram of an Azure VM used as a Syslog forwarder to Microsoft Sentinel.":::

Alternatively, you can use a VM in another cloud or an on-premises machine as the forwarder. Syslog sources securely send events to the Linux VM with AMA installed, which then securely forwards the logs to your Microsoft Sentinel workspace.

:::image type="content" source="../media/learn-path5-02.png" alt-text="Diagram of an on-premises machine used as a Syslog forwarder to Microsoft Sentinel.":::

## Security considerations

Configure the machine's security according to your organization's security policy. For example, configure your network to align with your corporate network security policy and change the daemon's ports and protocols to align with your requirements.

To use TLS communication between the Syslog source and the Syslog forwarder, configure the Syslog daemon (rsyslog or syslog-ng) to communicate in TLS.

## Prerequisites

Make sure the Linux machine you use as a log forwarder is running one of the following 64-bit operating systems:

- Amazon Linux 2 or 2023
- Oracle Linux 8 or 9
- Red Hat Enterprise Linux (RHEL) Server 8 or 9
- Debian GNU/Linux 10, 11, or 12
- Ubuntu Linux 20.04 LTS, 22.04 LTS, or 24.04 LTS
- SUSE Linux Enterprise Server 15

> [!NOTE]
> AMA supports only 64-bit operating systems.

Supported Syslog daemon versions:

- Syslog-ng: 2.1 - 3.22.1
- Rsyslog: v8

Supported Syslog RFCs:

- Syslog RFC 3164
- Syslog RFC 5424

Your machine must also meet these requirements:

**Permissions**

- You must have elevated permissions (sudo) on your machine.

