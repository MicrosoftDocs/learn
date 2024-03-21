The Extended Security Update (ESU) program is a last resort option for customers who need to run certain legacy Microsoft products past the end of support. Azure virtual machines. Virtual machines (VMs) hosted in Azure or on Azure Stack HCI running versions of Windows Server where ESUs are available are automatically enabled for ESUs. If your servers are on-premises or in a hosted environment, you can enroll your Windows Server 2012 and 2012 R2 or SQL Server 2012 machines for Extended Security Updates via the Azure portal, connect through Azure Arc, and you'll be billed monthly via your Azure subscription. If you can't connect using Azure Arc, use Extended Security Updates on non-Azure VMs, by using a special Multiple Activation Key (MAK) and applying it to the relevant servers. This special MAK key lets the Windows Update servers know that you can continue to receive security updates.

## Additional resources

The following resources provide more information on topics in this module or related to this module.

- [License provisioning guidelines for Extended Security Updates for Windows Server 2012](/azure/azure-arc/servers/license-extended-security-updates)
- [Deliver Extended Security Updates for Windows Server 2012](/azure/azure-arc/servers/deliver-extended-security-updates)
