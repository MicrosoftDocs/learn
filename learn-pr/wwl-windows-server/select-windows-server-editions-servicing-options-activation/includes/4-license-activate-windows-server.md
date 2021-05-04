As part of planning your server upgrade and migration process, Contoso should also consider how they will manage operating system licensing and activation. Their choice of activation model will be based on the characteristics of their environment. 

There are certain licensing characteristics based on the Windows Server edition you decide to deploy. These are discussed in the following table.

| Windows Server 2019 edition | Licensing characteristics                                    |
| --------------------------- | ------------------------------------------------------------ |
| Windows Server Essentials   | Licensing for Windows Server Essentials is per server. It includes Client Access Licenses for 25 users and is limited to 2 sockets. You can't purchase licensing for more than this limit. |
| Windows Server Standard     | The licensing model for Windows Server Standard changed with Windows Server 2016 and continues through the 2019 version. Licensing for Windows Server Standard is now based on the number of cores, not processors. |
| Windows Server Datacenter   | As for Windows Server standard, licensing is based on the number of cores. |

> [!NOTE]
> Where they are not included, as with Windows Server Essentials, you must purchase CALs separately.

## Core-based licensing requirements

Each Windows Server has the following minimum license requirement:

- All physical cores must be licensed.
- There must be at least eight core licenses per processor.

This minimum applies to both Datacenter and Standard version. Licenses can be bought in 2-core packs or 16-core packs. Servers that have more processors require you to obtain more core licenses. For example, a server with four processors requires at least 32 core licenses because each processor needs eight core licenses.

> [!NOTE]
> Standard edition includes licensing for two VMs running Windows Server or Hyper-V containers. If more VMs are added, you must purchase more core licenses.

> [!TIP]
> There are special licensing rules for VMs running in failover clusters. Licensing must fully support all the VMs to run on each host. For example, if you have a two-node failover cluster with two VMs on each host, then each host must be licensed to support all four VMs potentially running on a single host.

## Client Access Licenses (CALs)

Each authenticated user or device that connects to the server for any purpose must have a Client Access License (CAL). There are user CALs and device CALs. CALs allow users or devices to connect to any of the servers in the organization. In a typical organization where each user has an assigned workstation, it makes sense to buy a user CAL for each user. If your organization has many shared workstations, it might make more sense to purchase a device CALs.

> [!NOTE]
> Remote desktop connections are not included in user CALs. You need to buy remote desktop CALs separately.

## Windows server activation

There are multiple ways to activate Windows Server. Often, if you buy a server from an original equipment manufacturer (OEM), it will come with the operating system pre-installed and activated.

To ensure that your organization has the proper licenses, and to receive notices for product updates, you must activate every copy of Windows Server that you install. Windows Server requires that you activate the operating system after installation. This verifies that the products are licensed and that you receive important update information. There is no activation grace period. If you don't activate Windows Server, you can't customize your operating system. There are two general activation strategies:

- Manual activation. This strategy is suitable when you deploy a small number of servers.
- Automatic activation. This strategy is suitable when you deploy a larger number of servers.

## Manual activation

When you perform a manual activation, you must enter the product key. You can perform manual activation by using the retail product key or the multiple activation key (MAK). You can use a retail product key to activate only a single computer. However, a MAK has a set number of activations that you can use. This allows you to activate multiple computers up to a set activation limit.

OEM keys are a special type of activation key that a manufacturer receives. OEM keys enable automatic activation when a computer starts. You typically use this type of activation key with computers that are running Windows client operating systems, such as Windows 10. You rarely use OEM keys with computers that are running Windows Server operating systems.

## Automatic activation

Performing activation manually in large-scale server deployments can be cumbersome. Microsoft supplies an option to automatically activate a large number of computers without having to enter product keys manually on each system.

There are several technologies available that you can use to automate activating Windows Server licenses:

- Key Management Services (KMS). This is a service that helps you activate licenses on systems within your network from a server where a KMS host has been installed. The KMS host completes the activation process instead of individual computers connecting to Microsoft to complete activation.
- Volume Activation Services server role. This server role helps you to automate issuing and managing Microsoft software volume licenses. Volume Activation Services allows you to install and configure KMS and Active Directory-Based Activation. KMS requires activating at least 5 servers and 25 clients.
- Active Directory-Based Activation. This is a service that lets you use Active Directory Domain Services (AD DS) to store activation objects. A computer running Windows Server or client automatically contacts AD DS to receive an activation object, without the need to contact Microsoft.
- Volume Activation Tools console. You use this console to install, activate, and manage volume license activation keys in AD DS or KMS.
- Volume Activation Management Tool (VAMT). This is a no cost tool that you can use to manage volume activation by using Multiple Activation Keys (MAKs) or to manage KMS. You can use VAMT to generate license reports and manage client and server activation on enterprise networks.
- Automatic Virtual Machine Activation (AVMA). AVMA lets you activate VMs on a virtualization server with no product key, even in disconnected environments. AVMA binds the VM activation to the licensed virtualization server and activates the VM when it starts up.
