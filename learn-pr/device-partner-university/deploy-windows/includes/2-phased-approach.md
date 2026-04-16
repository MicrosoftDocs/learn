Throughout this module, we refer to deployment rings and various project phases. Some of these terms are often used interchangeably, but for this module, we use the following definitions:

- **Proof of Concept (PoC)**: An optional phase often performed in a lab environment. It’s most helpful in the earliest stages of a project to test basic functionality and assumptions. This phase is sometimes called a limited pilot and is covered in the [Prepare phase](placeholderURL).
- **Pilot**: The first phase you perform in the production environment. Use it to test the wider infrastructure, connectivity, and application compatibility.
- **Broad deployment**: One or more further deployment phases in the production environment, called rings. In Windows Autopatch, these rings are named first, fast, and broad. Eventually they target most of the estate.

For this module, the focus is on the pilot and broad deployment phases.

![A diagram of deployment project phases: Lab PoC, pilot deployment, and ringed broad deployment in the production environment.](../media/project-phases.svg)

## Helpful reports across the deployment phases

Windows diagnostic data provides the information used in Windows update compatibility reports, so you don’t need to install agents. You can use Microsoft Intune or Microsoft Configuration Manager (as appropriate) to deploy diagnostic data settings to the devices you want to include in reporting.

> [!IMPORTANT]
> You might have to modify your [diagnostic data settings](/mem/intune/protect/data-enable-windows-data) to fully use the reports referenced throughout this module.

### Suggested reports

| Area of use | Report name | Source | Phase |
|------------|-------------|--------|-------|
| Device readiness | • [Windows feature update device readiness report](/mem/intune/protect/windows-update-compatibility-reports#use-the-windows-feature-update-device-readiness-report)| Microsoft Intune | Plan, Prepare |
| Device readiness | • [Windows feature update compatibility risks report](/intune/intune-service/protect/windows-update-compatibility-reports#use-the-windows-feature-update-compatibility-risks-report) | Microsoft Intune | Prepare |
| Device readiness | • [Work from anywhere report](/intune/analytics/work-from-anywhere) | Endpoint analytics | Plan |
| Device readiness | • [Feature updates – device status](/windows/deployment/update/wufb-reports-workbook#feature-updates-tab) | Windows Update for Business reports | Plan |
| Application inventory | • [Discovered apps report](/intune/intune-service/apps/app-discovered-apps) | Microsoft Intune | Plan |
| Device provisioning | • [Work from anywhere report](/intune/analytics/work-from-anywhere) | Endpoint analytics | Plan |
| Device identity | • [Work from anywhere report](/intune/analytics/work-from-anywhere) | Endpoint analytics | Plan |
| Deployment status | • [Feature update status report](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-feature-update-status-report) | Windows Autopatch | Deploy |
| Deployment status | • [Feature update trending report](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-feature-update-trending-report) | Windows Autopatch | Deploy |
| Deployment status | • [Management status report](/windows/deployment/windows-autopatch/monitor/windows-autopatch-management-status-report)    | Windows Autopatch | Deploy |
| Deployment status | • [Windows quality and feature update reports](/windows/deployment/windows-autopatch/monitor/windows-autopatch-windows-quality-and-feature-update-reports-overview#windows-feature-update-reports) | Windows Autopatch | Deploy |
| Deployment status | • [Feature update failures report (Organizational)](/intune/intune-service/fundamentals/reports#feature-update-failures-report-operational) | Microsoft Intune | Deploy |
| Deployment status | • [Windows feature update (Organizational)](/intune/intune-service/fundamentals/reports#windows-feature-update-organizational)      | Microsoft Intune | Deploy |
| Deployment status | • [Windows feature update report](/intune/intune-service/protect/windows-update-reports#use-the-windows-10-feature-updates-organizational-report) | Microsoft Intune | Deploy |
| Deployment efficiency | • [Delivery Optimization report](/windows/deployment/update/wufb-reports-workbook#bkmk_do) | Windows Update for Business reports | Deploy |

### Prerequisites for report use

| Report source | Prerequisites |
|--------------|---------------|
| Microsoft Intune | • Microsoft Entra joined or Microsoft Entra hybrid joined devices<br>• Devices managed by Microsoft Intune, by Configuration Manager with tenant attach enabled, or co-managed<br>• [Windows diagnostic data enabled](/windows/privacy/configure-windows-diagnostic-data-in-your-organization) (minimum level: “Required”).<br>• [Enabled diagnostic data in processor](/intune/intune-service/protect/data-enable-windows-data#windows-data)<br>• A valid license: Windows 10/11 Enterprise (E3, E5), Windows 10/11 Education (A3, A5), Windows Virtual Desktop Access (E3, E5), or Microsoft 365 Business Premium<br>• Devices running Windows 10, version 1903 or later <br><br> Use [Windows Update for Business reports](/intune/intune-service/protect/windows-update-reports#prerequisites) for Windows Updates in Microsoft Intune. |
| Endpoint analytics | Same prerequisites as Microsoft Intune. For more information, visit [What is Endpoint analytics?](/intune/analytics/overview#bkmk_prereq). |
| Window Update for Business reports (Azure workbook) | • Azure subscription with Microsoft Entra ID<br>• Microsoft Entra joined or Microsoft Entra hybrid joined devices<br>• Log analytics workspace in a supported region<br>• Devices running Windows 10/11 Professional, Education, or Enterprise edition<br>• [Windows diagnostic data enabled](/windows/privacy/configure-windows-diagnostic-data-in-your-organization) (minimum level: “Required”) <br><br> Check out prerequisites for [Windows Update for Business reports](/windows/deployment/update/wufb-reports-prerequisites) for more information.|  |
| Windows Autopatch | Same [prerequisites](/windows/deployment/windows-autopatch/prepare/windows-autopatch-prerequisites) as Microsoft Intune. |

> [!TIP]
> Are there any steps from the Prepare phase that you haven’t finished or still need help with? Have you addressed all stakeholder feedback for the plan and secured all necessary approvals? Review the checklist and your notes from the Prepare phase before moving forward.
