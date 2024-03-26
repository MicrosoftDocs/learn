Policy-based management can streamline IT operations, and help to protect the organization by enforcing well-designed policies. Azure Policy lets you define requirements for your Azure subscriptions and tailor them to your type of workload or the sensitivity of your data.

Microsoft Defender for Cloud is fully integrated with Azure Policy. Defender for Cloud can monitor policy compliance across all of your subscriptions using a default set of *security policies*. A security policy defines the set of controls that are recommended for resources within the specified subscription or resource group. These security policies define the _desired_ configuration of your workloads, and help to ensure compliance with company or regulatory security requirements. These defaults can be customized and defined to match your specific organizational needs.

Here are several of the built-in security policies that Defender for Cloud monitors:

- Secure transfer to storage accounts should be enabled.
- Microsoft Entra administrator for SQL server should be provisioned.
- Client authentication should use Microsoft Entra ID.
- Diagnostics logs in Key Vault should be enabled.
- System updates should be installed on your machines.
- Audit missing blob encryption for storage accounts.
- Just-In-Time network access control should be applied on virtual machines.

By default, all security policies are turned on for each monitored subscription. Security policies and recommendations are tied to each other. If you enable a security policy, such as OS vulnerabilities, that enables recommendations for that policy. In Defender for Cloud, you define policies for your Azure subscriptions or resource groups according to your company’s security needs, and the types of applications or sensitivity of data in each subscription.

For example, resources used for development or testing might have different security requirements than resources used for production applications. Likewise, applications that use regulated data, like personal data, might require a higher level of security. Security policies that are enabled in Microsoft Defender for Cloud drive security recommendations and monitoring to help you identify potential vulnerabilities and mitigate threats.

Policies are inherited from the subscription down to the resource groups. However, you can control the security policies individually at the resource group level.

> [!NOTE]
> To modify a security policy at the subscription level or resource group level, you need to be an Owner or Contributor for that subscription.

## Work with security policies

You can view the active security policies through the Defender for Cloud **Environment settings**.

After selecting your subscription, select **Security policy** to see the default or custom initiatives enabled on your subscription. In this case, we'll select the default initiative.

:::image type="content" source="../media/4-defender-for-cloud-security-policy-select.png" alt-text="Screenshot of the Security policy pane with the default initiative selected.":::

Select the **Parameters** tab, and you'll see a list of policy parameters with drop-down menus. You might need to uncheck the **Only show parameters...** checkbox to see an unfiltered view.

:::image type="content" source="../media/4-defender-for-cloud-policy-parameters.png" alt-text="Screenshot that shows the Parameters tab with System updates entered in the search box and the results displayed.":::

In the previous image, you can see that we searched for *System updates*, and **System updates should be installed on your machines** is set to **AuditIfNotExists**. In this subscription, with enhanced security off, that means all virtual machines (VMs) will be audited to ensure they have the latest security updates applied. Any VMs that fail this check will generate an audit event.

### Change compliance policies

Owners and security administrators can edit the default security policy for each of the shown Azure subscriptions and management groups through Defender for Cloud. The Azure portal is the easiest way to make changes to policy, but you can also use a command-line interface (Azure CLI or Azure PowerShell) or the programmatic REST API.

Let's examine some of the recommendations Microsoft Defender for Cloud makes about your resources using these policy definitions.
