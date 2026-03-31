Now that you've explored how Surface for Business devices and the Surface Management Portal support collaboration, it’s time to walk through a deployment workflow. In this hands-on exercise, you simulate selecting devices, preparing them for management, and using the Surface Management Portal to validate device readiness and manage ongoing health.

> [!IMPORTANT]  
> To use the Surface Management Portal, you must have:  
> - A Microsoft Intune subscription (or Microsoft 365 E3/E5)  
> - At least **one Surface for Business device enrolled into Intune**  
> - Appropriate admin roles, such as **Hardware Warranty Administrator** or **Hardware Warranty Reader**  
> Learn more: [Surface Management Portal prerequisites](/surface/surface-management-portal#prerequisites)

## Deploying devices for a remote marketing team

Imagine you're an IT administrator supporting a marketing team that recently shifted to remote-first work. Your goal is to deploy devices that help the team collaborate effectively, stay productive, and maintain secure workflows—no matter where they are.

You’ll use the Surface Management Portal to review enrolled devices, organize them, validate configurations, and ensure they’re ready for remote collaboration.

## Choose the right Surface for Business devices

The marketing team needs:
- High-quality video conferencing
- Digital inking for brainstorming sessions
- Lightweight, portable hardware with strong battery life

> [!TIP]
> A **Surface for Business device** that supports touch, inking, and advanced camera/mic capabilities are ideal for creative, fast-moving teams.

## Prepare and enroll devices into Intune

Before devices appear in the Surface Management Portal, they must be enrolled in Intune.

1. Register or import the Surface for Business devices using one of these methods:
   - Windows Autopilot
   - Bulk enrollment
   - Manual enrollment (Settings > Accounts > Access work or school)
1. Verify that the devices successfully check in with Intune.
1. Confirm the devices appear under **Devices** in the Intune Admin Center.

Once a Surface device is enrolled, it automatically appears in the Surface Management Portal.

## Access and organize devices in the Surface Management Portal

1. Sign in to the [Microsoft Intune Admin Center](https://intune.microsoft.com/)
    1. Select **All services** > **Surface Management Portal**. 
   
       :::image type="content" border="true" source="../media/surface-management-portal.png" alt-text="Screenshot showing the Surface Management Portal access view.":::

1. Review the **All Devices** list to confirm that your Surface for Business devices appears.

   :::image type="content" border="true" source="../media/surface-management-portal-devices.png" alt-text="Screenshot showing the Surface Management Portal devices access view in Microsoft Intune.":::

1. Create a Surface device group named **Marketing Team**.
1. Add the appropriate devices to this group to simplify policy and configuration management.

## Apply collaboration and security policies

Policies are applied through Intune, and the Surface Management Portal helps you verify that they’re active.

1. In Intune, configure collaboration tools for the **Marketing Team** device group:
   - Microsoft Teams
   - OneDrive (including Known Folder Move)
   - Microsoft Whiteboard
1. Apply essential security settings and baselines:
   - BitLocker encryption
   - Windows Hello for Business
   - Microsoft Defender settings
   - Automatic updates

> [!TIP]  
> IT Administrators can deploy custom apps or organization branding through Intune and monitor installation status in the Surface Management Portal.

## Validate the deployment in the Surface Management Portal

1. From the portal, open a device’s detail page and review:
   - Firmware version
   - Battery health and cycle counts
   - SSD (Solid-State Drive) and TPM (Trusted Platform Module) status
   - Autopilot profile assignment
1. Check the **Insights** or **Device Health** dashboard to confirm:
   - Update compliance
   - Storage usage
   - Battery analytics
   - Hardware component alerts
1. Simulate a real collaboration scenario:
   - Launch Microsoft Teams and test the camera/mic
   - Open Microsoft Whiteboard and validate digital inking
   - Confirm OneDrive is configured and syncing

## Reflect and discuss

- How did the Surface Management Portal help streamline the deployment process?
- Which device insights were most helpful for supporting remote employees?
- How could this workflow scale to other departments or larger rollouts?

> [!TIP]
> Features on Surface devices include built-in **accessibility features** such as voice typing, magnifier, and high-contrast modes. Consider enabling these during deployment to support all users.

By combining Surface for Business devices with centralized management in Intune and the Surface Management Portal, IT teams can deliver consistent, secure, and collaboration-ready experiences from anywhere.