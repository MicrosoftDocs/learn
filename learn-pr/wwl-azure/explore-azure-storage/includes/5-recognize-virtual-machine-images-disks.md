



Microsoft Azure offers multiple ways to deploy VM-based solutions. One of the primary considerations is the approach to installing the operating system and the associated SAP workloads. In general, there are three options to choose from:

## Azure Marketplace images

This approach involves deploying VMs based on Microsoft or third-party provided VM images from the Azure Marketplace. After you deploy your VM in Azure, you follow the same guidelines and tools to install the SAP software and/or DBMS inside your VM as you would do in an on-premises environment. The installation can be performed manually or in an automated manner, by using configuration management tools, such as PowerShell DSC, Custom Script, Ansible, Puppet, or Chef (most of which are available in the form of Azure VM Extensions).

### Use a SQL Server image out of the Microsoft Azure Marketplace

Microsoft offers VMs in the Azure Marketplace, which already contain versions of SQL Server. For SAP customers who require licenses for SQL Server and Windows, using these images might be an opportunity to cover the need for licenses by deploying Windows VMs with SQL Server already installed. In order to use such images for SAP, the following provisions need to be accounted for:

- The SQL Server non-Evaluation versions acquire higher costs than a 'Windows-only' VM deployed from Azure Marketplace. To compare prices, see [Windows Virtual Machines Pricing](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) and [SQL Server Enterprise Virtual Machines Pricing](https://azure.microsoft.com/pricing/details/virtual-machines/sql-server-enterprise/)
- You only can use SQL Server releases, which are supported by SAP.
- The collation of the SQL Server instance, which is installed in the VMs offered in the Azure Marketplace is not the collation SAP NetWeaver requires the SQL Server instance to run. You can change the collation though by using the following procedure:

### Change the SQL Server collation of a Microsoft Windows/SQL Server VM

Since the SQL Server images in the Azure Marketplace are not set up to use the collation, which is required by SAP NetWeaver applications, it needs to be changed immediately after the deployment. For SQL Server, this change of collation can be done by running the following command as soon as the VM has been deployed and an administrator can log into the deployed VM:

```
Setup.exe /QUIET /ACTION=REBUILDDATABASE /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS=[local admin account name] /SQLCOLLATION=SQL_Latin1_General_Cp850_BIN2
```

The process should only take a few minutes. In order to make sure whether the step ended up with the correct result, you can run the sp\_helpsort stored procedure in the SQL Server primary database. The desired output should be Latin1-General, binary code point comparison sort for Unicode Data, SQL Server Sort Order 40 on Code Page 850 for non-Unicode Data.

If the result is different, STOP deploying SAP and investigate why the setup command did not work as expected. Deployment of SAP NetWeaver applications onto SQL Server instance with different SQL Server codepages than the one mentioned above is NOT supported.

## Custom images

This approach involves deploying VMs based on customer-specific images, in cases where Azure Marketplace images might not fit your needs. The process of preparing such images is operating system–specific. For details, refer to :

- Windows: [Upload a generalized VHD and use it to create new VMs in Azure](/azure/virtual-machines/windows/upload-generalized-managed)
- Linux:

  - SUSE: [Prepare a SLES or openSUSE Leap virtual machine for Azure](/azure/virtual-machines/linux/suse-create-upload-vhd)
  - Red Hat: [Prepare a Red Hat-based virtual machine for Azure](/azure/virtual-machines/linux/redhat-create-upload-vhd)
  - Oracle Linux: [Prepare an Oracle Linux virtual machine for Azure](/azure/virtual-machines/linux/oracle-create-upload-vhd)

If you have already installed SAP content in your on-premises VM (especially for 2-Tier systems), you can adapt the SAP system settings after the deployment of the Azure VM through the instance rename procedure supported by the SAP Software Provisioning Manager ([SAP Note \#1619720](https://aka.ms/az-120-sapnote-1619720) ).

Note that in this case, you also have the option of installing and configuring SAP workloads manually or in an automated manner, by using the same configuration management tools listed earlier.

## Custom disks

This approach involves uploading a VM from on-premises to Azure with a non-generalized disk, allowing you to move a specific SAP system from on-premises to Azure. The VHDs you upload should contain the OS, the SAP binaries, and DBMS binaries plus the data and log files of the DBMS. In contrast to the second approach, you keep the same hostname, SAP SID, and SAP user accounts.
