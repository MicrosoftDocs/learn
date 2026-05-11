Gen1 virtual machines require migration to Gen2 architecture before Trusted Launch can be enabled. Once Trusted Launch is active, you can also adjust individual security components independently. You complete both scenarios and verify the final Trusted Launch configuration.

## Migrate a Gen1 VM to Gen2 with Trusted Launch

Gen1 virtual machines can't be directly upgraded to Trusted Launch—you must first migrate the VM from Gen1 to Gen2 architecture. This migration is more complex than the Gen2 security type upgrade because it changes fundamental VM characteristics, not just security settings.

The migration process uses Azure's built-in migration tools to convert the Gen1 VM to Gen2 while simultaneously enabling Trusted Launch. Azure doesn't support migrating Gen1 to Gen2 without enabling Trusted Launch—the two changes must happen together.

Before migrating, complete a critical OS disk prerequisite. Gen1 VMs use a Main Boot Record (MBR) disk layout, but Gen2 requires GUID Partition Table (GPT) with an Extensible Firmware Interface (EFI) system partition. On Windows, use the built-in `MBR2GPT.exe` utility to convert the disk layout before initiating the upgrade. Linux VMs require equivalent GPT conversion steps. Microsoft recommends upgrading a test Gen1 VM first to validate the process before upgrading production workloads.

> [!IMPORTANT]
> Windows Server 2016 doesn't include `MBR2GPT.exe` and isn't supported for the Gen1 to Trusted Launch upgrade path. If your VM runs Windows Server 2016, first perform an in-place OS upgrade to Windows Server 2019 or 2022, then run MBR2GPT conversion. Azure Linux and Debian are also excluded from the Gen1 to Trusted Launch upgrade path.

Also understand the following limitations:

- Ephemeral OS disks are supported, but vTPM-sealed keys and secrets can not persist across reimage or platform service healing events
- Certain legacy VM extensions can not be compatible with Gen2 architecture
- The VM's IP address can change if not using a reserved IP

The upgrade is performed in-place on the existing VM—Azure upgrades the same VM resource to Gen2 architecture with Trusted Launch enabled. Plan the migration during a maintenance window, as the VM must be stopped and deallocated during the upgrade.

To migrate a Gen1 VM through the Azure portal:

1. Complete the MBR-to-GPT OS disk conversion on the running VM before proceeding
2. Stop and deallocate the VM
3. Navigate to **Configuration** in the left navigation
4. Under **Security type**, select **Trusted launch** from the dropdown
5. Enable **Secure Boot**, **vTPM**, and **Integrity monitoring**
6. Select **Save** - Azure upgrades the VM in-place to Gen2 architecture with Trusted Launch enabled
7. Start the VM and verify it boots successfully
8. Confirm application functionality before returning the VM to production

After migration completes, the VM runs as a Gen2 Trusted Launch VM within the same resource—no new resource is created. Verify that all application functionality works correctly after restart.

> [!IMPORTANT]
> The Gen1 to Trusted Launch upgrade can't be rolled back to Gen1 configuration. If rollback is needed, you must restore from a backup or restore point taken before the upgrade. Take a backup of the Gen1 VM before starting the migration.

## Configure individual security components

You can enable or disable Secure Boot, vTPM, and integrity monitoring independently even after the VM is running. This flexibility is useful when troubleshooting compatibility issues or adjusting security posture for specific workloads.

:::image type="content" source="../media/trusted-launch-component-dependencies.png" alt-text="Diagram showing Trusted Launch components and the effect of disabling each one, including the dependency where disabling vTPM also disables integrity monitoring." lightbox="../media/trusted-launch-component-dependencies.png":::

To modify individual components, navigate to the VM's **Configuration** screen and locate the **Security type** section. Each component appears as a separate toggle. If the VM is running, Azure prompts you to restart—a full stop and deallocate isn't required.

Disabling Secure Boot removes signature enforcement for boot components. Use this option only when running custom or unsigned kernel modules that can't obtain valid signatures. For Contoso Manufacturing, disabling Secure Boot should require security team approval because it eliminates the primary defense against boot-level malware.

Disabling vTPM removes the ability to measure and attest boot integrity. Without vTPM, integrity monitoring can't function. Disable vTPM only if the VM experiences hardware compatibility issues with specific UEFI configurations.

Disabling integrity monitoring stops the Guest Attestation extension from reporting boot measurements to Defender for Cloud. Boot measurement still occurs via vTPM, but failures don't generate alerts. This configuration is useful for test environments where security alerting creates unnecessary noise.

## Verify Trusted Launch configuration

After enabling Trusted Launch, verify that all components are active and functioning correctly. Multiple verification points confirm successful configuration.

The VM's **Overview** page shows the security type in the **Properties** section. The value should display **Trusted Launch** rather than **Standard**. Trusted Launch value confirms the security type upgrades completed successfully.

The **Extensions + applications** tab lists all installed extensions. When integrity monitoring is enabled, you should see the **GuestAttestation** extension (or **GuestAttestationLinuxExtension** on Linux VMs) with a **Provisioning succeeded** status. If the extension shows **Provisioning failed**, review the extension logs to identify configuration issues.

Microsoft Defender for Cloud provides the most comprehensive verification. Navigate to Defender for Cloud and select **Inventory** to view all protected resources. Filter the list to show only VMs with Trusted Launch enabled. Each VM should display boot integrity monitoring as active. If Defender for Cloud shows a recommendation to enable integrity monitoring, the Guest Attestation extension failed to install correctly.
