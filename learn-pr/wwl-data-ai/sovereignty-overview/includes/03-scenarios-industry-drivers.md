::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=510f63ae-8d09-4e7e-9527-c857df38fd89]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

Sovereignty requirements differ across regions, industries, and workloads. European regulations provide some common requirements across markets, but a shared regional framework doesn't make every service or control available in every country/region. Begin with the requirements of the workload.

## Compare the deployment models

Microsoft Sovereign Cloud combines productivity, security, and cloud infrastructure capabilities through different operating models.

:::image type="content" source="../media/sovereign-cloud-deployment-models.png" alt-text="Diagram comparing Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Clouds using European examples." lightbox="../media/sovereign-cloud-deployment-models.png":::

> [!NOTE]
> The diagram highlights European examples, not universal availability or assurances for every deployment. Verify regional coverage, access controls, and certification status for each service and provider.

### Sovereign Public Cloud

[Sovereign Public Cloud](/azure/azure-sovereign-clouds/public/overview-sovereign-public-cloud) adds sovereignty capabilities to existing Microsoft hyperscale cloud regions. It combines public cloud innovation with residency controls, operational oversight, policy guardrails, and customer-controlled encryption.

Customers can adopt applicable technical, operational, and contractual controls without moving every workload to a separate private environment. Existing workloads might still need configuration or architecture changes to meet a particular requirement. Service-specific eligibility and regional coverage matter.

### Sovereign Private Cloud

[Sovereign Private Cloud](/azure/azure-sovereign-clouds/private/overview/sovereign-private-cloud) is a portfolio for customer-operated environments, built on Azure Local. It supports applications, AI, and productivity workloads, including Microsoft 365 Local capabilities.

Evaluate this model when workloads require:

- Hybrid or supported disconnected services on customer-managed infrastructure.
- Greater local control over infrastructure, data, and operations.
- Plans for moving supported workloads between public and private environments as requirements change.

Defense, national security, and critical infrastructure workloads can have these requirements. Industry membership alone doesn't determine the model, and portability or disconnected operation must be verified for each service. Microsoft 365 Local isn't a promise that every Microsoft 365 online service can run offline.

### National Partner Clouds

[National Partner Clouds](/azure/azure-sovereign-clouds/partner/overview-national-partner-clouds) deliver Microsoft Azure and Microsoft 365 capabilities through independently operated environments under local ownership and control. They address requirements for local operating authority, national compliance frameworks, and jurisdictional separation.

Bleu in France and Delos Cloud in Germany illustrate this pattern. Availability, eligibility, certification status, and service coverage depend on the provider and national framework. Don't assume parity with the global public cloud.

The broader Sovereign Partner Ecosystem also includes software, services, and infrastructure partners. Azure Arc can help manage supported, connected hybrid resources with these tools:

- Azure Monitor.
- Microsoft Defender for Cloud.
- Microsoft Copilot in Azure.

These management integrations don't make every cloud management feature available in disconnected environments.

Partners with the [Digital Sovereignty specialization](https://partner.microsoft.com/partnership/specialization/digital-sovereignty) demonstrate capabilities in areas such as residency, privacy, encryption, and governance. The specialization requires qualifying expertise and an audit. It helps customers identify implementation expertise, but it doesn't replace their own compliance assessment.

## Identify industry drivers and customer triggers

Common triggers include a new regulation, a sensitive AI project, an audit finding, a requirement to restrict provider access, a national ownership rule, or a continuity review.

| Industry or workload | Examples of requirements to investigate |
| --- | --- |
| Financial services | Digital Operational Resilience Act (DORA), SWIFT Customer Security Controls, and Basel III operational risk requirements |
| Energy and critical infrastructure | North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) standards, where applicable |
| Automotive and manufacturing | Trusted Information Security Assessment Exchange (TISAX) requirements in the supply chain |
| Payments and commerce | Payment Card Industry (PCI) Data Security Standard (DSS) v4.0 family requirements |
| Media and content | Content Delivery and Security Association (CDSA) and Motion Picture Association (MPA) content security standards |

These requirements are examples, not a universal checklist. Some are laws, others are standards or industry frameworks. Determine jurisdiction, scope, current version, and contractual obligations with the organization's legal and compliance teams.

Microsoft Sovereign Cloud helps address five recurring needs: regulatory compliance, sovereign AI processing, protection against unauthorized operator access, data residency, and business continuity.

:::image type="content" source="../media/digital-sovereignty-scenarios.png" alt-text="Diagram showing five sovereignty needs: compliance, sovereign AI, operator access controls, data residency, and business continuity." lightbox="../media/digital-sovereignty-scenarios.png":::

In the diagram, **No cloud operator access** represents a workload control objective, not a blanket service guarantee. The **Operator access** tab explains supported controls and their limitations.

## Explore sovereignty scenarios

# [Compliance](#tab/sovereignty-compliance)

## Scenario: Map controls to compliance requirements

