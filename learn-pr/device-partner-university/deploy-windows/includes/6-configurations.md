Review deployment-related policies with respect to your security objectives, update compliance deadlines, and device activity.

| Tasks | Deliverables |
|-------|--------------|
| - Apply configurations.<br>- Monitor configurations.<br>- Remediate configurations.<br>- Sign off and update procedural documentation. | • Configurations completed and in place<br>• Procedural documentation of testing, remediation, and results |

## Apply configurations

In the Prepare phase you created and updated configurations for security baselines, policies and administrative templates, and network etc. In this phase you'll apply those configurations if you haven’t already done so.

During deployment, configurations are applied to devices through the active management platform.

In cloud managed environments, this typically occurs through Microsoft Intune via policy assignment. If you're using Windows Autopatch, configuration and update management are coordinated automatically as devices are registered and placed into deployment rings. In hybrid or on-premises environments, [configurations might also be applied through Configuration Manager](/intune/configmgr/compliance/deploy-use/deploy-configuration-baselines) and Group Policy.


> [!TIP]
>
> ***Recommended deliverable:***
>
> All configurations are in place to support the deployment of Windows 11.

## Monitor configurations

During the deployment phase you'll monitor test results and feedback to make sure that the configurations are providing the expected behavior.

When using Microsoft Intune, [monitor security baselines](/intune/intune-service/protect/security-baselines-monitor) deployed by Intune to verify that baseline policies are applied successfully and to identify devices where settings aren't applied or report errors. Deployment should be accompanied by monitoring to ensure that baseline enforcement remains consistent as the rollout scales. You should also [monitor configuration profile status](/intune/intune-service/configuration/device-profile-monitor) to verify that policies are applied successfully and to identify device reporting errors or conflicts.

In hybrid or on-premises environments, configuration baselines deployed through Configuration Manager should also be [monitored for compliance](/intune/configmgr/compliance/deploy-use/monitor-compliance-settings) to confirm that devices meet the expected configuration state.

If you’re using Windows Autopatch, review the [Windows Autopatch management status report](/windows/deployment/windows-autopatch/monitor/windows-autopatch-management-status-report) to understand how devices are managed for updates and configurations.

In addition to baseline application status, monitor user experience and device behavior. For example:

- Are users able to access the resources they need?

- Are users prevented from accessing resources they should be blocked from?

- Does the desktop experience provide the right environment for the user (“look and feel”)?

- Are applications working correctly?

- Are Windows quality updates being installed as expected?

- Are devices reporting in as expected?

As the deployment expands to more devices, other configuration-related issues might emerge. As such, you should revisit this task regularly throughout the deployment process.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Configurations are regularly reviewed with stakeholders and amended when necessary.

## Remediate configurations

If any issues are identified, you should review the configurations with the stakeholders and determine which, if any, changes need to be made.

Are there any old or conflicting policies? If you have a hybrid environment, pay particular attention to any policies that are old, outdated, no longer applicable, or no longer needed. If such policies are applied via Group Policy, they might cause conflicts. This is a common cause of misconfiguration and unexpected behavior.

If you're using Microsoft Intune or Windows Autopatch, [Alerts and remediations overview](/windows/deployment/windows-autopatch/monitor/alerts-remediations) and [Troubleshoot policies and configuration profiles in Microsoft Intune](troubleshoot/mem/intune/device-configuration/troubleshoot-policies-in-microsoft-intune) are resources that might help you.

Depending on the size or impact of the configuration remediations required, you might want to validate the changes in a test environment or a small deployment ring first.

> [!TIP]
>
> When documenting configuration changes, it's just as important to record the reason for making the change, because this will inform future IT admins.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document any configuration changes made.

## Sign off and update procedural documentation

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the next deployment phase.

| Tasks | Deliverables |
|-------|--------------|
| - Apply configurations.<br>- Monitor configurations.<br>- Remediate configurations.<br>- Sign off and update procedural documentation. | • Configurations completed and in place<br>• Procedural documentation of testing, remediation, and results |
