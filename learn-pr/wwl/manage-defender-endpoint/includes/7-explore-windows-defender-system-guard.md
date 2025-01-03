Windows uses containers to isolate sensitive system services and data, enabling them to remain secure even when the operating system has been compromised. Windows uses a container type called Windows Defender System Guard to protect critical resources, such as the Windows authentication stack, single sign-on tokens, the Windows Hello biometric stack, and the Virtual Trusted Platform Module.

Windows Defender System Guard reorganizes the existing Windows system integrity features in one system and sets up the next set of investments in Windows security. It's designed to:

 -  Help protect and maintain the integrity of the system as it starts up
 -  Help protect and maintain the integrity of the system after it's running
 -  Help ensure that system integrity has truly been maintained through local and remote attestation

### Maintain the integrity of the system as it starts

In the past, during the Windows 7 era, attackers often used bootkits or rootkits to persist and evade detection. These malicious software would initiate before or during the Windows boot process, granting them the highest level of privilege.

With modern hardware certified for Windows 8 or higher, a hardware-based root of trust helps prevent unauthorized firmware or software, such as bootkits, from executing before the Windows bootloader. This added security is achieved through the device's Secure Boot feature, a part of the Unified Extensible Firmware Interface (UEFI).

After the device's firmware and Windows bootloader have been verified and initiated, the next opportunity for attackers to compromise system integrity arises during the startup of the Windows operating system and its defenses. By embedding rootkit-based malicious code into the boot process, attackers can gain the highest level of privilege, which enables easier persistence and evasion.

Windows Defender System Guard steps in at this point, ensuring that only properly signed and secure Windows files and drivers, including third-party ones, can start on the device. Once the Windows boot process concludes, System Guard initiates the system's antimalware solution to scan all third-party drivers. Ultimately, Windows Defender System Guard helps guarantee a secure boot with integrity, preventing system compromise before the rest of the defenses begin.

:::image type="content" source="../media/defender-system-guard-74d54d3f.png" alt-text="Diagram of Windows Defender System Guard Boot time integrity Protection.":::


### Maintain integrity of the system after it’s running (run time)

Prior to Windows 10, if an attacker exploited the system and gained SYSTEM level privilege or they compromised the kernel itself, they were able to make significant damage to the attacked system. The level of control that an attacker would acquire in this condition would enable them to tamper with and bypass many, if not all, of your system defenses. While there are many development practices and technologies such as **Windows Defender Exploit Guard** that have made it difficult to gain this level of privilege in Windows, the reality is that there needs to be a way to maintain the integrity of the most sensitive Windows services and data, even if the highest level of privilege is secured by an adversary.

With Windows 10, Microsoft introduced the concept of virtualization-based security (VBS), which enables us to contain the most sensitive Windows services and data in hardware-based isolation, which is the Windows Defender System Guard container. This secure environment provides the hardware-based security boundary needed to be able to secure and maintain the integrity of critical system services at run time like Credential Guard, Device Guard, Virtual Trusted Platform Module (TPM) and parts of Windows Defender Exploit Guard, just to name a few.

### Validate platform integrity after Windows is running (run time)

While Windows Defender System Guard provides advanced protection that will help protect and maintain the integrity of the platform during boot and at run time, the reality is that an "assume breach" mentality must be applied to even the most sophisticated security technologies. Organizations should be able to trust that the technologies are successfully doing their jobs, but they also need the ability to verify that they were successful in achieving their goals. When it comes to platform integrity, the platform can't just be trusted, which potentially could be compromised, to self-attest to its security state. So, Windows Defender System Guard includes a series of technologies that enable remote analysis of the device’s integrity.

As Windows boots, a series of integrity measurements are taken by Windows Defender System Guard using the device’s TPM 2.0. This process and data are hardware-isolated away from Windows to help ensure that the measurement data isn't subject to the type of tampering that could happen if the platform was compromised. From here, the measurements can be used to determine the integrity of the device’s firmware, hardware configuration state, and Windows boot-related components, just to name a few. After the system boots, Windows Defender System Guard signs and seals these measurements using the TPM. Upon request, a management system like Intune or Configuration Manager can acquire them for remote analysis. If Windows Defender System Guard indicates that the device lacks integrity, the management system can take a series of actions, such as denying the device access to resources.
