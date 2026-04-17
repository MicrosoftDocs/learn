| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve device readiness:**         |                                                                  |
| - Run device driver readiness report.            | • List of device driver incompatibilities                        |
| - Perform device readiness remediation.          | • All devices ready to upgrade to Windows 11                     |
| - Remediate device identity.                      | • All devices provided with a device identity                    |
| - [Optional] Select and configure test devices.  | • [Optional] List of testing failures                             |
| - Sign off and update procedural documentation.  | • Procedural documentation of testing, remediation, and results  |

## Run device driver readiness report

Use Windows update compatibility reports to improve your organization’s device driver readiness. Take advantage of these reports to reduce the time and effort it takes to validate drivers in your environment. These are Microsoft Intune cloud-based reports. They can provide information on device readiness for a Windows feature update, and the compatibility risks likely to have the greatest effect in your organization.

In the Plan module, you might have already used these reports to identify which devices were eligible to receive the Windows 11 update. In this phase you can use the same reports to identify device drivers that might require remediation.  

At a high level, to get started with Windows update readiness reports, you’ll need to:

1. Access the [Microsoft Intune portal](https://intune.microsoft.com/).
2. Enable use of Windows diagnostic data by Intune.
3. Confirm ownership of Windows licenses on Windows data page. Note: Global Administrator or Intune Administrator role is required.
4. Configure devices.

> [!NOTE]
>
> Windows diagnostic data provides the information for Windows update compatibility reports, so it’s not necessary to install any agents. You can use Microsoft Intune or Microsoft Configuration Manager (as appropriate) to deploy diagnostic data settings to the clients you want to report on.

## Run the following report:

- **[Windows Feature Update device readiness report.](/mem/intune/protect/windows-update-compatibility-reports#use-the-windows-feature-update-device-readiness-report)** Get information about compatibility risks associated with the update, including app and driver issues on a per-device basis.

1. Sign in to the Microsoft Intune admin center.
2. In the admin center, go to Reports > Windows updates > select the Reports tab > select Windows Feature Update Device Readiness Report.
3. Configure settings:

   - Choose 'Select Target OS' and the version of Windows you plan to deploy.
   - Select other optional settings to refine the report.
   - Select 'Generate report'. This process can take several minutes. You're notified when report generation is complete.

Review the report for any device driver incompatibilities and document them.

> [!TIP]
> When an issue could result in a feature update failure or rollback, we might apply safeguard holds to prevent affected devices from installing the update. We remove these protections once a fix is found and verified.

> [!NOTE]
> ***Recommended deliverable***
>
> Document any device driver incompatibilities. Check: Do you need to get stakeholder approvals?

## Perform device readiness remediation

In both this and the Plan module, you evaluated the readiness of your devices for Windows 11. You should have identified which devices are capable of upgrade and which will need some remediation or replacement. Use this step to complete that remediation.

[Hardware remediation](/windows/whats-new/windows-11-requirements#hardware-requirements) might take the form of any of the following actions:

- Clear disk space
- Add memory
- Upgrade the TPM
- Update device drivers

For [Operating System remediation](/windows/whats-new/windows-11-requirements#os-requirements), you might need to install some updates to enable the upgrade to Windows 11.

Replace devices that are incapable of being upgraded as part of your normal PC refresh plan. Otherwise, you’ll have to initiate a procurement cycle for these devices.

> [!TIP]
>
> If you identified device driver incompatibilities, it's usually more successful to update them before attempting the Windows 11 update.

> [!NOTE]
> ***Recommended deliverable***
>
> All devices are ready to upgrade to Windows 11. Check: Do you need to get stakeholder approvals?

## Remediate device identity

In the Plan module, you identified devices that didn’t have a device identity. Use this step to enroll these devices into Microsoft Entra ID or other identity provider that you’ll be using.

> [!NOTE]
> ***Recommended deliverable***
>
> All devices provided with a device identity. Check: Do you need to get stakeholder approvals?

## [Optional] Select and configure test devices

Even if you decided not to perform a formal Proof of Concept, you might wish to allocate a few devices on which to perform some tests before you proceed to the deployment phase.

Such tests could be:

- Do the security and configuration settings behave as expected?
- Can I talk to my back-end systems?
- Do I need to adjust the user experience in any way?
- Can I run my business-critical apps?
- Are there new things that I need to inform my users about?

This can be a useful validation before you move to deployment.

> [!NOTE]
> ***Recommended deliverable***
>
> List of any identified gaps in your device readiness. Check: Do you need to get stakeholder approvals?

## Sign off and update procedural documentation

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the deployment phase.

| Tasks                                           | Deliverables                                                     |
|-------------------------------------------------|------------------------------------------------------------------|
| **Close gaps to achieve device readiness:**         |                                                                  |
| - Run device driver readiness report.            | • List of device driver incompatibilities                        |
| - Perform device readiness remediation.          | • All devices ready to upgrade to Windows 11                     |
| - Remediate device identity.                     | • All devices provided with a device identity                    |
| - [Optional] Select and configure test devices.  | • [Optional] List of testing failures                            |
| - Sign off and update procedural documentation.  | • Procedural documentation of testing, remediation, and results  |
