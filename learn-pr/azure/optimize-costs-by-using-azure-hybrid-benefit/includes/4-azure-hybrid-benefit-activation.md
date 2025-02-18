### Enabling Azure Hybrid Benefit for Windows VMs in Azure

One way to activate Azure Hybrid Benefit for a Windows Server VM is during VM creation, to select the checkbox under Licensing as in the following screenshot.

:::image type="content" source="../media/activate-azure-hybrid-benefit-for-windows-server-vm.png" alt-text="Screenshot of the Licensing confirmation box, which explains that you can save up to 49 percent by using an existing Windows Server license, and provides a link to Review your Azure Hybrid Benefit compliance." border="false":::

If you apply Azure Hybrid Benefit to your Windows Server VMs, verify the number of eligible licenses and the Software Assurance (or subscription) coverage period before you activate this benefit. Use the preceding guidelines to ensure you deploy the correct number of Windows Server VMs with this benefit.

If you already have Windows Server VMs running with Azure Hybrid Benefit, perform an inventory to determine how many units you're running, then verify this number against your Software Assurance or subscription licenses. You can contact your Microsoft licensing specialist to validate your Software Assurance licensing information.

You can use Windows VMs with Azure Hybrid Benefit using one of the following methods:

- Deploy VMs from one of the provided Windows Server images on Azure Marketplace.

- Upload a custom VM and deploy it using a Resource Manager template or Azure PowerShell.

- Toggle and convert an existing VM between running with Azure Hybrid Benefit or pay on-demand cost for Windows Server.

- Apply Azure Hybrid Benefit for Windows Server on Azure Virtual Machine Scale Sets.

Azure Hybrid Benefit for Windows Server supports all Windows Server OS-based images. You can use Azure platform support images or upload your own custom Windows Server images. If you have an existing VM that you want to convert to utilize Azure Hybrid Benefit for Windows Server, you can update your VM's license type.

> [!NOTE]
> Changing the license type on a VM does not cause the system to reboot or result in a service interruption. It simply updates a metadata flag.

To update the VM to use Azure Hybrid Benefit, from the Azure portal VM menu, select the **Configuration** option, and then toggle the **Azure Hybrid Benefit** option.

After you've deployed your VM through either PowerShell, Resource Manager template, or Azure portal, you can verify the setting using different methods. For example, from the Azure portal VM menu you can select the **Operating system** tab and then review the toggle for Azure Hybrid Benefit for Windows Server.

To review and count all VMs and Virtual Machine Scale Sets deployed with Azure Hybrid Benefit for Windows Server, you can run the following command from your subscription:

    Get-AzVM | ?{$_.LicenseType -like "Windows_Server"} | select ResourceGroupName, Name, LicenseType

In the Azure portal, from the Virtual Machine blade or Virtual machine Scale Sets Resource blade, you can review a list of all your VM(s) and licensing types by configuring the table column to include **OS licensing benefit**. The VM setting can either be in Azure Hybrid Benefit for Windows, Not enabled, or Windows client with multi-tenant hosting state.

For an interactive guide, refer to [Activate Azure Hybrid Benefit for Windows Server VMs](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmslearn.cloudguides.com%2Fguides%2FActivate%20Azure%20Hybrid%20Benefit%20for%20Windows%20Server%20VMs&data=05|02|mariajosef@microsoft.com|3640119bd39d42fedc6f08dce7dd5736|72f988bf86f141af91ab2d7cd011db47|1|0|638640185053099738|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|0|||&sdata=zcoBMxPygeXBYAgYtsrAhgssUqy%2BtFNVYFyRbxLOXLs%3D&reserved=0).

### Enabling Azure Hybrid Benefit for Linux VMs in Azure

You can invoke Azure Hybrid Benefit at the time of VM creation. Benefits of doing it at this time are threefold:

- You can provision both pay-as-you-go and BYOS VMs by using the same image and process.

- It enables future licensing mode changes.

- By default, the VM is connected to Red Hat Update Infrastructure (RHUI) to help keep it up to date and secure. You can change the updated mechanism after deployment at any time.

To enable Azure Hybrid Benefit when you create a VM, use the following procedure:

1. Go to the Azure portal.
1. Go to **Create a virtual machine**.

    :::image type="content" source="../media/create-vm-ahb-inline.png" alt-text="Screenshot of the Create a virtual machine dialog." lightbox="../media/create-vm-ahb-expanded.png" border="false":::

1. In the Licensing section, select the checkbox asking if you want to use an existing RHEL subscription, and the checkbox confirming that your subscription is eligible.

    :::image type="content" source="../media/create-vm-ahb-checkbox-inline.png" alt-text="Screenshot of the Licensing section." lightbox="../media/create-vm-ahb-checkbox-expanded.png" border="false":::

Next, create a VM using the following set of instructions.

1. In the navigation pane, select **Operating system**. Then, under **Licensing**, select the **Yes** option and the checkbox confirming you have an eligible Red Hat Enterprise Linux available for this VM.

    :::image type="content" source="../media/azure-hybrid-benefit-inline.png" alt-text="Screenshot of the Azure portal, configuration page, Licensing section for Azure Hybrid Benefit." lightbox="../media/azure-hybrid-benefit-expanded.png" border="false":::

