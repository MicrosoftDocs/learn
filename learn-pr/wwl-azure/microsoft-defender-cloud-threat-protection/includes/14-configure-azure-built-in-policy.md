Enabling Defender for Storage via a policy is recommended because it facilitates enablement at scale and ensures that a consistent security policy is applied across all existing and future storage accounts within the defined scope (such as entire management groups). This keeps the storage accounts protected with Defender for Storage according to the organization's defined configuration.

You can always configure specific storage accounts with custom configurations that differ from the settings configured at the subscription level (override subscription-level settings).

## Azure built-in policy

To enable and configure Defender for Storage at scale with an Azure built-in policy, follow these steps:

1.  Sign in to the [Azure portal](https://portal.azure.com/) and navigate to the **Policy** dashboard.<br>
2.  In the Policy dashboard, select **Definitions** from the left-side menu.<br>
3.  In the “Security Center” category, search for and then select **Configure Microsoft Defender for Storage to be enabled**. This policy enables all Defender for Storage capabilities: Activity Monitoring, Malware Scanning and Sensitive Data Threat Detection. You can also get it here: [List of built-in policy definitions](/azure/governance/policy/samples/built-in-policies#security-center). If you want to enable a policy without the configurable features, use **Configure basic Microsoft Defender for Storage to be enabled (Activity Monitoring only)**.
    
    :::image type="content" source="../media/policy-definitions-example-4d8af992.png" alt-text="Screenshot showing how to configure and enable Microsoft Defender for Storage.":::
    
4.  Select the policy and review it.
5.  Select **Assign** and edit the policy details. You can fine-tune, edit, and add custom rules to the policy.<br>
    
    :::image type="content" source="../media/policy-assign-901a7720.png" alt-text="Screenshot showing an example of how to assign and edit policy details.":::
    
6.  Once you have completed reviewing, select **Review + create**.
7.  Select **Create** to assign the policy.

Malware Scanning can be configured to send scanning results to the following:

**Event Grid custom topic** \- for near-real time automatic response based on every scanning result. Learn more how to [configure malware scanning to send scanning events to an Event Grid custom topic](/azure/defender-for-cloud/defender-for-storage-introduction?toc=%2Fazure%2Fdefender-for-cloud%2Ftoc.json&tabs=enable-storage-account#setting-up-event-grid-for-malware-scanning).

**Log Analytics workspace** \- for storing every scan result in a centralized log repository for compliance and audit. Learn more how to [configure malware scanning to send scanning results to a Log Analytics workspace](/azure/defender-for-cloud/defender-for-storage-introduction?toc=%2Fazure%2Fdefender-for-cloud%2Ftoc.json&tabs=enable-storage-account#setting-up-logging-for-malware-scanning).
