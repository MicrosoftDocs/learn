Defender for Cloud is a tool for security posture management and threat protection. It strengthens the security posture of your cloud resources, and with its integrated Microsoft Defender plans, Defender for Cloud protects workloads running in Azure, hybrid, and other cloud platforms.

Defender for Cloud provides the tools needed to harden your resources, track your security posture, protect against cyber attacks, and streamline security management. Because it's natively integrated, deployment of Defender for Cloud is easy, providing you with simple auto provisioning to secure your resources by default.
Defender for Cloud fills three vital needs as you manage the security of your resources and workloads in the cloud and on-premises:

- **Continuously Assess** – Understand your current security posture.

- **Secure** - Harden all connected resources and services.

- **Defend** - Detect and resolve threats to those resources and services.

To help you protect yourself against these challenges, Microsoft Defender for Cloud provides you with the tools to:

- **Secure score**: A single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.

- **Security recommendations**: Customized and prioritized hardening tasks to improve your posture. You implement a recommendation by following the detailed remediation steps provided in the recommendation. For many recommendations, Defender for Cloud offers a "Fix" button for automated implementation!

- **Security alerts**: With the enhanced security features enabled, Defender for Cloud detects threats to your resources and workloads. These alerts appear in the Azure portal and Defender for Cloud can also send them by email to the relevant personnel in your organization. Alerts can also be streamed to SIEM, SOAR, or IT Service Management solutions as required.

## Architecture

Because Defender for Cloud is natively part of Azure, PaaS services in Azure - including Service Fabric, SQL Database, SQL Managed Instance, and storage accounts - are monitored and protected by Defender for Cloud without necessitating any deployment.

In addition, Defender for Cloud protects non-Azure servers and virtual machines in the cloud or on-premises, for both Windows and Linux servers, by installing the Log Analytics agent on them. Azure virtual machines are autoprovisioned in Microsoft Defender for Cloud.

The events collected from the agents and Azure are correlated in the security analytics engine to provide you tailored recommendations (hardening tasks) that you should follow to ensure your workloads are secure. You should investigate these alerts as soon as possible to make sure malicious attacks aren't taking place on your workloads.

When you enable Defender for Cloud, the security policy built-in to Defender for Cloud is reflected in Azure Policy as a built-in initiative under the Defender for Cloud category. The built-in initiative is automatically assigned to all Defender for Cloud registered subscriptions (regardless of whether or not they have Defender for Cloud enabled). The built-in initiative contains only Audit policies. For more information about Defender for Cloud policies in Azure Policy, see Working with security policies.

## Strengthen security posture

Defender for Cloud enables you to strengthen your security posture. Meaning it helps you identify and perform the hardening tasks recommended as security best practices and implement them across your machines, data services, and apps. This includes managing and enforcing your security policies and ensuring your Azure virtual machines, non-Azure servers, and Azure PaaS services are compliant. Defender for Cloud provides you with the tools you need to have a bird's eye view on your workloads, with focused visibility on your network security estate.

## Manage organization security policy and compliance

It's a security basic to know and make sure your workloads are secure, and it starts with having tailored security policies in place. Because all the Defender for Cloud policies are built on top of Azure Policy controls, you're getting the full range and flexibility of a world-class policy solution. In Defender for Cloud, you can set your policies to run on management groups, across subscriptions, and even for a whole tenant.

Defender for Cloud helps you identify Shadow IT subscriptions. By looking at subscriptions labeled not covered in your dashboard, you can immediately know when there are newly created subscriptions and make sure they are covered by your policies and protected by Defender for Cloud.

## Continuous assessments

Defender for Cloud continuously discovers new resources being deployed across your workloads and assesses whether they are configured according to security best practices. If not, they're flagged, and you get a prioritized list of recommendations for what you need to fix in order to protect your machines.

To help you understand how important each recommendation is to your overall security posture, Defender for Cloud groups the recommendations into security controls and adds a secure score value to each control. This is crucial in enabling you to prioritize your security work.

## Network map

One of the most powerful tools Defender for Cloud provides for continuously monitoring your network's security status is the Network map. The map enables you to see the topology of your workloads, so you can see if each node is properly configured. You can see how your nodes are connected, which helps you block unwanted connections that could potentially make it easier for an attacker to creep along your network.

:::image type="content" source="../media/security-center-net-map.png" alt-text="Network map.":::

## Optimize and improve security by configuring recommended controls

The heart of Defender for Cloud's value lies in its recommendations. The recommendations are tailored to the particular security concerns found on your workloads, and Defender for Cloud does the security admin work for you by not only finding your vulnerabilities but providing you with specific instructions for how to get rid of them.

In this way, Defender for Cloud enables you not just to set security policies but to apply secure configuration standards across your resources.

The recommendations help you to reduce the attack surface across each of your resources. That includes Azure virtual machines, non-Azure servers, and Azure PaaS services such as SQL and Storage accounts and more - where each type of resource is assessed differently and has its own standards.

## Protect against threats

Defender for Cloud's threat protection enables you to detect and prevent threats at the Infrastructure as a Service (IaaS) layer, non-Azure servers, and for Platforms as a Service (PaaS) in Azure.

Defender for Cloud's threat protection includes fusion kill-chain analysis, which automatically correlates alerts in your environment based on cyber kill-chain analysis, to help you better understand the full story of an attack campaign, where it started, and what kind of impact it had on your resources.

## Integration with Microsoft Defender for Endpoint

Defender for Cloud includes automatic, native integration with Microsoft Defender for Endpoint. This means that without any configuration, your Windows and Linux machines are fully integrated with Defender for Cloud's recommendations and assessments.

In addition, Defender for Cloud lets you automate application control policies on server environments. The adaptive application controls in Defender for Cloud enable end-to-end app approval listing across your Windows servers. You don't need to create the rules and check violations. It's all done automatically for you.

## Protect PaaS

Defender for Cloud helps you detect threats across Azure PaaS services. You can detect threats targeting Azure services, including Azure App Service, Azure SQL, Azure Storage Account, and more data services. You can also take advantage of the native integration with Microsoft Defender for Cloud Apps's User and Entity Behavioral Analytics (UEBA) to perform anomaly detection on your Azure activity logs.

## Block brute force attacks

Defender for Cloud helps you limit exposure to brute force attacks. By reducing access to virtual machine ports, using the just-in-time VM access, you can harden your network by preventing unnecessary access. You can set secure access policies on selected ports for only authorized users, allowed source IP address ranges or IP addresses, and for a limited amount of time.

## Protect data services

Defender for Cloud includes capabilities that help you perform automatic classification of your data in Azure SQL. You can also get assessments for potential vulnerabilities across Azure SQL and Storage services and recommendations for how to mitigate them.

## Get secure faster

Native Azure integration (including Azure Policy and Azure Monitor logs) combined with seamless integration with other Microsoft security solutions, such as Microsoft Defender for Cloud Apps and Microsoft Defender for Endpoint, helps make sure your security solution is comprehensive and simple to onboard and roll out.

In addition, you can also extend the full solution beyond Azure to workloads running on other clouds and in on-premises data centers.

## Automatically discover and onboard Azure resources with automatic provisioning

Defender for Cloud provides seamless, native integration with Azure and Azure resources. That means that you can pull together a complete security story involving Azure Policy and built-in Defender for Cloud policies across all your Azure resources and make sure that the whole thing is automatically applied to newly discovered resources as you create them in Azure.