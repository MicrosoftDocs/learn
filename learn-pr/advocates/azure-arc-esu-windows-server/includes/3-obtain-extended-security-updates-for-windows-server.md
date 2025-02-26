How you get ESUs depends on where your server is hosted. You can get access to ESUs through the following options:

- **Azure virtual machines**. Virtual machines (VMs) hosted in Azure or on Azure Stack HCI running versions of Windows Server where ESUs are available are automatically enabled for ESUs. These updates are provided free of charge, there's no need to deploy a Multiple Activation Key (MAK) or take any other action. Extended Security Updates are also free of charge in other Azure products such as Azure Dedicated Host, Azure VMware Solution, Azure Nutanix Solution, and Windows Server VMs hosted on Azure Stack (Hub, Edge, and HCI). Customers in these environments should contact Microsoft Support for assistance.

- **Azure Arc-enabled servers**. If your servers are on-premises or in a hosted environment, you can enroll your Windows Server 2012 and 2012 R2 or SQL Server 2012 machines for Extended Security Updates via the Azure portal, connect through Azure Arc, and you're billed monthly via your Azure subscription. You can also enroll programmatically at scale through Azure CLI, ARM APIs, or Azure Policy.

- **Non-Azure physical and virtual machines**. If you can't connect using Azure Arc, use Extended Security Updates on non-Azure VMs, by using a special Multiple Activation Key (MAK) and applying it to the relevant servers. This special MAK key lets the Windows Update servers know that you can continue to receive security updates.

## Enabling updates with Azure Arc

ESUs are automatically delivered to Azure Arc-enabled servers if they're connected and enrolled for ESUs through Azure Arc. You can enroll in ESUs at scale by using Azure Policy or Azure portal. Once enabled, you're billed monthly via your Azure subscription. When you use this method, there is no need to activate special product keys.

## Using Multiple Activation Key (MAK) for non Arc enabled servers

Customers who can't connect to Azure Arc to apply ESUs can use Multiple Activation Keys (MAK) through Microsoft 365 Admin Center. To do this, perform the following steps:

1. Sign in to the Microsoft 365 Admin Center.

1. Select **Your products** > **Volume licensing** > **View contracts**.

1. Select your agreement number used to purchase ESUs, the three dots beside it (More Actions icon), then select **View product keys**. All the product keys available to the agreement shown on this page.

1. Once you have your MAK, install the new key on your eligible servers using the `slmgr /ipk` command with the appropriate product key.

With some versions of Windows Server, you may need to install the Servicing stack update and Extended Security Updates (ESU) Licensing Preparation Package that are available from the Microsoft Download Center before they can be enabled for ESUs.

Activation occurs over the Internet. For computers that are unable to directly communicate with the Internet, you can activate ESUs using the Volume Activation Management Tool (VAMT) in conjunction with the VAMT ESU configuration file.

ESU updates can be delivered through Update Manager, Windows Server Update Services, Microsoft Updates, Microsoft Endpoint Configuration Manager or third party patch management solutions.

## Enabling updates with Azure Stack HCI

Windows Server 2012 and 2012 R2 Extended Security Updates are available at no additional charge on Azure Stack HCI. Windows Server 2012 and 2012 R2 servers running on Azure Stack HCI can be enrolled in Extended Security Updates using PowerShell by the following steps:

1. **Turn on legacy OS support for Azure VM verification.**

   Run the following command from an elevated PowerShell window on your Azure Stack HCI cluster:

   ```powershell
   Enable-AzStackHCIAttestation
   ```

   To add all the VMs in a setup, run the command:

    ```powershell
    Enable-AzStackHCIAttestation -AddVM
    ```

1. **Enable access for VMs.**

   To configure networking access for selected VMs, run the following command on your Azure Stack HCI cluster:

   ```powershell
   Add-AzStackHCIVMAttestation [-VMName]
   ```

   To add all the VMs in a setup, run the command:

   ```powershell
   Add-AzStackHCIVMAttestation -AddAll
   ```

   Alternatively, these Windows Server 2012 and 2012 R2 servers can be enrolled in free ESUs for Azure Stack HCI through Windows Admin Center.
