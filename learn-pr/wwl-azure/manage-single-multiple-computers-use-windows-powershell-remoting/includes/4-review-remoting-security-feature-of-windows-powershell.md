By default, the endpoints that Windows PowerShell creates only allow connections by members of a particular group. Starting with Windows Server 2016 and Windows 10, these groups include the Remote Management Users group and the local Administrators group. In an Active Directory Domain Services (AD DS) domain, the latter also includes members of the Domain Admins domain global group, since that group is a member of the local Administrators group on every domain-joined computer. Prior to Windows Server 2016 and Windows 10, by default, only members of the local Administrators group were allowed to use PowerShell remoting. It is, however, possible to change the defaults. Each endpoint does have a system access control list (SACL) that you can modify to control exactly who can connect to it.

PowerShell Remoting and WinRM listen on the following ports:

- HTTP: 5985
- HTTPS: 5986

The default remoting behavior is to delegate your sign-in credentials to the remote computer, although you do have the option of specifying alternative credentials when you make a connection. The remote computer you are connecting to uses those credentials to impersonate you and perform the tasks that you have specified using those credentials. If you have enabled auditing, in addition to the tasks that you perform, the tasks that PowerShell remoting performs on your behalf will also be audited. In effect, remoting is security-transparent and doesn't change your environment’s existing security. With remoting, you can perform all the same tasks that you would perform while physically located in front of the local computer.

> [!NOTE]
> On private networks, the default Windows Firewall rule for PowerShell Remoting is to accept all connections. On public networks, the default Windows Firewall rule allows PowerShell Remoting connections only from within the same subnet. You must explicitly change that rule to open PowerShell Remoting to all connections on a public network.

## Security risks and mutual authentication

Delegating your credentials to a remote computer involves some security risks. For example, if an attacker successfully impersonates a known remote computer, you could potentially transmit highly privileged credentials to that attacker, who could then use them for malicious purposes. Because of this risk, remoting by default requires *mutual authentication*, which means that you must authenticate yourself to the remote computer, and the remote computer must also authenticate itself to you. This mutual authentication guarantees that you connect only to the exact computer that you intended.

Mutual authentication is a native feature of the Active Directory Kerberos authentication protocol. When you connect between trusted domain computers, mutual authentication occurs automatically. When you connect to non-domain joined computers, you must provide another form of mutual authentication in the form of an SSL certificate and the HTTPS protocol that must be set up in advance. Another option is to turn off the requirement for mutual authentication by adding the remote computer to your local TrustedHosts list. Note however, that TrustedHosts uses Windows NT LAN Manager (NTLM) authentication, which doesn't ensure server identity. As with any protocol using NTLM for authentication, attackers who have access to a domain-joined computer's trusted account could cause the domain controller to create an NTLM session-key and thus impersonate the server.

> [!NOTE]
> The NTLM authentication protocol cannot ensure the identity of the target server; it can only ensure that it already knows your password. Therefore, you should configure target servers to use SSL for PowerShell Remoting. Obtaining an SSL certificate issued by a trusted Certification Authority that the client trusts and assigning it to the target server enhances security of the NTLM-based authentication, helping validate both the user identity and server identity.

## Computer name considerations

For AD DS-based authentication to work, PowerShell remoting must be able to search for and retrieve Active Directory Domain Services (AD DS) computer objects. This means that you need to refer to target computers by using their fully qualified domain names (FQDN). IP addresses or Domain Name System (DNS) aliases, for example, won't work because they don't provide remoting with the mutual authentication it needs. If you must refer to a computer by an IP address or a DNS alias, you must connect using HTTPS, which means that the remote computer must be configured to accept that protocol. Alternatively, you must add the IP address or DNS alias to your local TrustedHosts list.

> [!NOTE]
> A special exception is made for the computer name localhost, which enables you to use it to connect to the local computer without any other configuration changes. If the local computer is using a client-based operating system, then WinRM needs to be configured on it.

## The TrustedHosts list

The *TrustedHosts list* is a locally configured setting that you also can configure by using a Group Policy Object (GPO). The TrustedHosts list enumerates the computers for which mutual authentication isn't possible. Computers must be listed with the same name that you'll use to connect to them, whether that's the actual computer name, a DNS alias, or an IP address. You can use wildcards to specify SRV*, which allows any computer whose name or DNS alias starts with **SRV** to connect. However, use caution with this list. While the TrustedHosts list makes it easier to connect to nondomain computers without having to set up HTTPS, it bypasses an important security measure. It allows you to send your credentials to a remote computer without determining whether that computer is in fact one that you intended to connect to. You should use the TrustedHosts list only to designate computers that you know not to be compromised, such as servers housed in a protected datacenter. You also can use TrustedHosts to temporarily enable connections to nondomain computers on a controlled network subnet, such as new computers that are undergoing a provisioning process.

> [!NOTE]
> As a best practice, you should avoid using the TrustedHosts list unless absolutely necessary. Configuring a nondomain computer to use HTTPS is a more secure long-term solution.

## Privacy

By default, remoting uses HTTP, which doesn't offer privacy or encryption of the content of your communication. However, Windows PowerShell can and does apply application-level encryption by default. This means that your communications receive a degree of privacy and protection. On internal networks, this application-level encryption is generally sufficient to satisfy organizational security requirements.

In a domain environment that uses the default Kerberos authentication protocol, credentials are sent in the form of encrypted Kerberos tickets that don't include passwords.

When you connect by using HTTPS, the entire channel is encrypted by using the encryption keys of the remote computer’s SSL certificate. As a result, even if you use Basic authentication, passwords are not transmitted in clear text. However, when you connect by using HTTP and Basic authentication to a computer that isn't configured for HTTPS, credentials (including passwords) will be transmitted in clear text. This can occur, for example, when you connect to a nondomain computer that you add to your local TrustedHosts list. This can even occur when you use a domain-joined computer by specifying its IP address rather than its host name.

Because credentials are transmitted in clear text in that scenario, you should ensure that you connect to a nondomain computer only on a controlled and protected network subnet, such as one specifically designated for new computer provisioning. If you have to routinely connect to a nondomain computer, you should configure it to support HTTPS.
