In this unit, you'll learn how to enable Microsoft Defender for Cloud on your Azure subscription.

Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP) with a set of security measures and practices designed to protect your cloud-based applications end-to-end by combining the following capabilities:

 -  A development security operations (DevSecOps) solution that unifies security management at the code level across multicloud and multiple-pipeline environments
 -  A cloud security posture management (CSPM) solution that surfaces actions that you can take to prevent breaches
 -  A cloud workload protection platform (CWPP) with specific protections for servers, containers, storage, databases, and other workloads

Defender for Cloud includes Foundational CSPM capabilities and access to [Microsoft Defender XDR](/microsoft-365/security/defender/microsoft-365-defender) for free. You can add additional paid plans to secure all aspects of your cloud resources. You can try Defender for Cloud for free for the first 30 days. After 30 days charges begin in accordance with the plans enabled in your environment. To learn more about these plans and their costs, see the Defender for Cloud [pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/).

> [!IMPORTANT]
> Malware scanning in Defender for Storage is not included for free in the first 30 day trial and will be charged from the first day in accordance with the pricing scheme available on the Defender for Cloud [pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/).

Defender for Cloud helps you find and fix security vulnerabilities. Defender for Cloud also applies access and application controls to block malicious activity, detect threats using analytics and intelligence, and respond quickly when under attack.

> [!IMPORTANT]
> To view information related to a resource in Defender for Cloud, you must be assigned the Owner, Contributor, or Reader role for the subscription or for the resource group that the resource is located in.

## Enable Defender for Cloud on your Azure subscription

To enable Defender for Cloud on all subscriptions within a management group, see [Enable Defender for Cloud on multiple Azure subscriptions](/azure/defender-for-cloud/onboard-management-group).

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Search for and select **Microsoft Defender for Cloud**
    
    :::image type="content" source="../media/defender-for-cloud-search-77e631eb.png" alt-text="Screenshot of the Azure portal with Microsoft Defender for Cloud selected.":::
    
    
    The Defender for Cloud's overview page opens.
    
    :::image type="content" source="../media/overview-defender-cloud-4cfa27a4.png" alt-text="Screenshot of Defender for Cloud's overview dashboard.":::
    

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

 -  **Recommendations** for ways to improve the security of your connected resources.
 -  An inventory of your resources that Defender for Cloud assesses along with the security posture of each.
