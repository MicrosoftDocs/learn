MSIX app attach stores application files in a separate virtual hard disk from the operating system. It registers the regular MSIX package on a device instead of on a physical download and installation. The registration uses existing Windows APIs and has minimal impact on user sign-in times, which enhances the user experience.

When you open MSIX app attach, the application files are accessed from a Virtual hard disk. (VHD). You're not even aware that the application isn't locally installed.

:::image type="content" source="../media/app-attach-c71d9d6a.png" alt-text="An overview of the MSIX app attach process.":::


MSIX app attach follows several steps or actions:

:::row:::
  :::column:::
    **Term**
  :::column-end:::
  :::column:::
    **Definition**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Stage
  :::column-end:::
  :::column:::
    MSIX app attach notifies the operating system that an application is available, and that the virtual disk that contains the MSIX package (also known as the MSIX image) is available.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Registration
  :::column-end:::
  :::column:::
    MSIX app attach uses a per-user process to make the application available to you.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delayed registration
  :::column-end:::
  :::column:::
    Complete registration of the application is delayed until you decide to run the application.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deregistration
  :::column-end:::
  :::column:::
    The application is no longer available to you after you sign out.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Destage
  :::column-end:::
  :::column:::
    The application is no longer available from the virtual machine after shutdown or restart of the machine.
  :::column-end:::
:::row-end:::


After you open MSIX app attach, you experience the following process:

1.  From the Azure Virtual Desktop client, you sign in and select the host pool for which you have access. The process is similar to opening published RemoteApp programs from the Azure Virtual Desktop environment.
2.  You're assigned a virtual machine within the host pool, on which a RemoteApp or Remote Desktop session is created. The Azure Virtual Desktop client interacts with that session.
3.  If the user profile is configured, the FSLogix agent on the session host provides the user profile from the file share. The file share can be Azure Files, Azure NetApp Files, or an infrastructure as a service (IaaS) file server.
4.  Applications that are assigned to you are read from Azure Virtual Desktop.
5.  MSIX app attach applications are registered to the virtual machine for you, from the attached MSIX virtual disk. That virtual disk might be on an IaaS file share, Azure Files, or Azure NetApp Files.

:::image type="content" source="../media/how-msix-app-attach-work-8b5ff719.png" alt-text="Diagram of MSIX app attach applications are registered to the virtual machine.":::


Use the following key terms for MSIX app attach as a review and reference.

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Traditional app layering**
  :::column-end:::
  :::column:::
    **MSIX app attach**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Format
  :::column-end:::
  :::column:::
    Different-app layering technologies require different proprietary formats.
  :::column-end:::
  :::column:::
    Works with the native MSIX packaging format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Repackaging overhead
  :::column-end:::
  :::column:::
    Proprietary formats require sequencing and repackaging per update.
  :::column-end:::
  :::column:::
    Apps published as MSIX don't require repackaging. However, if the MSIX package isn't available, repackaging overhead still applies.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Ecosystem
  :::column-end:::
  :::column:::
    N/A (for example, vendors don't ship App-V)
  :::column-end:::
  :::column:::
    MSIX is Microsoft's mainstream technology that key ISV partners and in-house apps like Office are adopting. You can use MSIX on both virtual desktops and physical Windows computers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Infrastructure
  :::column-end:::
  :::column:::
    Additional infrastructure required (servers, clients, and so on)
  :::column-end:::
  :::column:::
    Storage only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Administration
  :::column-end:::
  :::column:::
    Requires maintenance and update
  :::column-end:::
  :::column:::
    Simplifies app updates
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    User experience
  :::column-end:::
  :::column:::
    Impacts user sign-in time. Boundary exists between OS state, app state, and user data.
  :::column-end:::
  :::column:::
    Delivered apps are indistinguishable from locally installed applications.
  :::column-end:::
:::row-end:::
