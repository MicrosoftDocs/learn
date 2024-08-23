Azure Bastion and just-in-time access technologies allow you to connect securely to your organization's VMs hosted in Azure.

Here, you learn about the use cases and capabilities of two options, Azure Bastion and just-in-time (JIT) virtual machine (VM) access. You can then help your teams choose the most appropriate one for them.

## Capabilities of Azure Bastion

:::image type="content" source="../media/bastion-network-diagram.png" alt-text="A diagram showing how to connect to a VM through a TLS connection to the Azure portal." border="false":::

The Azure Bastion Service allows you to use a modern HTML5-based web client from directly inside the Azure portal. The service connects securely over TLS and port 443 to any Azure VM in the same virtual network. Azure Bastion is a fully platform-managed PaaS you can choose to provision inside the same virtual network as your organization's VMs.

There are many benefits to this approach:

- The web client connects an RDP or SSH session over the industry standard TLS on port 443. The same port browsers are used for HTTPS connections. Using TLS over 443 enables you to traverse your corporate firewalls securely without the need to open any more ports.

- You can harden your VMs as they no longer need a public facing IP address. Azure Bastion connects over a private IP address.

- You no longer need to add another NSG to allow users to connect to the VMs. You just create a single secure NSG for Azure Bastion to connect over its secure private IP address.

- As your VMs no longer have a public facing IP address, they're automatically protected from external port scanning by malicious users outside your virtual network.

## Capabilities of just-in-time VM access

:::image type="content" source="../media/just-time-network-diagram.png" alt-text="A diagram showing how to connect to a VM using just-in-time VM access." border="false":::

In comparison to Azure Bastion, just-in-time VM access is a feature of Microsoft Defender for Cloud. When enabled in your subscription, you can authorize JIT access to a specific VM for a set amount of time. When that time passes, the access is removed. Microsoft Defender for Cloud allows this access by automatically changing the inbound port rules in the NSG and Azure Firewall.

The benefits to this approach are:

- You can connect to your VM with the tools of your choice, Remote Desktop or any other app that supports the RDP.

- You can easily transfer and manage files directly with the VM.

- Your VMs are protected by locking down inbound traffic automatically when access isn't being used.

## Choose between Azure Bastion and JIT VM access

Both of your options greatly reduce the attack surface that malicious users might exploit. Here are some use cases where you could choose one over the other.

| Use Case| Azure Bastion| JIT VM access|
| :--- | :--- | :--- |
| Want to reduce costs for VMs that are accessed and used 24/7|| ✔️|
| Client machines are locked down and can't install RDP software| ✔️||
| You need to be able to transfer files|| ✔️|
| Corporate firewall doesn't have ports 3389 or 22 open| ✔️||

If you want the maximum security, you can combine Azure Bastion and JIT VM access.

:::image type="content" source="../media/bastion-just-time-together.png" alt-text="A diagram showing how Azure Bastion and JIT VM access can be combined to get the benefits of both." border="false":::

You get the benefits of browser-based SSL connection to an Azure VM, with no public IP address or RDP ports open, and the time-based restriction of just-in-time access.

