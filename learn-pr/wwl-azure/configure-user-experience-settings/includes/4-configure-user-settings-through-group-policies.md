There are opportunities for you to refine the Windows 10 operating system specifically for your Azure Virtual Desktop environment.

> [!NOTE]
> Some recommendations might disable functionality that you would prefer to use, so you should consider the cost versus the benefit of adjusting any setting.

## Creating the Windows 10 image

The first step is to install a reference image of Windows 10 on either a physical or virtual machine. Installing to a virtual machine is easy and allows you to save versions of the virtual hard-disk (VHD) file, in case you want to roll back to an earlier version.

During installation, you can choose either **Express Settings** or **Customize**. The settings offered during the **Customize** option are adjustable by using Group Policy, so the method of installing the base OS is not that important.

## Group Policy settings

To edit Group Policy settings, press the Windows button and type *group policy* or *gpedit.msc*. In the results that return, click **Edit group policy** to open Local Group Policy Editor.

Below is an example of configuring Group Policy settings for the Network.

1.  Under **Computer Configuration**, select **Windows Settings**, and select **Security Settings**.
2.  Click **Network List Manager Policies**, and then choose **All Networks**.
3.  In **Network location** area, select **User cannot change location**.
4.  Click **OK**.

:::image type="content" source="../media/all-networks-group-policy-azure-virtual-desktop-185c7d69.png" alt-text="Screenshot of Group Policy Edit.":::


Collapse **Windows Settings**, and then expand **Administrative Templates**. Click or expand **Network**, and then adjust each setting as follows by double-clicking it, then selecting the radio button for the indicated value and clicking the **OK** button:

:::row:::
  :::column:::
    **Setting area**
  :::column-end:::
  :::column:::
    **Setting**
  :::column-end:::
  :::column:::
    **Recommended value for VDI use**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Background Intelligent Transfer Service (BITS)
  :::column-end:::
  :::column:::
    Do not allow the BITS client to use Windows Branch Cache.Do not allow the computer to act as a BITS Peer caching client.Do not allow the computer to act as a BITS Peer caching server.
  :::column-end:::
  :::column:::
    Enabled
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    BranchCache
  :::column-end:::
  :::column:::
    Turn on BranchCache.
  :::column-end:::
  :::column:::
    Disabled
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Hotspot Authentication
  :::column-end:::
  :::column:::
    Enable Hotspot Authentication.
  :::column-end:::
  :::column:::
    Disabled
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Peer-to-Peer Networking Services
  :::column-end:::
  :::column:::
    Turn off Microsoft Peer-to-Peer Networking Services.
  :::column-end:::
  :::column:::
    Enabled
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Offline Files
  :::column-end:::
  :::column:::
    Allow or Disallow use of the Offline Files feature.
  :::column-end:::
  :::column:::
    Disabled
  :::column-end:::
:::row-end:::
