Host pools are a collection of one or more identical virtual machines (VMs) within Azure Virtual Desktop environments.

:::image type="content" source="../media/host-pools-environment-f131f8b0.png" alt-text="Diagram of host pools.":::


Each host pool can contain an app group that users can interact with as they would on a physical desktop.

:::image type="content" source="../media/host-pools-by-department-891fb540.png" alt-text="Diagram of host pools configured by department.":::


Users obtain access to host pools by being allocated to a host pool using an assigned Application Group:

 -  **Pooled**: You can configure a pooled host pool for several users to sign in and share a VM. Typically, none of those users would be a local administrator on the pooled VM. With pooled, you can use one of the recommended images that includes Windows 10 Enterprise multisession. This operating system is exclusive to Azure Virtual Desktop. You can also use your own custom image.

:::image type="content" source="../media/pooled-host-pool-348c0ead.png" alt-text="Diagram showing a pooled host pool where several users sign in.":::


 -  **Personal**: A personal host pool is where each user has their own dedicated VM. Those users would typically be local administrators for the VM. This enables the user to install or uninstall apps without impacting other users.

:::image type="content" source="../media/personal-desktop-f30e4036.png" alt-text="Diagram showing a personal host pool is where each user has their own dedicated VM.":::


Personal desktop solutions (sometimes called persistent desktops) allow users to always connect to the same specific session host. Users can typically modify their desktop experience to meet personal preferences, and save files in the desktop environment. Personal desktop solutions:

 -  Let users customize their desktop environment, including user-installed applications and saving files within the desktop environment.
 -  Allow assigning dedicated resources to a specific user, which can be helpful for some manufacturing or development use cases.

Pooled desktop solutions assign users to whichever session host is currently available, depending on the load-balancing algorithm. Because the users don't always return to the same session host each time they connect, they have limited ability to customize the desktop environment and don't usually have administrator access.
