The assigned security policies create security recommendations. These recommendations can help to identify the current security state of your created workloads in Azure. Defender for Cloud reviews your security recommendations across all workloads, uses algorithms to determine how critical each recommendation is, and calculates a **Secure Score** which appears on the Overview page. The recommendation Secure Score is a calculation based on the ratio between your healthy resources and your total resources.

:::image type="content" source="../media/5-defender-for-cloud-secure-score.png" alt-text="Screenshot of the Secure Score shown on the Overview page of Defender for Cloud.":::

You can select the **Improve your secure score >** link to get more information about each subscription. Select **View recommendations** for a subscription to improve your score.

:::image type="content" source="../media/5-defender-for-cloud-secure-score-dashboard.png" alt-text="{Screenshot that shows the Secure Score Dashboard.}":::

On the Recommendations pane, you can identify the severity of the issue and get help on correcting each violation. In some cases, Defender for Cloud can even fix the issue for you with a **Quick fix**. Recommendations with a quick fix option display a lightning bolt icon in the **Insights** column.

:::image type="content" source="../media/5-defender-for-cloud-recommendations.png" alt-text="Screenshot that shows the Recommendations pane with a quick fix icon in the recommendations list.":::

## View recommendations by category

In **Defender for Cloud**, select **Recommendations** from the left menu pane. The **Recommendations** pane displays. Here, you can examine specific recommendations based on category. For example, **Apply system updates** provides recommendations for updates to Azure virtual machines (VMs) and virtual machine scale sets.

:::image type="content" source="../media/5-defender-for-cloud-recommendations-categories.png" alt-text="Screenshot that shows the recommendations pane with the Apply system updates category selected.":::

As in the secure score pane, some recommendations can be fixed directly from the dashboard while other issues require you to perform some steps on the resource. For example, in the previous image, the **System updates should be installed on your machines** will only give you the list of affected resources that need updates. To address this issue, you would use a solution such as Windows Update Services (WSUS).

Each recommendation can be selected to get more details. For issues that need manual remediation, you'll get a list of steps to perform. For example, selecting the **Virtual machines should be migrated to new Azure Resource Manager resources** will show the following screen.

:::image type="content" source="../media/5-defender-for-cloud-recommendations-remediation-steps.png" alt-text="Screenshot that shows the recommendation details pane with the Remediation steps drop-down displayed.":::

VMs are important to protect as they often have a broader attack surface than other compute resources. Microsoft Defender for Cloud helps you safeguard your VMs in Azure by providing visibility *into* the security settings on each VM. As previously shown, Defender for Cloud can examine OS-level settings by using a *monitor* service that it installs into each Windows and Linux VM. With this feature enabled, Defender for Cloud can provide several safeguards, including:

- OS security settings with the recommended configuration rules.
- System security updates and critical updates that are missing.
- Endpoint protection recommendations.
- Disk encryption validation.
- Vulnerability assessment and remediation.
- Threat detection.

### Other categories

Defender for Cloud lists similar sections for Networking, IoT Hubs, Data & storage, and Identity & Access. It also has sections for other security products like the Next Generation Firewall and Web Application Firewall.

Try selecting each item under the **All recommendations** tab to see examples of recommendations Defender for Cloud makes for each area.

### Disable security recommendations

It's recommended to leave all the security policies enabled; however, sometimes a recommendation will be generated that isn't relevant to your environment. You can turn it off by disabling the security policy that is sending the recommendation.

1. Select **Environment settings** in the left menu pane, and then select the subscription or management group that shouldn't show the recommendation.

    > [!NOTE]
    > Remember that a management group applies its policies to its subscriptions. Therefore, if you disable a subscription's policy, and the subscription belongs to a management group that still uses the same policy, you will continue to receive the policy recommendations. The policy will still be applied from the management level, and the recommendations will still be generated.

1. Select **Security policy**, and then select the assigned policy.

     :::image type="content" source="../media/4-defender-for-cloud-security-policy-select.png" alt-text="Screenshot of the Security policy pane with the default initiative selected.":::

1. Select the **PARAMETERS** tab, and locate the policy that sends the recommendation you want to disable.

1. From the dropdown list, select **Disabled**.

    :::image type="content" source="../media/5-defender-for-cloud-edit-policy-parameter.png" alt-text="Screenshot that shows a policy parameter with 'Disabled' selected.":::

1. Select **Review + Save** to persist your changes. The change can take up to 12 hours to replicate through the Azure infrastructure.
