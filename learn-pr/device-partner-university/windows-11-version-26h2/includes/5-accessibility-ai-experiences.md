Contoso also supports users with different accessibility requirements and is evaluating newer AI-related Windows experiences.

The team asks:

**Which experiences are relevant to our users, and do all devices running 26H2 support the same capabilities?**

The answer shows why update eligibility and feature eligibility shouldn't be treated as the same question.

## Accessibility

Windows 11 includes improvements across Magnifier, Narrator, and Voice access.

- [Magnifier](https://support.microsoft.com/accessibility/windows/magnifier/use-magnifier-to-make-things-on-the-screen-easier-to-see) provides clearer and more consistent announcements when used with a screen reader. Users can enter a specific zoom percentage, adjust zoom increments from the Magnifier window, and apply a full-screen color tint to help reduce eye strain and improve readability.
- [Narrator](https://support.microsoft.com/accessibility/windows/narrator/complete-guide-to-narrator) adds Braille Viewer, which displays on-screen text and its Braille equivalent on a refreshable Braille display. Narrator also improves reading and navigation in Microsoft Word and gives users greater control over which details about on-screen controls are announced and the order in which they're announced.
- [Voice access](https://support.microsoft.com/accessibility/windows/voice-access/get-started-with-voice-access) adds French, German, Spanish, and Korean language support along with Voice Isolation, which helps reduce interference from other speakers and background noise. It also supports natural-language commands on supported Copilot+ PCs, providing more flexibility to use filler words and synonyms rather than predefined commands.

That last capability demonstrates why Contoso needs to look beyond OS-version eligibility: natural-language commands in Voice access are only supported on supported Copilot+ PCs.

## AI-related Windows experiences

Several other experiences enabled by 26H2 incorporate AI or expose AI-related capabilities.

In File Explorer, AI actions can edit supported images or summarize documents. The Copilot Summarize action can present quick overviews of OneDrive and SharePoint files without opening them. That action requires an active Microsoft 365 subscription and Copilot license.

Users signed in with a work or school account can also access quick actions such as Ask Copilot when hovering over files in File Explorer Home.

The taskbar can display the progress of supported AI agents and notify users when work is complete starting with Researcher in Microsoft Copilot.

Task Manager adds visibility into neural processing unit (NPU) usage on PCs with supported hardware. Optional columns can display NPU utilization, engines, dedicated memory, and shared memory, while neural engines that are part of a graphics processing unit (GPU) can appear on the Performance page.

## Update eligibility versus experience requirements

This distinction gives Contoso an important framework: An eligible Windows 11, version 24H2 or 25H2 device might be able to move to 26H2 through the enablement package.

That fact alone doesn't establish whether every 26H2 capability applies to the device.

For example:

| **Experience** | **Device requirement** | **Subscription/license** | **Account/content condition** |
| :---: | :---: | :---: | :---: |
| Voice access natural-language commands | Supported Copilot+ PC | Not identified here | Not identified here |
| Copilot Summarize in File Explorer | No additional device requirement identified here | Active Microsoft 365 subscription and Copilot license | OneDrive or SharePoint files |
| Ask Copilot quick action | No additional device requirement identified here | Not identified here | Signed in with a work or school account |
| Task Manager NPU visibility | PC with an NPU | Not identified here | Not identified here |

Contoso can now consider "Is the device eligible for Windows 11, version 26H2?" separately from "Does the device, user, or organization meet the documented requirements for this individual experience?"

That's especially important when planning validation. It prevents the team from assuming that the Windows version alone determines every available experience.

## Key takeaways

26H2 includes accessibility and AI-related experiences with different requirements. Evaluate the requirements for an individual capability separately from eligibility for the Windows feature update.