A bank needs secure, available money transfers. A government agency must protect tax-filing records. A healthcare provider wants AI-assisted care while safeguarding patient information. Each organization must translate its obligations into implementable controls and audit evidence.

For example, DORA and the Network and Information Security Directive (NIS2) create resilience and security obligations for organizations within their scope. Azure Policy can help govern supported resource configurations. Microsoft Purview Compliance Manager and Microsoft Defender for Cloud can help assess applicable controls and organize evidence.

Microsoft publishes independent assessments and [compliance offerings](/compliance/regulatory/offering-home). A provider's certification doesn't automatically make the customer's application compliant. Customers remain responsible for their architecture, configurations, processes, and evidence.

# [Sovereign AI](#tab/sovereignty-ai)

## Scenario: Keep AI data processing under your control

For an AI workload, evaluate the location of inputs, outputs, model artifacts, training or inference, logs, and supporting services. Public cloud controls can support residency, access governance, encryption, and compliance. Deployment type matters: global processing options can have different data-location behavior from regional options.

Private and partner models offer alternatives when requirements extend to local infrastructure or operating authority. [AI workloads on Azure Local](/azure/azure-sovereign-clouds/private/azure-local/ai-workloads-overview) include local inference with Foundry Local. The October 2026 announcement describes Foundry Local on Azure Local becoming generally available at Ignite, so confirm availability and disconnected support before planning production use.

Other options include the [Kubernetes AI toolchain operator (KAITO) preview on Azure Kubernetes Service (AKS) on Azure Local](/azure/aks-hybrid-edge/local/hyperconverged/deploy-ai-model) and [Azure Machine Learning with supported Kubernetes compute targets](/azure/machine-learning/how-to-attach-kubernetes-anywhere). Hardware and GPU support depend on the solution. A connected Azure Machine Learning integration isn't automatically a disconnected AI platform.

# [Operator access](#tab/sovereignty-operator-access)

## Scenario: Limit unauthorized cloud-provider access

Use layered controls rather than relying on one assurance:

- Encrypt data at rest and in transit with appropriate service settings and key controls.
- Use supported confidential computing workloads to protect data in use inside hardware-based, attested trusted execution environments (TEEs).
- Use Customer Lockbox for applicable customer-data access requests.
- Evaluate Data Guardian regional oversight and Production Touch Ledger audit records for in-scope systems.
- Use Sovereign Control Panel to assess posture as its capabilities become available.

Data Guardian adds oversight by authorized European-resident personnel for qualifying access, rather than promising that no Microsoft engineer outside Europe can ever access a system. Review service scope, exclusions, and residual risks.

> [!IMPORTANT]
> **Encryption doesn't universally require a TEE and Managed HSM to decrypt data.** Standard services can decrypt data for authorized processing according to their design. Confidential computing and policy-based key release can restrict processing to an attested environment in supported architectures; customer-managed keys alone don't turn every service into such an architecture.

# [Residency](#tab/sovereignty-residency)

## Scenario: Keep data resident in a required geography

An organization might need financial records, citizen information, or patient data stored and processed within a defined geography. Evaluate the exact data categories and operations involved.

Use [Azure data residency guidance](https://azure.microsoft.com/explore/global-infrastructure/data-residency/) and service-specific documentation to review regional and nonregional services, backups, replication, telemetry, support data, and AI processing. For eligible European workloads, evaluate the [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn). For Microsoft 365, [Advanced Data Residency](/microsoft-365/enterprise/m365-dr-adr-overview) provides extra storage-at-rest commitments for eligible data and local region geographies.

Access-location controls complement residency but don't establish it. Examples include [Microsoft Entra Conditional Access](/entra/identity/conditional-access/policy-block-by-location), network rules in Azure Firewall, and [geographic filtering in Azure Web Application Firewall](/azure/web-application-firewall/ag/geomatch-custom-rules). Microsoft 365 access policies can also restrict access to applicable services.

> [!TIP]
> A geographic sign-in or traffic restriction doesn't determine where service data is stored or processed.

# [Continuity](#tab/sovereignty-continuity)

## Scenario: Maintain business continuity

A bank, airport, or manufacturer needs a tested plan for natural disasters, outages, security incidents, and geopolitical disruption.

Azure and Microsoft 365 provide service-specific resilience capabilities. Customers must still design and test their own recovery strategy. Evaluate availability zones, regional redundancy, backups, recovery objectives, dependencies, and whether a recovery location satisfies residency requirements.

Hybrid, partner-hosted, multicloud, and on-premises options can support continuity goals, but require architecture, operational readiness, and testing. The October 2026 announcement describes connected-to-disconnected workload transitions as entering public preview, not as an automatic failover capability for all workloads.

Microsoft's [European digital commitments](https://www.microsoft.com/trust-center/compliance/europe-digital-resilience) include a legal commitment to contest orders to suspend services for covered government customers and European partner contingency arrangements. These measures supplement technical resilience. They don't guarantee uninterrupted service under every circumstance or replace a customer's business continuity plan.

---

::: zone-end
