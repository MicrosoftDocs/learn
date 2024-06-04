Microsoft Defender for Cloud offers built-in security management and threat protection for your cloud workloads. Defender for Cloud helps you find and fix vulnerabilities, block malicious access, and identify weak areas in your servers and network.

Defender for Cloud is available to every Azure subscription through a free, basic tier. You can activate a paid tier to get more features, including integration with on-premises resources and other cloud providers.

One of those standard tier features is *Just-in-time VM access*. When a Just-in-time (JIT) access request is approved for a virtual machine (VM) behind an Azure Firewall, Microsoft Defender for Cloud pokes through the firewall to allow management access to the VM for a specific time period. After the specified time period, Defender for Cloud restores the firewall and Network Security Group (NSG) rules to their previous state, so your VM is protected from attack. Each request is audited so security personal can identify each access request.

Finally, you can protect your VMs and servers with the *antimalware software* integrated into Microsoft Defender for Cloud. With Defender for Cloud, you can monitor all your resources in a single place.

## Cleanup

We created two VM resources in this module. To ensure you don't continue to get charged for these VMs, go ahead and delete the **mslearnDeleteMe** resource group.

1. In Azure portal, search for and select **Resource groups**.

1. Locate and select the **mslearnDeleteMe** resource group.

1. Select **Delete resource group** from the top menu.

    :::image type="content" source="../media/6-azure-portal-delete-resource-group.png" alt-text="Screenshot that shows the resource group pane with Delete resource group selected.":::

1. Type the resource group name (**mslearnDeleteMe**), and select **Delete**.

## Further reading

To learn more about the subjects in this module, check out the following links:

- [Microsoft Security Intelligence](https://www.microsoft.com/wdsi)
- [Microsoft Defender for Cloud overview](https://azure.microsoft.com/services/security-center/)
- [Microsoft Defender for Cloud documentation](/azure/defender-for-cloud/)
- [Microsoft Antimalware](/azure/security/fundamentals/antimalware)
- [Azure Security blog](https://azure.microsoft.com/blog/topics/security/)
- [ARM template to test a virus attack on an Azure VM](https://azure.microsoft.com/resources/templates/vm-virus-attack-prevention/)
