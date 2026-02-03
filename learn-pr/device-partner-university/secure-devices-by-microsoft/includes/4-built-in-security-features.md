Surface devices offer built-in security features like Secure Boot and Virtualization-based Security, enabled by default for seamless protection. Windows Hello provides fast, secure biometric authentication, and passwordless options like NFC (Near Field Communications) and Smart Card Readers simplify access. Regular Windows Updates keep devices secure and performing well.

In the following sections, you'll explore how these security features work together to safeguard users and their data.

## Key security features in Windows 11 Pro

Windows 11 Pro on Surface devices offers advanced security features like BitLocker to Go for drive encryption, Config Lock, Intune Endpoint Privilege Management, LAPS (Local Administrator Password Solution), and token protection for sign-in.

Windows Hello for Business, Windows Firewall, Win32 app isolation, and hardware-backed security (TPM 2.0, Secure Boot, Trusted Boot) provide strong protection. Surface also includes App Control for Business, built-in management, enhanced phishing protection, and Microsoft Pluton integration for CPU-level security.

## Enterprise-ready compliance and lifecycle protection

Surface devices are delivered with enterprise-ready compliance, adhering to the Microsoft Unified Compliance Framework (UCF) and meeting or exceeding requirements set by industry standards and government regulations. Regular vulnerability scans, secret checks, and third-party audits ensure that Surface devices remain secure and reliable. With features like Windows Autopilot for streamlined deployment and Windows Update for Business, organizations can manage devices efficiently while maintaining a strong security posture.

## Layered security architecture

Surface devices with Windows 11 Pro use a multi-layered security approach that integrates protections across the cloud, identity, application, operating system, and hardware.

Cloud services like Microsoft Endpoint Manager and Windows Autopilot enable secure management and compliance from anywhere. Passwordless sign-in options and advanced credential protections reduce the risk of credential theft. Application and OS defenses include app control, encryption, and real-time threat detection.

At the hardware level, features like TPM 2.0 and Microsoft Pluton establish a secure foundation, reinforced by secure supply chain practices and industry certifications. This integrated approach helps organizations confidently address evolving security threats and compliance needs.

## Windows Hello for Business

:::image type="content" border="true" source="../media/windows-hello.jpeg" alt-text="Screenshot of Windows Hello biometric authentication on a Surface device.":::

All Surface devices are equipped with Windows Hello for Business, providing modern, biometric security for organizations. Windows Hello replaces traditional passwords with advanced authentication methods, such as facial recognition, fingerprint scanning, or PIN entry. These credentials are securely bound to each device using asymmetric keys stored in the Trusted Platform Module (TPM), ensuring that only authorized users can access sensitive information.

Windows Hello authentication validates users through their PIN or biometric data, then enables cryptographic keys unique to that user and device. Because these credentials are protected by the TPM and require physical access to the device, they're resistant to replay attacks, phishing, spoofing, and password reuse or leaks.

Some specific Windows 11 enhancements on Surface include:

- **Enhanced Biometric Security:** Expanded support for Enhanced Sign-in Security (ESS) with Virtualization-Based Security (VBS) and TPM 2.0. Windows Hello now supports Intel USB IR cameras, and Windows 11 adds support for AMD USB secure cameras. ESS Fingerprint is available across all platforms.
- **Simplified Hybrid Deployments:** Windows Hello for Business is easier to deploy in hybrid environments, with the removal of key blockers such as Public-Key Infrastructure (PKI) requirements and the need to sync keys between Entra ID (formerly Azure Active Directory) and Active Directory.

>[!NOTE]
> Windows Hello requires specialized hardware, such as an illuminated infrared camera for facial or iris recognition, or a fingerprint reader compatible with the Windows Biometric Framework.

## Enhanced security with Wi-Fi 7

The latest Surface devices feature Wi-Fi 7—offering fast data connections and network security.

Wi-Fi 7 boosts resilience and security by using multiple frequency bands and channels, ensuring robust data transmission even with interference. Its Multi-Link Operation (MLO) allows seamless switching between links for stable connections. Load balancing distributes traffic across links, reducing targeted attack threats.

Wi-Fi 7 security features 256-bit WPA3 AES (Advanced Encryption Standard) encryption (up from 128-bit in Wi-Fi 6), and Protected Management Frames (PMF) are now mandatory for all bands, ensuring encrypted and authenticated management frames. Wi-Fi 7 requires WPA3 certification, stronger key management, and beacon protection—making it a reliable choice for organizations handling sensitive data.

## Windows Update

Windows Update keeps your Surface devices secure and up to date automatically. It delivers important updates for Windows, apps, Windows Defender, and even Surface firmware and UEFI, helping protect against new threats.

Updates are checked for authenticity and integrity before installation, so only trusted content is applied. With services like Windows Autopatch, Microsoft handles update management for you, reducing complexity and ensuring your devices stay healthy and secure.

Imagine that you're an IT decision maker, and there's a new firmware update that is need to be installed on your team's fleet of devices. Windows Update on Surface enables you to deploy the necessary fixes seamlessly to keep your team productive and secure.
