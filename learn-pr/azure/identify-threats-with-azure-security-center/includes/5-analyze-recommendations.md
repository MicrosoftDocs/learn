The assigned security policies create security recommendations. These recommendations can help to identify the current security state of your created workloads in Azure. Security Center reviews your security recommendations across all workloads, uses algorithms to determine how critical each recommendation is, and calculates a **Secure Score** which is displayed on the Overview page. The recommendation Secure Score is a calculation based on the ratio between your healthy resources and your total resources.

![Screenshot of the Secure Score shown on the Overview page of Security Center](../media/3-secure-score.png)

You can select the **Review your secure score >** link to get more information on each subscription and the recommendations to improve your score.

![Screenshot showing recommendations for a single subscription](../media/3-recommendations.png)

Here you can identify the severity of the issue, and get help on correcting each violation. In some cases, Security Center can even fix the issue for you through the **1-Click Fix** tag as shown above.

## Viewing recommendations by category

Under the **RESOURCE SECURITY HYGIENE** header in Security Center you can examine specific recommendations based on category. For example, the **Compute & apps** section of Azure Security Center provides recommendations for Azure VMs, non-Azure computers (standard-tier), App Services, Containers, and VM scale sets.

![Screenshot showing the Compute & App recommendations from Security Center](../media/4-compute-apps-recommendations.png)

As in the secure score screen, some recommendations can be fixed directly from the Security Center dashboard while other issues require you to perform some steps on the resource. For example, in the above image, the **System updates should be installed on your machines** will only give you the list of computers that need updates. To address this issue you would use a solution such as Windows Update Services (WSUS).

Each recommendation can be selected to get more details. For issues which need manual remediation, you will get a list of steps to perform. For example, selecting the **Virtual machines should be migrated to new Azure Resource Manager resources** will show the following screen:

![Screenshot showing the remediation steps for VM should be migrated to new ARM](../media/4-mediation-steps.png)

VMs are particularly important to protect as they often have a  broader attack surface than other compute resources. Azure Security Center helps you safeguard your virtual machines in Azure by providing visibility _into_ the security settings on each VM. As shown earlier, ASC can examine OS-level settings through the use of a _monitor_ service that it installs into each Windows and Linux VM. With this feature enabled, Security Center can provide several safeguards including:

- OS security settings with the recommended configuration rules
- System security updates and critical updates that are missing
- Endpoint protection recommendations
- Disk encryption validation
- Vulnerability assessment and remediation
- Threat detection

### Other categories

Security Center lists similar sections for Networking, IoT Hubs, Data & storage, Identity & access, and other security products such as the Next Generation Firewall and Web Application Firewall.

![Screenshot of the various sections you can explore in Security Center](../media/4-resource-security-hygiene.png)

Try selecting each item in the **RESOURCE SECURITY HYGIENE** section to see examples of recommendations Security Center makes for each area.

### Disabling security recommendations

It's recommended to leave all the security policies enabled, however sometimes a recommendation will be generated that isn't relevant to your environment. You can turn it off by disabling the security policy that is sending the recommendation.

1. In the **Policy & Compliance** section, select **Security policy**.

    ![Screenshot of the policy management screen in Security Center](../media/3-policy-management.png)

1. Select the subscription or management group that shouldn't show the recommendation.

    > [!NOTE]
    > Remember that a management group applies its policies to its subscriptions. Therefore, if you disable a subscription's policy, and the subscription belongs to a management group that still uses the same policy, then you will continue to receive the policy recommendations. The policy will still be applied from the management level and the recommendations will still be generated.

1. Select the assigned policy:

    ![Screenshot of the policy assignment](../media/3-security-policy.png)

1. In the **PARAMETERS** section, locate the policy that sends the recommendation you want to disable, and from the dropdown list, select **Disabled**.

    ![Screenshot of the screen to disable the recommendation](../media/3-disable-policy.png)

1. Select **Save** to persist your changes. The change can take up to 12 hours to replicate through the Azure infrastructure.

