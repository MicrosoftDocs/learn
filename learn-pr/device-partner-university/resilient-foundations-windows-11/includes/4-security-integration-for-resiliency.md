Device security isn't just about protecting data; it's a foundation for resiliency. Windows 11 Pro is secure by design, providing advanced threat protection and reducing security incidents.

## Secure by design principles

:::image type="content" border="true" source="../media/secure-by-design.jpeg" alt-text="Illustration representing secure by design principles in Windows 11 Pro.":::

Microsoft is committed to fostering a culture that makes security a core priority. In late 2023, we announced the Microsoft Secure Future Initiative (SFI)—a comprehensive, multiyear commitment aimed at enhancing cybersecurity across Microsoft and its products. SFI is anchored by three core principles:

- **Secure by design:** Security comes first when designing any product or service.
- **Secure by default:** Security protections are enabled and enforced by default, require no extra effort, and aren't optional.
- **Secure operations:** Security controls and monitoring will be continuously improved to meet current and future cyber threats.
:::image type="content" border="true" source="../media/secure-future-initiative.png" alt-text="Illustrations representing the Microsoft Secure Future Initiative principles.":::

SFI dictates Microsoft's goals and actions that define its security approach, which is reflective of security features on Windows 11 Pro. Let's review some of these goals:

- **Protecting identities and secrets:** Reducing the risk of unauthorized access by implementing and enforcing best-in-class standards across all identity and secrets infrastructure, plus user and application authentication and authorization.
- **Protecting tenants and isolating systems:** Protecting all Microsoft tenants and production environments using consistent security practices and strict isolation to minimize the breadth of impact.
- **Protecting engineering systems:** Protecting software assets and continuously improving code security through governance of the software supply chain and engineering systems infrastructure.
- **Monitoring and detecting cyberthreats:** Comprehensive coverage and automatic detection of cyberthreats for Microsoft production infrastructure and services.
- **Accelerating response and remediation:** Preventing vulnerability exploitation by external and internal entities through comprehensive and timely remediation.

The Secure Future Initiative has influenced the way that Windows 11 Pro has been developed. The operating system has innovated with Zero Trust principles, expanded passkeys, automatic recovery capabilities, and memory-safe improvements to firmware and drivers. For business users, their safety is at the forefront of the development of Windows 11 Pro—creating peace of mind and accelerating productivity.

## Post-Quantum Cryptography

As part of Microsoft's broader commitment to building a secure-by-design ecosystem, Windows 11 Pro now incorporates Post-Quantum Cryptography (PQC) capabilities designed to protect businesses against emerging quantum-enabled threats. With quantum computing expected to render traditional public-key algorithms vulnerable in the future, Microsoft has introduced PQC algorithms directly into the Windows cryptographic infrastructure.

These advancements, now generally available across Windows 11 Pro and Windows Server through updates to CNG (Cryptography Next Generation) and certificate APIs (Application Programming Interface), enable organizations to begin adopting quantum-resistant security today—mitigating risks while ensure long-term data protection.

By integrating PQC into core platform components, Microsoft is laying a forward-looking foundation that complements Windows 11 Pro's existing hardware-rooted defenses and supports resilient, enterprise-ready security strategies for the decade ahead.

## Hardware-based security

Microsoft works closely with OEM partners to help ensure that all certified Windows systems deliver a secure operating environment. Windows integrates closely with hardware to deliver protections that take advantage of available hardware capabilities. A byproduct of this effort has been building Secured-core PCs—devices that deeply integrate hardware, firmware, and software to ensure enhanced security for devices, identities, and data.

Secured-core PCs provide protection that's useful against sophisticated attacks and can provide increased assurance when handling mission-critical data in some of the most data sensitive industries. All Copilot+ PCs are Secured-core PCs, designed to provide robust security features that protect users and their data—reflecting Microsoft's commitment to delivering secure computing experiences in the age of AI. To verify that your PC is a Secured-Core PC, follow these steps:

- Select the **Windows icon** and open **Settings**.
- Select **Privacy & Security**, then select **Windows Security**.
- Select **Device security**.
- If your device is a Secure-core PC, it reflects that status on the top of the screen (see below).

:::image type="content" border="true" source="../media/secured-core-pc.png" alt-text="Screenshot showing the Secured-Core PC status in Windows Security settings.":::

On the processor level, Microsoft Pluton is a secure crypto processor built into the CPU (Central Processing Unit) for security at the core to ensure code integrity and the latest protection with updates delivered through Windows Update. Designed by Microsoft, it's designed to provide the Trusted Platform Module (TPM) functionality and deliver other security functionality beyond what's possible with the TPM 2.0 specification. This allows for other Pluton firmware and operating system features to be delivered over time via Windows Update.

Pluton is built to provide better end-to-end security experiences on Windows 11 Pro devices. It does so by doing three things:

- **Zero-trust security and reliability:** Windows PCs and services like Microsoft Entra and Intune need to work harmoniously to provide frictionless security. Pluton helps ensure users get high security and operational reliability.
- **Innovation:** Pluton platform and the functionality it provides is informed by user feedback and Microsoft's threat intelligence—empowering users to do their best work while keeping their devices and data safe.
- **Continuous improvement: Supports loading new firmware from operating system updates.** The extra support for dynamically loading valid new Pluton firmware through operating system updates facilitates continuous improvements both for bug fixes and new features.

Secured-Core PCs and Microsoft Pluton allow IT decision makers to have peace of mind when deploying innovative solutions to their teams. For a global workforce, as was detailed in our earlier scenario, this is crucial as sensitive data is protected—and users can remain productive with enhanced AI workflows.

## Identity and access controls

With the risk of cyberattacks in today's work environment being ever-present, it's crucial for businesses to ensure that their data is safe. Passwords are vulnerable to hacks, which is why Windows 11 Pro offers business users an added layer of security with Windows Hello Enhanced Sign-in Security (ESS).

**Windows Hello:** enables biometrics or PIN authentication, eliminating the need for a password. Biometric authentication uses facial recognition or fingerprint to prove a user's identity in a secure, personal, and convenient way.

**Enhanced Sign-in Security (ESS):** provides an extra level of security to biometric data with the use of specialized hardware and software components. Virtualization Based Security (VBS) and Trusted Platform Module 2.0 are used to isolate and protect user authentication data, and to secure the data communication channel. Whether your PC supports facial recognition, fingerprint recognition, or both, follow these steps to set up Windows Hello:

:::image type="content" border="true" source="../media/windows-hello.png" alt-text="Screen showing Windows Hello sign-in options in Windows 11 Pro.":::

- In the Settings app on your Windows device, select **Accounts** > **Sign-in options**.
- Under **Ways to sign in**, choose from the available Windows Hello methods (availability depends on your device hardware):
  - **Facial recognition (Windows Hello):** Uses the device's built-in infrared camera or a compatible external camera.
  - **Fingerprint recognition (Windows Hello):** Uses a built-in or external fingerprint reader.
  - **PIN (Windows Hello):** Sets up a PIN, which is required before setting up biometric options.
- Choose an option and select **Set up**.
- Follow the instructions to complete the configuration of Windows Hello.
- The next time you sign in to your device, you can use facial recognition, fingerprint identification, or PIN code instead of your password.

>[!NOTE]
> A **PIN is mandatory** to enable any Windows Hello biometric (face or fingerprint).

Now that you understand Windows 11 Pro resiliency features and how to use them, let's explore a real-world example of a business that utilizes Windows 11 Pro and Copilot+ PCs to achieve its goals.
