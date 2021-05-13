Windows Server will negotiate and use the highest SMB version that a client supports. In this regard, the client can be another server, a Windows 10 device, or even an older legacy client or Network-attached storage (NAS) device. This can potentially result in protocol downgrade to SMB 2.0. Older Windows Server versions also include support for SMB 1.0, which is known for its vulnerabilities. Therefore, the use of SMB 1.0 should be blocked for security reasons.

> [!NOTE]
> Starting with Windows Server version 1709 and Windows 10 version 1709, support for SMB 1.0 isn't installed by default.

## Demonstration

The following video demonstrates how to:

- Disable SMB 1.0.
- Configure SMB encryption.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest with a domain member configured as a file server.
1. Enable SMB 1.0 on the member server. Explicitly enable SMB 1.0 by using the ```Enable-WindowsOptionalFeature``` Windows PowerShell cmdlet.
1. Detect whether SMB 1.0 is enabled. Enable auditing of SMB 1.0 connections.
1. Audit the use of SMB 1.0. Use the command-line tools to transfer the operations master roles back to the first domain controller.
1. Disable SMB 1.0. Disable SMB 1.0 by using the ```Disable-WindowsOptionalFeature``` Windows PowerShell cmdlet.
1. Configure SMB encryption. Enforce the use of SMB encryption.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MjvN]