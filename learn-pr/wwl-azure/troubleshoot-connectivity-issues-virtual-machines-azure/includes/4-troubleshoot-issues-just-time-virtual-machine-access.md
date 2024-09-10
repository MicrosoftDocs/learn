Unlike Azure Bastion, there are only two high-level issues you might need to troubleshoot with just-in-time VM access.

## Availability

JIT VM access is one of the enhanced security features of Microsoft Defender for Cloud. Your organization has to have enhanced security enabled at the subscription level. To check, go to the Azure portal, select **Microsoft Defender for Cloud**, and under **Management**, select **Environment settings**.

:::image type="content" source="../media/defender-environment-settings.png" alt-text="A screenshot of the Azure portal, selecting Microsoft Defender for Cloud, and then Environment settings.":::

If Microsoft Defender for Cloud isn't enabled on your subscription, you see the following error:

:::image type="content" source="../media/defender-description-error.png" alt-text="A screenshot of the error shown if Microsoft Defender for Cloud isn’t enabled on a subscription. It shows there’s an Enable Microsoft Defender for Cloud button to select.":::

Select **Enable Microsoft Defender for Cloud** to be taken to a page that allows you to select your subscription.

If you have multiple subscriptions, select the one with the resources you're troubleshooting. Then select the large **Enable all Microsoft Defender for Cloud plans** box.

:::image type="content" source="../media/enable-enhanced-security.png" alt-text="A screenshot showing how to enable all Microsoft Defender for Cloud plans.":::

Choose the services you’d like to protect; at a minimum, you need to select **Server** to enable JIT VM access.

You can enable JIT access from the VM connection pane, from Workload protections inside Microsoft Defender for Cloud, or by using Azure CLI commands. For example, to use Workload protections, follow these steps:

1. In the Azure portal, select **Microsoft Defender for Cloud**.

1. Under Cloud Security, select **Workload protections**.

1. Select **Just-in-time VM** access.

    :::image type="content" source="../media/select-just-time-access-workload-protections.png" alt-text="A screenshot showing selecting Workload protections, and then selecting Just-in-time VM access.":::

You can then select the **Not Configured** tab to show all the VMs in your subscription that don’t have JIT access enabled.

:::image type="content" source="../media/enable-just-time-access-defender.png" alt-text="A screenshot showing the Not Configured tab selected, and a check against the VM to protect it. The Enable JIT button on one VM is highlighted.":::

Select the check next to the VM you want to protect.

Select **Enable JIT** on 1 VM.

This page can also help you diagnose your VMs that JIT VM access doesn't support. The VMs having problems were likely deployed without using the Azure Resource Manager. JIT access only supports VMs deployed through Azure Resource Manager.

## Access

With JIT VM access enabled on your machines, users might still have issues when they request access to a specific protected VM. You request access to a VM using the Azure portal as follows:

- From inside the Connect options for a VM.

- From inside the Workload protections section of Microsoft Defender for Cloud.

- Using Azure CLI commands.

If your users are unable to request JIT access, check that their role has these actions, at a minimum:

- Microsoft.Security/locations/jitNetworkAccessPolicies/*/read

- Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action

- Microsoft.Compute/virtualMachines/read

- Microsoft.Network/*/read

You use Access control (IAM) to check which users have access to a VM. In the Azure portal, select Virtual machine, and then select Access control (IAM).

:::image type="content" source="../media/check-virtual-machine-access.png" alt-text="A screenshot showing a VM’s Access control (IAM) settings. The View button for View access to this resource is highlighted.":::

You can review the currently enabled and used JIT VM access in the Microsoft Defender for Cloud advanced protection section.

:::image type="content" source="../media/current-just-time-access.png" alt-text="A screenshot of the currently configured JIT VM access showing two VMs and their current status of access.":::