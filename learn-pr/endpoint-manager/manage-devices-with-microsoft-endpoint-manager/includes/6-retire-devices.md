When a device gets lost or stolen, when it needs to be replaced, or when users move to another position, it's usually time to retire or wipe the device. There are a number of ways you can do this, including resetting the device, removing it from management, and wiping the corporate data on it.

In Intune, you can add actions for noncompliance for devices that don't meet your organization's compliance policies or rules. This feature configures a time-ordered sequence of actions, such as emailing the end user, and more. One of the available actions for noncompliance is to retire the noncompliant device.

> [!IMPORTANT]
> Retiring a device from Intune leaves the user's personal data on the device.

The retire action removes managed app data (where applicable), settings, and email profiles that were assigned by using Intune. The device is removed from Intune management. The actual retirement happens the next time the device checks in and receives the remote retire action. The device still shows up in Intune until the device checks in. If you want to remove stale devices immediately, use the Delete action instead.

[ ![Sceenshot of retiring devices using Microsoft Intune.](../media/intro-to-endpoint-manager-18.png) ](../media/intro-to-endpoint-manager-18.png#lightbox)