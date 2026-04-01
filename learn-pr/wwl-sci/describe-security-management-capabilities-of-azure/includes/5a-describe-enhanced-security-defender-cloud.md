
A pillar of cloud security is cloud workload protection. Through cloud workload protection capabilities, Microsoft Defender for Cloud is able to detect and resolve threats to resources, workloads, and services. Cloud workload protections are delivered through integrated Microsoft Defender plans, specific to the types of resources in your subscriptions and provide enhanced security features for your workloads. 

## Defender plans

Microsoft Defender for Cloud includes a range of advanced intelligent protections for your workloads. The workload protections are provided through Microsoft Defender plans specific to the types of resources in your subscriptions. Some of the Microsoft Defender for Cloud plans you can select from include:

- **Microsoft Defender for servers** adds threat detection and advanced defenses for your Windows and Linux machines.
- **Microsoft Defender for App Service** identifies attacks targeting applications running over App Service.
- **Microsoft Defender for Storage** detects potentially harmful activity on your Azure Storage accounts. 
- **Microsoft Defender for SQL** secures your databases and their data wherever they're located.
- **Microsoft Defender for Containers** provides cloud-native security for Kubernetes environments, including environment hardening, workload protection, and run-time threat detection for containerized workloads and registries.
- **Microsoft Defender for Key Vault** is advanced threat protection for Azure Key Vault.
- **Microsoft Defender for Resource Manager** automatically monitors the resource management operations in your organization.
- **Microsoft Defender for open-source relational databases** brings threat protections for open-source relational databases.
- **Microsoft Defender for AI Services** provides threat protection for AI workloads, detecting prompt injection attacks, anomalous usage patterns, and other threats targeting Azure AI services.
- **Microsoft Defender for APIs** provides visibility into business-critical APIs, improves API security posture, prioritizes vulnerability fixes, and detects active real-time threats against your APIs.

These different plans can be enabled separately and will run simultaneously to provide a comprehensive defense for compute, data, and service layers in your environment.

## Enhanced security features
Microsoft Defender plans specific to the types of resources in your subscriptions provide enhanced security features for your workloads. Listed below are some of the enhanced security features.

- Comprehensive endpoint detection and response - Microsoft Defender for servers includes Microsoft Defender for Endpoint for comprehensive endpoint detection and response (EDR).

- Vulnerability scanning for virtual machines, container registries, and SQL resources - Easily deploy a scanner to all of your virtual machines. View, investigate, and remediate the findings directly within Microsoft Defender for Cloud.

- Multicloud security - Connect your accounts from Amazon Web Services (AWS) and Google Cloud Platform (GCP) to protect resources and workloads on those platforms with a range of Microsoft Defender for Cloud security features.

- Hybrid security – Get a unified view of security across all of your on-premises and cloud workloads. Apply security policies and continuously assess the security of your hybrid cloud workloads to ensure compliance with security standards. Collect, search, and analyze security data from multiple sources, including firewalls and other partner solutions.

- Threat protection alerts - Monitor networks, machines, and cloud services for incoming attacks and post-breach activity. Use interactive tools and contextual threat intelligence to investigate alerts and determine the appropriate response.

- Track compliance with a range of standards - Microsoft Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the Microsoft cloud security benchmark. When you enable the enhanced security features, you can apply a range of other industry standards, regulatory standards, and benchmarks according to your organization's needs. Add standards and track your compliance with them from the regulatory compliance dashboard.

- Access and application controls - Block malware and other unwanted applications by applying machine learning powered recommendations adapted to your specific workloads to create allow lists and block lists. Reduce the network attack surface with just-in-time, controlled access to management ports on Azure VMs. Access and application controls drastically reduce exposure to brute force and other network attacks.

Additional benefits include threat protection for the resources connected to the Azure environment and container security features, among others. Some features may be associated with specific Defender plans for specific workloads.

:::image type="content" source="../media/defender-for-cloud-enhanced-features-inline.png" lightbox="../media/defender-for-cloud-enhanced-features-expanded.png" alt-text="Screenshot showing feature set of Microsoft Defender for Cloud. The feature set without enhanced security consists of continuous assessments and secure score. The enhanced security features that are part of Defender plans adds just-in-time access, threat protection, adaptive controls and more.":::

## Protecting AI workloads

Generative AI has expanded the attack surface that security teams must protect. Organizations running AI applications built on services like Azure OpenAI are potential targets for attacks specifically designed to exploit or misuse AI models. **Microsoft Defender for AI Services** is the CWPP plan dedicated to addressing this new category of threat.

Defender for AI Services monitors AI workload activity in real time and works with Microsoft Threat Intelligence and Azure AI Content Safety Prompt Shields to detect threats such as:

- **Prompt injection attacks**—malicious attempts to manipulate an AI model's behavior by inserting instructions into the model's input, potentially causing it to bypass safety controls or reveal sensitive information.
- **Data leakage**—sensitive information being extracted or exposed through AI model responses.
- **Data poisoning**—attempts to corrupt the data an AI model uses during inference, undermining the reliability of its outputs.
- **Credential theft**—attempts to steal authentication tokens or API keys by targeting AI application components.

Security alerts from Defender for AI Services integrate with Microsoft Defender XDR. This integration lets security teams correlate AI workload threats with other alerts across endpoints, identities, and applications—giving them the broader context they need to understand the full scope of an attack.

As the use of AI applications increases across organizations, protecting those workloads becomes as important as protecting traditional servers, containers, or databases. CWPP addresses this through purpose-built plans that expand to cover new workload types as they emerge.
