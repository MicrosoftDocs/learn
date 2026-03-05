Windows Autopilot functional and critical updates automatically download during the out-of-the-box experience. They launch after:

- The device is connected to a network.
- Critical driver and Windows updates are complete.

End users can’t opt out of these updates.

## BitLocker encryption

With Windows Autopilot, you can configure BitLocker encryption settings to apply before automatic encryption starts.

By doing so, you can enforce an organization’s security policies or requirements right from the start of the device setup process—ensuring consistency, compliance, and enhanced protection for sensitive data.

To learn how to configure these settings, visit [Microsoft Learn](/autopilot/bitlocker).

## Pre-provisioning

Pre-provisioning enhances efficiency and boosts user satisfaction during the initial device setup.

This process takes place between the time the device leaves the factory and when it arrives at the end user. During this phase, an IT technician performs intermediate but automatic configurations, such as installing apps and adjusting settings.

 This process occurs after the device leaves the factory and before it reaches the end user. An IT technician initiates the technician phase, which automatically applies configurations—such as installing apps and applying settings—before the device is delivered.

As a result, when end users sign in for the first time, most device setup work is already complete, so they can start using the device sooner.

Learn more about [Windows Autopilot for pre-provisioned deployment](/autopilot/pre-provision) on Microsoft Docs.

![A woman smiling while working on a laptop in an office environment. They are holding datasheets with a bar graph printed on the paper.](../media/desk.png)

## Common challenges

**Deploying and configuring devices so an end user can set it up themselves**
[Windows Autopilot user-driven mode](/autopilot/user-driven) lets you configure new Windows devices to automatically transform from their factory state to a ready-to-use state.

**Deploying devices automatically configured for shared use, as a kiosk, or as a digital signage device**
[Windows Autopilot self-deploying mode](/autopilot/self-deploying) lets you deploy a device as a kiosk, digital signage device, or a shared device with little to no user interaction.

**Redeploying devices in a business-ready state**
[Windows Autopilot Reset](/autopilot/windows-autopilot-reset) takes the device back to a business-ready state, allowing the next person to sign in and get productive quickly and simply.

**Reducing the time spent deploying devices**
[Windows Autopilot device preparation](/autopilot/device-preparation/overview) is the newer provisioning path for Windows devices. While it isn’t yet feature‑complete compared to traditional Windows Autopilot, it introduces a simpler, more resilient approach that improves deployment speed, reliability, and supportability.

## Key advantages of Windows Autopilot device preparation

### Faster and more reliable provisioning

- Device preparation significantly reduces provisioning time.
- It removes several enrollment and ESP dependencies that commonly cause timeouts or failures in classic Autopilot.
- Result: more consistent first-boot experiences, especially at scale.
- **Why this matters:** Traditional Autopilot ESP frequently blocks on app installs, policy timing, or network conditions.

### Simplified enrollment flow

- No Enrollment Status Page (ESP) dependency.
- Device setup completes without forcing users to wait for apps or policies to finish installing.
- **Why this matters:** ESP is the single largest source of Autopilot failures and support tickets.

### Reduced user impact and better first-sign-in experience

- Users reach the desktop faster.
- Apps and policies continue installing after the user signs in.
- **Why this matters:** Classic Autopilot often creates the perception that “the device is broken” due to long, opaque waits.

### Lower operational complexity

- Fewer Autopilot-specific profiles and settings to manage.
- Leverages modern Intune provisioning behaviors instead of legacy Autopilot constructs.
- **Why this matters:** Autopilot has accumulated technical debt; device preparation is intentionally minimal.

### Improved resilience to app and policy issues

- App failures do not block device readiness.
- Noncritical apps no longer prevent users from accessing the device.
- **Why this matters:** In classic Autopilot, one misconfigured Win32 app can halt the entire deployment.

### Better alignment with modern device management

- Designed for cloud-native, Entra ID–joined devices from day one.
- Assumes continuous management post-sign-in instead of “everything must finish at OOBE.”
- **Why this matters:** This matches how Windows, Intune, and Microsoft Entra ID now operate.

### Easier troubleshooting and support

- Clearer separation between provisioning and ongoing management.
- Failures occur in normal Intune app/policy workflows, not during a fragile OOBE phase.
- **Why this matters:** Support teams can use standard Intune diagnostics instead of Autopilot-specific logs.

### Summary table

| Area | Device Preparation | Traditional Autopilot |
|------|--------------------|-----------------------|
| Provisioning time | Shorter | Longer, ESP-bound |
| ESP dependency | None | Required |
| User wait time | Minimal | Often significant |
| App failure impact | Nonblocking | Blocking |
| Operational complexity | Lower | Higher |
| Troubleshooting | Standard Intune | Autopilot-specific |

### Bottom line

Windows Autopilot device preparation is the strategic replacement for traditional Autopilot. It prioritizes speed, reliability, and operational simplicity while eliminating the ESP-driven fragility that has plagued Autopilot deployments for years.
