Another important part of securing an environment is to ensure that the computers that IT staff use to connect to secure servers are themselves secure. Your business-critical servers are only as secure as the computers that your IT staff use to perform administrative tasks.

IT staff should not perform routine activities such as answering email or browsing the internet on computers that are used for performing administrative tasks. Those daily activities provide another avenue for compromising administrative workstations.

IT staff are high-value targets for unauthorized users. By gaining access to IT computers or accounts, they can have all the privileges and resources that the team member has. Without protection solutions such as Windows Defender Credential Guard, in addition to the original compromised account a sophisticated unauthorized user can extract any other account credentials that have been used to sign in to the same computer. This scenario is particularly problematic if the same device is used to sign in with both credentials for daily tasks and for highly privileged credentials.

Even if an unauthorized user can’t harvest credentials directly, they could install malware such as a keystroke logger that lets them indirectly discover usernames and passwords used for administrative tasks. You can help make sure that external attacks can’t infect devices, by ensuring IT staff perform administrative tasks only on secure administrative hosts, also called a privileged access workstation (PAW).

## Privileged access workstation configuration

When configuring a PAW, you should:

- Ensure that only authorized users can sign in to the PAW. Standard user accounts should not be able to sign in.

- Enable Windows Defender Credential Guard to help protect against credential theft.

- Enable BitLocker Drive Encryption to help protect the boot environment and the hard disk drives from tampering.

- Use Windows Defender Device Guard policies to restrict application execution to only trusted applications that your organization’s employees use for performing administrative tasks.

- Block PAWs from accessing the internet.

- Install all the tools your administrative tasks require, so your IT staff aren't tempted or required to use other workstations to perform their administrative tasks.

- Limit physical access to the PAWs

After you have PAWs configured, you should then perform the following configuration tasks to maximize their value in securing your environment:

- Block Remote Desktop Protocol (RDP), Windows PowerShell, and management console connections to your servers that come from any computer that isn't a PAW.

- Implement connection security rules so that traffic between servers and PAWs is encrypted and protected from replay attacks.

- Configure sign-in restrictions for administrative accounts so that those accounts can only sign in to a PAW.

Combining a daily-user workstation and a PAW on the same device is a common practice. You combine these computers by hosting one of the operating systems in a virtual environment. However, if you combine these computers you should host the daily-use workstation virtual machine within the PAW host, and not a PAW virtual machine within a daily-user host. If the PAW is hosted in the daily user workstation and the workstation is compromised, the PAW could be compromised as well.

For more information about Device Guard, see [Windows Defender Application Control and virtualization-based protection of code integrity](/windows/security/threat-protection/device-guard/introduction-to-device-guard-virtualization-based-security-and-windows-defender-application-control).

## Jump servers and secure bastion hosts

Jump servers and secure bastion hosts are similar to PAWs. When performing administrative tasks, you use RDP to connect to a dedicated server that's configured similarly to a PAW. The difference is that you sign in to PAWs locally, while you sign in to jump servers remotely. In this scenario, there's a risk that the host you sign in from might be compromised.

> [!NOTE]
> You can combine jump servers with PAWs.

