Before exploring what makes Copilot+ PCs unique, it helps to understand a few foundational hardware concepts. These terms come up frequently when discussing device performance and AI capabilities.

## Hardware terms

| Term | Definition |
|---|---|
| **Central Processing Unit (CPU)** | The primary processor in a computer, responsible for performing general-purpose operations and running applications. |
| **Graphics Processing Unit (GPU)** | A specialized processor designed to render images, video, and 3D graphics efficiently. |
| **Neural Processing Unit (NPU)** | A dedicated chip designed to run AI and deep learning workloads directly on the device, separate from the CPU and GPU. |
| **Trillions of Operations Per Second (TOPS)** | A unit of measurement for the maximum processing throughput of an NPU. Higher TOPS indicates greater capacity for on-device AI workloads. |

> [!TIP]
> Think of the CPU, GPU, and NPU as a team. The CPU handles general tasks, the GPU handles visual workloads, and the NPU handles AI-specific processing. On Copilot+ PCs, the NPU takes on AI tasks, so the CPU and GPU remain available for everything else—improving overall system performance and battery life.

## Understanding Windows 11 device tiers

The current Windows 11 device ecosystem includes two primary tiers for business: **Windows 11 Pro PCs** and **Copilot+ PCs**. Copilot+ PCs build on everything included with Windows 11 Pro and add dedicated AI hardware and enhanced experiences.

The following table summarizes the key differences between tiers.

| Capability | Windows 11 Pro PCs | Copilot+ PCs |
|---|---|---|
| **AI access** | Cloud-based AI through Copilot (with eligible Microsoft 365 license) | Cloud-based AI plus on-device AI powered by a dedicated NPU |
| **NPU** | May include an integrated NPU | Dedicated NPU capable of 40+ TOPS |
| **Security** | TPM 2.0,<br>Virtualization-based security,<br>BitLocker,<br>Microsoft Defender Antivirus,<br>Post-quantum cryptography (PQC) | All Windows 11 Pro security features, plus Copilot+ PC–exclusive protections enabled by default:<br>Microsoft Pluton,<br>Windows Hello Enhanced Sign-in Security,<br>Secured-core PC protection |
| **Performance** | Modern processors with reliable performance for business workloads | Up to 2x faster in office productivity tasks compared to average five-year-old Windows PCs, with extended battery life |
| **Productivity features** | Snap layouts,<br>Desktops,<br>Microsoft Narrator,<br>Voice access | All Windows 11 Pro features, plus:<br>Click to Do,<br>Improved Windows search with federation,<br>Live Captions with translation,<br>Windows Studio Effects,<br>Fluid Dictation,<br>Agent in Settings |
| **Management** | Microsoft Intune,<br>Windows Autopilot,<br>Windows Autopatch,<br>Windows Update for Business | Same management tools and processes as Windows 11 Pro PCs |

> [!NOTE]
> Both Windows 11 Pro PCs and Copilot+ PCs are managed with the same IT tools and processes, including Microsoft Intune and Windows Autopilot. Organizations don't need separate management infrastructure for Copilot+ PCs.

> [!IMPORTANT]
> Performance claims are based on Microsoft testing. Results may vary depending on device configuration, usage, and other factors. For more information, see the [Copilot+ PC claims and disclosures documentation](/windows/deployment/performance-lab/claims-disclosures?tabs=copilot-plus).

## What's enhanced on Copilot+ PCs

Copilot+ PCs include everything available on Windows 11 Pro, with additional hardware and software capabilities designed for AI workloads. The following features are enhanced or exclusive to Copilot+ PCs:

- **Click to Do**—Analyzes text or images on screen and suggests next steps, such as opening content in another app, rewriting text, or applying edits in Photos.
- **Improved Windows search**—Contextual search that understands descriptive queries for files, settings, and images, and unifies local and cloud results in a single taskbar experience.
- **Agent in Settings**—Describe what you want to configure (such as attaching an external screen or pairing a Bluetooth device), and the agent offers suggestions and applies your selected changes.
- **Windows Studio Effects**—Full NPU-powered video call enhancements, including portrait blur, eye contact correction, voice focus, and autoframing.
- **Live Captions with translation**—Real-time translation from 40+ languages to English, and 25+ languages to Chinese (Simplified).
- **Fluid Dictation**—Voice input that suggests corrections and improvements to your writing as you speak.

> [!IMPORTANT]
> Some Copilot+ PC features have language, region, or hardware requirements. Feature availability varies by device. For the latest details, see [Copilot+ PC FAQs](https://www.microsoft.com/windows/copilot-plus-pcs).

## Security features across both tiers

The following security capabilities are available on all Windows 11 Pro PCs and Copilot+ PCs:

- TPM 2.0
- Virtualization-based security
- Windows Hello for Business passwordless sign-in
- Microsoft Copilot with enterprise data protection (with eligible 
  Microsoft 365 license)
- Microsoft vulnerable driver blocklist
- Microsoft Defender Antivirus protection
- App Control for Business (requires Microsoft Intune)
- Windows administrator protection (requires Microsoft Intune)
- Network security improvements
- BitLocker device encryption
- Post-quantum cryptography (PQC)

> [!NOTE]
> Some security features may require supported hardware and configuration. Availability can vary by device and deployment. For example, while all Windows 11 Pro PCs support TPM 2.0, some may use a discrete TPM chip while others use firmware-based TPM. For more information on security features and requirements, see the [Windows 11 security documentation](/windows/security/).

On Copilot+ PCs, the following security features are enhanced and enabled by default:

| Feature | Copilot+ PC enhancement |
|---|---|
| **Microsoft Pluton** | Built in and enabled by default |
| **Windows Hello Enhanced Sign-in Security** | Enabled by default |
| **Secured-core PC protection** | Enabled by default (configurable on supporting Windows 11 devices) |

> [!TIP]
> For learners positioning these devices in business conversations: the key takeaway is that Copilot+ PCs are **secure by default**—Microsoft Pluton, Enhanced Sign-in Security, and Secured-core protection all come enabled out of the box, without requiring IT configuration.