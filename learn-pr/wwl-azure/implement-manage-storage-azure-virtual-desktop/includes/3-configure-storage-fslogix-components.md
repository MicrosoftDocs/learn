The Azure Virtual Desktop service offers FSLogix profile containers as the recommended user profile solution. We don't recommend using the User Profile Disk (UPD) solution, which will be deprecated in future versions of Azure Virtual Desktop.

This unit explains how to set up a FSLogix profile container share for a host pool using a virtual machine-based file share.

## Create a new virtual machine that will act as a file share

When creating the virtual machine, be sure to place it on either the same virtual network as the host pool virtual machines or on a virtual network that has connectivity to the host pool virtual machines.

After creating the virtual machine, join it to the domain by doing the following things:

1.  Connect to the virtual machine with the credentials you provided when creating the virtual machine.
2.  On the virtual machine, launch **Control Panel** and select **System**.
3.  Select **Computer name**, select **Change settings**, and then select **Change…**
4.  Select **Domain** and then enter the Active Directory domain on the virtual network.
5.  Authenticate with a domain account that has privileges to domain-join machines.

## Prepare the virtual machine to act as a file share for user profiles

The following are general instructions about how to prepare a virtual machine to act as a file share for user profiles:

1.  Add the Azure Virtual Desktop Active Directory users to an Active Directory security group. This security group will be used to authenticate the Azure Virtual Desktop users to the file share virtual machine you created.
2.  Connect to the file share virtual machine.
3.  On the file share virtual machine, create a folder on the **C drive** that will be used as the profile share.
4.  Right-click the new folder, select **Properties**, select **Sharing**, then select **Advanced sharing...**.
5.  Select **Share this folder**, select **Permissions...**, then select **Add...**.
6.  Search for the security group to which you added the Azure Virtual Desktop users, then make sure that group has **Full Control**.
7.  After adding the security group, right-click the folder, select **Properties**, select **Sharing**, then copy down the **Network Path** to use for later.

## Configure the FSLogix profile container

To configure the virtual machines with the FSLogix software, do the following on each machine registered to the host pool:

1.  Connect to the virtual machine with the credentials you provided when creating the virtual machine.
2.  Launch an internet browser and navigate to this link to download the FSLogix agent.
3.  Navigate to either *\\Win32\\Release* or *\\X64\\Release* in the .zip file and run **FSLogixAppsSetup** to install the FSLogix agent.
4.  Navigate to **Program Files &gt; FSLogix &gt; Apps** to confirm the agent installed.
5.  From the start menu, run **RegEdit** as an administrator. Navigate to **Computer\\HKEY\_LOCAL\_MACHINE\\software\\FSLogix**.
6.  Create a key named **Profiles**.
7.  Create the following values for the Profiles key:

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Data/Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Enabled
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    VHDLocations
  :::column-end:::
  :::column:::
    Multi-String Value
  :::column-end:::
  :::column:::
    "Network path for file share"
  :::column-end:::
:::row-end:::
