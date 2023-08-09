

You must sync your devices with Intune to update them with the latest policies and actions. The **Sync device** action forces the selected device to immediately check in with Intune. When a device checks in, it immediately receives any pending actions or policies that have been assigned to it. This feature can help you immediately validate and troubleshoot policies you’ve assigned, without waiting for the next scheduled check-in.

Complete the following steps to sync a device:

1.  In the Microsoft Intune admin center, select **Devices**, then select **All devices**.
2.  In the list of devices you manage, select a device, select **More** and then select **Sync**.
3.  To confirm, select **Yes**.
4.  To see the status of the sync action, choose **Devices** > **Monitor** > **Device actions**.

### Manage settings and features on your devices with Intune policies

Microsoft Intune policies are groups of settings that control features on mobile devices and computers. You create policies by using templates that include recommended or custom settings. Then, you deploy them to device or user groups.

Intune policies fall into the following categories. The category that you use affects how you create and deploy the policy.

 -  **Configuration policies**. Commonly used to manage security settings and features on your devices, including access to company resources. Get started at Intune device profiles.
 -  **Device compliance policies**. Define the rules and settings that a device must comply with to be considered compliant by conditional access policies. You can also use compliance policies to monitor and remediate the compliance of devices independent of conditional access.
 -  **Conditional access policies**. Help secure email and other services, depending on conditions that you enter.
 -  **Corporate device enrollment policies**. Intune supports the enrollment of corporate-owned iOS devices using the Apple Device Enrollment Program (DEP) or the Apple Configurator tool running on a Mac computer.

When a policy or an app is deployed, Intune immediately begins notifying the device to check in with the Intune service. This step typically takes less than five minutes.

If a device doesn't check in to get the policy after the first notification is sent, Intune makes three more attempts. If the device is offline (such as being turned off, or not connected to a network), it might not receive the notifications. In this case, the device gets the policy on its next scheduled check-in with the Intune service, as follows:

| Platform   | Check-in frequency |
| ---------- | ------------------ |
| iOS        | Every 6 hours      |
| macOS      | Every 6 hours      |
| Android    | Every 8 hours      |
| Windows 11 | Every 8 hours      |

If the device recently enrolled, the check-in frequency is more frequent, as follows:

| Platform                          | Check-in frequency                                                                        |
| --------------------------------- | ----------------------------------------------------------------------------------------- |
| iOS                               | Every 15 minutes for 6 hours, and then every 6 hours                                      |
| macOS                             | Every 15 minutes for 6 hours, and then every 6 hours                                      |
| Android                           | Every 3 minutes for 15 minutes, then every 15 minutes for 2 hours, and then every 8 hours |
| Windows PCs (enrolled as devices) | Every 3 minutes for 30 minutes, and then every 8 hours                                    |

Users can also open the Company Portal app and sync the device to immediately check for the policy anytime.