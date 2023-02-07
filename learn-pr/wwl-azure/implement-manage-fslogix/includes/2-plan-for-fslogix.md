
The Azure Virtual Desktop service recommends FSLogix profile containers as a user profile solution. FSLogix is designed to roam profiles in remote computing environments, such as Azure Virtual Desktop. It stores a complete user profile in a single container.

At sign-in, this container is dynamically attached to the computing environment using natively supported Virtual Hard Disk (VHD) and Hyper-V Virtual Hard disk (VHDX). The user profile is immediately available and appears in the system exactly like a native user profile.

:::image type="content" source="../media/fslogix-concept-a2405e6b.png" alt-text="Diagram showing how a container dynamically attached to the computing environment using natively supported Virtual Hard Disk.":::


## User profiles

A user profile contains data elements about an individual, including configuration information like desktop settings, persistent network connections, and application settings. By default, Windows creates a local user profile that is tightly integrated with the operating system.

A remote user profile provides a partition between user data and the operating system. It allows the operating system to be replaced or changed without affecting the user data. In Remote Desktop Session Host (RDSH) and Virtual Desktop Infrastructures (VDI), the operating system may be replaced for the following reasons:

 -  An upgrade of the operating system
 -  A replacement of an existing Virtual Machine (VM)
 -  A user being part of a pooled (non-persistent) RDSH or VDI environment
