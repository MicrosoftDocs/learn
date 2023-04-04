
BitLocker provides protection for an operating system and the data that an operating system volume stores in addition to other volumes on the computer. It helps ensure that data stored on a computer remains encrypted, even if someone tampers with the computer when the operating system is not running. BitLocker provides a closely integrated solution in Windows to address the threats of data theft or exposure from lost, stolen, or inappropriately decommissioned computers.

Data on a lost or stolen computer can become vulnerable to unauthorized access when a malicious user runs a software-attack tool against it or transfers the computer’s hard disk to a different computer. BitLocker helps mitigate unauthorized data access by enhancing file and system protections. Additionally, BitLocker helps render data inaccessible when you decommission or recycle BitLocker-protected computers.

BitLocker performs two functions that provide offline data protection and system-integrity verification:

 -  **It encrypts all data that is stored on a Windows operating system volume and configured data volumes**. This includes the Windows operating system, hibernation and paging files, applications, and application data. BitLocker also provides umbrella protection for non-Microsoft applications, which benefits applications automatically when you install them on an encrypted volume.
 -  **It is configured, by default, to use a Trusted Platform Module (TPM) chip**, on a computer mainboard, to help ensure the integrity of the startup components that an operating system uses in the early stages of the startup process. BitLocker locks any BitLocker-protected volumes, so they remain protected even if someone tampers with the computer when the operating system is not running.

#### System integrity verification

BitLocker uses a TPM to verify the integrity of the startup process by:

 -  **Providing a method to check that early boot-file integrity has been maintained**, and to help ensure that there has been no adverse modification of those files, such as with boot-sector viruses or root kits.
 -  **Enhancing protection to mitigate offline software-based attacks**. Any alternative software that might start the system does not have access to the decryption keys for a Windows operating system volume.
 -  **Locking the system when it detects tampering**. If BitLocker determines that tampering has occurred with any monitored files, the system does not start. This alerts a user to tampering because the system fails to start as usual. If system lockout occurs, BitLocker offers a simple recovery process.

In conjunction with a TPM, BitLocker verifies the integrity of early startup components, which helps prevent additional offline attacks, such as attempts to insert malicious code into those components. This functionality is important because the components in the earliest part of the startup process must remain unencrypted so that the computer can start.

As a result, an attacker can change the code of those early startup components and then gain access to a computer even though the disk data is encrypted. Then, if the attacker gains access to confidential information, such as the BitLocker keys or user passwords, the attacker can circumvent BitLocker and other Windows security protections.

#### Compare BitLocker and EFS

As previously noted, both BitLocker and EFS provide encryption functionality. However, these technologies are not the same and don’t have the same purpose. While EFS is focused on providing protection on the file and folder level, BitLocker does that on the volume or disk level. Once you protect the file with EFS, that file stays protected until you (or another person with proper permission) unlock it, and that protection does not depend on file location. On the other hand, files on the drive protected with BitLocker are protected as long as they are on that specific drive. The following table compares BitLocker and EFS-encryption functionality.

|BitLocker functionality |EFS functionality|
|------------------------|----------------|
| Encrypts volumes (the entire operating-system volume, including Windows system files, and the hibernation file). | Encrypts files. |
| Does not require user certificates.    | Requires user certificates.    |
| Protects the operating system from modification. | Does not protect the operating system from modification. |

#### Device encryption

Device encryption is a built-in Windows feature. By default, device encryption protects the operating system drive and any fixed data drives on the system by using Advanced Encryption Standard (AES) 128-bit encryption, which uses the same technology as BitLocker. You can use device encryption with a Microsoft account or a domain account.

Device encryption is enabled automatically on all Windows 10 and later versions on new devices, so that the device is always protected. Supported devices that you upgrade to Windows 10 or with a clean installation also have device encryption automatically enabled.

#### BitLocker To Go

When a laptop is lost or stolen, the loss of data typically has more impact than the loss of the computer asset. As more people use removable storage devices, they can lose data without losing a computer. BitLocker To Go provides protection against data theft and exposure by extending BitLocker support to removable storage devices, such as USB flash drives. You can manage BitLocker To Go by using Group Policy, from Windows PowerShell, and by using the BitLocker Drive Encryption Control Panel app.

In Windows, users can encrypt their removable media by opening File Explorer, right-clicking the drive, and selecting **Turn On BitLocker**. Users then can choose a method with which to unlock the drive, including using a password or a smart card.

After choosing an unlock method, users must print or save their recovery key. You can configure Windows to store this 48-digit key in Active Directory Domain Services (AD DS) automatically, so that you can use it if other unlocking methods fail, such as when users forget their passwords. Finally, users must confirm their unlocking selections to begin encryption. When you insert a BitLocker-protected drive into your computer, the Windows operating system will detect the encrypted drive and prompt you to unlock it.

#### Microsoft BitLocker Administration and Monitoring (MBAM)

As with any security technology that you implement, centralized management is recommended. You can centrally manage BitLocker by using Group Policy, but with limited functionality. Part of the Microsoft Desktop Optimization Pack, MBAM makes it easier to manage and support BitLocker and BitLocker To Go with full functionality. MBAM 2.5 with Service Pack 1, the latest version, has the following key features:

 -  Administrators can automate the process of encrypting volumes on client computers across the enterprise.
 -  Security officers can determine the compliance state of individual computers or even of the enterprise itself.
 -  Provides centralized reporting and hardware management with Microsoft Endpoint Configuration Manager.
 -  Reduces help desk workload assisting end users with BitLocker recovery requests.
 -  End users can recover encrypted devices independently by using the Self-Service Portal.
 -  Security officers can audit access to recovery key information.
 -  Windows Enterprise users can continue working anywhere with their corporate data protected.
 -  Enforces the BitLocker encryption policy options that you set for your enterprise.
 -  Integrates with existing management tools, such as Endpoint Configuration Manager.
 -  Offers an IT-customizable recovery user experience.

:::image type="content" source="../media/bitlocker-administration-monitoring-b958cc38.png" alt-text="Screenshot of Microsoft MBAM prompting for the KeyID and reason for recovering access to an encrypted drive.":::
