You have a choice of operating systems (OS) that you can use for session hosts to provide desktops and applications. You can use different operating systems with different host pools to provide flexibility to your users. We support the 64-bit operating systems and SKUs in the following table lists (where supported versions and dates are inline with the [Microsoft Lifecycle Policy](/lifecycle/)), along with the licensing methods applicable for each commercial purpose:

| Operating system (64-bit only)                                                                                                                                                                                                                                                                                                                                                                                                                                           | Licensing method<br>(Internal commercial purposes)                                                                                           | Licensing method<br>(External commercial purposes)                                                                                                                                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Windows 11 Enterprise multi-session](/lifecycle/products/windows-11-enterprise-and-education)[Windows 11 Enterprise](/lifecycle/products/windows-11-enterprise-and-education)[Windows 10 Enterprise multi-session](/lifecycle/products/windows-10-enterprise-and-education)[Windows 10 Enterprise](/lifecycle/products/windows-10-enterprise-and-education) | Microsoft 365 E3, E5, A3, A5, F3, Business Premium, Student Use BenefitWindows Enterprise E3, E5Windows Education A3, A5Windows VDA per user | [Per-user access pricing](/azure/virtual-desktop/licensing#per-user-access-pricing-for-external-commercial-purposes-to-use-azure-virtual-desktop) by enrolling an Azure subscription.                                                                               |
| [Windows Server 2022](/lifecycle/products/windows-server-2022)[Windows Server 2019](/lifecycle/products/windows-server-2019)[Windows Server 2016](/lifecycle/products/windows-server-2016)                                                                                                                                                                                              | Remote Desktop Services (RDS) Client Access License (CAL) with Software Assurance (per-user or per-device)RDS User Subscription Licenses.    | Windows Server 2022 RDS Subscriber Access License (SAL).<br>[Per-user access pricing](/azure/virtual-desktop/licensing#per-user-access-pricing-for-external-commercial-purposes-to-use-azure-virtual-desktop) isn't available for Windows Server operating systems. |

To learn more about licenses you can use, including per-user access pricing, see [Licensing Azure Virtual Desktop](/azure/virtual-desktop/licensing).

 -  The following items aren't supported:
    
    
     -  32-bit operating systems.
     -  N, KN, LTSC, and other editions of Windows operating systems not listed in the previous table.
     -  [Ultra disks](/azure/virtual-machines/disks-types#ultra-disks) for the OS disk type.
     -  [Ephemeral OS disks for Azure VMs](/azure/virtual-machines/ephemeral-os-disks).
     -  [Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview).
 -  Support for Windows 7 ended on January 10, 2023.
 -  Support for Windows Server 2012 R2 ended on October 10, 2023.

For Azure, you can use operating system images provided by Microsoft in the [Azure Marketplace](https://azuremarketplace.microsoft.com/), or create your own custom images stored in an Azure Compute Gallery or as a managed image. Using custom image templates for Azure Virtual Desktop enables you to easily create a custom image that you can use when deploying session host virtual machines (VMs). To learn more about how to create custom images, see:

 -  [Custom image templates in Azure Virtual Desktop](/azure/virtual-desktop/custom-image-templates)
 -  [Store and share images in an Azure Compute Gallery](/azure/virtual-machines/shared-image-galleries).
 -  [Create a managed image of a generalized VM in Azure](/azure/virtual-machines/windows/capture-image-resource).

Alternatively, for Azure Stack HCI you can use operating system images from:

 -  Azure Marketplace. For more information, see [Create Azure Stack HCI VM image using Azure Marketplace images](/azure-stack/hci/manage/virtual-machine-image-azure-marketplace).
 -  Azure Storage account. For more information, see [Create Azure Stack HCI VM image using image in Azure Storage account](/azure-stack/hci/manage/virtual-machine-image-storage-account).
 -  A local share. For more information, see[Create Azure Stack HCI VM image using images in a local share](/azure-stack/hci/manage/virtual-machine-image-local-share).

You can deploy a virtual machines (VMs) to be used as session hosts from these images with any of the following methods:

 -  Automatically, as part of the [host pool setup process](/azure/virtual-desktop/create-host-pool?tabs=portal) in the Azure portal.
 -  Manually by [adding session hosts to an existing host pool](/azure/virtual-desktop/add-session-hosts-host-pool?tabs=portal,gui) in the Azure portal.
 -  Programmatically, with [Azure CLI](/azure/virtual-desktop/add-session-hosts-host-pool?tabs=cli,cmd) or [Azure PowerShell](/azure/virtual-desktop/add-session-hosts-host-pool?tabs=powershell,cmd).

If your license entitles you to use Azure Virtual Desktop, you don't need to install or apply a separate license, however if you're using per-user access pricing for external users, you need to [enroll an Azure Subscription](/azure/virtual-desktop/remote-app-streaming/per-user-access-pricing). You need to make sure the Windows license used on your session hosts is correctly assigned in Azure and the operating system is activated. For more information, see [Apply Windows license to session host virtual machines](/azure/virtual-desktop/apply-windows-license).

For session hosts on Azure Stack HCI, you must license and activate the virtual machines you use before you use them with Azure Virtual Desktop. For activating Windows 10 and Windows 11 Enterprise multi-session, and Windows Server 2022 Datacenter: Azure Edition, use [Azure verification for VMs](/azure-stack/hci/deploy/azure-verification). For all other OS images (such as Windows 10 and Windows 11 Enterprise, and other editions of Windows Server), you should continue to use existing activation methods. For more information, see [Activate Windows Server VMs on Azure Stack HCI](/azure-stack/hci/manage/vm-activate).

> [!NOTE]
> To ensure continued functionality with the latest security update, update your VMs on Azure Stack HCI to the latest cumulative update by June 17, 2024. This update is essential for VMs to continue using Azure benefits. For more information, see [Azure verification for VMs](/azure-stack/hci/deploy/azure-verification?tabs=wac#benefits-available-on-azure-stack-hci).

## Azure regions

You can deploy host pools, workspaces, and application groups in the following Azure regions. This list of regions is where the *metadata* for the host pool can be stored. Session hosts for the user sessions can be located in any Azure region, and on-premises when using [Azure Virtual Desktop on Azure Stack HCI](/azure/virtual-desktop/azure-stack-hci-overview), enabling you to deploy compute resources close to your users. For more information about the types of data and locations, see [Data locations for Azure Virtual Desktop](/azure/virtual-desktop/data-locations).

 -  Australia East
 -  Canada Central
 -  Canada East
 -  Central India
 -  Central US
 -  East US
 -  East US 2
 -  Japan East
 -  North Central US
 -  North Europe
 -  South Central US
 -  UK South
 -  UK West
 -  West Central US
 -  West Europe
 -  West US
 -  West US 2
 -  West US 3

Azure Virtual Desktop is also available in sovereign clouds, such as [Azure for US Government](https://azure.microsoft.com/explore/global-infrastructure/government/) and [Azure operated by 21Vianet](https://docs.azure.cn/virtual-desktop/) in China.
