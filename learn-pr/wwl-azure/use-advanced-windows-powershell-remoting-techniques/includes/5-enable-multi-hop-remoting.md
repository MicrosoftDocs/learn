Another challenge with remoting is related to delegating credentials across multiple remote connections. By default, credentials can be delegated across only one connection, or *hop*. This restrictions delegation prevents the remote computer from further delegating your credentials, since this could introduce an extra security risk. 

In general, this is the scenario we want to address:

1. You're signed in to **ServerA**.
2. From **ServerA**, you start a remote PowerShell session to connect to **ServerB**.
3. A command you run on **ServerB** via your PowerShell Remoting session attempts to access a resource on **ServerC**.
4. Access to the resource on **ServerC** is denied because the credentials you used to create the PowerShell Remoting session are not passed from **ServerB** to **ServerC**.

The need to perform multiple hop (or, *multi-hop*) delegation can often occur in production environments. For example, in some organizations administrators aren't permitted to connect directly from their client computers to a server in the datacenter. Instead, they must connect to an intermediate gateway or jump server, and then from there connect to the server they intend to manage. In its default configuration, remoting doesn't permit this approach. After you're connected to a remote computer, your credential can go no further than the remote computer. Trying to access any resource that isn't located on that computer typically results in a failure because your access isn't accompanied by a credential. The solution is to enable Credential Security Support Provider (CredSSP).

## Enabling CredSSP

CredSSP caches credentials on the remote server (**ServerB**, from the previous example). Because of this, you should be aware that using CredSSP opens you up to potential credential theft attacks. If the remote computer is compromised, the attacker has access to the user's credentials. CredSSP is disabled by default on both client and server computers. You should enable CredSSP only in the most trusted environments. For example, a domain administrator connecting to a domain controller could have CredSSP enabled because the domain controller is highly trusted.

You must enable the CredSSP protocol both on the initiating computer, referred to as the *client*, and on the receiving computer, referred to as the *server*. Doing this enables the receiving computer to delegate your credential one additional hop.

To configure the client, run the following command, substituting *servername* with the name of the server that will be able to redelegate your credential:

```powershell
Enable-WsManCredSSP –Role Client –Delegate servername
```

The server name can contain wildcard characters. However, using the asterisk (`*`) wildcard by itself is too permissive because you would be enabling any computer to redelegate your credential, even an unauthorized user. Instead, consider a limited wildcard pattern, such as *.ADATUM.com, which would limit redelegation to computers in that domain.

To configure the server, run **Enable-WsManCredSSP –Role Server**. No delegated computer list is required on the server. You also can configure these settings through Group Policy, which offers a more centralized and consistent configuration across an enterprise.

> [!NOTE]
> There have been numerous security breaches documented while using CredSSP, and therefore it's no longer a preferred option. You should instead use constrained delegation.

## Resource-based, Kerberos-constrained delegation

Starting with Windows Server 2012, you can forgo using CredSSP and instead use constrained delegation. *Constrained delegation* implements delegation of service tickets by using security descriptors rather than an allow list of server names. This allows the resource to determine which security principals can request tickets on behalf of another user. Resource-based constrained delegation works correctly regardless of domain functional level.

Constrained delegation requires:

- Access to a domain controller in the same domain as the host computer from which the Windows PowerShell remoting commands are being run.
- Access to a domain controller in the domain hosting the remote server you're trying to access from the intermediate remote server.

The code for setting up the permissions requires a computer running Windows Server with the Active Directory PowerShell Remote Server Administration Tools (RSAT). You can add RSAT as a Windows feature by running the following two commands:

```powershell
Add-WindowsFeature RSAT-AD-PowerShell
Import-Module ActiveDirectory
```

To grant resource-based, Kerberos-constrained delegation from **LON-SVR1** through **LON-SVR2** to **LON-SVR3**, run the following command:

```powershell
Set-ADComputer -Identity LON-SVR2 -PrincipalsAllowedToDelegateToAccount LON-SVR3
```

One issue could cause this command to fail. The Key Distribution Center (KDC) has a 15-minute SPN negative cache. If **LON-SVR2** has already tried to communicate with **LON-SVR3**, then there's a negative cache entry. You'll need to clear the cache on **LON-SVR2** by using one of the following techniques:

- Run the command `klist purge -li 0x3e7`. This is the preferred and fastest method.
- Wait 15 minutes for the cache to clear automatically.
- Restart **LON-SVR2**.

To test constrained delegation, run the following code example:

```powershell
$cred = Get-Credential Adatum\TestUser                
Invoke-Command -ComputerName LON-SVR1.Name -Credential $cred -ScriptBlock {Test-Path \\$($using:ServerC.Name)\C$            `
Get-Process lsass -ComputerName $($using:LON-SVR2.Name)
Get-EventLog -LogName System -Newest 3 -ComputerName $using:LON-SVR3.Name            
}
```

## Just enough administration

*Just Enough Administration (JEA)* is a security technology that enables delegated administration for anything managed by PowerShell. With JEA, you can:

- Reduce the number of administrators on your machines by using virtual accounts or group-managed service accounts to perform privileged actions on behalf of regular users.
- Limit what users can do by specifying which cmdlets, functions, and external commands they can run.
- Better understand what your users are doing by reviewing transcripts and logs that depict exactly which commands a user ran during their session.

Highly privileged accounts used to administer your servers pose a serious security risk. Should an attacker compromise one of these accounts, they could launch lateral attacks across your organization. Each compromised account gives an attacker access to even more accounts and resources, and puts them one step closer to stealing company secrets, launching a denial-of-service (DOS) attack, and more.

It's not always easy to remove administrative privileges, either. Consider the common scenario where the DNS role is installed on the same machine as your Active Directory domain controller. Your DNS administrators require local administrator privileges to fix issues with the DNS server. But to do so, you must make them members of the highly privileged Administrators security group. This approach effectively gives DNS Administrators the ability to gain control over your entire domain and access to all the resources on that machine.

JEA addresses this problem through the principle of least privilege. With JEA, you can configure a management endpoint for DNS administrators that gives them access only to the PowerShell commands they need to get their job done. This means you can provide the appropriate access to repair a poisoned DNS cache or restart the DNS server without unintentionally giving them rights to Active Directory, or to browse the file system, or run potentially dangerous scripts. Better yet, when the JEA session is configured to use temporary, privileged virtual accounts, your DNS administrators can connect to the server by using non-admin credentials and still run commands that typically require admin privileges. JEA enables you to remove users from widely privileged local or domain administrator roles and carefully control what they can do on each machine.

JEA is a feature included in PowerShell 5.0 and newer. For full functionality, you should install the latest version of PowerShell available for your system. PowerShell Remoting provides the foundation on which JEA is built. It's necessary to ensure PowerShell Remoting is enabled and properly secured before you can use JEA.

When creating a JEA endpoint, you need to define one or more role capabilities that describe what someone can do in a JEA session. A *role capability* is a PowerShell data file with the .psrc extension that lists all the cmdlets, functions, providers, and external programs that are made available to connecting users.

You can create a new PowerShell role capability file with the **New-PSRoleCapabilityFile** cmdlet. You should then edit the resulting role capability file to allow the commands required for the role. The PowerShell help documentation contains several examples of how you can configure the file.