> [!NOTE]
> The SUSE workflow is the same as the previously described method.

To enable Azure Hybrid Benefit on an existing VM:

1. From the Azure portal, open the VM page on which you want to apply the conversion.
1. Navigate to **Operating System** and then to **Licensing**.
1. To enable the Azure Hybrid Benefit conversion, select **Yes**, and then select the confirmation checkbox.

To switch the licensing model from BYOS to pay-as-you-go or the other way around, the Azure Hybrid Benefit extension must be installed on the VM. You can verify whether the agent is installed by using the Azure CLI or the Azure Instance Metadata Service.

You can use the **az vm get-instance-view** command to check whether the AHBForSLES or AHBForRHEL extension is installed. If the corresponding extension is installed and Azure Hybrid Benefit has been enabled, review the license type to determine which licensing model your VM is using.

For an interactive guide, refer to [Activate Azure Hybrid Benefit for Linux VMs](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmslearn.cloudguides.com%2Fguides%2FActivate%20Azure%20Hybrid%20Benefit%20for%20Linux&data=05|02|mariajosef@microsoft.com|3640119bd39d42fedc6f08dce7dd5736|72f988bf86f141af91ab2d7cd011db47|1|0|638640185053112443|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|0|||&sdata=CCsg9duogzC5EkF8U2SC%2FwLE7kcuQaO%2FTCtPIXgcqv0%3D&reserved=0).

### Enabling Azure Hybrid Benefit for SQL Server, SQL Database, and SQL Managed Instance

To indicate the use of Azure Hybrid Benefit for SQL Server on Azure VM and be compliant, you have three options:

- Provision a VM by using a BYOL SQL Server image from Azure Marketplace. This option is available only to customers who have an Enterprise Agreement.

- Provision a VM by using a pay-as-you-go SQL Server image from Azure Marketplace, and then activate the Azure Hybrid Benefit.

- Self-install SQL Server on Azure VM, manually register with the SQL IaaS Agent extension, and then activate Azure Hybrid Benefit.

You can configure the license type of SQL Server when you provision the VM, or anytime afterward. Switching between license models incurs no downtime, doesn't restart the VM or the SQL Server service, doesn't add any additional costs, and is effective immediately.

You can modify the license model directly from the portal:

1. Open the Azure portal and open the SQL VMs resource for your SQL Server VM.
1. Under Settings, select **Configure**.
1. Select the **Azure Hybrid Benefit** option, and then select the checkbox to confirm that you have a SQL Server license with Software Assurance.
1. On the **Configure** page, select **Apply**.

:::image type="content" source="../media/ahb-in-portal-inline.png" alt-text="Screenshot of the SQLVM-Configure page with Azure Hybrid Benefit selected for the SQL Server License type." lightbox="../media/ahb-in-portal-expanded.png "border="false":::

Azure Hybrid Benefit allows you to exchange your existing licenses for discounted rates on Azure SQL Database and Azure SQL Managed Instance. You can save up to 30 percent or more on SQL Database and SQL Managed Instance by using your Software Assurance–enabled SQL Server licenses on Azure. Changing to Azure Hybrid Benefit does not require any downtime.

You can choose or change your licensing model for Azure SQL Database using the Azure portal or an API of your choice. You can apply the Azure Hybrid licensing model only if you choose a vCore-based purchasing model and the provisioned compute tier for your Azure SQL Database.

> [!NOTE]
> Azure Hybrid Benefit isn't available for service tiers under the database transaction units (DTU)-based purchasing model or for the serverless compute tier.

To set or update the license type for SQL Database using the Azure portal, use one of the following methods:

- **For new databases**. During creation, on the **Basics** tab, select **Configure database**, and then select the option to **Save money**.

- **For existing databases**. In the **Settings** menu, select **Compute + storage**, and then select the option to **Save money**. (If you can’t find the **Save money** option in the Azure portal, verify that you selected a service tier using the vCore-based purchasing model and the provisioned compute tier.)

You can choose to change your licensing model for Azure SQL Managed Instance using either the Azure portal or the API of your choice.

To set or update the license type using the Azure portal:

- For new managed instances: During creation, on the **Basics** tab, select **Configure Managed Instance**, and then select the option for **Azure Hybrid Benefit**.

- For existing managed instances: In the **Settings** menu, select **Compute + storage**, and then select the option for **Azure Hybrid Benefit**.

For an interactive guide, refer to [Activate Azure Hybrid Benefit for SQL Server](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmslearn.cloudguides.com%2Fguides%2FActivate%20Azure%20Hybrid%20Benefit%20for%20SQL%20Server&data=05|02|mariajosef@microsoft.com|3640119bd39d42fedc6f08dce7dd5736|72f988bf86f141af91ab2d7cd011db47|1|0|638640185053124938|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|0|||&sdata=0SPrcYFCNurnCAW7cmV0Rn2ayJAEkpdKZTKIJIXJV6U%3D&reserved=0).
