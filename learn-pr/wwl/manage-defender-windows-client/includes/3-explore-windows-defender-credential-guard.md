

Windows Defender Credential Guard, was first introduced in Windows 10 Enterprise and Windows Server 2016, employs virtualization-based security to restrict access to sensitive information, allowing only privileged system software to access it. Credential theft attacks, such as Pass-the-Hash or Pass-The-Ticket, can occur due to unauthorized access to these secrets. By safeguarding NTLM password hashes, Kerberos Ticket Granting Tickets, and domain credentials stored by applications, Windows Defender Credential Guard effectively thwarts such attacks.

By enabling Windows Defender Credential Guard, the following features and solutions are provided:

 -  **Platform security features to protect credentials:** Hardware security NTLM, Kerberos, and Credential Manager take advantage of platform security features, including Secure Boot and virtualization, to protect credentials.
 -  **Virtualization-based security:** Windows NTLM and Kerberos-derived credentials and other secrets run in a protected environment that's isolated from the running operating system.
 -  **Better protection against advanced persistent threats:** The credential theft attack techniques and tools used in many targeted attacks are blocked when Credential Manager domain credentials, NTLM, and Kerberos-derived credentials are protected using virtualization-based security. Malware running in the operating system with administrative privileges can't extract secrets that are protected by virtualization-based security. While Windows Defender Credential Guard offers strong protection, advanced persistent threats may still adapt to new attack techniques. For complete security, combining Windows Defender Device Guard with other security strategies and architectures is recommended.

### How Windows Defender Credential Guard works?

Kerberos, NTLM, and Credential Manager isolate secrets by using virtualization-based security. Previous versions of Windows stored secrets in the Local Security Authority (LSA). Prior to Windows 10, the LSA stored secrets used by the operating system in its process memory. With Windows Defender Credential Guard enabled, the LSA process in the operating system talks to a new component called the isolated LSA process that stores and protects those secrets. Data stored by the isolated LSA process is protected using virtualization-based security and isn't accessible to the rest of the operating system. LSA uses remote procedure calls to communicate with the isolated LSA process.

For increased security, the isolated LSA process doesn't allow any device drivers and only includes a restricted number of essential operating system binaries necessary for security reasons. Each of these binaries bears a certificate trusted by virtualization-based security, and their signatures undergo validation before file execution in the protected environment.

When Windows Defender Credential Guard is enabled, NTLMv1, MS-CHAPv2, Digest, and CredSSP can't use the signed-in credentials. Thus, single sign-on doesn't work with these protocols. However, applications can prompt for credentials or use credentials stored in the Windows Vault, which aren't protected by Windows Defender Credential Guard with any of these protocols. It's recommended that valuable credentials, such as the sign-in credentials, shouldn't be used with any of these protocols. When domain or Azure AD users require the use of these protocols, provision secondary credentials specifically for these scenarios.

When Windows Defender Credential Guard is enabled, Kerberos doesn't allow unconstrained Kerberos delegation or DES encryption, not only for signed-in credentials, but also prompted or saved credentials.

Here's a high-level overview on how the LSA is isolated by using virtualization-based security:

:::image type="content" source="../media/hypervisor-virtualization-based-security-dc72cf3c.png" alt-text="Diagram of Windows Defender Credential Guard overview.":::


Windows Defender Credential Guard can be enabled either by using Group Policy, the registry, or the Windows Defender Device Guard and Windows Defender Credential Guard hardware readiness tool. Windows Defender Credential Guard can also protect secrets in a Hyper-V virtual machine, just as it would on a physical machine. The same set of procedures used to enable Windows Defender Credential Guard on physical machines applies also to virtual machines.

### Enable Windows Defender Credential Guard by using Group Policy

You can use Group Policy to enable Windows Defender Credential Guard. This adds and enables the virtualization-based security features for you if needed. To enable it, follow these steps:

1.  From the Group Policy Management Console, go to **Computer Configuration** \- **Administrative Templates** \- **System** \- **Device Guard**.
2.  Double-click **Turn On Virtualization Based Security**, and then select **Enabled**.
3.  In the Select Platform Security Level box, choose **Secure Boot** or **Secure Boot and DMA Protection**.
4.  In the Credential Guard Configuration box, select **Enabled with UEFI lock**, and then select **OK**. If you want to be able to turn off Windows Defender Credential Guard remotely, choose **Enabled without lock**. :::image type="content" source="../media/virtualization-based-security-322010f5.png" alt-text="screenshot of Windows Defender Credential Guard Group Policy setting.":::
    

Besides using Group Policy to enable Credential Guard, administrators can also use Microsoft Intune platform to deploy this feature to client computers enrolled to Azure AD and Intune. Credential Guard is a part of device configuration profile, when using Endpoint protection profile type. It's available only for Windows 10 and later OS platforms.

:::image type="content" source="../media/intune-credential-guard-760949ed.png" alt-text="screenshot of Windows Defender Credential Guard.":::
