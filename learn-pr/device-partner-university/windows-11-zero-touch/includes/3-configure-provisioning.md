Zero-touch provisioning (for example, using [Windows Autopilot](/autopilot/overview)) depends on devices being recognized as belonging to your organization before they ever reach the user.

In practice, this means ensuring that devices are registered and associated with your tenant ahead of time. When a user turns on a new laptop and connects to the internet, the device can identify its organization and present the correct sign-in experience. Instead of asking for a personal account or offering a consumer setup flow, the device prompts the user to sign in with their work credentials.

During this first sign-in, several things happen automatically. The device enrolls into management, applies initial configuration settings, and begins pulling down required policies. From the user's perspective, this feels like a slightly extended first-run experience. From IT's perspective, it replaces hours of manual setup with a repeatable, scalable process, reducing hands-on effort and enabling faster delivery of ready-to-use devices.

>[!NOTE]
> Even zero-touch provisioning under ideal conditions might include some breaks and pauses at certain stages, such as during policy and app installation. Consider sending users a prearrival email or including a message in the [out-of-box experience](/windows-hardware/customize/desktop/customize-oobe-in-windows-11) that sets expectations for how long initial setup might take.

This setup should feel familiar and predictable. When users power on the device, they're guided through a standard sign-in experience using their work account, rather than creating a personal profile or making configuration decisions. Behind the scenes, IT-defined settings take effect automatically, ensuring the device is configured correctly before the user begins work. This alignment between user experience and IT intent is a key benefit of zero-touch provisioning.

To ensure the right behavior, organizations typically assign provisioning settings to groups rather than individual devices. This helps reduce per-device exceptions and simplifies future rollouts, which can improve consistency while lowering the operational burden on IT teams during large deployments.

In this scenario, all new employees receiving refreshed laptops are placed in the same group. Any device associated with that group follows the same provisioning path. Devices are now ready to be shipped directly to users, each one ready to enroll and configure itself on first boot.

## Exercise: Prepare devices for zero-touch provisioning

You're preparing a batch of Windows 11 Pro devices that will ship directly to new hires.

### Your task

Describe how you would ensure:

- Devices are recognized as belonging to your organization before shipment (for example, through vendor registration or tenant association)
- The first sign-in experience prompts for work credentials based on tenant configuration
- The correct provisioning configuration applies automatically through assigned policies in your management platform

### What success looks like

You can explain what happens from the moment the user turns on the device through completion of first sign in, with no steps requiring IT involvement.
