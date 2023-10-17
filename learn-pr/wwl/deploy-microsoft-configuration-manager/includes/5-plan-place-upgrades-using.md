

Whether performed manually or through an automated process, in-place upgrade consists of using the Windows setup. The setup engine runs several small pre-installation checks, looking for known compatibility issues. It also preserves the user state and applications and only removes what isn’t compatible with the version of Windows being installed. With this option, previously installed applications and user state are preserved. In-place upgrade also allows you to roll back to the previous OS installed if needed for troubleshooting purposes.

Running setup manually isn't a scalable solution, even when using an unattended file. A task sequence is the recommended approach for large-scale deployments.

You can use both MDT and Configuration Manager to perform in-place upgrades using a task sequence. Like setup, this preserves the user’s files, apps, and settings, including the ability to roll back to the previous version if issues arise.

Until the device is upgraded to Windows 11 or later, traditional deployment tools must be used. Once the machine is upgraded to Windows 10 or Windows 11, solutions such as Windows Autopilot can be used for future servicing. This process is part of Windows Autopilot for existing devices and is covered in more detail later.

As discussed earlier, the environment and clients should be assessed prior to upgrading. Tools such as Upgrade Readiness, the Application Compatibility Toolkit, and the Windows and Planning Toolkit.

### Considerations for In-place Upgrades

The following considerations might be critical in determining whether you can perform an in-place upgrade:

 -  **The operating system and edition that can be upgraded to Windows**. You can upgrade to a higher Windows 11 edition, for example, from Windows 7 Professional to Windows 11 Enterprise. However, an in-place upgrade can’t migrate apps and user settings if you perform edition downgrade. For example, if you attempt to upgrade Windows 7 Enterprise to Windows 11 Pro, you'll be informed that the in-place upgrade can’t migrate any apps.
 -  **Sufficient hardware resources**. If a computer doesn’t meet minimum hardware requirements for Windows 11, you can’t perform an in-place upgrade. For example, if you attempt an in-place upgrade of a 64-bit Windows 8.1 computer that has 1 GB of RAM, you'll receive an error because you need at least 2 GB of RAM to upgrade to 64-bit Windows 11.
 -  **Windows 11–compatible hardware and apps**. If the earlier version of the Windows operating system uses device drivers or has installed apps that aren’t compatible with Windows 11, an in-place upgrade will stop and inform you about the issue. To find detailed information on these issues, you can run Setup.exe at an administrative command prompt by typing the following command and pressing Enter:

`Setup.exe /auto upgrade /compat scanonly`

Running Setup.exe creates several XML files that you can open and inspect for issues.

 -  **32-bit OS.** You can’t use an in-place upgrade to upgrade a 32-bit operating system to 64-bit Windows.
 -  **OS language**. You can’t use an in-place upgrade to change operating system languages. If you use an in-place upgrade, you must use Windows in the same language as the operating system that you want to upgrade. For example, you can’t upgrade Spanish Windows 8.1 to German Windows 10.
 -  **Dual boot/multiboot**. You can’t use an in-place upgrade for upgrading dual boot or multiboot computers.
 -  **Windows To Go/VHD**. You can’t use an in-place upgrade for upgrading Windows To Go media and computers that use virtual hard disks to start up.
 -  **Standard image only**. You can perform an in-place upgrade only by using the standard Windows image (Install.wim on the Windows installation media). The in-place upgrade doesn’t support using custom images because of potential conflicts between the existing apps and new apps in a custom image.

If an in-place upgrade fails in the last three phases, you can restart the device, and it will run its original operating system’s startup repair tool. This restores the original operating system and can take some time to complete.

If the upgrade path isn't supported, then an In-place upgrade can't be used. In these cases, a fresh install of the OS must be performed. This process is called an in-place migration and is discussed later in the lesson on migrating devices.
