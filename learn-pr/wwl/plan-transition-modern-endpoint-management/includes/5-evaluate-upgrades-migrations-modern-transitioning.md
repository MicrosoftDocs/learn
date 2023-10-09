

Device migration is like deploying a new device. The deployment to the target device, whether it be the same or a different device, is typically the same process as a new device. You can use a traditional process, such as reimaging the device, or if the target device has Windows 11, you can use modern methods, such as Autopilot.

The key difference is consideration for the end user's data and configuration. The process must include a way to safely and securely ensure that user data and settings aren't lost during the process.

Scenarios for migrating users can include:

 -  The user's device is being replaced.
 -  The user's existing device is being upgraded from an older OS to Windows 11 and an in-place upgrade isn't possible (such as an unsupported upgrade path).
 -  A clean installation is needed. You may want to do this if the current state of the PC is undesirable. For example, the PC has performance or stability issues unrelated to hardware or the device hasn't been ideally maintained (it has legacy or unapproved apps installed, non-standard configuration, etc.)

Depending on your environment, you can use two migration scenarios: side-by-side migration or wipe-and-load migration, which is also referred to as a refresh migration. In a refresh migration scenario, the source computer and the destination computer are the same, whereas in a side-by-side migration scenario, the source computer and the destination computer are different. Both migration scenarios require a clean installation of Windows 11. When you migrate configurations from an older version of the Windows operating system, you're moving files and settings to a clean installation of the Windows operating system.

Careful consideration should be given when choosing to migrate instead of upgrade. Whenever an in-place migration is performed, there can be a risk of loss of data if either IT or the user didn't properly identify data that needed to be migrated. If something goes wrong during the deployment, a migration can't be rolled back.

| **In-place upgrade** | **Migration**               |
|--------------------|----------------------------|
| Preserves the environment | Provides a standardized environment |
| Doesn't need to reinstall apps or transfer data | You can control what migrates |
| Upgrade can be rolled back if needed | Cleans up the environment |
| Only certain upgrade paths are possible | You must reinstall the apps |
| You must use the default Windows image | You can use a custom Windows image |


The process of preparing the destination computer isn't unlike deploying a new computer or refreshing an existing one. In the case of side-by-side migrations, if the new device has Windows 11, you can use modern methods like Autopilot to configure the device. If performing an in-place migration, you can use Autopilot for existing devices or you can use traditional methods, as well.

### In-place upgrades

Modern desktop deployment with Windows Autopilot helps you easily deploy the latest version of Windows to your existing devices. You can adapt this method for an existing legacy device (such as Windows 7/8.1) to both transform a traditional domain joined endpoint into an Azure AD managed device and perform a rebuild, all within the same piece of automation. Alternatively, you must build devices from fresh using Autopilot from a vanilla Windows 11 PC.

:::image type="content" source="../media/autopilot-for-existing-devices-task-sequence-editor-21352361.png" alt-text="Screenshot of Task Sequence Editor showing Autopilot for existing devices options.":::


As with many of the options that exist in a deployment strategy, transforming a device is only relevant if this fits into your overall planning approach. You may want to begin your journey with newly provisioned devices and migrate over time.

With tools such as Microsoft Intune and Autopilot, device deployment and the deployment scenarios are beginning to change. Co-management offers that bridge to spread workloads between Intune and Configuration Manager. This means that co-management can offer a path to modern management (with a workflow moved fully to Intune) or it can be part of the journey in helping an enterprise get to modern management by allowing it to trial the workload in Intune while running most production clients from Configuration Manager.

> [!TIP]
> With some of the workloads that can be moved at present, it's common to set up Autopilot groups to test co-management workloads. For example, you can move a group of devices being managed by Configuration Manager for software updates to Intune, which manages them using a Windows Update for Business (WuFB) policy.
