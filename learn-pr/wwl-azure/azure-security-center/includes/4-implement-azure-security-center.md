
Microsoft Defender for Cloud is a **Cloud Security Posture Management (CSPM)** and **Cloud Workload Protection Platform (CWPP)** for all of your **Azure**, **on-premises**, and **multi-cloud** (Amazon AWS and Google GCP) **resources**. Defender for Cloud fills three vital needs as you manage the security of your resources and workloads in the cloud and on-premises:

For an interactive overview of how to Manage your cloud security posture with Microsoft Defender for Cloud, click on the image below.<br>

[:::image type="content" source="../media/manage-cloud-security-posture-microsoft-defender-cloud-landing-page-8605516a.png" alt-text="Screenshot of the interactive guide landing page for Manage your cloud security posture with Microsoft Defender for Cloud.":::
](https://mslearn.cloudguides.com/guides/Manage%20your%20cloud%20security%20posture%20with%20Microsoft%20Defender%20for%20Cloud)

Microsoft Defender for Cloud is a **Cloud Security Posture Management (CSPM)** and **Cloud Workload Protection Platform (CWPP)** for all of your Azure, on-premises, and multi-cloud (Amazon AWS and Google GCP) resources. Defender for Cloud fills **three vital needs** as you manage the security of your resources and workloads in the cloud and on-premises:<br>

:::image type="content" source="../media/defender-for-cloud-synopsis-e0fdf519.png" alt-text="Image describing how Defender for Cloud fills the need of three vital areas as you manage the security of your resources and workloads in the cloud and on-premises.":::
<br>

 -  **Defender for Cloud secure score continually assesses** your security posture so you can track new security opportunities and precisely report on the progress of your security efforts.
 -  **Defender for Cloud recommendations secures** your workloads with step-by-step actions that protect your workloads from known security risks.
 -  **Defender for Cloud alerts defends** your workloads in real-time so you can react immediately and prevent security events from developing.

## Protect your resources and track your security progress

Microsoft Defender for Cloud's features covers the **two broad pillars** of cloud security:

1.  **Cloud Security Posture Management (CSPM)**
2.  C**loud Workload Protection Platform (CWP)**

### Cloud Security Posture Management (CSPM) - Remediate security issues and watch your security posture improve

In Defender for Cloud, the posture management features provide the following:

 -  **Hardening guidance** \- to help you efficiently and effectively improve your security
 -  **Visibility** \- to help you understand your current security situation

Defender for Cloud continually assesses your resources, subscriptions, and organization for security issues and shows your security posture in the secure score, an aggregated score of the security findings that tells you, at a glance, your current security situation: the higher the score, the lower the identified risk level.

As soon as you open Defender for Cloud for the first time, Defender for Cloud:<br>

 -  **Generates a secure score** for your subscriptions based on an assessment of your connected resources compared with the guidance in the **Microsoft cloud security benchmark**. Use the score to understand your security posture and the compliance dashboard to review your compliance with the built-in benchmark. When you've enabled the enhanced security features, you can customize the standards used to assess your compliance and add other regulations, such as the **National Institute of Standards and Technology (NIST)** and **Azure Center for Internet Security (CIS)** or organization-specific security requirements. You can also apply recommendations and score based on the **AWS Foundational Security Best practices standards**.
 -  **Provides hardening recommendations** based on any identified security misconfigurations and weaknesses. Use these security recommendations to strengthen the security posture of your organization's Azure, hybrid, and multi-cloud resources.
 -  **Analyzes and secure's your attack paths** through the cloud security graph, which is a graph-based context engine that exists within Defender for Cloud. The cloud security graph collects data from your multi-cloud environment and other data sources. For example, the cloud assets inventory, connections and lateral movement possibilities between resources, exposure to the internet, permissions, network connections, vulnerabilities, and more. The data collected is then used to build a graph representing your multi-cloud environment.
    
    Attack path analysis is a graph-based algorithm that scans the cloud security graph. The scans expose exploitable paths attackers may use to breach your environment to reach your high-impact assets. Attack path analysis exposes those attack paths and suggests recommendations as to how best to remediate the issues that will break the attack path and prevent a successful breach.
    
    By taking your environment's contextual information into account, such as internet exposure, permissions, lateral movement, and more. Attack path analysis identifies issues that may lead to a breach in your environment and helps you to remediate the highest risk ones first.

### Cloud Workload Protection (CWP) - Identify unique workload security requirements

Defender for Cloud offers security alerts that are powered by Microsoft Threat Intelligence. It also includes a range of advanced, intelligent protections for your workloads. The workload protections are provided through Microsoft Defender plans specific to the types of resources in your subscriptions. For example, you can enable Microsoft Defender for Storage to get alerted about suspicious activities related to your storage resources.

## Protect all of your resources under one roof

Because Defender for Cloud is an Azure-native service, many Azure services are monitored and protected without needing any deployment, but you can also add resources that are on-premises or in other public clouds.

When necessary, Defender for Cloud can automatically deploy a Log Analytics agent to gather security-related data. For Azure machines, deployment is handled directly. For hybrid and multi-cloud environments, **Microsoft Defender plans are extended to non-Azure machines** with the help of **Azure Arc**. **Cloud Security Posture Management (CSPM) features** are extended to multi-cloud machines without the need for any agents.

## Defend your Azure-native resources

Defender for Cloud helps you detect threats across:

 -  **Azure Platform as a Service (PaaS)** services - Detect threats targeting **Azure services**, including **Azure App Service**, **Azure SQL**, **Azure Storage Account**, and **more data services**. You can also perform anomaly detection on your Azure activity logs using the native integration with Microsoft Defender for Cloud Apps (formerly known as Microsoft Cloud App Security).
 -  **Azure data services** \- Defender for Cloud includes capabilities that help you automatically classify your data in Azure SQL. You can also get assessments for potential vulnerabilities across Azure SQL and Storage services and recommendations for how to mitigate them.
 -  **Networks** \- Defender for Cloud helps you limit exposure to brute force attacks. By **reducing access to virtual machine ports** and **using just-in-time VM access**, you can harden your network by preventing unnecessary access. You can **set secure access policies on selected ports** for **only authorized users**, **allowed source IP address ranges** or **IP addresses**, and for a **limited amount of time**.

## Defend your on-premises resources

In addition to defending your Azure environment, you can **add Defender for Cloud capabilities to your hybrid cloud environment to protect your non-Azure servers**. To help you focus on what matters the most, you'll get customized threat intelligence and prioritized alerts according to your specific environment.

To **extend protection** to on-premises machines, **deploy Azure Arc** and **enable Defender for Cloud's enhanced security features**.

## Defend resources running on other clouds

Defender for Cloud can protect resources in other clouds (such as Amazon Web Services AWS and Google Cloud Platform GCP).

For example, if you've connected an Amazon Web Services (AWS) account to an Azure subscription, you can enable any of these protections:

 -  **Defender for Cloud's CSPM features** extend to your AWS resources. This agentless plan assesses your AWS resources according to AWS-specific security recommendations, and these are included in your secure score. The resources will also be assessed for compliance with built-in standards specific to **AWS (AWS Center for Internet Security (CIS)**, **AWS Payment Card Industry (PCI) Data Security Standards (DSS)**, and **AWS Foundational Security Best Practices)**. Defender for Cloud's asset inventory page is a multi-cloud enabled feature helping you manage your AWS resources alongside your Azure resources.
 -  **Microsoft Defender for Kubernetes extends** its container threat detection and advanced defenses to your Amazon Elastic Kubernetes Service (EKS) Linux clusters.
 -  **Microsoft Defender for Servers** brings threat detection and advanced defenses to your Windows and Linux Elastic Compute Cloud 2 (EC2) instances. This plan includes the integrated license for Microsoft Defender for Endpoint, security baselines, and OS level assessments, vulnerability assessment scanning, adaptive application controls (AAC), file integrity monitoring (FIM), and more.

## Close vulnerabilities before they get exploited

:::image type="content" source="../media/defender-for-cloud-expanded-assess-38a0a9ce.png" alt-text="Image describing vulnerability assessment solution.":::


Defender for Cloud includes vulnerability assessment solutions for **virtual machines, container registries**, and **SQL servers** as part of the enhanced security features. Some of the scanners are powered by Qualys. But you don't need a Qualys license or even a Qualys account - everything's handled seamlessly inside Defender for Cloud.

Microsoft Defender for Servers includes automatic, native integration with Microsoft Defender for Endpoint. With this integration enabled, you'll have access to the vulnerability findings from Microsoft Defender Vulnerability Management.

Review the findings from these vulnerability scanners and respond to them all from within Defender for Cloud. This broad approach brings Defender for Cloud closer to being the single pane of glass for all of your cloud security efforts.

## Enforce your security policy from the top down

## :::image type="content" source="../media/defender-for-cloud-expanded-secure-028f1443.png" alt-text="Image describing how Defender for Cloud secures workloads."::: 

It's a security basic to know and make sure your workloads are secure, and it starts with having tailored security policies in place. Because policies in Defender for Cloud are built on top of Azure Policy controls, you're getting the full range and flexibility of a world-class policy solution. In Defender for Cloud, you can set your policies to run on management groups, across subscriptions, and even for a whole tenant.

Defender for Cloud continuously discovers new resources that are being deployed across your workloads and assesses whether they're configured according to security best practices. If not, they're flagged, and you get a prioritized list of recommendations for what you need to fix. Recommendations help you reduce the attack surface across each of your resources.

The list of recommendations is enabled and supported by the Microsoft cloud security benchmark. This Microsoft-authored benchmark, based on common compliance frameworks, began with Azure and now provides a set of guidelines for security and compliance best practices for multiple cloud environments.

In this way, Defender for Cloud enables you not just to set security policies but to ***apply secure configuration standards across your resources***.

## Extend Defender for Cloud with Defender plans and external monitoring

## :::image type="content" source="../media/defender-for-cloud-expanded-defend-1fa3337b.png" alt-text="Image describing Defender for Cloud's Advanced threat protection features."::: 

You can extend the Defender for Cloud protection with the following:

 -  **Advanced threat protection features** for virtual machines, Structured Query Language SQL databases, containers, web applications, your network, and more - Protections include securing the management ports of your VMs with just-in-time access and adaptive application controls to create allowlists for what apps should and shouldn't run on your machines.

The **Defender plans** of Microsoft Defender for Cloud offer comprehensive defenses for the **compute**, **data**, and **service layers** of your environment:

 -  Microsoft Defender for Servers
 -  Microsoft Defender for Storage
 -  Microsoft Defender for Structured Query Language (SQL)
 -  Microsoft Defender for Containers
 -  Microsoft Defender for App Service
 -  Microsoft Defender for Key Vault
 -  Microsoft Defender for Resource Manager
 -  Microsoft Defender for Domain Name System (DNS)
 -  Microsoft Defender for open-source relational databases
 -  Microsoft Defender for Azure Cosmos Database (DB)
 -  Defender Cloud Security Posture Management (CSPM)
     -  Security governance and regulatory compliance
     -  Cloud security explorer
     -  Attack path analysis
     -  Agentless scanning for machines
 -  Defender for DevOps

Use the advanced protection tiles in the **workload protections Azure dashboard** to monitor and configure each of these protections.

> [!TIP]
> Microsoft Defender for the **Internet of Things (IoT)** is a separate product.

 -  **Security alerts** \- When Defender for Cloud detects a threat in any area of your environment, it generates a security alert. These alerts describe details of the affected resources, suggested remediation steps, and in some cases, an option to trigger a logic app in response. Whether an alert is generated by Defender for Cloud or received by Defender for Cloud from an integrated security product, you can export it. To export your alerts to Microsoft Sentinel, any third-party Security information and event management (SIEM), or any other external tool, follow the instructions in Stream alerts to a SIEM, Security orchestration, automation and response (SOAR), or IT Service Management solution. Defender for Cloud's threat protection includes fusion kill-chain analysis, which automatically correlates alerts in your environment based on cyber kill-chain analysis, to help you better understand the full story of an attack campaign, where it started, and what kind of impact it had on your resources. Defender for Cloud's supported kill chain intents are based on version 9 of the MITRE ATT&CK matrix.
