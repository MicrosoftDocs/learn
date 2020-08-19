Tailwind Traders plans on broadening their use of Azure services, to include a range of Azure resources. In addition, they still have on-premises workloads with current security-related configuration best practices and business procedures. How do they ensure that all of their systems meet a minimum level of security, and that their information is protected from attacks?

As well as specific features relevant to each Azure product or service, there are a number of tools in Azure to help Tailwind Traders with this requirement. 

## Azure Security Center capabilities
[Azure Security Center](https://azure.microsoft.com/services/security-center?azure-portal=true)  is a monitoring service that provides visibility of your *security posture* across all of your services both in Azure, and on-premises. Your security posture is a combination of your cybersecurity policies and controls, and how well you can predict, prevent and respond to security threats. Security Center can:

+ Monitor security settings across on-premises and cloud workloads, and automatically apply required security to new resources as they come online.
+ Provide security recommendations based on your current configurations, resources, and networks.
+ Continuously monitor your resources, performing automatic security assessments to identify potential vulnerabilities before they can be exploited.
+ Use machine learning to detect and block malware from being installed on your virtual machines and other resources. You can also define a list of allowed applications to ensure that only the apps you validate can execute.
+ Analyze and identify potential inbound attacks and help to investigate threats and any post-breach activity that might have occurred.
+ Provide just-in-time access control for network ports, reducing your attack surface by ensuring the network only allows traffic that you require, at the time that you need it to, and blocks it by default at all other times.

<div style="background:yellow;">
TODO: Replace this bullet list with a video.
</div>

## Understand your security posture
<div style="background:yellow;">
TODO: Do we need a para about Secure Score?.
</div>
Tailwind Traders can use Security Center to get a detailed analysis of different components of their environment. At a glance, they can view their overall regulatory compliance from a security perspective, as their resources are analyzed against the security controls of any governance policies they have assigned.  

For example, this may highlight that they are not meeting one of more compliance controls for the Payment Card Industry's Data Security Standard (PCI DSS) and they have resources they will need to remediate:
:::image type="content" source="../media/security-center-compliance.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene and threat protection.":::

<div style="background:yellow;">
TODO: Replace image - too big.
</div>

Under the Resource Security Hygiene section, they can also see the health of their resources from a security perspective and view low, medium and high priority security recommendations specific to their resources. This will help them to decide what actions to prioritize. 


<div style="background:yellow;">
TODO: Replace image - too big & doesnt mimic above para.
</div>

:::image type="content" source="../media/security-center-dashboard-2.png" alt-text="Azure security center dashboard showing policy compliance, resource security hygiene and threat protection.":::

## Protect against threats
Security Center also includes some advanced cloud defence capabilities for virtual machines, network security and file integrity. 

+ Just in time VM access - Here, Tailwind Traders will configure **just in time** access, which blocks traffic by default to specific network ports of their virtual machines, but allows it for a specified time when requested and approved by the right users.

+ Adaptive application controls - They will also control which applications are allowed to run on their virtual machines. In the background, Security Center uses machine learning to look at the processes running on a virtual machine. It creates exception rules for each resource group that holds the virtual machines, and it gives recommendations. This will prevent unauthorised applications from being able to execute on Tailwind Trader's VMs. 

+ Adaptive network hardening - Security Center will also monitor the Internet traffic patterns of the VMs and compare them with the current Network Security Group settings, making recommendations on whether the NSGs can be further locked down and providing remediation steps.

+ File integrity monitoring - Tailwind Traders can also configure the monitoring of changes to important files (Windows or Linux), registry settings, applications and other things that may indicate a security attack. 


## Respond to security alerts
Tailwind Traders can use Security Center for a centralized view of all of their security alerts. The alerts are based on their severity and, where possible, multiple related alerts are combined into a single security incident. 

Then they can dismiss false alerts, investigate them further, remediate the alert manually or use an automated response with a **Workflow automation**. 

Workflow automations use Logic Apps and Security Center connectors. The Logic App can be triggered by a threat detection alert or a security center recommendation, filtered by name or by severity. You can then configure the Logic App to run an action, such as sending an email or posting a message in a Microsoft Teams channel.      

More Azure Security Center implementation and scenario detail is available in the [Azure Security Center planning and operations guide](https://docs.microsoft.com/azure/security-center/security-center-planning-and-operations-guide?azure-portal=true).


<div style="background:yellow;">
TODO: Create images 
</div>

**Azure Security Center versions**

Azure Security Center is available in two versions, known as tiers:

+ **Free**. Available as part of your Azure subscription, this tier is limited to assessments and recommendations of Azure resources only.
+ **Standard**. This tier provides a full suite of security-related services including continuous monitoring, threat detection, just-in-time access control for ports, and more.

To access the full suite of Azure Security Center services you will need to upgrade to a Standard tier Azure Security Center subscription. You can access a 30-day free trial of the Standard tier from within the Azure Security Center dashboard in the Azure portal.

   > [!NOTE]
   > + To upgrade a subscription to the Standard tier, you must be assigned the role of *Subscription Owner*, *Subscription Contributor*, or *Security Admin*.
   > + After the 30-day trial period is over, Azure Security Center is priced as per details on the [Security Center pricing](https://azure.microsoft.com/pricing/details/security-center?azure-portal=true) page.
