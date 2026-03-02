In this unit, we introduce the Microsoft Cybersecurity Reference Architecture (MCRA). But to understand what the MCRA is, it's important to first introduce the Microsoft Security Adoption Framework, as the MCRA is a component of the SAF.

## The Microsoft Security Adoption Framework

The Microsoft Security Adoption Framework (SAF) is a comprehensive guide for end-to-end security modernization. It provides a structured approach—from executive strategy to architectural and technical planning—grounded in Zero Trust principles, to help organizations improve their security posture across a hybrid, multicloud environment. Think of SAF as the overarching "playbook" for security transformation, addressing not just technology but also strategy, governance, and processes. [learn.microsoft.com]

Within that framework, the Microsoft Cybersecurity Reference Architecture (MCRA) serves as a key component of SAF. MCRA is essentially the technical blueprint that visualizes how all Microsoft security capabilities and best practices fit together in an end-to-end architecture. It shows how to implement SAF’s guidance at the technical level. In fact, SAF applies MCRA as the reference model for security architecture. MCRA illustrates the integrated security solutions (identity, devices, apps, infrastructure, etc.) working in concert under Zero Trust. By design, MCRA is part of SAF, helping security teams align their detailed technical architecture with the broader security strategy and Zero Trust approach advocated by SAF. [Microsoft...soft Learn | Learn.Microsoft.com]

In summary, SAF provides the “why and how” of security modernization (the strategic roadmap and operational guidance), while MCRA provides the "what" (the detailed architecture of security capabilities). Understanding their relationship: SAF sets the vision and process for modernizing security, and MCRA gives you the picture of the end-state architecture to aim for, ensuring that your security program’s execution aligns with Microsoft’s best-practice architecture for cybersecurity. This interplay ensures that as you plan and implement improvements via SAF, you're guided by the MCRA to cover all security domains in a coherent, integrated way. The result is a well-aligned security strategy (via SAF) and architecture (via MCRA) for modern enterprises.

## MCRA

The [Microsoft Cybersecurity Reference Architectures (MCRA)](/security/adoption/mcra) describe Microsoft's cybersecurity capabilities and how they integrate with existing security architectures. The MCRA provides:

- **Technical diagrams** showing how Microsoft security capabilities integrate with Microsoft platforms (Microsoft 365 and Azure), non-Microsoft applications (ServiceNow, Salesforce), and non-Microsoft cloud platforms (AWS, GCP).
- **Capability descriptions** with ScreenTips that provide brief explanations and links to documentation when viewing in presentation mode.
- **Best practice guidance** for implementing security capabilities across your enterprise environment.

The MCRA helps you understand how Microsoft capabilities work together to help you achieve your end-to-end security goals.
The MCRA includes:
- Antipatterns (common mistakes) and best practices
- Threat trends, attack patterns, and the importance of an end-to-end security approach and ruthlessly prioritizing security work
- Guidance for successfully adopting an end-to-end security approach using Zero Trust principles 
- Mapping Microsoft capabilities to Zero Trust standards and organizational roles
- Guidance on AI Security
- Detailed diagrams for:
  - Microsoft cybersecurity capabilities
  - Zero Trust user access
  - Security operations (SecOps/SOC)
  - Operational technology (OT)
  - Multicloud and cross-platform capabilities
  - Attack chain coverage
  - Infrastructure and development Security
  - Security organizational functions
- ...and more 

### How organizations apply the MCRA

Organizations use the MCRA for several purposes. Understanding these use cases helps you get the most value from this resource as a cybersecurity architect.

- **Define a target security architecture**: The most common use case is using the MCRA as a starting template for security architecture. Organizations find this architecture useful because it covers capabilities across the modern enterprise estate that now spans on-premises, mobile devices, multiple clouds, and IoT/Operational Technology. You can use the diagrams to help define your target state for cybersecurity capabilities and identify gaps in your current environment.

- **Compare and assess existing capabilities**: Use the MCRA as a comparison reference for security capabilities. Compare Microsoft's recommendations with what you already own and have implemented. Many organizations discover they already have access to security technologies they weren't aware of, particularly through existing Microsoft 365 or Azure subscriptions. This assessment helps you maximize your current investments before acquiring new tools.

- **Learn about Microsoft security capabilities**: The MCRA serves as an effective learning tool for understanding Microsoft's security portfolio. When viewing the diagrams in presentation mode, each capability includes a ScreenTip with a short description and a link to documentation for deeper learning. This makes it easy to quickly understand what each component does and how it fits into the overall architecture.

- **Identify integration opportunities**: Architects and technical teams use the MCRA to identify how to take advantage of integration points within Microsoft capabilities and with existing security investments. The diagrams show how different security technologies connect and share data, helping you design solutions that maximize the value of integrated security operations.

- **Build cybersecurity knowledge**: For those new to cybersecurity or preparing for a career change, the MCRA provides a comprehensive overview of modern security architecture. The visual format and organized structure make it easier to understand how different security domains relate to each other and what capabilities are needed for a complete security program.

### Understand AI security considerations

As organizations adopt AI technologies, cybersecurity architects must address the unique security challenges that AI introduces. AI security encompasses two related concerns:

- **Securing AI systems** - Protecting AI models, training data, and AI-powered applications from attacks such as model theft, data poisoning, and prompt injection.
- **Using AI for security** - Using AI capabilities to enhance threat detection, automate security operations, and improve security posture through tools like Microsoft Security Copilot.

The MCRA includes content on AI security considerations to help you understand how AI affects your security architecture. For comprehensive guidance on securing AI workloads, see [Security for AI](/security/ai/) and [AI security best practices](/security/ai/secure-ai-best-practices).

