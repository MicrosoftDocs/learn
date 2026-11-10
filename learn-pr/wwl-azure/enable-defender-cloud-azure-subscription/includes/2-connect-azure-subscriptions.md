Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP) with a set of security measures and practices designed to protect your cloud-based applications end-to-end by combining the following capabilities:

- A development security operations (DevSecOps) solution that unifies security management at the code level across multicloud and multiple-pipeline environments.
- A cloud security posture management (CSPM) solution that surfaces actions that you can take to prevent breaches.
- A cloud workload protection platform (CWPP) with specific protections for servers, containers, storage, databases, and other workloads.

Defender for Cloud includes Foundational CSPM capabilities and access to Microsoft Defender XDR for free. You can add paid plans for the workloads you need to protect.

Eligible paid plans have a trial that lasts up to 30 days, or until the applicable trial usage limit is reached, whichever comes first. Charges then apply for plans that remain enabled. Check the trial status for the selected Azure subscription and plan instead of assuming that a new trial is available. For current plan costs and usage limits, review the Defender for Cloud pricing page.

> [!IMPORTANT]
> Defender for Storage malware scanning isn't included in the free trial and is charged from day one. Underlying Azure resources and other separately billed services can also incur charges.

Defender for Cloud helps you find and fix security vulnerabilities. Its capabilities include access controls, threat detection, and security recommendations. The protection you receive depends on the plans, features, and workloads you configure.

## Prerequisites

You need access to an Azure commercial subscription. Reader, Contributor, or Owner at subscription or resource-group scope can view resource information within that scope.

To enable or disable Defender plans for this subscription, you need Security Admin, Contributor, or Owner at subscription scope. Resource-group Contributor or Owner doesn't grant this subscription-level permission.

> [!IMPORTANT]
> Permission to toggle a plan isn't permission to deploy every capability or remediate every resource. Owner is required to enable all capabilities of a plan, and monitoring components can have additional requirements. Use the least-privileged role needed for each task. For action-specific permissions, review Defender for Cloud roles and permissions.

## Enable foundational protection

> [!NOTE]
> These instructions use the Azure portal. Defender for Cloud also has experiences in the Microsoft Defender portal, with different navigation and feature availability. Use the Azure portal for the procedures in this module.

1. Sign in to the Azure portal.
1. Search for and select **Microsoft Defender for Cloud**.

   :::image type="content" source="../media/microsoft-defender-cloud-subscription-f2daf5b1-597fb3a2.png" alt-text="Screenshot of an Azure portal search for Microsoft Defender for Cloud.":::

1. On the overview page, use the subscription filter to confirm that you're viewing the intended subscription.

   :::image type="content" source="../media/defender-cloud-overview-page-8c732b76-064b7fda.png" alt-text="Screenshot of the Microsoft Defender for Cloud overview page.":::

Opening Defender for Cloud starts the foundational onboarding experience described here. Paid workload protection plans are configured separately. Foundational capabilities include:

- The Foundational CSPM plan.
- Recommendations.
- Asset inventory.
- Workbooks.
- Secure score.
- Assessment against the Microsoft Cloud Security Benchmark (MCSB).

Access to additional regulatory standards has separate plan and permission prerequisites. Review the guidance for assigning regulatory compliance standards.

The Defender for Cloud overview page provides a unified view of the security posture of your connected workloads. The subscription filter changes the scope displayed on the dashboard.

After onboarding, you might begin to see recommendations and an inventory of assessed resources. Allow time for resource discovery and assessment. An empty view doesn't establish that all resources are protected or compliant.

## Enable a workload protection plan

Enable the plans needed for the workloads you intend to protect. Subscription-level settings apply to eligible resources for each plan, subject to its support requirements and any resource-level configuration. A plan for one workload doesn't protect every type of resource in the subscription.

The following walkthrough uses Defender for Servers Plan 2, the same plan used in the next unit's lab. Use an authorized training subscription and record the existing plan, tier, and feature settings before changing anything. If the intended plan is already configured, verify it rather than repeating the changes.

1. In the Azure portal, open **Microsoft Defender for Cloud**.
1. Select **Environment settings**, then select the intended Azure subscription.

   :::image type="content" source="../media/environmental-settings-b7df4178-dfcf6719.png" alt-text="Screenshot of Environment settings in the Defender for Cloud menu.":::

1. On **Defender plans**, review the current Servers setting and trial/pricing information. Hover over an active trial indicator to see the remaining time. If no trial indicator is shown, don't assume that a free trial remains.
1. With authorization to change the subscription, set **Servers** to **On**.
1. Review the selected plan. The default is Plan 2. If needed, select **Change plans**, choose **Plan 2**, and select **Confirm**.
1. Select **Save**.
1. Reopen the subscription's Defender plans page and confirm that the intended Servers plan and tier are saved.

> [!NOTE]
> Select the subscription for this exercise, not a Log Analytics workspace. Workspaces still support specific features, such as file integrity monitoring and the Servers Plan 2 data ingestion benefit. They aren't interchangeable with subscription scope for enabling all Defender plans.
> For new subscriptions, suspicious DNS activity alerts are included in Defender for Servers Plan 2. DNS protection applies to Azure resources using Azure's default DNS resolvers. You don't need to enable a separate DNS plan for this exercise.

