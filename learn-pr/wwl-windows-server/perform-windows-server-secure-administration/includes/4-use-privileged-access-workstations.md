When reviewing the security report produced by consultants for Contoso, you learned that malicious hackers will focus on workstations that are regularly used by administrators with high-level access to the infrastructure. Therefore, it's important to ensure that such workstations are secure.

## What is a privileged access workstation?

A privileged access workstation (PAW) is a computer that you can use for performing administration tasks, such as the administration of identity systems, cloud services, and other sensitive functions. This computer will be protected from the internet and locked down so that only the required administration apps can run.

>[!CAUTION]
> Ensure that administrative user accounts aren't allowed to be used as standard user accounts.

You should never use this workstation for web browsing, email, and other common end-user apps, and it should have strict application control. You shouldn't allow connection to wireless networks or to external USB devices. A PAW should implement security features such as Multi-Factor Authentication (MFA).

> [!TIP]
> You must configure privileged servers to not accept connections from a non-privileged workstation.

Microsoft recommends using Windows 10 Enterprise for your PAWs. This is because Windows 10 Enterprise supports security features that aren't available in other editions. These Windows Defender features are described in the following table.

|Feature|Description|
|-|--|
|Windows Defender Application Control|Moves away from the traditional application trust model where all applications are assumed trustworthy by default to one where applications must earn trust to run.|
|Windows Defender Credential Guard|Protects NTLM password hashes, Kerberos ticket-granting tickets, and credentials stored by applications as domain credentials. Because they are no longer stored in the local security authority (LSA), credential theft can be blocked even on a compromised system.|
|Windows Defender Device Guard|Combines the features of Windows Application Control with the ability to use the Windows Hyper-V hypervisor to protect Windows kernel-mode processes against the injection and execution of malicious or unverified code.|
|Windows Defender Exploit Guard| Enables administrators to define and manage policies for reducing surface attacks and exploits, network protection, and protecting suspicious apps from accessing folders commonly targeted.|

## PAW hardware profiles

It's important to remember that administrators are also users. This means that they will use email, browse the web, and run productivity apps like Microsoft Office. If the administrator's computer is a PAW, that will severely impact the user's ability to be productive in non-administrative tasks.

> [!CAUTION]
> It's worth remembering that users tend to abandon secure solutions that limit productivity in favor of insecure solutions that enhance productivity.

To maintain security, administrator users should be provided with two workstations. One workstation is a PAW, while the other is used for day-to-day tasks that don't require elevation. You can achieve this separation by using PAW hardware profiles. Microsoft recommends using one of the following hardware profiles:

- Dedicated hardware. Separate dedicated devices for user tasks versus administrative tasks. The admin workstation must support hardware security mechanisms such as a trusted platform module (TPM) and implement the Windows 10 Enterprise security features already discussed.
- Simultaneous use. A single device that can run user tasks and administrative tasks concurrently by running two operating systems, where one is a user system and the other is an administrator system. You can do this by running a separate operating system in a VM for daily use.

> [!CAUTION]
> If you're using a single device, ensure that the PAW runs on the physical computer, while your regular workstation is running as a VM. This provides the correct security.

The following table describes the advantages and disadvantages of these approaches.

|Scenario|Advantages|Disadvantages|
||--||
|Dedicated hardware|Strong security separation|Requires two devices. This requires more space and costs more to implement.|
|Simultaneous use|Reduced hardware costs|Sharing the same keyboard and mouse can result in errors and pose security risks.|