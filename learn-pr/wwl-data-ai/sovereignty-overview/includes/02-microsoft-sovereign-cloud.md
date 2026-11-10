::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=347c3d1f-b06e-4c3c-9f36-460ac961eafd]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

Microsoft Sovereign Cloud builds on Microsoft's experience with governments and highly regulated organizations. It helps organizations balance cloud innovation with control over data, operations, technology dependencies, and continuity.

## A workload-based continuum of control

Microsoft Sovereign Cloud spans **Sovereign Public Cloud**, **Sovereign Private Cloud**, and the **Sovereign Partner Ecosystem**. National Partner Clouds are part of that ecosystem. These options aren't mutually exclusive destinations: an organization can combine them across its workloads.

:::image type="content" source="../media/microsoft-sovereign-cloud-continuum.png" alt-text="Diagram of Sovereign Public Cloud, Sovereign Private Cloud, and the Sovereign Partner Ecosystem as a continuum of control." lightbox="../media/microsoft-sovereign-cloud-continuum.png":::

A public-facing service might use public cloud scale and innovation. A critical local system might require disconnected operation. Another workload might require a nationally owned and operated partner environment. The appropriate model depends on the control objective and the trade-offs the organization accepts.

## Data controls

Data controls govern data locations, access permissions, and protection. A hardware security module (HSM) protects cryptographic keys. Relevant controls include:

- **Residency:** Select appropriate regions and service configurations, and understand replication, backup, support, and transfer behavior.
- **Access governance:** Use identity controls and, for supported scenarios, Customer Lockbox and confidential computing to reduce unauthorized access.
- **Encryption and key management:** Protect data at rest and in transit, and use confidential computing for supported data-in-use scenarios. Azure Key Vault, including Premium vaults, and Azure Key Vault Managed HSM provide key-management options with different capabilities.
- **External key custody:** External key management provides an option when requirements mandate holding the root encryption key outside Microsoft infrastructure.

The [October 20, 2026 sovereignty announcement](https://blogs.microsoft.com/blog/2026/10/20/advancing-digital-sovereignty-with-greater-control-and-choice/) describes external key management with Azure Managed HSM as generally available. It also describes Azure Confidential Clean Rooms in limited preview for approved multiparty collaboration. Check the applicable service documentation and terms for supported integrations, regions, and deployment requirements.

> [!IMPORTANT]
> Keeping keys outside Azure means customers must manage availability, recovery, performance, and external HSM infrastructure. Key custody and residency are related but distinct decisions.
>
> For more information, see [Data controls](/azure/azure-sovereign-clouds/data-controls), [Key management controls](/azure/azure-sovereign-clouds/key-controls), and [External Key Management](/azure/azure-sovereign-clouds/public/external-key-management).

## Operational controls

Operational controls provide transparency, accountability, and authority over how systems are operated:

- **Policy enforcement:** Azure Policy definitions and initiatives can audit or enforce supported configurations.
- **Access lifecycle governance:** Just-in-time access limits the duration and scope of elevated permissions. Customer Lockbox lets customers approve or reject applicable requests for access to customer data.
- **Regional oversight and auditability:** Data Guardian adds European-resident oversight for qualifying Microsoft engineer remote access to in-scope production systems. Production Touch Ledger provides tamper-evident records of that access and the actions performed.
- **Deployment governance:** The Sovereign Landing Zone applies policy-as-code guardrails to an Azure landing zone foundation.
- **Posture visibility:** Sovereign Control Panel brings together sovereignty signals to identify gaps and support remediation and continuity planning.

The October 2026 announcement describes phased EU/EFTA rollouts for Data Guardian and Production Touch Ledger, and Sovereign Control Panel as entering public preview at Microsoft Ignite. Don't assume every capability is available for every workload. Sovereign Control Panel is the current name for the capability previously called Regulated Environment Management.

Customer Lockbox excludes certain emergency scenarios and external legal demands. Data Guardian oversight isn't a statement that every person accessing a system is European-resident.

> [!NOTE]
> For more information, see [Operational controls](/azure/azure-sovereign-clouds/operational-controls), [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview), [Data Guardian](/azure/azure-sovereign-clouds/public/data-guardian), and [Sovereign Control Panel](/azure/azure-sovereign-clouds/public/sovereign-control-panel).

## Technological independence

Technological independence concerns the ability to choose, manage, and secure infrastructure and software without undue dependency. Relevant considerations include:

- **Local infrastructure:** Run supported workloads on customer-operated infrastructure, including disconnected or air-gapped deployments where required.
- **Open standards and portability:** To reduce switching barriers, evaluate interoperability, export mechanisms, and migration paths.
- **National innovation and supply chains:** Consider local capabilities, suppliers, and support dependencies.
- **Local operating authority:** National Partner Clouds and specialized partners combine Microsoft technology with local ownership, operations, and regulatory expertise.

Independence is a matter of degree. A local deployment still depends on hardware, software updates, skills, licensing, and supply chains. Identify those dependencies rather than assuming that disconnection removes all external risk.

> [!NOTE]
> For more information, see [Technological independence](/azure/azure-sovereign-clouds/technological-independence).

## Balance cloud value and sovereign control

Cloud value includes innovation, elasticity, reliability, cybersecurity capabilities, and cost efficiency. Sovereignty controls include residency, operational transparency, encryption, and operating authority.

:::image type="content" source="../media/cloud-value-sovereign-control.png" alt-text="Diagram showing a comparison of cloud value and sovereign control across public, disconnected, and private deployments." lightbox="../media/cloud-value-sovereign-control.png":::

Public cloud controls can preserve many hyperscale benefits. Private or disconnected deployments can provide greater local authority but shift more responsibility for capacity, updates, security, and resilience to the customer. There isn't one universal trade-off curve or a guaranteed cost penalty: compare the actual capabilities, dependencies, and costs of each workload.

To begin implementation:

1. Define the data, access, jurisdiction, and continuity requirements for the workload.
2. Compare public, private, and partner models against those requirements.
3. Map control objectives to the residency, encryption-at-rest/in-transit, and encryption-in-use levels described in [Controls and principles](/azure/azure-sovereign-clouds/public/overview-controls-principles).
4. Evaluate the [Sovereign Landing Zone](/azure/azure-sovereign-clouds/public/overview-sovereign-landing-zone) and Azure Policy for public cloud guardrails.
5. Plan and test resilience, evidence collection, and any required transition to disconnected operation.

Complete this planning and testing before disruption occurs.

::: zone-end
