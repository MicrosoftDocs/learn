The Contoso Hyper-V administrator needs to determine what Hyper-V networking features and functionality are available and how they can be utilized before workload migrations take place. Networking in Hyper-V consists of two primary components: a *virtual network adapter* and a *virtual switch*. To communicate on a network, the virtual network adapter is configured on the VM and connects to a port on the virtual switch.

## Virtual network adapter types

Hyper-V supports the following virtual network adapter types:

- Legacy network adapter. This adapter type emulates an Intel 21140-based PCI Fast Ethernet Adapter. It can be used to perform a network boot for OS installation tasks. Legacy network adapters are available only in generation 1 VMs.
- Network adapter. Also known as a *synthetic* network adapter. This type is faster than the legacy network adapter; however, it doesn't support perform a network boot for generation 1 VMs. This type of network adapter can be used with both generation 1 and generation 2 VMs.

## Virtual switch types

A virtual switch is used to control how network traffic flows between the VMs hosted on a Hyper-V Server, in addition to the flow of network traffic between the VMs and the rest of the organizational network. The following table details the three types of virtual switches: internal, external, and private.

|Type|Description|
|---|---|
|Internal|An *internal virtual switch* is used to communicate between each of the VMs on a Hyper-V host, and to communicate between the VMs and the Hyper-V host.|
|External|An *external virtual switch*  is used to map a network to a specific network adapter or network adapter team. Hyper-V also supports mapping an external network to a wireless network adapter. To map an external network to a wireless adapter, install the Wireless local area network (LAN) service on the Hyper-V host server and ensure that the Hyper-V Server has a compatible network adapter.|
|Private|A *private switch* facilitates communication between the VMs on the same Hyper-V host. Private switches can't be used to communicate between the Hyper-V host and VMs.|

> [!TIP] 
> When configuring a virtual network, you can also configure a virtual LAN (VLAN) ID, and then associate the ID with the network. Use this configuration to extend existing VLANs on an external network to VLANs within the Hyper-V host's network switch.

> [!TIP] 
> You can use VLANs to partition network traffic. VLANs function as separate logical networks. Traffic can pass only from one VLAN to another if it passes through a router.

### Create and manage virtual switches for Hyper-V

To create and manage a virtual switch for Hyper-V, you can use the following tools:

- Hyper-V Manager
- The `New-VMSwitch` PowerShell cmdlet
- Windows Admin Center

## Virtual switch extensions

Independent software vendors (ISVs) can create extensible plug-ins known as *virtual switch extensions*. A virtual switch extension is an extension that runs inside a Hyper-V Virtual Switch to provide enhanced networking and security capabilities. After an extension is installed, it can be enabled or disabled on separate instances of a Hyper-V Virtual Switch.

There are three classes of virtual switch extensions: capture, filtering, and forwarding. All of these extension types can be bound to the virtual switch drivers as network driver interface specification (NDIS) filter drivers. Filtering extensions can also be bound to the virtual switch drivers as Windows Filtering Platform (WFP) filter drivers.

- NDIS virtual switch extensions. NDIS extensions bind within the Hyper-V Virtual Switch driver stack. This enables extensions to capture, filter, and forward packets to Hyper-V Virtual Switch ports. This also enables extensions to inject, drop, or redirect packets to ports that are connected to the network adapters exposed in the Hyper-V partitions.

- WFP virtual switch extensions. The WFP provides `Wfplwfs.sys`, an in-box filtering extension that enables WFP filters or callout drivers to intercept packets along the Hyper-V Virtual Switch data path. This enables the WFP filters or callout drivers to perform packet inspection or modification by using the WFP management and system functions.

> [!NOTE]
> Virtual switch extensions that you can add to a Hyper-V Virtual Switch are listed in the Virtual Switch Manager feature of Hyper-V Manager.

## Demonstration

The following video demonstrates how to:

- Create a Hyper-V Virtual Switch in Hyper-V Manager.
- Create a Hyper-V Virtual Switch in WAC.
- Create a network switch by using Windows PowerShell.

The main steps in the process are:

1. Create a Hyper-V Virtual Switch in Hyper-V Manager:

    1. To open the **Virtual Switch Manager** console, start **Server Manager**, and then select **Virtual Switch Manager**.
    1. In **Virtual Switch Manager**, select **Internal**, and then select **Create Virtual Switch**.
    1. In **Virtual Switch Properties**, enter the following details, and then select **OK**:
        - Name: **internal switch 1**
        - External network: **Internal network**
    1. In **Virtual Switch Manager**, verify the presence of the switch you created. You can now add the switch to VMs as required.

1. Create a Hyper-V Virtual Switch in WAC:

    1. Start WAC, scroll through **Tools**, and then select **Virtual switches**. Note the presence of the switch created in the previous step.
    1. Select **+New**, enter the following details, and then select **Save**:
        - Switch name: **private switch 1**
        - Switch Type: **Private**
    1. On the **Virtual switches** pane, confirm that the new switch is listed with the other switches.

1. Open **Windows PowerShell** and then use the `VMSwitch` cmdlet to list available Hyper-V network switch commands with the source value listed as **Hyper-V** for relevant commands.
1. Use the **Windows PowerShell** `New-VMSwitch` cmdlet to create a new network switch.
1. Use the **Windows PowerShell** `Get-VMSwitch` cmdlet to observe all Hyper-V network switches, including the one you just created.

 > [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MzHL]

---



---