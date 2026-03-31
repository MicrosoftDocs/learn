
<!-- markdownlint-disable MD041 -->

In organizations running only on-premises hardware and software, the organization is responsible for the entire technology stack: the building, physical servers, networking, operating systems, applications, and the data.

When you move to cloud services, security and compliance become a shared effort between the **cloud provider** and the **customer**. The *shared responsibility model* helps you understand who is accountable for which parts of security.

## Shared responsibility in the cloud

In the cloud, responsibilities change depending on the service model:

- **Software as a Service (SaaS)**
- **Platform as a Service (PaaS)**
- **Infrastructure as a Service (IaaS)**
- **On-premises datacenter**

As you move from on-premises → IaaS → PaaS → SaaS, the provider typically takes responsibility for more of the underlying technology. You still keep important responsibilities, especially around your data and who can access it.

The following diagram illustrates the typical division of responsibility between the customer and the cloud provider.

:::image type="content" source="../media/3-shared-responsibility-model.png" lightbox="../media/3-shared-responsibility-model.png" alt-text="Diagram showing the Shared responsibility model responsibilities by type.":::

- **On-premises datacenters**: You secure everything, including physical access, hardware, network devices, operating systems, applications, identity, and data.

- **Infrastructure as a Service (IaaS)**: The provider secures the physical datacenter, network, and hosts. You still secure what you deploy and configure on top of that infrastructure (for example: operating systems, network controls you configure, applications, and data).

- **Platform as a Service (PaaS)**: The provider manages the platform components (for example: the operating system, runtime, and foundational platform services). You focus on securing what you build and how you use the platform (for example: application configuration, code security, access controls, and data).

- **Software as a Service (SaaS)**: The provider delivers a complete application and manages most of the underlying stack. You still control critical security decisions such as who has access, how identities are protected, what data is stored/shared, and which endpoints are allowed.

### Responsibilities you always keep (cloud)

No matter which cloud service model you choose, you always retain responsibility for:

- **Data** (classification, protection, encryption choices, and governance)
- **Identities and access** (accounts, permissions, authentication, and authorization)
- **Endpoints** (the devices that access cloud services)
- **Configuration choices** (security settings you control in your tenant and resources)

## AI shared responsibility model

AI-enabled solutions also follow a shared responsibility model, but there are extra considerations because AI systems can be influenced by user inputs and can generate outputs.

An AI-enabled application can be thought of as three layers:

- **AI platform**: The underlying infrastructure and AI model capability exposed through APIs (including platform-level safeguards).
- **AI application**: The app you build or deploy that connects to the AI platform (including orchestration, plugins/connectors, and grounding data).
- **AI usage**: How people in your organization use the AI system (including behavior, policy, and oversight).

:::image type="content" source="../media/ai-shared-responsibility-v2.png" lightbox="../media/ai-shared-responsibility-v2.png" alt-text="Diagram showing the AI shared responsibility model.":::

### What the provider typically handles (AI)

Depending on whether the AI capability is provided as SaaS or PaaS, the provider typically takes care of:

- Securing the **datacenter, physical hosts, and core platform services**
- Operating the **model hosting infrastructure** and baseline platform protections
- Providing **built-in safety controls** (for example, filtering or other safeguards), depending on the service

### What you typically handle (AI)

Even when the provider secures the AI platform, you remain responsible for how AI is used in your environment:

- Protecting **sensitive data** (what you send to the AI system and what the AI system can access)
- Managing **identity and access** to AI apps and AI resources
- Configuring the AI solution safely (for example: allowed users, allowed connectors/plugins, logging, and retention)
- Reducing common AI risks such as **prompt injection** and unsafe use of external data sources
- Setting **acceptable use policies** and training users (because users can strongly influence outputs)

### Key takeaway

The shared responsibility model (for cloud and AI) is about clarity: you can delegate more of the underlying security work to the provider as you choose higher-level services, but you never delegate accountability for your **data**, **access**, and **how the technology is used**.
