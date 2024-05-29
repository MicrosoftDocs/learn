Azure Virtual Desktop service recommends FSLogix profile containers as a user profile solution. FSLogix is designed to roam profiles in remote computing environments, such as Azure Virtual Desktop. It stores a complete user profile in a single container. At sign-in, this container is dynamically attached to the computing environment using natively supported Virtual Hard Disk (VHD) and Hyper-V Virtual Hard disk (VHDX).

The VHD or VHDX files are stored to this location and attached to users the next time they sign in.

The following diagram shows the process of getting the user profile after sign-in to the Remote Desktop client.

:::image type="content" source="../media/fslogix-drives-user-profiles-2-083667f2.png" alt-text="Diagram of process for users to sign in with profiles and disks.":::


1.  User signs into the Remote Desktop client
2.  User gets assigned to a session host virtual machine (VM)
3.  VM gets the user profile from the Azure file share.
4.  (Preview) If you have MSIX app attach configured, apps are dynamically delivered to the session host VM. MSIX app attach uses FSLogix storage concepts, but for applications.
5.  User gets their Azure Virtual Desktop workspace populated with their assigned app(s) or session desktop.

The user profile is immediately available and appears in the system exactly like a native user profile.

## User profiles

A user profile contains data elements including desktop settings, persistent network connections, and application settings. By default, Windows creates a local user profile that is tightly integrated with the operating system.

:::image type="content" source="../media/fslogix-drives-user-profiles-f53f1b9d.png" alt-text="Diagram of users signed in with profiles and disks.":::


A remote user profile provides a partition between user data and the operating system. It allows the operating system to be replaced or changed without affecting the user data. In Remote Desktop Session Host (RDSH) and Virtual Desktop Infrastructures (VDI), the operating system may be replaced for the following reasons:

 -  An upgrade of the operating system
 -  A replacement of an existing Virtual Machine (VM)
 -  A user being part of a pooled (non-persistent) RDSH or VDI environment

Microsoft products operate with several technologies for remote user profiles, including these technologies:

 -  Roaming user profiles (RUP)
 -  User profile disks (UPD)
 -  Enterprise state roaming (ESR)

UPD and RUP are the most widely used technologies for user profiles in Remote Desktop Session Host (RDSH) and Virtual Hard Disk (VHD) environments.

## FSLogix profile containers

FSLogix addresses many profile container challenges. Key among them are:

 -  **Performance**: The FSLogix profile containers are high performance and resolve performance issues that have historically blocked cached exchange mode.
 -  **OneDrive**: Without FSLogix profile containers, OneDrive for Business is not supported in non-persistent RDSH or VDI environments.
 -  **Additional folders**: FSLogix provides the ability to extend user profiles to include additional folders.

Microsoft has started replacing existing user profile solutions, like UPD, with FSLogix profile containers.

<a name='azure-files-integration-with-azure-active-directory-domain-service'></a>

## Azure Files integration with Microsoft Entra Domain Service

Microsoft Azure Files recently announced the general availability of [Azure Files authentication with Microsoft Entra Domain Service (AD DS)](/azure/storage/files/storage-files-active-directory-overview).
