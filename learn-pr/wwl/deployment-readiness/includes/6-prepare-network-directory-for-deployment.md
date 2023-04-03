
It’s important to understand the capacity of the network infrastructure when planning a deployment. Without proper planning, a deployment can take longer than anticipated and drastically impact the performance of those using the network during deployment. The deployment method and the number of devices that can be deployed at a given time can be impacted by the available bandwidth and network reliability. This is an important consideration for organizations with multiple locations and wide area network (WAN) links.

When deploying an operating system or image, a primary consideration is how to deploy a large amount of data with the least amount of impact to the network. This is typically done by ensuring clients are downloading the data from the closest possible location and managing how much bandwidth is being consumed.

#### Delivery Optimization

Windows updates, upgrades, and applications can contain packages with large files. Downloading and distributing updates can consume quite a bit of network resources on the devices receiving them. You can use Delivery Optimization to reduce bandwidth consumption by sharing the work of downloading these packages among multiple devices in your deployment. Delivery Optimization can accomplish this because it's a self-organizing distributed cache that allows clients to download those packages from alternate sources (such as other peers on the network) in addition to the traditional Internet-based servers. You can use Delivery Optimization with Windows Update, Windows Server Update Services (WSUS), Windows Update for Business, or Endpoint Configuration Manager (when installation of Express Updates is enabled).

Delivery Optimization is a cloud-managed solution; therefore, access to the Delivery Optimization cloud service is a requirement. In addition, devices must have access to the internet to use the peer-to-peer functionality of Delivery Optimization.

By default in Windows 10 or later Enterprise and Education editions, Delivery Optimization allows peer-to-peer sharing only on the organization's own network (specifically, all of the devices must be behind the same NAT). However, you can configure it differently in Group Policy and mobile device management (MDM) solutions such as Microsoft Intune.

#### Branch Cache

Branch Cache replicates files from a central location to a local device like a server. Branch Cache lets clients download locally hosted data instead of consuming WAN bandwidth. Windows Server Update Services (WSUS) and Endpoint Configuration Manager can use BranchCache to optimize network bandwidth during update deployment. BranchCache has two operating modes: Distributed Cache mode and Hosted Cache mode.

 -  **Distributed Cache mode.** In Distributed Cache mode, each client contains a cached version of the BranchCache-enabled files it requests and acts as a distributed cache for other clients requesting that same file. This is similar to the Delivery Optimization feature in Windows.
 -  **Hosted Cache mode.** In Hosted Cache mode, designated servers at specific locations act as a cache for files requested by clients in its area. So rather than clients retrieving files from a latent source, the hosted cache server provides the content on its behalf.

Whether you use BranchCache with Configuration Manager or WSUS, each client that uses BranchCache must be configured to do so. You typically make your configurations through Group Policy in the **Computer Configuration/Policies/Administrative Templates/Windows Components/Delivery Optimization** node.

For detailed information about how Distributed Cache mode and Hosted Cache mode work, see [BranchCache Overview](https://technet.microsoft.com/library/dd637832%28v=ws.10%29.aspx).

#### BITS

Background Intelligent Transfer Service (BITS) is used by programmers and system administrators to download files from or upload files to HTTP web servers and SMB file shares. BITS takes the cost of the transfer and the network usage into consideration so that the user's foreground work has as little impact as possible.

BITS uses idle network bandwidth to transfer the files by increasing or decreasing the rate at which files are transferred based on the amount of idle network bandwidth available. If a network application begins to consume more bandwidth, BITS decreases its transfer rate to preserve the user's interactive experience. BITS also adapts to network interruptions by pausing and automatically resuming transfers, even after a reboot. BITS also transfers files when the machine is in Modern Standby mode and plugged in.

If an administrator enables Windows BranchCache on client and server computers in an organization through a group policy or local configuration settings, BITS will use Windows BranchCache for data transfers.

#### LEDBAT

Windows Low Extra Delay Background Transport (LEDBAT) is a network congestion control feature introduced in Windows Server 2019 to help manage background network transfers. Unlike BITS, which restricts traffic, LEDBAT consumes as much bandwidth as possible, but only unused bandwidth.

For example, an administrator might set bandwidth throttling for package downloads to 50%. With BITS alone, the remaining 50% of bandwidth isn't used, even when it’s available. With LEDBAT, an administrator can remove this throttling limitation because LEDBAT will automatically scale back as latency increases.

**Additional information.** For more information on Windows LEDBAT, see the following article on transport features and performance advancements for Windows clients and Windows Servers.

#### Migration data size

When many devices are being replaced or refreshed, the amount of user data to be migrated can impact device availability. End users may not be able to use their devices until their data migration is complete. If there's a large amount of data, devices may be unavailable for a longer period of time. As storage is inexpensive and client hardware typically has hundreds of gigabytes or more, user data can easily surpass the size of the OS and applications.

Organizations should first consider minimizing the amount of end user data that is stored only on the client device. Migration challenges aside, the cost and risks are higher when data is stored locally versus data that is centrally managed. Solutions such as Work Folders, OneDrive, and SharePoint enable users to work with their data as they typically do, even offline, while the data is managed and protected in a centralized location. Tied with an effective deployment solution, users should be able to move to other devices and seamlessly have access to their apps and data. This can enable the replacement or refresh process to be no more complicated than a user switching to another device.

For organizations that have either not adopted or don’t primarily use a centralized solution for user data, administrators should consider implementing such a solution prior to migrating to Windows 10 or Windows 11. This can minimize the effort involved in the data migration or device upgrade process versus implementing a centralized solution after the additional costs and risks of a migration have already been realized. Tools like Known Folder Move can help migrate a large number of users’ files to OneDrive without impacting their daily habits. Known Folder Move is examined in greater detail later in this course.

#### Directory planning

Your network directory plays a critical role in the deployment process. Organizations typically have Active Directory Domain Services (AD DS) in-place. Most organizations also use Azure Active Directory (Azure AD) as it provides identity services for common cloud services such as Exchange Online and Microsoft 365. Many organizations connect their on-premises AD DS environment with Azure AD to unify identity management across their on-premises and cloud services.

Administrators should consider using the Azure AD Connect tool to integrate directories if their organizations have on-premises directories but don't currently use Azure AD. When using modern deployment methods, setting up directory integration prior to deployment significantly simplifies the deployment process, and day-to-day management of your environment.