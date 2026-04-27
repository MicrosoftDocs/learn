In the Plan and Prepare phases, you completed the tasks needed to get your applications ready for Windows 11. Because Windows 11 offers 99.7% application compatibility, most apps will already be ready to deploy. However, the following recommendations can help you evaluate application compatibility in your specific environment:

| Tasks | Deliverables |
|------|--------------|
| - Deploy and test critical and important applications.<br>- Deploy and test other applications.<br>- Remediate applications.<br>- Review application decision matrix.<br>- Sign off and update procedural documentation. | • List of pass/fail test results and remediation steps identified<br>• Record of all remediated apps<br>• Record of apps that can't be remediated<br>• Documented go/no-go decisions for each deployment phase |

> [!TIP]
>
> Consider the time and resources you need to devote to application testing. Since most applications are already compatible with Windows 11, focus on testing business-critical apps and those required for regulatory compliance.

## Deploy and test critical and important apps

In the Prepare phase, you identified a prioritized list of applications to test during the pilot deployment. If you haven’t already, deploy these applications to the users and devices included in the pilot.

Work closely with the people identified in your RACI chart to ensure the applications are tested thoroughly.

Be sure to record pass/fail results along with any remediation steps you identify.

### General functionality testing

1. Install the application. If deployed from Intune, configuration is already applied. If manually installed, the application might need organization-specific configuration. This needs to be considered during or after installation depending on the application.
2. Verify product services are started.
3. Update the application, including both program and definition updates.
4. Test application core functionality.
5. Test application extended features, such as system tray context menu options or pop-up blockers. These are merely example features a product might contain, not a list of features you should include.

This is just an overview of general functionality testing. For more detailed guidance on how to test applications with Windows 11, visit the [Windows 11 testing guidelines](/windows/compatibility/windows-11/testing-guidelines).

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document test results and all apps that require remediation. Record the remediation steps, if applicable.

## Deploy and test other applications

As you move through the deployment phases, you'll deploy the applications that are required by the users and devices in the current deployment phase.

> [!TIP]
>
> When users go about their normal work on Windows 11, they’re effectively testing their apps. You can choose to rely on their feedback instead of running formal application testing.

Review any user feedback and monitor helpdesk calls to identify any common issues with app compatibility.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document test results and all apps that require remediation. Record the remediation steps, if applicable.

## Remediate applications

Use the information collected during testing to remediate applications wherever possible. Before taking action, consult the application decision matrix created during the Plan phase to help you:
- Estimate impact.
- Make deployment decisions (for example, whether to pause deployment broadly or only for affected devices). 
- Triage priority for each issue.

1. Identify the blocking application and the type of block.
   - Review Windows Update for “What needs your attention” messages to identify affected applications.
   - Use diagnostic tools such as SetupDiag (Microsoft diagnostic tool), WindowsUpdate.log, and the Application Compatibility Toolkit (ACT) to help you analyze and identify the root cause of blocks.

   **Common types of app blockers include:**
   - Applications using deprecated drivers
   - Applications with kernel-mode components incompatible with newer builds
   - Outdated security agents or anti-malware software
   - Legacy VPN or networking applications using outdated filter drivers
   - Applications that trigger hard blocks due to known issues
   - Applications requiring vendor updates before the OS can be upgraded

2. Remediate based on the application scenario.

   After identifying the blocking application, select the appropriate remediation action based on the application state and vendor support. The remediation actions available to you are:

   **Option A: Update the application (preferred):** If the application vendor provides a version supported on Windows 11, update the application to that version before retrying the upgrade.
  
   Microsoft compatibility updates and diagnostics are designed to allow upgrades once a compatible version of the application is detected.

   **Option B: Uninstall the blocking application:** If no compatible version exists:
   1. Uninstall the application (and related drivers or services).
   2. Retry the Windows 11 upgrade.
   3. Reinstall the application only after a supported version becomes available later.

   Incompatible applications might generate upgrade blocks that require removal before the upgrade can proceed.

   **Option C: Replace or retire the application:** For legacy or unsupported apps:
   - Replace the application with a modern, supported alternative.
   - Retire the app if it's no longer business critical.

   This is common with older antivirus, encryption, VPN, or device driver–dependent software, which frequently causes upgrade blocks.

   **Option D: Seek alternatives to running the application locally:** Some options include Software-as-a-service (SaaS) offerings from the vendor or running the application in Windows 365, Azure Virtual Desktop, or on a Remote Desktop Session Host (RDSH).

> [!TIP]
>
> If you can't resolve an application compatibility issue, consider using the [Microsoft App Assure](https://www.microsoft.com/fasttrack/microsoft-365/app-assure) service for assistance.

