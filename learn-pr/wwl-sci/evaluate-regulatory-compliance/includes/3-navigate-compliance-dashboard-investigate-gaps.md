Assigning compliance standards is only the first step in building a compliance program. The real work begins when you investigate which controls are passing, which are failing, and what actions you must take to close the gaps. For Contoso Healthcare, the Security Officer (CISO) needs a report identifying ISO 27001 control failures before the upcoming audit. Here, you learn how to navigate the regulatory compliance dashboard, drill into failing controls, and trace them to specific resource recommendations.

| Navigation Stage | Purpose |
|------------------|---------|
| Dashboard overview | Identify lowest-performing standards and overall pass rates |
| Standard drill-down | Review control status by category and access control details |
| Assessment investigation | Link failing controls to affected resources and remediation steps |
| Recommendation filtering | Focus remediation work on controls that influence specific frameworks |

## The compliance dashboard in the Defender portal

The regulatory compliance dashboard provides a centralized view of your organization's compliance posture across all assigned standards. You access the dashboard through the Defender portal at `https://security.microsoft.com` by navigating to **Cloud security** > **Regulatory compliance**.

At the top of the dashboard, you see a summary of your lowest-performing standards, highlighting which frameworks need immediate attention. Next, the dashboard displays each assigned compliance standard with its current pass rate. For Contoso Healthcare, ISO 27001 appears in this list with a percentage indicating how many of its controls currently pass automated assessments.

Selecting a compliance standard expands it to show all controls organized by category. The color-coded pass, fail, and unavailable states let you quickly identify which categories need attention and prioritize your investigation based on the number of failing controls.

## Drilling into a standard and its controls

When you select an individual control, you access detailed information through the **Control details** pane. This pane organizes information into three tabs that clarify responsibilities and actions.

The **Overview** tab describes the control requirement and explains what the control protects against. The **Your Actions** tab shows both automated and manual assessments that your organization owns under the shared responsibility model. Automated assessments link directly to Defender for Cloud recommendations, while manual assessments require you to provide attestation with supporting evidence. The **Microsoft Actions** tab displays platform-level controls that Microsoft manages, demonstrating how shared responsibility works in practice.

Under **Your Actions**, you find the specific assessments that Defender for Cloud uses to evaluate this control. Each automated assessment shows how many resources pass or fail, and selecting a failing assessment takes you directly to the affected resources with remediation guidance.

## Investigating a failing assessment

The following diagram shows the full investigation path—from opening the dashboard to verifying a remediated control.

:::image type="content" source="../media/compliance-investigation-flow.png" alt-text="Flow diagram showing the compliance investigation workflow: open the dashboard, select a standard, browse failing controls, open Control details, review Your Actions, select a failing assessment, view affected resources, apply remediation, and verify the updated score after the next assessment cycle.":::

Following Contoso Healthcare's ISO 27001 review, you identify that a network controls assessment is failing under ISO 27001 A.13.1.1. This control maps to the recommendation "Storage accounts should restrict network access."

Selecting this recommendation opens a detailed view showing all affected storage accounts. You see that three storage accounts currently allow public network access, creating compliance violations. Selecting one of the affected resources displays the remediation steps in the right pane.

For each storage account, the recommended action is to configure network rules that restrict access to specific virtual networks or IP address ranges. After you apply these network restrictions through the Azure portal or Infrastructure as Code templates, wait for the next assessment cycle before the dashboard reflects the change.

> [!NOTE]
> Compliance assessments run approximately every 12 hours. After remediating a failing control, wait for the next assessment cycle before the compliance dashboard reflects the updated status.

This investigation pattern connects the high-level control requirement to specific Azure resources that need configuration changes. By tracing from control to recommendation to resource, you create a clear remediation path that your team can execute.

## Filtering recommendations by compliance framework

The **Recommendations** page in the Defender portal supports compliance-focused work through framework filtering. Select the filter icon and choose a specific compliance standard to display only recommendations that affect controls in that framework.

This filtering helps you focus sprint work on a single framework or track remediation progress against an audit deadline. For Contoso Healthcare, filtering recommendations by ISO 27001 shows exactly which security improvements contribute to their upcoming audit readiness.

Filtering by framework also helps you understand the overlap between compliance requirements and general security posture. Many recommendations satisfy multiple compliance controls simultaneously, so remediating one issue often improves your standing across several standards.

