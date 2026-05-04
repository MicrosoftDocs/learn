If all the prerequisites for hotpatch updates are met, IT admins can use Windows Autopatch to opt devices in or out of automated hotpatch update deployment.

In other words, they can use Windows Autopatch to manage which devices receive hotpatch updates automatically.

![Photograph of executive sitting at desk using laptop in an office with a panoramic view.](../media/executive.png)

To enable hotpatching in the Microsoft Intune admin center:

1. Go to the Intune admin center.
2. Select Devices from the left navigation menu.
3. Under the Manage updates section, select Windows updates.
4. Go to the Quality updates tab.
5. Select Create, and select Windows quality update policy.
6. Under the Basics section, enter a name for your new policy and select Next.
7. Under the Settings section, ensure that the option "When available, apply without restarting the device ("Hotpatch") is set to Allow. Then, select Next.
8. Select the appropriate Scope tags or leave as Default. Then, select Next.
9. Assign the devices to the policy and select Next.
10. Review the policy and select Create.
11. You can also Edit the existing Windows quality update policy and set the "When available, apply without restarting the device ("Hotpatch") to Allow.

This policy enables the deployment of Windows quality updates, including hotpatch updates, through Windows Autopatch.

The Windows quality update policy can automatically determine whether targeted devices are eligible for hotpatch updates. Devices running Windows 11 version 23H2 or earlier will continue to receive standard monthly security updates. This ensures that systems remain protected and operational.
