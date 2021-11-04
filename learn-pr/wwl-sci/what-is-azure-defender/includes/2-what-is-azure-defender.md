Microsoft Defender for Cloud's features cover the two broad pillars of cloud security:

**Cloud Security Posture Management (CSPM)** - Defender for Cloud is available for free to all Azure users. The free experience includes CSPM features such as secure score, detection of security misconfigurations in your Azure machines, asset inventory, and more. Use these CSPM features to strengthen your hybrid cloud posture and track compliance with built-in policies.

**Cloud Workload Protection (CWP)** - Defender for Cloud's integrated cloud workload protection platform (CWPP) brings advanced, intelligent protection to your Azure and hybrid resources and workloads. Enabling Microsoft Defender for Cloud brings a range of extra security features. In addition to the built-in policies, when you've enabled any Microsoft Defender plans, you can also add custom policies and initiatives.

The workload protection dashboard in Defender for Cloud provides visibility and control of the CWP features for your environment:

:::image type="content" source="../media/sample-defender-dashboard.png" alt-text="Screenshot of the workload protection dashboard.":::

## What resource types can Microsoft Defender for Cloud secure?

Microsoft Defender for Cloud provides security alerts and advanced threat protection for virtual machines, SQL databases, containers, web applications, your network, and more.

When you enable Microsoft Defender for Cloud from **Pricing and settings**, the following Defender plans are all enabled simultaneously and provide comprehensive defenses for the compute, data, and service layers of your environment:

- Microsoft Defender for servers

- Microsoft Defender for App Service

- Microsoft Defender for Storage

- Microsoft Defender for SQL

- Microsoft Defender for Kubernetes

- Microsoft Defender for container registries

- Microsoft Defender for Key Vault

- Microsoft Defender for Resource Manager

- Microsoft Defender for DNS

## Hybrid cloud protection

In addition to defending your Azure environment, you can add Microsoft Defender for Cloud capabilities to your hybrid cloud environment:

- Protect your non-Azure servers

- Protect your virtual machines in other clouds (such as AWS and GCP)

You'll get customized threat intelligence and prioritized alerts according to your specific environment so that you can focus on what matters the most.

To extend protection to virtual machines and SQL databases in other clouds or on-premises, deploy Azure Arc and enable Microsoft Defender for Cloud. Azure Arc for servers is a free service, but services used on Arc enabled servers, such as Microsoft Defender for Cloud, will be charged as per the pricing for that service. Learn more in Add non-Azure machines with Azure Arc.

## Microsoft Defender for Cloud security alerts

When Microsoft Defender for Cloud detects a threat in any area of your environment, it generates a security alert. These alerts describe details of the affected resources, suggested remediation steps, and in some cases, an option to trigger a logic app in response.

Whether an alert is generated or received by Defender for Cloud from an integrated security product, you can export it. To export your alerts to Microsoft Sentinel, any third-party SIEM, or any other external tool, follow the instructions in Stream alerts to a SIEM, SOAR, or IT Service Management solution.

## Microsoft Defender for Cloud advanced protection capabilities

Microsoft Defender for Cloud uses advanced analytics for tailored recommendations related to your resources.

Protections include securing the management ports of your VMs with just-in-time access and adaptive application controls to create allow lists for what apps should and shouldn't run on your machines.

Use the advanced protection tiles in the workload protection dashboard to monitor and configure each of these protections.

## Vulnerability assessment and management

Microsoft Defender for Cloud includes vulnerability scanning for your virtual machines and container registries at no extra cost. The scanners are powered by Qualys, but you don't need a Qualys license or even a Qualys account - everything's handled seamlessly inside Defender for Cloud.

Review the findings from these vulnerability scanners and respond to them all from within Defender for Cloud. This brings Defender for Cloud closer to being the single pane of glass for all of your cloud security efforts.
