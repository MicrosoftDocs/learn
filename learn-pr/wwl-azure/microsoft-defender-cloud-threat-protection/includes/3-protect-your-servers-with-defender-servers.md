Defender for Servers in Microsoft Defender for Cloud brings threat detection and advanced defenses to your Windows and Linux machines that run in Azure, Amazon Web Services (AWS), Google Cloud Platform (GCP), and on-premises environments. This plan includes the integrated license for Microsoft Defender for Endpoint, security baselines and OS level assessments, vulnerability assessment scanning, adaptive application controls (AAC), file integrity monitoring (FIM), and more.

Microsoft Defender for Servers includes an automatic, native integration with Microsoft Defender for Endpoint. Learn more, Protect your endpoints with Defender for Cloud's integrated EDR solution: Microsoft Defender for Endpoint. With this integration enabled, you have access to the vulnerability findings from Microsoft threat and vulnerability management.

## Enable the Defender for Servers plan

You can enable the Defender for Servers plan from the Environment settings page to protect all the machines in an Azure subscription, AWS account, or GCP project.

### To enable the Defender for Servers plan:

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Search for and select **Microsoft Defender for Cloud**.

3. In the Defender for Cloud menu, select **Environment settings**.

4. Select the relevant subscription.

5. On the Defender plans page, toggle the Servers switch to **On**.

After enabling the plan, you have the ability to [configure the features of the plan](/azure/defender-for-cloud/configure-servers-coverage) to suit your needs. When you enable Defender for Servers on a subscription, it doesn't extend that coverage to an attached workspace. You need to [enable Defender for Servers on the Log Analytics workspace level](/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-log-analytics-workspace-level).

## Select a Defender for Servers plan

When you enable the Defender for Servers plan, you're then given the option to select which plan - Plan 1 or Plan 2 - to enable. There are two plans you can choose from that offer different levels of protections for your resources.

Compare the [available features](/azure/defender-for-cloud/plan-defender-for-servers-select-plan#plan-features) provided by each plan.

### To select a Defender for Servers plan:

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Search for and select **Microsoft Defender for Cloud**.

3. In the Defender for Cloud menu, select **Environment settings**.

4. Select the relevant Azure subscription, AWS account, or GCP project.

5. Select **Change plans**.

6. In the popup window, select **Plan 2** or **Plan 1**.

7. Select **Confirm**.<br>

8. Select **Save**.

After enabling the plan, you have the ability to [configure the features of the plan](/azure/defender-for-cloud/configure-servers-coverage) to suit your needs.

## Enable the plan at the Log Analytics workspace level

When you enable Defender for Servers on your subscription, the coverage provided by Defender for Servers isn't automatically extended to your Log Analytics workspaces. You need to enable Defender for Servers on each workspace. Defender for Servers on workspaces only supports Plan 2.

To enable Defender for Servers on the Log Analytics workspace

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Search for and select **Microsoft Defender for Cloud**.

3. In the Defender for Cloud menu, select **Environment settings**.

4. Select the relevant workspace.

5. Toggle the servers plan to **On**.

6. Select **Save**.

## Enable Defender for Servers at the resource level

To protect all of your existing and future resources, we recommend you [enable Defender for Servers on your entire Azure subscription](/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-on-an-azure-subscription-aws-account-or-gcp-project).

You can exclude specific resources or manage security configurations at a lower hierarchy level by enabling the Defender for Servers plan at the resource level. You can enable the plan on the resource level with REST API or at scale.

The supported resource types include:

 -  Azure VMs.
 -  On-premises with Azure Arc.
 -  Azure Virtual Machine Scale Sets Flex.

## Enable Defender for Servers at the resource level with REST API

Use the following base script file to customize it for your specific needs.

1.  [Download and save this file](https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level) as a PowerShell file.
2.  Run the downloaded file.
3.  Set pricing by tag or by resource group.
4.  Follow the rest of the onscreen instructions.

After enabling the plan, you have the ability to [configure the features of the plan](/azure/defender-for-cloud/configure-servers-coverage) to suit your needs.
