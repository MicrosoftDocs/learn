Azure Security Center offers built-in security management and threat protection for your cloud workloads. Security Center helps you find & fix vulnerabilities, aids in blocking malicious access, and identifying weak areas in your servers and network.

Security Center is available to every Azure subscription through a free, basic tier. You can activate a paid tier to get more features, including integration with on-premise resources and other cloud providers.

One of those standard tier features is _Just-in-time VM access_. When a JIT access request is approved for a VM behind an Azure Firewall, Azure Security Center pokes a hole into the firewall to allow management access to the VM for a specific time period. After the specified time period, Security Center restores the firewall and NSG rules to their previous state, so your VM is protected from attack. Each request is audited so security personal can identify each access request.

Finally, you can protect your VMs and servers with _antimalware software_ that's integrated into Azure Security Center so you can monitor all your resources in a single place.

## Cleanup

We created two VM resources in this module. To ensure you don't continue to get charged for these VMs, go ahead and delete the **mslearnDeleteMe** resource group.

1. Select **Resource groups** from the left-hand sidebar in the Azure portal.

1. Locate the **mslearnDeleteMe** resource group in the list and select the "..." context menu on the right side of the entry.

1. Select **Delete resource group** from the menu.

    ![Screenshot of the Azure portal showing the Delete resource group entry](../media/6-summary-cleanup.png)

1. Type the resource group name (**mslearnDeleteMe**) into the entry and select **Delete**.

## Further reading

To learn more about the topics in this module, check out the following links:

- [Microsoft Security Intelligence](https://www.microsoft.com/wdsi)
- [Azure Security Center overview](https://azure.microsoft.com/services/security-center/)
- [Azure Security Center documentation](https://docs.microsoft.com/azure/security-center/)
- [Microsoft Antimalware](https://docs.microsoft.com/azure/security/fundamentals/antimalware)
- [Azure Security blog](https://azure.microsoft.com/blog/topics/security/)
- [ARM template to test a virus attack on an Azure VM](https://aka.ms/ASCPlaybooksVAttack)
