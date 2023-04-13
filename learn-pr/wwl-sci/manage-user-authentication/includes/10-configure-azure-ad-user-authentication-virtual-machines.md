Organizations can now improve the security of Windows and Linux virtual machines (VMs) in Azure by integrating with Azure Active Directory (AD) authentication. You can now use Azure AD as a core authentication platform to connect to:

 -  Windows Server 2019 Datacenter edition and later.
 -  Windows 10 1809 and later.
 -  Windows 11.
 -  Linux virtual machine.

You can then centrally control and enforce role-based-access and Conditional Access policies that allow or deny access to the VMs.

### Benefits

 -  Use Azure AD credentials to sign into Windows VMs in Azure.
 -  Reduce reliance on local administrator accounts.
 -  Password complexity and password lifetime policies configured for your Azure AD.
 -  Configure Conditional Access policies to require multifactor authentication and other signals such as risky-user or sign-in risk.

### Configure Azure AD sign-in for Windows VMs

To use Azure AD sign-in for Windows VM in Azure, you must:

 -  First enable the Azure AD sign-in option for your Windows VM.
 -  Then configure Azure role assignments for users who are authorized to sign into the VM.

:::image type="content" source="../media/azure-authentication-windows-machine-07ba6c3c.png" alt-text="Screenshot of create or configure Windows virtual machine dialog.  The checkbox for \`Login with Azure A D\` is selected.":::


### Configure Azure AD sign-in for Linux VMs

You can enable Azure AD sign-in for any of the supported Linux distributions mentioned using the Azure portal. As an example, to create an Ubuntu Server 18.04 Long Term Support (LTS) VM in Azure with Azure AD authentication:

1.  Sign into the Azure portal, with an account that has access to create VMs, and select + Create a resource.
2.  Select **Create** under Ubuntu Server 18.04 LTS in the Popular view.
3.  On the Management tab, Check the box to enable `Login with Azure Active Directory (Preview)`.
4.  Ensure System assigned managed identity is checked.
5.  Complete the Linux virtual machine setup.
