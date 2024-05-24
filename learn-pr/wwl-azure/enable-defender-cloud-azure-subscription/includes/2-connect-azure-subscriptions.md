Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP) with a set of security measures and practices designed to protect your cloud-based applications end-to-end by combining the following capabilities:

 -  A development security operations (DevSecOps) solution that unifies security management at the code level across multicloud and multiple-pipeline environments.
 -  A cloud security posture management (CSPM) solution that surfaces actions that you can take to prevent breaches.
 -  A cloud workload protection platform (CWPP) with specific protections for servers, containers, storage, databases, and other workloads.

Defender for Cloud includes Foundational CSPM capabilities and access to [Microsoft Defender XDR](/microsoft-365/security/defender/microsoft-365-defender) for free. You can add additional paid plans to secure all aspects of your cloud resources. You can try Defender for Cloud for free for the first 30 days. After 30 days charges begin in accordance with the plans enabled in your environment. To learn more about these plans and their costs, see the Defender for Cloud [pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/).

> [!IMPORTANT]
> Malware scanning in Defender for Storage is not included for free in the first 30 day trial and will be charged from the first day in accordance with the pricing scheme available on the Defender for Cloud [pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/).

Defender for Cloud helps you find and fix security vulnerabilities. Defender for Cloud also applies access and application controls to block malicious activity, detect threats using analytics and intelligence, and respond quickly when under attack.

## Prerequisites

 -  To view information related to a resource in Defender for Cloud, you must be assigned the Owner, Contributor, or Reader role for the subscription or for the resource group that the resource is located in.
    
    :::image type="content" source="../media/microsoft-defender-cloud-subscription-f2daf5b1.png" alt-text="Screenshot showing an example of how to search for Microsoft Defender for Cloud.":::
    
 -  The Defender for Cloud's overview page opens.
    
    :::image type="content" source="../media/defender-cloud-overview-page-8c732b76.png" alt-text="Screenshot showing an example of the Microsoft Defender for Cloud overview page.":::
    

Defender for Cloud is now enabled on your subscription and you have access to the basic features provided by Defender for Cloud. These features include:

 -  The [Foundational Cloud Security Posture Management (CSPM)](/azure/defender-for-cloud/concept-cloud-security-posture-management) plan.
 -  [Recommendations](/azure/defender-for-cloud/security-policy-concept).
 -  Access to the [Asset inventory](/azure/defender-for-cloud/asset-inventory).
 -  [Workbooks](/azure/defender-for-cloud/custom-dashboards-azure-workbooks).
 -  [Secure score](/azure/defender-for-cloud/secure-score-security-controls).
 -  [Regulatory compliance](/azure/defender-for-cloud/update-regulatory-compliance-packages) with the [Microsoft cloud security benchmark](/azure/defender-for-cloud/concept-regulatory-compliance).

The Defender for Cloud overview page provides a unified view into the security posture of your hybrid cloud workloads, helping you discover and assess the security of your workloads and to identify and mitigate risks. Learn more in [Microsoft Defender for Cloud's overview page](/azure/defender-for-cloud/overview-page).

You can view and filter your list of subscriptions from the subscriptions menu to have Defender for Cloud adjust the overview page display to reflect the security posture to the selected subscriptions.

Within minutes of launching Defender for Cloud for the first time, you might see:

 -  Recommendations for ways to improve the security of your connected resources.
 -  An inventory of your resources that Defender for Cloud assesses along with the security posture of each.

## Enable all paid plans on your subscription

To enable all of Defender for Cloud's protections, you need to enable the plans for the workloads that you want to protect.

When you enable Defender plans on an entire Azure subscription, the protections are applied to all other resources in the subscription.

To enable additional paid plans on a subscription:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Search for and select **Microsoft Defender for Cloud**.
3.  In the Defender for Cloud menu, select **Environment settings**.
    
    :::image type="content" source="../media/environmental-settings-b7df4178.png" alt-text="Screenshot showing an example of how to navigate to Defender for Cloud's Environment settings page.":::
    
4.  Select the subscription or workspace that you want to protect.
5.  Select **Enable** all to enable all of the plans for Defender for Cloud.
    
    :::image type="content" source="../media/enable-all-plans-fe385b32.png" alt-text="Screenshot showing an example of how to Enable all plans in Defender for Cloud's Settings page.":::
    
6.  Select **Save**.

All of the plans are turned on and the monitoring components required by each plan are deployed to the protected resources.

If you want to disable any of the plans, toggle the individual plan to **off**. The extensions used by the plan aren't uninstalled but, after a short time, the extensions stop collecting data.

> [!TIP]
> To enable Defender for Cloud on all subscriptions within a management group, see [Enable Defender for Cloud on multiple Azure subscriptions](/azure/defender-for-cloud/onboard-management-group).
