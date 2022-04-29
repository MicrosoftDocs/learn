Microsoft Defender for Cloud provides unified security management and advanced threat protection for workloads that run in Azure, on-premises, and in other clouds. The following Defender for Cloud recommendations, if followed, will set various security policies on an Azure subscription.

These policies define the set of controls that are recommended for your resources with an Azure subscription.

## Microsoft Defender for Cloud recommendations

Here are the recommendations for setting up Microsoft Defender for Cloud. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps with your own subscription using your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Enable enhanced security features - Level 2

Microsoft Defender for Cloud is offered in two modes, **Without enhanced security features (Free)** and **With enhanced security features**. Enabling enhanced security extends the capabilities of the Free mode to workloads that run in private and other public clouds. Enhanced security also provides unified security management and threat protection across your hybrid cloud workloads. This mode also adds advanced threat detection capabilities, such as:

- Built-in behavioral analytics and machine learning to identify attacks and zero-day exploits.
- Access and application controls to reduce exposure to network attacks and malware.

Microsoft Defender for Cloud with all enhanced security features supports Azure resources like:

- Virtual machines (VMs)
- Virtual machine scale sets
- App Service
- SQL servers
- Threat detection provided with Microsoft Security Response Center
- Storage accounts

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the resource menu, select **Microsoft Defender for Cloud**. The **Microsoft Defender for Cloud** Overview pane displays.

1. Select **Getting started** from the left navigation menu.

1. Select the subscription to upgrade. The pane on the right shows the resources that will be protected, and the billing cost per resource.

1. Scroll down and select **Upgrade**.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-getting-started.png" alt-text="Screenshot that shows the getting started with Microsoft Defender for Cloud pane.":::

### Microsoft Defender for Cloud built-in security policies

The policies are grouped as shown.

   :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-security-policies.png" alt-text="Screenshot that shows the built-in security policies for Defender for Cloud.":::

The enabled policies define the Microsoft Defender for Cloud recommendations.

### Enable the automatic provision of the Log Analytics agent - Level 1

When you enable automatic provisioning, Defender for Cloud installs the Log Analytics agent on all supported Azure VMs and any new ones that are created. **Automatic provisioning is strongly recommended**.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the left navigation menu, select **Getting started**, and then select the **Install agents** tab.

1. In the list of management groups and subscription, select the subscription to install agents on.

1. Select **Install agents**.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-install-agents.png" alt-text="Screenshot that shows the getting started pane and Install agents tab.":::

### Enable System Updates - Level 1

Microsoft Defender for Cloud monitors daily Windows and Linux VMs and computers for missing operating system updates. Defender for Cloud retrieves a list of available security and critical updates from *Windows Update* or *Windows Server Update Services (WSUS)*. Which updates are on the list depend on which service you configure on a Windows computer. Defender for Cloud also checks for the latest updates in Linux systems. If your VM or computer is missing a system update, Defender for Cloud will recommend that you apply system updates.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the **Defender for Cloud Overview** pane, in the left menu pane, under **Management**, select **Environment settings**, and then select your subscription.

1. Select **Security policy** from the left menu pane.

1. Under **Default initiative**, select a subscription or management group from the list.

1. Select the **Parameters** tab.

    > [!NOTE]
    > Ensure the *Only show parameters that need input or review* box isn't checked.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-security-policies-parameters.png" alt-text="Screenshot that shows the Parameters tab and checkbox for the Edit Initiative Assignment window.":::

1. Check that **System updates should be installed on your machines** is one of the policies.

1. In this example, the Microsoft Defender for Cloud agent hasn't been deployed to a VM or physical machine so the message **AuditIfNotExists** appears. AuditIfNotExists enables auditing on resources that match the *if* condition. If the resource isn't deployed, **NotExists** appears.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-parameters-system-updates.png" alt-text="Screenshot that shows the 'System updates should be installed on your machines' parameter.":::

    If enabled, **Audit** appears. If deployed but disabled, **Disabled** appears.

### Enable Security Configurations - Level 1

Microsoft Defender for Cloud monitors security configurations by applying a set of over 150 recommended rules for hardening the OS. These rules are related to firewalls, auditing, password policies, and more. If a machine is found to have a vulnerable configuration, Defender for Cloud generates a security recommendation.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the **Defender for Cloud Overview** pane, in the left menu pane, under **Management**, select **Environment settings**, and then select your subscription.

1. Select **Security policy** from the left menu pane.

1. Under **Default initiative**, select a subscription or management group from the list.

1. Select the **Parameters** tab.

1. Check that **Vulnerabilities in security configuration on your virtual machine scale sets should be remediated** is one of the policies.

> [!NOTE]
> All of the following policy categories that have a (\*) in their title are in the **Parameters** pane. In some cases, there are several options in each category.

#### Enable endpoint protection (\*) - Level 1

Endpoint protection is recommended for all VMs.

