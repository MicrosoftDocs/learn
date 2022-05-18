This unit answers some frequently asked questions about Marketplace items in the Azure Stack Hub Marketplace.

## Marketplace items

### Who should I contact for support issues with Azure Stack Hub Marketplace items?

Azure Marketplace support guidance extends to Azure Stack Hub Marketplace items as well. Publishers are responsible for providing technical support for their products on the Azure Stack Hub Marketplace. To learn more about support guidance for Azure Marketplace items, see the [support section in the Azure Marketplace FAQs topic.](/azure/marketplace/marketplace-faq-publisher-guide#customer-support)

### How do I update to a newer Windows image?

First, determine if any Azure Resource Manager templates refer to specific versions. If so, update those templates, or keep older image versions. It's best to use version: latest.

Next, if any virtual machine scale sets refer to a specific version, you should think about whether these will be scaled later, and decide whether to keep older versions. If neither of these conditions apply, delete older images in Azure Stack Hub Marketplace before downloading newer ones. Use Marketplace management to delete them if that's how the original was downloaded. Then download the newer version.

### What are the licensing options for Windows Server images on Azure Stack Hub Marketplace?

Microsoft offers two versions of Windows Server images through Azure Stack Hub Marketplace. Only one version of this image can be used in an Azure Stack Hub environment.

 -  **Pay as you go (PAYG)**: These images run the full-price Windows meters. Who should use this option? Enterprise Agreement (EA) customers who use the Consumption billing model; CSPs who don't want to use SPLA licensing.
 -  **Bring Your Own License (BYOL)**: These images run basic meters. Who should use this option? EA customers with a Windows Server license; CSPs who use SPLA licensing.

Azure Hybrid Use Benefit (AHUB) is not supported on Azure Stack Hub. Customers who license through the "Capacity" model must use the BYOL image. If you're testing with the Azure Stack Development Kit (ASDK), you can use either of these options.

### What if I downloaded the wrong version to offer my tenants/users?

Delete the incorrect version first through marketplace management. Wait for it to complete (look at the notifications for completion, not the **Marketplace Management** blade). Then download the correct version.

If you download both versions of the image, only the latest version is visible to end customers in Azure Stack Hub Marketplace.

### What if my user incorrectly checked the "I have a license" box in previous Windows builds, and they don't have a license?

You can change the license model attribute to switch from BYOL to the PAYG model by running the following script:

```
$vm= Get-Azvm -ResourceGroup "<your RG>" -Name "<your VM>"
$vm.LicenseType = "None"
Update-AzVM -ResourceGroupName "<your RG>" -VM $vm

```

You can check the license type of your virtual machine by running the following command. If the license model says **Windows\_Server**, you'll be charged for the BYOL price. Otherwise, you'll be charged for the Windows meter per the PAYG model:

$vm \| ft Name, VmId,LicenseType,ProvisioningState

### What if I have an older image and my user forgot to check the "I have a license" box, or we use our own images and we do have Enterprise Agreement entitlement?

You can change the license model attribute to the BYOL model by running the following commands:

```
$vm= Get-Azvm -ResourceGroup "<your RG>" -Name "<your VM>"
$vm.LicenseType = "Windows_Server"
Update-AzVM -ResourceGroupName "<your RG>" -VM $vm

```

### I have an Enterprise Agreement (EA) and will be using my EA Windows Server license; how do I make sure images are billed correctly?

You can add **licenseType: Windows\_Server** in an Azure Resource Manager template. This setting must be added to each virtual machine resource block.

### Activation

To activate a Windows Server virtual machine on Azure Stack Hub, the following conditions must be true:

 -  The OEM has set the appropriate BIOS marker on every host system in Azure Stack Hub.
 -  Windows Server 2012 R2 and Windows Server 2016 must use [Automatic virtual machine Activation](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn303421%28v=ws.11%29). Key Management Service (KMS) and other activation services aren't supported on Azure Stack Hub.

### How can I verify that my virtual machine is activated?

Run the following command from an elevated command prompt:

`slmgr /dlv`

If it's correctly activated, it will be clearly indicated and the host name displayed in the `slmgr` output. Don't depend on watermarks on the display as they might not be up to date, or are showing from a different virtual machine behind yours.
