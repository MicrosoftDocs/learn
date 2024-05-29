
Azure Network Watcher packet capture allows you to create packet capture sessions to track traffic to and from a virtual machine (VM) or a scale set. Packet capture helps to diagnose network anomalies both reactively and proactively. Other uses include gathering network statistics, gaining information on network intrusions, to debug client-server communications and much more.

Packet capture is an extension that is remotely started through Network Watcher. This capability eases the burden of running a packet capture manually on the desired virtual machine or virtual machine scale set instance(s), which saves valuable time. Packet capture can be triggered through the portal, PowerShell, Azure CLI, or REST API. One example of how packet capture can be triggered is with virtual machine alerts. Filters are provided for the capture session to ensure you capture traffic you want to monitor. Filters are based on 5-tuple (protocol, local IP address, remote IP address, local port, and remote port) information. The captured data can be stored in the local disk or a storage blob. Packet capture requires a virtual machine extension.

To implement a packet capture, perform the following steps:

1. In the search box at the top of the Azure portal, enter Network Watcher and in the search results, select **Network Watcher**.
1. Select **Packet capture** under **Network diagnostic tools**. Any existing packet captures are listed, regardless of their status.
1. Select **+ Add** to create a packet capture. In **Add packet capture**, enter or select values for the following settings in the **Basic Details** page:
    - Subscription. Select the Azure subscription of the virtual machine.
    - Resource group. Select the resource group of the virtual machine.
    - Target type. Select **Virtual machine**.
    - Target instance. Select the virtual machine.
    - Packet capture name. Enter a name or leave the default name.
1. Enter or select values for the following settings in the Packet capture configuration page:
    - Capture location. Select **Storage account**, **File**, or **Both**.
    - Storage account. Select your Standard storage account. This option is available if you selected **Storage account** or **Both**.
    - Local file path. Enter a valid local file path where you want the capture to be saved in the target virtual machine. If you're using a Linux machine, the path must start with /var/captures.
    - Maximum bytes per packet. Enter the maximum number of bytes to be captured per each packet. All bytes are captured if left blank or 0 entered.
    - Maximum bytes per session. Enter the total number of bytes that are captured. Once the value is reached the packet capture stops. Up to 1 GB is captured if left blank.
    - Time limit (seconds). Enter the time limit of the packet capture session in seconds. Once the value is reached the packet capture stops. Up to 5 hours (18,000 seconds) is captured if left blank.
1. You can optionally configure the following filtering settings.
    - Protocol. Filters the packet capture based on the selected protocol. Available values are TCP, UDP, or Any.
    - Local IP address. Filters the packet capture for packets where the local IP address matches this value.
    - Local port. Filters the packet capture for packets where the local port matches this value.
    - Remote IP address. Filters the packet capture for packets where the remote IP address matches this value.
    - Remote port. Filters the packet capture for packets where the remote port matches this value.
1. Select **Start packet capture**. Once the time limit set on the packet capture is reached, the packet capture stops and can be reviewed.