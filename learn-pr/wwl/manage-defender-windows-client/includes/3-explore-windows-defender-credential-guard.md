
Introduced in Windows 10 Enterprise and Windows Server 2016, Windows Defender Credential Guard uses virtualization-based security to isolate secrets so that only privileged system software can access them. Unauthorized access to these secrets can lead to credential theft attacks, such as Pass-the-Hash or Pass-The-Ticket. Windows Defender Credential Guard prevents these attacks by protecting NTLM password hashes, Kerberos Ticket Granting Tickets, and credentials stored by applications as domain credentials.

By enabling Windows Defender Credential Guard, the following features and solutions are provided:

 -  **Platform security features to protect credentials:** Hardware security NTLM, Kerberos, and Credential Manager take advantage of platform security features, including Secure Boot and virtualization, to protect credentials.
 -  **Virtualization-based security:** Windows NTLM and Kerberos-derived credentials and other secrets run in a protected environment that's isolated from the running operating system.
 -  **Better protection against advanced persistent threats:** The credential theft attack techniques and tools used in many targeted attacks are blocked when Credential Manager domain credentials, NTLM, and Kerberos-derived credentials are protected using virtualization-based security. Malware running in the operating system with administrative privileges can't extract secrets that are protected by virtualization-based security. While Windows Defender Credential Guard is a powerful mitigation, persistent threat attacks will likely shift to new attack techniques and you should also incorporate Windows Defender Device Guard and other security strategies and architectures.

### How Windows Defender Credential Guard works?

Kerberos, NTLM, and Credential Manager isolate secrets by using virtualization-based security. Previous versions of Windows stored secrets in the Local Security Authority (LSA). Prior to Windows 10, the LSA stored secrets used by the operating system in its process memory. With Windows Defender Credential Guard enabled, the LSA process in the operating system talks to a new component called the isolated LSA process that stores and protects those secrets. Data stored by the isolated LSA process is protected using virtualization-based security and isn't accessible to the rest of the operating system. LSA uses remote procedure calls to communicate with the isolated LSA process.

For security reasons, the isolated LSA process doesn't host any device drivers. Instead, it only hosts a small subset of operating system binaries that are needed for security and nothing else. All of these binaries are signed with a certificate that is trusted by virtualization-based security and these signatures are validated before launching the file in the protected environment.

When Windows Defender Credential Guard is enabled, NTLMv1, MS-CHAPv2, Digest, and CredSSP cannot use the signed-in credentials. Thus, single sign-on doesn't work with these protocols. However, applications can prompt for credentials or use credentials stored in the Windows Vault, which aren't protected by Windows Defender Credential Guard with any of these protocols. It's strongly recommended that valuable credentials, such as the sign-in credentials, should not be used with any of these protocols. If these protocols must be used by domain or Azure AD users, secondary credentials should be provisioned for these use cases.

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
    

Besides using Group Policy to enable Credential Guard, administrators can also use Microsoft Intune platform to deploy this feature to client computers enrolled to Azure AD and Intune. Credential Guard is a part of device configuration profile, when using Endpoint protection profile type. It is available only for Windows 10 and later OS platforms.

:::image type="content" source="../media/intune-credential-guard-760949ed.png" alt-text="screenshot of Windows Defender Credential Guard.":::
