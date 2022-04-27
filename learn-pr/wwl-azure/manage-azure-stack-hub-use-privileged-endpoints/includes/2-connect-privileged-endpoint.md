Most day-to-day management tasks use the administrator portal, PowerShell, or Azure Resource Manager APIs. However, for some less common operations, you need to use the *privileged endpoint* (PEP). The PEP is a pre-configured remote PowerShell console that provides you with enough capabilities to help you do a required task. The endpoint uses PowerShell JEA (Just Enough Administration) to expose only a restricted set of cmdlets. To access the PEP and invoke the restricted set of cmdlets, a low-privileged account is used. No admin accounts are required. For more security, scripting isn't allowed.

You can use the PEP to perform these tasks:

 -  Low-level tasks, such as collecting diagnostic logs.
 -  Many post-deployment datacenter integration tasks for integrated systems, such as adding DNS forwarders after deployment, setting up Microsoft Graph integration, AD FS integration, and certificate rotation.
 -  To work with support to obtain temporary, high-level access for in-depth troubleshooting of an integrated system.

The PEP logs every action (and its corresponding output) that you perform in the PowerShell session. The logs provide full transparency and complete auditing of operations. You can keep these log files for future audits.

You can also use the Operator Access Workstation (OAW) to access the privileged endpoint (PEP), the Administrator portal for support scenarios, and Azure Stack Hub GitHub Tools.

## Access the privileged endpoint

You access the PEP through a remote PowerShell session on the virtual machine that hosts the PEP. In the ASDK, this virtual machine is named AzS-ERCS01. If you're using an integrated system, there are three instances of the PEP, each running inside a virtual machine (*Prefix*\-ERCS01, *Prefix*\-ERCS02, or *Prefix*\-ERCS03) on different hosts for resiliency.

Before you begin this procedure for an integrated system, make sure you can access the PEP either by IP address or through DNS. After the initial deployment of Azure Stack Hub, you can access the PEP only by IP address because DNS integration isn't set up yet. Your OEM hardware vendor will provide you with a JSON file named **AzureStackStampDeploymentInfo** that contains the PEP IP addresses.

You may also find the IP address in the Azure Stack Hub administrator portal. Open the portal, for example, `https://adminportal.local.azurestack.external`. Select **Region Management &gt; Properties**.

You will need set your current culture setting to `en-US` when running the privileged endpoint, otherwise cmdlets such as `Test-AzureStack` or `Get-AzureStackLog` will not work as expected.

For security reasons, you connect to the PEP only from a hardened virtual machine running on top of the hardware lifecycle host, or from a dedicated and secure computer, such as a Privileged Access Workstation. The original configuration of the hardware lifecycle host must not be modified from its original configuration (including installing new software) or used to connect to the PEP.

On an integrated system, run the following command from an elevated Windows PowerShell session to add the PEP as a trusted host on the hardened virtual machine running on the hardware lifecycle host or the Privileged Access Workstation.

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '&lt;IP Address of Privileged Endpoint&gt;' -Concatenate<br>

```

On the hardened virtual machine running on the hardware lifecycle host or the Privileged Access Workstation, open a Windows PowerShell session. Run the following commands to establish a remote session on the virtual machine that hosts the PEP:

```
$cred = Get-Credential

$pep = New-PSSession -ComputerName <IP_address_of_ERCS> -ConfigurationName PrivilegedEndpoint -Credential $cred -SessionOption (New-PSSessionOption -Culture en-US -UICulture en-US)
Enter-PSSession $pep
```
