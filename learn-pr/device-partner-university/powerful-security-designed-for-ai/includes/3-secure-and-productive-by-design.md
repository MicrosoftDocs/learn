Copilot+ PCs include AI-powered experiences that run locally on the device, using the NPU to process data without sending it to the cloud.

Because these experiences operate on-device, they benefit from the same hardware security protections—**Microsoft Pluton**, **Secured-core PC**, and **BitLocker encryption**—that help protect the operating system.

These protections extend to AI-powered features, helping ensure that data remains secure while being processed and accessed.

Two examples of these on-device AI experiences are **Recall (preview)** and **Click to Do**, which are designed with privacy, security, and user control in mind.

## Recall (preview)

Recall helps users locate previously viewed content by capturing snapshots of on-screen activity over time.

Because this feature may include sensitive data, it includes multiple security and privacy controls:

**Opt-in by design**

Recall is not enabled by default. Users must explicitly opt in, and the feature requires Windows Hello Enhanced Sign-in Security to be configured before it can be activated. Users can pause, disable, or delete their Recall data at any time.

**Encrypted and on-device**

All Recall snapshots are stored locally on the device and encrypted at rest. Snapshot data is protected by device-level encryption, including BitLocker or Device Encryption. Recall data never leaves the device, isn't shared with Microsoft, and isn't used to train AI models.

**Authenticated access**

Each time Recall is accessed, Windows Hello reauthenticates the user. Enhanced Sign-in Security provides hardware-backed biometric protection that helps resist spoofing and replay attacks.

**Sensitive content filtering**

Recall includes built-in filtering to help prevent capturing sensitive information such as passwords and financial data. InPrivate browsing sessions and DRM-protected content are excluded from snapshots.

**IT administrator controls**

IT administrators can manage Recall using Microsoft Intune. This includes disabling Recall, configuring storage and retention settings, and excluding apps or websites from capture.

> [!TIP]
> For detailed IT admin configuration guidance, see [Manage Recall](/windows/client-management/manage-recall).
> For more user-facing privacy controls, see [Control Recall](https://support.microsoft.com/windows/privacy-and-control-over-your-recall-experience-d404f672-7647-41e5-886c-a3c59680af15).

## Click to Do

Click to Do enables users to take actions on text and images displayed on screen using on-device AI processing.

Like Recall, Click to Do processes data locally and benefits from the same encryption and hardware-backed protections that secure Copilot+ PCs.

Because Click to Do works directly with on-screen content, it keeps data processing on the device and aligned with existing security controls.

**On-device processing**

Actions are performed locally using the NPU, helping reduce the need to send sensitive data to the cloud.

**Platform-level protection**

Click to Do benefits from built-in protections such as Microsoft Pluton, Secured-core PC, and BitLocker encryption.

**Managed using existing tools**

Click to Do can be governed using the same tools used to manage devices and applications, including Microsoft Intune.

> [!TIP]
> For IT administrator configuration and policy guidance, see [Manage Click to Do](/windows/client-management/manage-click-to-do). This includes how to enable or disable Click to Do and manage its behavior using Microsoft Intune.

These examples show how Copilot+ PCs extend hardware-backed security to AI-powered experiences, keeping data protected while enabling new ways to interact with information directly on the device.

In addition to securing on-device AI experiences, organizations also need to manage how AI operates and how data is protected across cloud-based services.