#### Enable disk encryption (\*) - Level 1

Microsoft Defender for Cloud recommends that you use Azure Disk Encryption if you have Windows or Linux VM disks. Disk Encryption lets you encrypt your Windows and Linux IaaS VM disks. Encryption is recommended for both the OS and data volumes on your VM.

#### Enable Network Security Groups (\*) - Level 1

Microsoft Defender for Cloud recommends that you enable a network security group (NSG). NSGs contain a list of Access Control List (ACL) rules that allow or deny network traffic to your VM instances in a virtual network. NSGs can be associated with either subnets or individual VM instances within that subnet. When an NSG is associated with a subnet, the ACL rules apply to all the VM instances in that subnet. In addition, traffic to an individual VM can be restricted further by associating an NSG directly to that VM.

#### Enable a Web Application Firewall (\*) - Level 1

Microsoft Defender for Cloud might recommend that you add a web application firewall (WAF) from a Microsoft partner to secure your web applications.

#### Enable vulnerability assessment (\*) - Level 1

The vulnerability assessment in Microsoft Defender for Cloud is part of the Defender for Cloud VM recommendations. If Defender for Cloud doesn't find a vulnerability assessment solution installed on your VM, it recommends that you install one. A partner agent, after being deployed, starts reporting vulnerability data to the partner's management platform. In turn, the partner's management platform provides vulnerability and health monitoring data back to Defender for Cloud.

#### Enable storage encryption (\*) - Level 1

When this setting is enabled, any new data in Azure Blobs and Files will be encrypted.

#### Enable JIT network access (\*) - Level 1

Just-in-time (JIT) VM access can be used to lock down inbound traffic to your Azure VMs, reducing exposure to attacks while providing easy access to connect to VMs when needed.

#### Enable adaptive application controls (\*) - Level 1

Adaptive application control is an intelligent, automated end-to-end approved application listing solution from Microsoft Defender for Cloud. It helps you control which applications can run on your Azure and non-Azure VMs (Windows and Linux), which, among other benefits, helps harden your VMs against malware. Defender for Cloud uses machine learning to analyze the applications running on your VMs, and helps you apply the specific approval rules using this intelligence. This capability greatly simplifies the process of configuring and maintaining approved application policies.

#### Enable SQL auditing and threat detection (\*) - Level 1

Microsoft Defender for Cloud recommends that you turn on auditing and threat detection for all databases on your Azure SQL servers. Auditing and threat detection can help you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate business concerns or suspected security violations.

#### Enable SQL encryption (\*) - Level 1

Microsoft Defender for Cloud recommends that you enable Transparent Data Encryption (TDE) on SQL databases. TDE protects your data and helps you meet compliance requirements by encrypting your database, associated backups, and transaction log files at rest. This encryption doesn't require changes to your application.

### Set security contact email and phone number - Level 1

Microsoft Defender for Cloud recommends that you provide security contact details for your Azure subscription. Microsoft uses this information to contact you if the Microsoft Security Response Center (MSRC) finds that your customer data has been accessed by an unauthorized party. MSRC performs select security monitoring of the Azure network and infrastructure and receives threat intelligence and abuse complaints from third parties.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **Home** page, in the top search bar, search for and select *Cost Management + Billing*. Depending on your subscriptions, you'll either see the *Overview* pane or the *Billing scopes* pane.

    - If you see the *Overview* pane, continue to the next step.
    - If you see the *Billing scopes* pane, select your subscription to go to the *Overview* pane.

1. Scroll down on the left menu to **Settings**, and then select **Properties**.

1. Validate the contact information that appears. If you need to update the contact information, select **Update sold to** and enter the new information.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/azure-portal-update-contact-information.png" alt-text="Screenshot that shows Properties pane with contact information and 'Update sold to' selected.":::

### Enable Send me emails about alerts - Level 1

Microsoft Defender for Cloud recommends that you provide security contact details for your Azure subscription.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **Home** page, in the top search bar, search for and select *Defender for Cloud*. The **Defender for Cloud - Overview** pane appears.

1. In the left menu pane, under **Management**, select **Environment Settings**.

1. Select the subscription. The **Settings** pane displays.

1. Select **Email notifications**.

1. Select your role in the **All users with the following roles** drop-down, or enter your email in the **Additional email addresses** text box.

1. Select the **Notify about alerts** checkbox, select the alert severity from the drop-down, and then select **Save**.

    :::image type="content" source="../media/3-create-an-azure-security-center-baseline/defender-for-cloud-email-notifications-settings.png" alt-text="Screenshot that shows the email notifications settings pane for Microsoft Defender for Cloud.":::

### Enable Send email also to subscription owners - Level 1

Microsoft Defender for Cloud recommends that you provide security contact details for your Azure subscription.

- Using the previous **Email notifications** form, you can add more emails separated by commas.

    > [!TIP]
    > Remember to select **Save** if you make changes to any of the settings.
