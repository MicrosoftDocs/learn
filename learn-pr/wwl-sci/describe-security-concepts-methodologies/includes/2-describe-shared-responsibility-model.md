
<!-- markdownlint-disable MD041 -->

In organizations running only on-premises hardware and software, the organization is responsible for the entire technology stack: the building, physical servers, networking, operating systems, applications, and the data. When you move to cloud services, some of those responsibilities shift to the cloud provider. The *shared responsibility model* helps you understand exactly who is accountable for which parts of security, so you can plan your security strategy accordingly.

## Shared responsibility in the cloud

In a traditional on-premises environment, your organization controls every layer of the technology stack. Your team is responsible for the physical security of the building, maintaining and patching hardware, configuring network devices, securing operating systems, deploying and updating applications, protecting identities and access, and safeguarding your data. This full ownership means complete control—but it also places the entire security burden on your team.

Cloud computing changes this model. When you use cloud services, some of the day-to-day security responsibilities transfer to the cloud provider. The exact split depends on which cloud service model you're using:

- **On-premises**: Your organization manages and secures the entire stack—from the physical building and hardware to the operating system, applications, and data.
- **Infrastructure as a Service (IaaS)**: The cloud provider secures the physical datacenter, the network hardware, and the host machines. You're responsible for the operating systems, applications, network controls you configure, and your data.
- **Platform as a Service (PaaS)**: The cloud provider also takes on responsibility for the operating system and the runtime environment. You're responsible for your application code, its configuration, access controls, and your data.
- **Software as a Service (SaaS)**: The cloud provider manages the entire application stack and its underlying infrastructure. You're responsible for access management—controlling who uses the service—your data, and how you configure tenant-level settings.

As you move from on-premises to IaaS to PaaS to SaaS, the cloud provider takes on more of the underlying security responsibilities. However, moving to the cloud doesn't mean security becomes entirely someone else's problem. Some responsibilities always remain with you, no matter which service model you use.

The following diagram illustrates the typical division of responsibility between the customer and the cloud provider.

:::image type="content" source="../media/3-shared-responsibility-model.png" lightbox="../media/3-shared-responsibility-model.png" alt-text="Diagram showing the Shared responsibility model responsibilities by type.":::

### Responsibilities you always retain

Regardless of which cloud service model you use, the following responsibilities always stay with you:

- **Data**: You're responsible for your data, including classifying its sensitivity, choosing how to protect it, making encryption decisions, and ensuring compliance with data governance requirements. The cloud provider secures the infrastructure that stores your data, but you decide what data you collect, who can access it, how long to keep it, and how to protect it.

- **Identities and access**: Managing user accounts, authentication methods, and access permissions is always your responsibility. A compromised identity can give an attacker access to cloud resources even when everything else is locked down. Implementing strong identity practices—such as requiring multifactor authentication (MFA) and applying least-privilege access—is one of your most important security obligations.

- **Endpoints**: The devices that connect to your cloud services—laptops, tablets, phones, and desktops—are yours to secure. An attacker who compromises an endpoint can use it to access cloud services as that device's legitimate user. Protecting endpoints through device management, security updates, and threat detection is part of your shared responsibility.

- **Configuration choices**: The security settings and configurations within your cloud tenant—how you configure services, resource permissions, and network policies—are your responsibility. A misconfigured storage account or an overly permissive access policy can expose your data even when the underlying platform is properly secured.

### Cloud security advantages

Using cloud services doesn't just transfer some responsibilities—it also gives you access to security capabilities that most individual organizations couldn't build or sustain on their own.

Cloud providers like Microsoft continuously invest in physical security, hardware reliability, compliance certifications, threat intelligence, and large-scale security monitoring. When you use cloud infrastructure services, you automatically benefit from those investments in the areas the provider is responsible for. This lets your team focus security resources on the responsibilities you retain: your data, your identities, and your configurations.

In on-premises environments, security gaps often develop because teams are stretched thin. Patches get delayed, hardware ages past its vendor support window, and monitoring tools aren't available for every system. When you move to the cloud, the provider handles infrastructure patching and physical security for its portion of the stack. This shift doesn't remove your security obligations, but it lets you focus your expertise where it has the most impact.

## AI shared responsibility model

As organizations adopt AI-powered solutions, the shared responsibility model extends to cover AI workloads. AI systems introduce unique considerations: they can be influenced by the data and instructions users provide, and they generate outputs that may drive important decisions. These characteristics create security and oversight responsibilities that go beyond traditional cloud services.

An AI-enabled application can be thought of in three layers:

- **AI platform**: The underlying infrastructure, AI model, and platform-level safety controls—including any built-in content filtering, safety systems, or access controls provided by the service.
- **AI application**: The application you build or deploy that connects to the AI platform, including how the app is configured, what data sources or connectors it uses, and what plugins it enables.
- **AI usage**: How people in your organization use the AI system—including the inputs they provide, the acceptable use policies you set, and the oversight you put in place.

:::image type="content" source="../media/ai-shared-responsibility-v2.png" lightbox="../media/ai-shared-responsibility-v2.png" alt-text="Diagram showing the AI shared responsibility model, with responsibility divided across AI platform, AI application, and AI usage layers for IaaS, PaaS, and SaaS service types.":::

### What the provider typically handles (AI)

Depending on whether AI capability is delivered as a SaaS service (for example, Microsoft 365 Copilot) or a PaaS service (for example, Azure AI Foundry), the provider typically handles:

- Securing the physical infrastructure and the AI model hosting environment
- Providing platform-level safety controls—such as content filtering and built-in safeguards—depending on the service tier
- Managing the underlying compute infrastructure and the operational security of the AI service

### What you typically handle (AI)

Even when the provider secures the AI platform, you're responsible for how AI is used throughout your organization:

- **Protecting your data**: You control what sensitive data you share with or allow the AI system to access. If an AI system connects to business-critical data, you must configure appropriate access controls and data governance policies.
- **Identity and access management**: You determine who in your organization can access AI applications and what they're permitted to do.
- **Safe configuration**: You're responsible for configuring the AI solution appropriately—restricting which users have access, which external connectors or data sources are enabled, how outputs are logged, and how long data is retained.
- **Mitigating AI-specific risks**: Prompt injection—where an attacker embeds instructions in user input or external data to manipulate the AI's behavior or outputs—is a key risk you need to address through input validation, access controls, and monitoring.
- **User training and acceptable use policies**: Because users directly influence what an AI system does through their inputs and prompts, user education and clear policies are a meaningful part of your security responsibility.

### Key takeaway

The shared responsibility model—whether for traditional cloud services or AI workloads—creates clarity about who is responsible for what. As you choose higher-level services, you can delegate more of the underlying security work to the cloud provider. But you never delegate accountability for your **data**, your **identities**, your **endpoint security**, and **how the technology is used**. Understanding where your responsibility begins and ends is fundamental to protecting your organization.
