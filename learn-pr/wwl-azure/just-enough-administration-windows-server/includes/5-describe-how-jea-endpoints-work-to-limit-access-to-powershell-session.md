A JEA (Just Enough Administration) endpoint is a Windows PowerShell endpoint that is configured so only specific authenticated users can connect to it. Once connected, those users only have access predefined sets of Windows PowerShell cmdlets, parameters, and values, based on security group and role capability definitions.

Servers can have multiple JEA endpoints. Each JEA endpoint should be configured so it's used for a specific administrative task. For example, you might have a Domain Name System Operations (DNSOps) endpoint to perform DNS administrative tasks, and a DHCPOps endpoint to perform Dynamic Host Configuration Protocol (DHCP) administrative tasks.

With the JEA endpoints, your IT staff doesn't need to have privileged accounts that are members of groups such as the local Administrators group, to connect to an endpoint. Instead, users have the privileges assigned to the virtual account, which is configured in the session configuration file and could include the privileges of a local administrator or Domain Admin.

## Registering JEA on a single machine

On a single computer, you can create JEA endpoints by using the **Register-PSSessionConfiguration** cmdlet. When using this cmdlet, you specify an endpoint name and a session configuration file located on the local machine. However, prior to creating the JEA endpoint you must ensure that the following prerequisites are met:

You must have defined one or more roles, and the role capabilities file (or files)must be placed in the RoleCapabilities folder of a Windows PowerShell module.

- You have created a session configuration file.

- The user registering JEA must be an administrator on the machine.

- You have decided on a name for the JEA endpoint

Windows Server ships with some predefined JEA endpoints, which have a name starting with Microsoft. You can find existing JEA endpoints using the following Windows PowerShell command:

```powershell
Get-PSSessionConfiguration | Select-Object Name

```

For example, to register the endpoint DNSOps using the DNSOps.pssc session configuration file, use the following command:

```powershell
Register-PSSessionConfiguration -Name DNSOps -Path .\DNSOps.pssc

```

## Registering JEA on multiple machines

You can register JEA on multiple machines by using Desired State Configuration (DSC). To use DSC to deploy JEA, the following prerequisites must be met:

- You must have defined one or more roles, and the role capabilities file (or files) must be placed in the RoleCapabilities folder of a Windows PowerShell module.

- The PowerShell module must be stored on a read-only file share accessible by the machines.

- You have determined the session configuration settings. (You don't need to create a session configuration file though.)

- You have account credentials that have administrative access to each machine.

- You have downloaded the JEA DSC resource from [https://github.com/PowerShell/JEA/tree/master/DSC Resource](https://github.com/PowerShell/JEA/tree/master/DSC%20Resource)

- You have decided on a name for the JEA endpoint

You can apply the DSC configuration using the Local Configuration Manager or by updating the pull server configuration.

For more information about Registering JEA on multiple machines, refer to the GitHub page [JEA/DSC Resource/](/powershell/scripting/learn/remoting/jea/register-jea?view=powershell-7.1&preserve-view=true).

## Check your knowledge

Choose the best response for each of the questions below. Then select **Check your answers**.

---



---