3. Remediate driver-related blocks.

   Some “application” blocks are actually caused by associated drivers (for example, printer, security, or virtualization drivers), not the application itself.
   
   Microsoft uses driver hard blocks to prevent upgrades when incompatible drivers are known to cause failures. These blocks must be remediated before the upgrade can proceed. In these instances, you should update the driver to a Windows 11–compatible version or remove the application if the driver can't be updated.

4. Rerun compatibility checks.
   
   After remediating blocking applications or drivers, retry the Windows 11 upgrade. Windows Setup automatically reevaluates compatibility using updated diagnostic definitions delivered through Windows Update. No manual reset of compatibility data is required.

### Quick reference: issue types and remediation

| **Issue Type**          | **Recommended Remediation**                                    |
|-------------------------|----------------------------------------------------------------|
| Outdated version        | Update or reinstall the application.                            |
| Incompatible driver     | Update the driver to a supported version or remove it.         |
| Security / VPN software | Update to a supported version.                                 |
| Legacy application      | Apply a shim using ACT or replace with a modern alternative.  |
| Hard block              | Update required; the upgrade can't proceed until resolved.    |

Microsoft Copilot can also help you troubleshoot issues with specific applications by referencing known issues, documented workarounds, official support guidance, and common patterns identified by Microsoft. You can ask it for suggestions on resolving problems and recommended troubleshooting steps.

> [!TIP]
>
> ***Recommended deliverable:***
>
> All applications are either remediated or documented for replacement if they can't be remediated.

## Review application decision matrix

In the Plan phase, you defined criteria to determine what action, if any, to take when testing an application is unsuccessful. Review these criteria together with the list of apps that failed testing. Use the decision matrix to determine whether to pause or stop deployment for all or some devices, or if you can safely continue. Consult with the relevant stakeholders from your RACI chart.

| Classification | Estimated impact of downtime | Deployment decision | Triage priority |
|---------------|----------------------------|------------------|----------------|
| *Your app classification based on impact* | *Your definitions* | *Your definitions* | *Your decision* |
| Critical | Work stoppage or loss of revenue | Stop the deployment. | Investigate and resolve any identified issues or risks as soon as possible. |
| Very important | Productivity loss for a business unit | Stop the deployment for affected devices only. | Start investigating risks and issues within two business days and fix them *during* the current deployment cycle. |
| Important | Productivity loss for individual users | Continue the deployment but provide workaround guidance for affected users if possible. | Start investigating risks and issues within 10 business days. You don't have to fix them all within the current deployment cycle. However, all issues must be fixed by the end of the next deployment cycle. |
| Not important | Minimal impact on users | Continue the deployment. | Start investigating risks and issues within 20 business days. You can fix them in the current or any future deployment cycle. |

> [!NOTE]
>
> The specifics will vary for your organization.

### Scenario: Applying the Application Decision Matrix during deployment

During pilot deployment, an IT team at Contoso, Inc. identifies several applications that don't pass compatibility testing on Windows 11. The team reviews the failed applications against the application decision matrix.

#### Application: Custom inventory management tool

One of the failed applications is a custom inventory management tool used by warehouse staff. The application supports daily operations, and downtime would disrupt order fulfillment.

- **Classification by impact:** Very important
- **Deployment decision:** Based on the decision matrix, the team pauses the Windows 11 deployment only for devices used by warehouse employees, while continuing deployment for the rest of the organization. The application owner and operations lead are engaged to investigate the issue, and remediation begins within the current deployment cycle.

#### Application: Legacy reporting add-in

Another application—a legacy reporting add-in used by a small group of individual contributors—fails testing but has a known workaround.

- **Classification by impact:** Important
- **Deployment decision:** The team continues the deployment, publishes workaround guidance to affected users, and schedules remediation for a future update.

#### Application: Noncritical internal utility

A noncritical internal utility used infrequently by a handful of users fails testing.

- **Classification by impact:** Not important
- **Deployment decision:** The deployment continues without interruption, and the issue is added to the backlog for investigation during a later deployment cycle.

Throughout this process, the deployment team consults stakeholders identified in the RACI chart to confirm classifications and decisions before acting.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document your deployment go/no-go decisions as you progress through each deployment phase.

## Sign off and update procedural documentation

Document the success, failure, and remediation of all steps you take to close the application testing gaps.

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the next deployment phase (if that is what your application handling criteria dictates).

| Tasks | Deliverables |
|-------|--------------|
| - Deploy and test critical and important applications.<br>- Deploy and test other applications.<br>- Remediate applications.<br>- Review application handling criteria.<br>- Sign off and update procedural documentation. | • List of pass/fail test results and remediation steps identified<br>• Record of all remediated apps<br>• Record of apps that can't be remediated<br>• Documented go/no-go decisions for each deployment phase |