## Verify coverage and review settings

Saving a plan enables its configured capabilities. It doesn't prove that every resource has completed onboarding or that every optional feature is active.

1. In **Microsoft Defender for Cloud**, open **Inventory**.
1. Filter to the intended subscription and supported server resource types.
1. Review the **Defender for Cloud** coverage status for an authorized test machine. If no supported machines are present, stop at plan-configuration verification.
1. Open the machine's security information and review applicable recommendations and monitoring or endpoint-protection issues. Check these separately from the plan's enabled state.
1. Return to **Environment settings**, select the subscription, and open **Settings** for Servers to review **Settings and monitoring**.
1. Confirm the settings appropriate to the exercise. Defender for Endpoint integration and agentless scanning are enabled by default with Servers Plan 2. File integrity monitoring requires separate configuration and isn't enabled by default.
1. If coverage is missing, check resource-level exclusions, supported operating systems, permissions, connectivity, and provisioning status. Allow time for deployment and assessment before concluding that onboarding failed.

> [!IMPORTANT]
> **Enable all** can activate additional paid plans. Use it only when you've reviewed the required coverage, permissions, and costs. It isn't necessary for this Servers exercise.

You can also use the Coverage workbook to review plan coverage across subscriptions and resources. An absence of alerts doesn't prove either that protection is working or that deployment failed.

> [!NOTE]
> Different plans have different completion steps. For example, Defender for APIs requires onboarding supported APIs after enabling its subscription plan. Don't infer full workload protection from an enabled subscription switch alone.

## Review compliance posture

The Microsoft Cloud Security Benchmark (MCSB) supplies the default Azure security benchmark and recommendations. Foundational CSPM includes MCSB. Access to additional regulatory standards has separate plan and permission prerequisites. To view policy compliance data, use an account with Reader access to that data, such as a subscription Reader. Security Reader alone doesn't grant that access.

1. In **Microsoft Defender for Cloud** in the Azure portal, open **Regulatory compliance**.
1. Confirm the subscription in scope and select the available MCSB standard.
1. Expand a control and select an available assessment to inspect the affected resources and remediation guidance.
1. If a failed assessment is available, review its recommended action and identify who is authorized to make that change. Don't apply changes to production resources as part of this exercise.
1. Review **Control details**, including customer actions and Microsoft's responsibilities. Distinguish automated assessments from controls requiring manual evidence.
1. After an approved remediation, allow the next assessment to run before expecting an updated result.

> [!NOTE]
> If relevant resources or assessment results aren't available yet, record that limitation rather than assuming compliance or deliberately introducing a misconfiguration. Controls that can't be automatically assessed aren't evidence of a pass. A dashboard score isn't a certification of your organization's compliance.

### Assign an additional standard

For this optional activity, use an authorized training subscription with a qualifying plan such as Servers Plan 2, relevant resources, and an Owner account. Owner is a sufficient role for this exercise, not the only possible authorization. Check the current standards-assignment prerequisites for other supported roles and plan requirements. Foundational CSPM alone isn't sufficient for the additional-standard workflow. Servers Plan 1 and APIs Plan 1 don't qualify on their own.

1. In **Regulatory compliance**, select **Manage compliance policies**.
1. Select the intended subscription and then **Security policies**.
1. Locate an appropriate standard and set it to **On**. Complete any required parameters and confirmation prompts.
1. Return to **Regulatory compliance** and review the standard after relevant resources have been assessed.

> [!IMPORTANT]
> An assigned standard might not appear when the subscription has no relevant assessed resources. Assignment doesn't remediate failed controls or establish certification. Record any assignment made only for training and remove that assignment afterward only with authorization.

## Clean up exercise changes

Use these steps when you've finished the walkthrough and the next unit's lab. Only reverse changes made for this exercise, with approval from the subscription owner. Don't disable pre-existing or production protection.

1. Compare the current settings with the configuration recorded before making any exercise changes.
1. If the plan was enabled only for this exercise and isn't required afterward, open **Environment settings**, select the subscription, turn the relevant plan **Off**, and select **Save**. If the exercise changed an existing tier or feature setting, restore the approved original configuration instead.
1. Review separately configured workspace or resource-level plans. A subscription-level change doesn't necessarily remove independently configured coverage or charges.
1. Verify the saved plan state and the actual protection and reporting state of affected machines. Check deployment policies that might reapply settings.
1. If you assigned an additional standard only for training, return to **Regulatory compliance > Manage compliance policies**, select the subscription, and open **Security policies**. Turn off only that training assignment with authorization, preserving any pre-existing assignments.
1. Remove only disposable resources created for the exercise that are no longer needed. Turning off a Defender plan doesn't stop charges for underlying Azure resources.

> [!WARNING]
> Disabling protection can affect endpoint reporting and active investigations. For eligible Azure servers, the supported automatic offboarding flow can offboard Defender for Endpoint when Servers is disabled. Check applicability and rollout status for your environment. If automatic offboarding doesn't apply and you intend to offboard the machines, follow the documented manual process. Offboarding, extension removal, software uninstallation, and deletion of historical data are different operations.

Use the current Defender for Servers disablement guidance and Defender for Endpoint offboarding guidance to determine the appropriate process and confirm the outcome.

For source references, use the More info section in the Summary unit.
