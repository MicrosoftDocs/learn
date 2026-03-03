Windows Autopilot streamlines the deployment, reset, and repurposing of devices, reducing manual configuration requirements.

Designed to minimize IT involvement, Windows Autopilot enables end users to begin working with minimal setup time, compared to traditional deployment methods.

Throughout the device lifecycle, Windows Autopilot facilitates transitions such as provisioning, reassigning, and refreshing devices. It reduces the need for IT support during setup and allows IT teams to focus on other operational priorities.

## Benefits of Autopilot

Windows Autopilot utilizes cloud-based services to automate several device deployment procedures that typically require manual effort and coordination between IT personnel and end users. Automating these procedures can:

- Minimize the time IT administrators spend on deploying, managing, and decommissioning devices.
- Reduce the need for on-premises infrastructure to support device lifecycle operations.
- Improve the setup experience for end users by streamlining initial configuration and provisioning.

## User-friendly deployment

When an employee receives a device—whether via mail or other delivery methods—they can initiate setup by powering it on. No IT appointment is required for initial configuration.

## Cloud versus traditional

Traditional deployment methods require IT administrators to maintain custom operating system images and device drivers for each hardware model.

During initial device deployment, Windows Autopilot leverages the instance of Windows that comes preinstalled on the device (typically provided by the OEM). This approach eliminates the need for manual image and driver management, streamlining setup procedures and reducing IT workload.

Existing Windows installations can be transformed by Autopilot into “business-ready” states by:

- Applying settings and policies.
- Installing apps.
- Changing the edition of Windows being used to support advanced features.
- Automatically joining devices to Microsoft Entra ID.
- Autoenrolling devices into mobile device management services such as Microsoft Intune. A Microsoft Entra ID Premium subscription is required for configuration.
- Creating and autoassigning devices to configuration groups based on a device’s profile.
- Customizing out-of-the-box content specific to the organization.

![A photograph of a woman working at a desk on a laptop in an office.](../media/end-user.png)

## Deployment experience

- Zero-touch provisioning: Devices can be deployed without direct IT interaction, allowing IT teams to allocate time to other operational tasks.
- Remote setup: Using Microsoft Intune or other mobile device management (MDM) solutions, IT administrators can configure applications, settings, and user experiences remotely.
- Device repurposing: Existing devices can be reconfigured for new users using Windows Autopilot Reset.

## Management experience

- Simplified image management: Eliminates the need to maintain custom operating system images and drivers for each device model.
- Remote reset capabilities: Enables IT administrators to resolve device issues remotely without requiring physical access.
- Automatic updates: In Autopilot deployments that use Intune’s Enrollment Status Page (ESP), monthly security (quality) updates can be installed during Windows out-of-the-box experience (OOBE) when enabled via the ESP setting “Install Windows quality updates (might restart the device).” Feature updates aren’t supported for installation during OOBE.

## End-users experience

- Devices are ready for use shortly after unboxing and sign in, minimizing delays typically associated with traditional deployment methods.
- Provides users with up-to-date tools and configurations aligned with current workplace technology standards.
- Devices can be preconfigured and shipped directly to users at various locations, eliminating the need for centralized setup.
- Devices remain current with the latest Windows updates, supporting optimal functionality and security.

## Differentiating processes

Here are deployment scenarios that fall under [Windows Autopilot](/autopilot/overview):

- *User-driven:* Users enroll their devices using their credentials for a personalized setup.
- *Self-deploying:* Devices configure automatically without user interaction.
- *Pre-provisioning:* IT preconfigures devices before delivery, reducing setup time so end users can start using their devices faster after powering it on and signing in.

In these scenarios, devices must first be registered with the Windows Autopilot deployment service. Once registration is complete, a Windows Autopilot profile must also be assigned to the device, defining the configuration options for the specific scenario. In contrast, [Windows Autopilot device preparation](/autopilot/device-preparation/overview) doesn’t require registration. While there’s still a profile assignment process, a Windows Autopilot profile is assigned to users rather than individual devices.

> [!NOTE]
> Windows Autopilot device preparation is still evolving, and device-based assignment is currently in development.

## Register and customize

Next, follow through each step of the deployment process for Windows Autopilot scenarios, so you can:

- Register devices using the Windows Autopilot deployment service for your business customers.

- Customize setup and configuration by creating a profile to assign to your customer’s devices.

Lastly, review what happens after the device is provided to an end user.
