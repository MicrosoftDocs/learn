Tailwind Traders is broadening their use of Azure services. They still have on-premises workloads with current security-related configuration best practices and business procedures. How do they ensure that all of their systems meet a minimum level of security and that their information is protected from attacks?

Many Azure services include built-in security features. There are also tools on Azure that can help Tailwind Traders with this requirement. Let's start by looking at Azure Security Center.

## What's Azure Security Center?

[Azure Security Center](https://azure.microsoft.com/services/security-center?azure-portal=true) is a monitoring service that provides visibility of your security posture across all of your services, both on Azure and on-premises. The term _security posture_ refers to cybersecurity policies and controls, as well as how well you can predict, prevent, and respond to security threats.

Security Center can:

* Monitor security settings across on-premises and cloud workloads.
* Automatically apply required security settings to new resources as they come online.
* Provide security recommendations that are based on your current configurations, resources, and networks.
* Continuously monitor your resources and perform automatic security assessments to identify potential vulnerabilities before those vulnerabilities can be exploited.
* Use machine learning to detect and block malware from being installed on your virtual machines and other resources. You can also use _adaptive application controls_ to define rules that list allowed applications to ensure that only applications you allow can run.
* Analyze and identify potential inbound attacks and investigate threats and any post-breach activity that might have occurred.
* Provide just-in-time access control for network ports. Doing so reduces your attack surface by ensuring that the network only allows traffic that you require at the time that you need it to.

## Understand your security posture

<div style="background:yellow;">
TODO: Do we need a para about Secure Score?.
</div>

Tailwind Traders can use Security Center to get a detailed analysis of different components in their environment. Because their resources are analyzed against the security controls of any governance policies they have assigned, they can view their overall regulatory compliance from a security perspective all from one place.

Here's an example of what you might see in Azure Security Center:

<div style="background:yellow;">
TODO: Replace image - too big.
</div>

:::image type="content" source="../media/security-center-compliance.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene, and threat protection.":::

Let's say that Tailwind Traders must comply with the Payment Card Industry's Data Security Standard (PCI DSS). This report shows that they have resources that they need to remediate.

Under the **Resource Security Hygiene** section, they can also see the health of their resources from a security perspective. To help you prioritize remediation actions, recommendations are categorized as low, medium, and high.

<div style="background:yellow;">
TODO: Replace image - too big & doesnt mimic above para.
</div>

:::image type="content" source="../media/security-center-dashboard-2.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene, and threat protection.":::

## Protect against threats

Security Center also includes advanced cloud defence capabilities for virtual machines, network security and file integrity. Let's take a look at how some of these capabilities apply to Tailwind Traders.

* **Just in time VM access**

    Tailwind Traders will configure *just in time* access to virtual machines (VMs), which blocks traffic by default to specific network ports of their virtual machines, but allows it for a specified time when requested and approved by an administrator.
* **Adaptive application controls**

    Tailwind Traders can also control which applications are allowed to run on their virtual machines. In the background, Security Center uses machine learning to look at the processes running on a virtual machine. It creates exception rules for each resource group that holds the virtual machines and provides recommendations. This helps prevent unauthorized applications from running on their VMs.
* **Adaptive network hardening**

    Security Center can also monitor the internet traffic patterns of the VMs and compare those patterns with their current Network Security Group (NSG) settings. From there, Security Center can make recommendations on whether the NSGs should be locked down further and provide remediation steps.
* **File integrity monitoring**

    Tailwind Traders can also configure the monitoring of changes to important files on both Windows and Linux, registry settings, applications, and other aspects that might indicate a security attack.

## Respond to security alerts

Tailwind Traders can use Security Center to get a centralized view of all of their security alerts. These alerts are based on their severity and, when possible, multiple related alerts are combined into a single security incident.

From there, Tailwind Traders can dismiss false alerts, investigate them further, remediate the alert manually, or use an automated response with a **Workflow automation**.

Workflow automation uses Logic Apps and Security Center connectors. The Logic App can be triggered by a threat detection alert or by a Security Center recommendation, filtered by name or by severity. You can then configure the Logic App to run an action such as sending an email or posting a message to a Microsoft Teams channel.

## Choose the version that's right for you

Azure Security Center is available in two versions, known as tiers:

* **Free**

    This tier is available as part of your Azure subscription. It's limited to assessments and recommendations of Azure resources only.
* **Standard**

    This tier provides a full suite of security-related services including continuous monitoring, threat detection, just-in-time access control for ports, and more.

To access the full suite of Azure Security Center services you will need to upgrade to a Standard tier Azure Security Center subscription. You can access a 30-day free trial of the Standard tier from within the Azure Security Center dashboard in the Azure portal.

> [!NOTE]
> * To upgrade a subscription to the Standard tier, you must be assigned the role of *Subscription Owner*, *Subscription Contributor*, or *Security Admin*.
> * After the 30-day trial period is over, Azure Security Center is priced according to the [Security Center pricing](https://azure.microsoft.com/pricing/details/security-center?azure-portal=true) page.
