Surface devices are built to protect your business at every step; from the moment you turn them on until you power them off. Security starts with Microsoft's own firmware and UEFI (Unified Extensible Firmware Interface) platform, which is regularly improved through open-source collaboration. This means updates and security controls can be delivered from the cloud, making management easier and keeping devices safer.

Working closely with chip manufacturers, Surface devices use a hardware-backed root of trust to ensure a secure startup. This can be done directly in the silicon or through Windows-based technology, both helping to protect your device from the very beginning.

All these security features come together in Secured-core PCs—which combine hardware, firmware, and software to keep your devices, identities, and data safe. Surface is designed to be a trusted choice for organizations that need strong security at every layer.

## Surface UEFI

Surface devices use UEFI (Unified Extensible Firmware Interface) instead of the older BIOS system. UEFI acts like a small operating system that helps control and protect the device's firmware. It adds important security features, such as Secure Boot, which stops untrusted software from running when the device starts up.

Microsoft works with other companies through Project Mu to keep Surface UEFI open source and up to date. This means that Surface devices can quickly get security updates and new features through Windows Update.

**Key benefits of Surface UEFI include:**

- Security updates and new features are delivered directly through Windows Update.
- Updates use signed drivers and capsules, making it much harder for attackers to tamper with them.
- An A-B update system helps catch any corrupted updates before they cause problems.
- IT professionals can easily see which part of the firmware is being updated, thanks to color-coded progress bars.
- Surface Enterprise Management Mode allows for detailed control over hardware and firmware.
- Integration with Microsoft Intune lets IT teams manage UEFI remotely and without passwords.

These features help keep Surface devices secure and easy to manage for businesses.

## How to use Surface UEFI settings

Surface UEFI is standardized across the entire portfolio of Surface for Business devices. Under normal circumstances, there's no need to change UEFI settings. But you can adjust them if you desire. To do so, follow these steps and remember that UEFI settings can only be accessed during startup.

:::image type="content" border="true" source="../media/uefi-settings.gif" alt-text="Animation showing how to access UEFI settings on a Surface device.":::

**Open UEFI settings**

- Shut down your Surface and wait about 10 seconds to make sure that it's off.
- Press and hold the volume-up button on your Surface, and, at the same time, press and release the power button.
- The Microsoft or Surface logo appears on your screen. Continue to hold the volume-up button. Release the button when the UEFI screen appears.

**Load UEFI settings through Windows**

You can also load the UEFI firmware settings menu through Windows. To do this:

- Select **Start** > **Settings** > **System** > **Recovery**.
- Next to **Advanced startup**, select **Restart Now**.
- Under **Choose an option**, select **Troubleshoot** > **Advanced Options** > **UEFI Firmware Settings**, and then select **Restart**.

Depending on which Surface model you have, you'll see different UEFI settings. Typically, there are six main settings categories that you can choose from:

:::image type="content" border="true" source="../media/uefi-pc-information.png" alt-text="Screenshot of the PC information section in Surface UEFI settings.":::

- **PC information:** In this section, you can see important information about your Surface, such as the Universally Unique Identifier (UUID), serial number, and firmware version. You can use this information for troubleshooting or for working with warranty support.

:::image type="content" border="true" source="../media/uefi-security.png" alt-text="Screenshot of the Security section in Surface UEFI settings.":::

- **Security:** In the Security section, you can set or change your UEFI password. UEFI passwords are used primarily by enterprises and IT professionals to limit the types of changes that employees can make to their devices. You can also turn Secure Boot on or off and make other changes. Typically, only enterprises will need to change security settings—the default, out-of-the-box settings will be perfect for most users.

:::image type="content" border="true" source="../media/uefi-boot-configuration.png" alt-text="Screenshot of the Boot configuration section in Surface UEFI settings.":::

- **Boot configuration:** In the Boot configuration section, you can change how your Surface boots into Windows. If your Surface is part of an enterprise, these settings may be locked or configured to your enterprise specification. If you accidentally delete Windows Boot Manager from your Master Boot Record, simply restart your Surface and Windows Boot Manager will reinstall automatically.

:::image type="content" border="true" source="../media/uefi-date-time.png" alt-text="Screenshot of the Date and time section in Surface UEFI settings.":::

- **Date and time:** In the Date and time section, you can manually enter a new date and time for your Surface.

- **About:** When you select About, you'll see regulatory information.

:::image type="content" border="true" source="../media/uefi-exit.png" alt-text="Screenshot of the Exit section in Surface UEFI settings.":::

- **Exit:** You can select Exit > Restart now to save the changes made to Surface UEFI and restart your device.

## Enhanced memory safety with Rust

:::image type="content" border="true" source="../media/surface-rust.png" alt-text="Screenshot of Rust code in Surface firmware.":::

Modern PC firmware needs to be safe and reliable. Rust is a programming language that helps make this possible. Unlike older languages like C, which can sometimes lead to memory errors and security risks, Rust is built to prevent these problems. This means attackers have fewer chances to find and exploit weaknesses in devices.

Rust is now used in Surface devices and Microsoft's Project Mu firmware to improve security. By adopting Rust and collaborating with the wider community, Surface helps raise industry security standards and delivers safer, more reliable firmware.

## Secured Core PC

All new Surface devices—including Surface Pro for Business and Surface Laptop for Business—are secured-core PCs that are designed to deliver robust protection for organizations handling sensitive data. These devices combine advanced hardware, firmware, and software features to ensure that only authentic, trusted versions of Windows run from the moment the device powers on.

The key features of Secured-core PCs include:

- **Hardware-backed root of trust:** Security begins at the silicon level, using security processors such as TPM (Trusted Platform Module). On ARM-based devices like those with the Microsoft SQ3 processor, dynamic root of trust is used. On the latest Intel-based Surface devices, innovations in firmware such as UEFI and FASR (Firmware Attack Surface Reduction) further strengthen the security posture.
- **Hypervisor Code Integrity:** Enabled by default on all Windows 11 Surface devices, this feature isolates code execution, reducing the risk of malware and unauthorized access.
- **Windows Hello for Business:** Provides seamless, secure authentication, protecting user identities and simplifying sign-in experiences.
- **BitLocker:** Ensures data is encrypted and protected, even if a device is lost or stolen.
- **Compliance and Lifecycle Security:** Surface devices adhere to rigorous standards, including NIST, ISO, and Microsoft's Unified Compliance Framework, ensuring enterprise-ready compliance throughout the device lifecycle.

Imagine you're an IT decision maker at a mid-sized enterprise tasked with upgrading the organization's fleet of laptops. The primary concern is safeguarding sensitive business data while enabling remote work and seamless productivity. Your decision points include the following considerations:

- **Assessing Threats:** The IT team reviews current and emerging threats, prioritizing devices that offer multi-layered defense and least privilege access. Secured-core PCs stand out for their ability to mitigate both known and unknown vulnerabilities through hardware, firmware, and software integration.
- **Evaluating Compliance:** Regulatory requirements such as NIST and ISO are non-negotiable. Surface devices, with their built-in compliance controls and transparent supply chain (SBOM), simplify audits and ongoing management.
- **Lifecycle Management:** From deployment to retirement, Surface devices offer end-to-end security, including remote management via Microsoft Intune and regular firmware updates delivered through Windows Update.
- **User Experience:** Employees benefit from secure, passwordless authentication (Windows Hello for Business) and data protection (BitLocker), reducing friction, and enhancing productivity.

By selecting Secured-core Surface devices, the IT decision maker ensures that every endpoint is protected at every layer, compliance is maintained, and the workforce can operate securely and efficiently—no matter where they work.
