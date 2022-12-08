In Windows 10, Windows Hello for Business replaces passwords with strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that is tied to a device and uses a biometric or PIN. Windows Hello for Business lets user authenticate to an Active Directory or Azure AD account.

Windows Hello addresses the following problems with passwords:

 -  Strong passwords can be difficult to remember, and users often reuse passwords on multiple sites.
 -  Server breaches can expose symmetric network credentials (passwords).
 -  Passwords are subject to replay attacks.
 -  Users can inadvertently expose their passwords due to phishing attacks.

:::image type="content" source="../media/authentication-flow-d3e33dbf.png" alt-text="Diagram of the process flow for how authentication works in Windows Hello.":::


## How Windows Hello for Business works: key points

 -  Windows Hello credentials are based on certificate or asymmetrical key pair. Windows Hello credentials can be bound to the device, and the token that is obtained using the credential is also bound to the device.
 -  Identity provider (such as Active Directory, Azure Active Directory (Azure AD), part of Microsoft Entra, or a Microsoft account) validates user identity and maps the Windows Hello public key to a user account during the registration step.
 -  Keys can be generated in hardware (TPM (Trusted Platform Module) 1.2 or 2.0 for enterprises, and TPM 2.0 for consumers) or software, based on the policy.
 -  Two-factor authentication is the combination of a key or certificate tied to a device. Then something that the person knows (a PIN) or something that the person is (biometrics). The Windows Hello gesture doesn't roam between devices and isn't shared with the server. Biometrics templates are stored locally on a device. The PIN is never stored or shared.
 -  The private key never leaves a device when using TPM. The authenticating server has a public key that is mapped to the user account during the registration process.
 -  PIN entry and biometric gesture both trigger Windows 10 to use the private key to cryptographically sign data that is sent to the identity provider. The identity provider verifies the user's identity and authenticates the user.
 -  Personal (Microsoft account) and corporate (Active Directory or Azure AD) accounts use a single container for keys. All keys are separated by identity providers' domains to help ensure user privacy.
 -  Certificate private keys can be protected by the Windows Hello container and the Windows Hello gesture.

## Creating security groups

Windows Hello for Business uses several security groups to simplify the deployment and management.

> [!IMPORTANT]
> If your environment has one or more Windows Server 2016 domain controllers in the domain to which you are deploying Windows Hello for Business, then skip the Create the KeyCredentials Admins Security Group. Domains that include Windows Server 2016 domain controllers use the KeyAdmins group, which is created during the installation of the first Windows Server 2016 domain controller.

### Create the KeyCredential Admins security group

Azure Active Directory Connect synchronizes the public key on the user object created during provisioning. You assign write and read permission to this group to the Active Directory attribute. This will ensure the Azure AD Connect service can add and remove keys as part of its normal workflow.

1. Sign in a domain controller or management workstation with *Domain Admin* equivalent credentials.
1. Open **Active Directory Users and Computers**.
1. Select **View** and select **Advance Features**.
1. Expand the domain node from the navigation pane.
1. Right-select the **Users** container. Select **New**. Select **Group**.
1. Type **KeyCredential Admins** in the **Group Name** text box.
1. Select **OK**.

### Create the Windows Hello for Business Users security group

The Windows Hello for Business Users group is used to make it easy to deploy Windows Hello for Business in phases. You assign Group Policy and Certificate template permissions to this group to simplify the deployment by adding the users to the group. This provides users with the proper permissions to configure Windows Hello for Business and to enroll in the Windows Hello for Business authentication certificate.

1. Sign in a domain controller or management workstation with *Domain Admin* equivalent credentials.
1. Open **Active Directory Users and Computers**.
1. Select **View** and select **Advanced Features**.
1. Expand the domain node from the navigation pane.
1. Right-select the **Users** container. Select **New**. Select **Group**.
1. Type **Windows Hello for Business Users** in the **Group Name** text box.
1. Select **OK**.

## Microsoft Pluton Security Processor

:::image type="content" source="../media/pluton-a1449d2b.png" alt-text="Diagram of the new Microsoft Pluton C P U chip on the motherboard next to the C P U and T P M chips.":::


Today, the heart of operating system security on most PCs lives in a chip separate from the CPU, called the TPM (Trusted Platform Module). The TPM is a hardware component, which is used to help securely store keys and measurements that verify the integrity of the system. TPMs have been supported in Windows for more than 10 years and power many critical technologies such as Windows Hello and BitLocker. Based on the effectiveness of the TPM at performing critical security tasks, attackers have begun to innovate ways to attack it. This is particularly common in situations where an attacker can steal or temporarily gain physical access to a PC. These sophisticated attack techniques target the communication channel between the CPU and TPM, which is typically a bus interface. This bus interface provides the ability to share information between the main CPU and security processor. It also provides an opportunity for attackers to steal or modify information in-transit using a physical attack.

The Pluton design removes the potential for that communication channel to be attacked by building security directly into the CPU. Windows PCs using the Pluton architecture will first emulate a TPM. This emulation works with the existing TPM specifications and APIs. Finally, this will allow customers to immediately benefit from enhanced security for Windows features that rely on TPM. Some examples are BitLocker and System Guard. Windows devices with Pluton will use the Pluton security processor to protect credentials, user identities, encryption keys, and personal data. None of this information can be removed from Pluton even if an attacker has installed malware or has complete physical possession of the PC.

 -  Built in collaboration with AMD, Intel, Qualcomm, and others.
 -  Security Hardware Cryptographic Key (SHACK).
 -  Update / replacement for the TPM chip, which hackers are starting to learn how to get around.
 -  Based on technology pioneered in Azure Sphere and Xbox security.
