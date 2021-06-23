While you are evaluating the Azure Stack HCI management and maintenance tasks, Contoso's Information Security team is examining the security-related implications of the new operational model. One of the areas of particular interest is authentication. Contoso relies on AD DS as its identity provider for Windows and Linux-based workloads, with Kerberos as the primary authentication protocol. The Information Security team asked you to identify Azure Stack HCI tasks that might be dependent on other authentication protocols and determine the potential implications of their usage. Throughout your evaluation, you encountered several scenarios that forced you to switch temporarily to CredSSP-based authentication. Now, you want to verify the need for CredSSP and document any potential considerations regarding its usage. 

## Overview of the role of CredSSP authentication in Azure Stack HCI

The primary purpose of CredSSP is to facilitate remote delegation scenarios that involve three components: a client, a server, and a remote resource. With CredSSP, a user authenticates to the client, which delegates the user's credentials to the server, which, in turn, uses these credentials to access the remote resource. Such delegation is frequently a requirement when using Windows Remote Management (WinRM) and PowerShell Remoting. 

> [!NOTE]
> Unlike Kerberos, which allows for constrained delegation by restricting the remote service to be accessed with delegated credentials, CredSSP passes credentials to the server without any constraints. Because of this feature, although CredSSP is easier to configure, it doesn't offer the same level of protection as Kerberos. If the server is compromised, the user credentials could potentially be used to gain access to other network resources. 

> [!NOTE]
> CredSSP authentication serves as a workaround for environments where implementing Kerberos delegation is not a viable option. Configuring Kerberos constrained delegation requires privileged access to AD DS.  

Some Azure Stack HCI WinRM-based operations require delegation, which includes running Windows Admin Center-based Create Cluster wizard and setting up Cluster-Aware Updating (CAU). In such cases, you can temporarily enable CredSSP between your management computer and Azure Stack HCI servers. 

> [!NOTE]
> You must disable CredSSP after you complete the task that relies on its functionality. 

## Manage and troubleshoot CredSSP in Azure Stack HCI

The methods of configuring WinRM-based CredSSP settings include the WinRM utility, Group Policies, and Windows PowerShell. Regardless of the method you choose, you need to enable CredSSP delegation for the client and the server. CredSSP also requires an HTTPS listener on the server. In addition, AD DS server and client computer objects must include the Service Principal Name (SPN) attribute values associated with the WSMAN service class.

To enable CredSSP-based delegation of user credentials to a server, run the following command within an elevated PowerShell session on the client computer (where the `<server_FQDN_name>` placeholder represents the fully qualified DNS name of the server):

```powershell
Enable-WsmanCredSSP -Role Client -DelegateComputer <server_FQDN_name>
```

To enable CredSSP-based delegation on the server, connect to it (for example, through a console session or Remote Desktop) and run the following command within an elevated PowerShell session:

```powershell
Enable-WsmanCredSSP -Role Server
```

The process of verifying and troubleshooting the configuration of the SPN attribute is the same for the client and server computers. In both cases, start by running the following command from the elevated Command Prompt (where the `<computer_name>` placeholder represents the name of the computer for which you want to identify the SPN):

```cmd
setspn -Q WSMAN/<computer_name>
```

The results should include `WSMAN/<computer_name>` and `WSMAN/<computer_FQDN_name>`. If that's not the case, run the following command within an elevated Command Prompt (where the `<computer_name>` placeholder represents the name of the computer you are registering the SPN for):

```cmd
setspn -S WSMAN/<computer_name> <computer_name>
```

As part of managing and troubleshooting CredSSP in Azure Stack HCI, you should also keep in mind the following authentication and authorization considerations:

- The Gateway administrator role privileges are necessary for many delegation-related tasks, including enabling and disabling CredSSP from within Windows Admin Center or running the Create Cluster wizard.
- The computer hosting Windows Admin Center should be a member of the same AD DS domain as the managed Azure Stack HCI cluster.