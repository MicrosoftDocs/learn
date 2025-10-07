For ARM64 devices, hotpatch updates might not work if Compiled Hybrid Portable Executable (CHPE) support is enabled. To make these devices eligible for hotpatch updates, you might need to disable CHPE by setting the following registry key:

**Path:** HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management

**DWORD Key value:** HotPatchRestrictions=1

CHPE optimizes the performance of applications on ARM64 devices by compiling parts of the code to run more efficiently. However, when it comes to hotpatching, CHPE can interfere with the application of updates.

To ensure that hotpatch updates are applied correctly on ARM64 devices, CHPE must be disabled. This is because hotpatching updates the in-memory code of running processes, and CHPE binaries located in the %SystemRoot%\SyChpe32 folder aren't compatible with this process. Disabling CHPE allows hotpatch updates to be applied without requiring a system reboot.

> [!NOTE]
> An ARM64 device uses a 64-bit processor based on the ARM architecture, which is designed for high efficiency and low power consumption. These processors are commonly used in mobile devices, tablets, and lightweight laptops due to their strong performance and battery life.
>
> ARM stands for Advanced RISC Machines—a family of processors built on Reduced Instruction Set Computing (RISC). RISC uses a simplified set of instructions that can be executed quickly, making ARM processors especially well-suited for portable and embedded systems.

![Executive sitting at desk using laptop in an office with a panoramic view.](../media/executive.png)

## Enabling hotpatch updates

If all the prerequisites for hotpatch updates are met, you can use Windows Autopatch to opt devices in or out of automated hotpatch update deployment.

In other words, they can use Autopatch to manage which devices receive hotpatch updates automatically.

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

The Windows quality update policy can automatically determine whether targeted devices are eligible for hotpatch updates. Devices running Windows 10 and Windows 11, version 23H2 or earlier, will continue to receive standard monthly security updates. This ensures that systems remain protected and operational.