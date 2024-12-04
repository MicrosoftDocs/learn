Organizations need a new security model that adapts to the complexity of the hybrid and multicloud environments. Support is required for the cloud environment, embracing the mobile workforce, and protects people, devices, applications, and data wherever they're located. Zero Trust is the core strategy. Instead of believing everything behind the corporate firewall is safe, the Zero Trust model assumes breach and verifies each request as though it originated from an uncontrolled network. Regardless of where the request originates or what resource it accesses, the Zero Trust model teaches us to "never trust, always verify."

### Zero Trust principles - guidance for architecture design

| Verify Explicitly | Use least privilege access | Assume breach |
| :---------------- | :------------------------ | :------------ |
|Always validate all available data points including: | To help secure both data and productivity, limit user access using: | Minimize blast radius for breaches and prevent lateral movement by: |
| User identity and location | Just-in-time (JIT) | Segmenting access by network, user, devices, and app awareness |
| Device health | Just-enough-access (JEA) | Encrypting all sessions end to end |
| Service or workload context | Risk-based adaptive policies | Use analytics for threat detection, posture visibility and improving defenses |
| Data classification | Data protection against out of band vectors | |
| Anomalies | | |

Zero Trust is designed to adapt to the complexities of the modern working conditions.  Your security embraces the mobile workforce. Configurations protect people, devices, applications, and data.  The protection goes wherever the activity is located.

### Deploy Zero Trust solutions

A Zero Trust approach should extend throughout the entire digital estate and serve as an integrated security philosophy and end-to-end strategy. You need to implement Zero Trust controls and technologies across six foundational elements. Each element is a source of signal, a control plane for enforcement, and a critical resource to be defended.

:::image type="content" source="../media/zero-trust-pillars.png" alt-text="Diagram of the six pillars of Zero Trust.  Identity - endpoints - data - apps - infrastructure - and network.":::

For this content, we're going to focus specifically on the **security identity with zero trust** pillar. Identities, whether they represent people, services, or IoT devices define the Zero Trust control plane. When an identity attempts to access a resource, verify that identity with strong authentication, and ensure access is compliant and typical for that identity. Follow least privilege access principles.

### Zero Trust architecture

:::image type="content" source="../media/zero-trust-architecture.png" alt-text="Diagram of corporate technology architecture based on Zero Trust.":::
Security policy governs everything.  Identity is used to verify identity and access. Additionally, the diagram has blocks for data, apps, networking, and infrastructure radiating outward.

An integrated set of solutions and capabilities offer built-in Zero Trust controls that make implementing a Zero Trust security model across your organization achievable at scale. At the heart of your Zero Trust strategy, you need a policy engine to make dynamic access decisions for trusted users at critical checkpoints—access to networks, apps, and data. Identity and access management and endpoint-management solutions enables your organization to verify users and devices explicitly. Verification is done with rich signal, such as device health and sign-in risk. Looking at the signal enables systems to make informed decisions based on access policies. 

Information protection and cloud security solutions help enforce decisions and protect resources across the entire environment in real time. Networking solutions help use real-time threat protection to detect and respond to threats across your networks and infrastructure. 

Finally, the integrated security information and event management (SIEM) and extended detection and response (XDR) solutions to deliver true, end-to-end threat prevention, detection, and response. Together, Microsoft SIEM + XDR provide your organization visibility into threats across all your resources, stitch signal together to tell you what is most important and enable you to respond swiftly with integrated remediation capabilities. An intelligent security approach helps ensure that only the right people are getting the right level of access across your organization, elevating both security and end-user productivity.
