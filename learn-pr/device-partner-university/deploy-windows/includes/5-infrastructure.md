| Tasks | Deliverables |
|-------|--------------|
| - Monitor infrastructure.<br>- Remediate infrastructure and tooling.<br>- Sign off and update procedural documentation. | • Procedural documentation of observations and remediations |

## Monitor infrastructure

In the Prepare phase, you validated your infrastructure and tooling. In this Deploy phase, you should continue to validate that the infrastructure is still working as expected. Occasionally, a little tuning might be required to achieve the best results.

When monitoring infrastructure during deployment, review signals that indicate the status and progress of Windows feature upgrades. These signals can be observed through reporting resources such as:

- Windows Update for Business reports (Azure Workbooks)
   - [Feature update tab](/windows/deployment/update/wufb-reports-workbook#feature-updates-tab)
- Microsoft Intune
   - [Windows feature update report](/intune/intune-service/fundamentals/reports#windows-feature-update-organizational)
   - [Feature update failures report](/intune/intune-service/fundamentals/reports#feature-update-failures-report-operational)
- Windows Autopatch
   - [Windows feature update summary dashboard](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-feature-update-summary-dashboard)
   - [Windows quality and feature update reports](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-quality-and-feature-update-reports-overview#windows-feature-update-reports)
   - [Feature update status report](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-feature-update-status-report)

As an example, if you configured Delivery Optimization in the Plan and Prepare phases, you can monitor its effectiveness during deployment. Use the [Delivery Optimization report](windows/deployment/update/wufb-reports-workbook#bkmk_do) in the Windows Update for Business reports workbook to monitor how well it’s working across your organization.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document your observations, particularly if some remediation might be beneficial.

## Remediate infrastructure and tooling

If you identified any required infrastructure or tooling changes in the monitoring step, now is the time to implement them. Then continue to monitor to confirm that your infrastructure meets the expected performance.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Document any infrastructure and tooling changes made and the final validation results. Check: Do you need to get stakeholder approvals?

## Sign off and update procedural documentation

Document the success, failure, and remediation of all steps you take regarding the infrastructure.

| Tasks | Deliverables |
|-------|--------------|
| - Monitor infrastructure.<br>- Remediate infrastructure and tooling.<br>- Sign off and update procedural documentation. | • Procedural documentation of observations and remediations |
