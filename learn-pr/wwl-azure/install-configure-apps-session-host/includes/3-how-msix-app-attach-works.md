MSIX app attach stores application files in a separate virtual hard disk from the operating system. It registers the regular MSIX package on a device instead of on a physical download and installation. The registration uses existing Windows APIs and has minimal impact on user sign-in times, which enhances the user experience.

When you open MSIX app attach, the application files are accessed from a Virtual hard disk. (VHD). You're not even aware that the application isn't locally installed.

:::image type="content" source="../media/app-attach-c71d9d6a.png" alt-text="Diagram that shows the overview of the MSIX app attach process.":::


MSIX app attach follows several steps or actions:

| **Term**             | **Definition**                                                                                                                                                                        |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Stage                | MSIX app attach notifies the operating system that an application is available, and that the virtual disk that contains the MSIX package (also known as the MSIX image) is available. |
| Registration         | MSIX app attach uses a per-user process to make the application available to you.                                                                                                     |
| Delayed registration | Complete registration of the application is delayed until you decide to run the application.                                                                                          |
| Deregistration       | The application is no longer available to you after you sign out.                                                                                                                     |
| Destage              | The application is no longer available from the virtual machine after shutdown or restart of the machine.                                                                             |

After you open MSIX app attach, you experience the following process:

1.  From the Azure Virtual Desktop client, you sign in and select the host pool for which you have access. The process is similar to opening published RemoteApp programs from the Azure Virtual Desktop environment.
2.  You're assigned a virtual machine within the host pool, on which a RemoteApp or Remote Desktop session is created. The Azure Virtual Desktop client interacts with that session.
3.  If the user profile is configured, the FSLogix agent on the session host provides the user profile from the file share. The file share can be Azure Files, Azure NetApp Files, or an infrastructure as a service (IaaS) file server.
4.  Applications that are assigned to you are read from Azure Virtual Desktop.
5.  MSIX app attach applications are registered to the virtual machine for you, from the attached MSIX virtual disk. That virtual disk might be on an IaaS file share, Azure Files, or Azure NetApp Files.

:::image type="content" source="../media/how-msix-app-attach-work-8b5ff719.png" alt-text="Diagram that shows how app attach applications are registered to the virtual machine.":::


Use the following key terms for MSIX app attach as a review and reference.

| **Feature**          | **Traditional app layering**                                                           | **MSIX app attach**                                                                                                                                                                   |
| -------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Format               | Different-app layering technologies require different proprietary formats.             | Works with the native MSIX packaging format.                                                                                                                                          |
| Repackaging overhead | Proprietary formats require sequencing and repackaging per update.                     | Apps published as MSIX don't require repackaging. However, if the MSIX package isn't available, repackaging overhead still applies.                                                   |
| Ecosystem            | N/A (for example, vendors don't ship App-V)                                            | MSIX is Microsoft's mainstream technology that key ISV partners and in-house apps like Office are adopting. You can use MSIX on both virtual desktops and physical Windows computers. |
| Infrastructure       | Additional infrastructure required (servers, clients, and so on)                       | Storage only                                                                                                                                                                          |
| Administration       | Requires maintenance and update                                                        | Simplifies app updates                                                                                                                                                                |
| User experience      | Impacts user sign-in time. Boundary exists between OS state, app state, and user data. | Delivered apps are indistinguishable from locally installed applications.                                                                                                             |
