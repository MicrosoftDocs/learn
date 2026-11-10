::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=56d93ad9-3776-49cc-b644-0b37e0ff223b]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

European organizations expect technology to protect data, keep services resilient, and support long-term competitiveness. Microsoft's [European digital commitments](https://blogs.microsoft.com/on-the-issues/2025/04/30/european-digital-commitments/), announced in April 2025, address these priorities through five commitments:

- Help build a broad AI and cloud ecosystem across Europe.
- Uphold Europe's digital resilience even when there's geopolitical volatility.
- Continue to protect the privacy of European data.
- Help protect and defend Europe's cybersecurity.
- Help strengthen Europe's economic competitiveness, including open source.

Translate these commitments into the organization's actual obligations. For example, an EU financial institution might assess resilience requirements under the Digital Operational Resilience Act (DORA). Automotive suppliers might need evidence for Trusted Information Security Assessment Exchange (TISAX). These frameworks have different scopes and don't prescribe one universal sovereign architecture.

:::image type="content" source="../media/european-digital-commitments.png" alt-text="Diagram showing five European commitments covering cloud and AI, resilience, privacy, cybersecurity, and economic competitiveness." lightbox="../media/european-digital-commitments.png":::

## Build a broad AI and cloud ecosystem

Microsoft's approach combines public cloud infrastructure, national partner clouds, and collaboration with European providers that offer Microsoft applications and services on their infrastructure. Different delivery models let organizations select capabilities suited to their regulatory and operational requirements.

The April 2025 announcement set out plans to increase European datacenter capacity by 40% over the following two years, expand operations in 16 regions, and support operations in more than 200 datacenters by 2027.

> [!NOTE]
> These were investment plans announced at that time, not evidence that every planned location or service is already operational.

The commitment also includes respecting European laws, including competition law and the Digital Markets Act. Infrastructure investment and partnerships support an ecosystem for public services, enterprises, startups, research, and open-source communities.

## Uphold Europe's digital resilience

The resilience commitment combines governance, legal measures, and operational planning:

- **A European cloud for Europe:** Microsoft commits to oversight of European datacenter operations and their boards by a board of European nationals operating under European law.
- **Digital Resilience Commitment:** Microsoft commits to promptly and vigorously contest government orders to suspend or cease covered cloud operations, using available legal avenues.
- **Business continuity partnerships:** European partner contingency arrangements and secure backup copies of code in Switzerland are intended to support continuity if needed.

The [Trust Center description of the commitments](https://www.microsoft.com/trust-center/compliance/europe-digital-resilience) explains their incorporation into the Microsoft Products and Services Data Protection Addendum for covered European government entities and the European Commission. Review the current contractual terms for eligibility and exact scope; don't assume the same commitment applies to every commercial customer worldwide.

Microsoft cites its history of legal challenges as part of this approach. A commitment to contest an order or provide contingency rights isn't a guarantee of a particular court outcome or uninterrupted service. Customers must still design, exercise, and maintain their own continuity and recovery plans.

## Protect the privacy of European data

Privacy protections combine service configuration, encryption, access controls, contractual commitments, and legal safeguards. Under the **Defending Your Data** commitment, Microsoft challenges government demands for covered EU customer data where there's a legal basis to do so. This commitment doesn't mean Microsoft can reject every lawful demand.

### Understand the EU Data Boundary

The [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn) is a geographically defined boundary consisting of EU and European Free Trade Association (EFTA) regions. Its commitments apply to eligible enterprise online services, including Azure, Microsoft 365, Dynamics 365, and Power Platform.

For in-scope services:

- **Customer Data and personal data:** Microsoft commits to storage and processing within the boundary, subject to documented limited transfer circumstances.
- **Pseudonymized personal data in system-generated logs:** The commitments cover applicable personal data in service logs. Pseudonymization reduces direct identifiability; it doesn't turn personal data into anonymous data.
- **Professional Services Data:** Data from support and consulting engagements has a storage-at-rest commitment within the boundary, subject to documented exceptions. This storage commitment doesn't promise that all support processing occurs only in Europe.

The final phase, completed in February 2025, extended the boundary to Professional Services Data. Support case information and service-generated logs are different data categories; don't treat all logs as Professional Services Data.

> [!IMPORTANT]
> The EU Data Boundary isn't an absolute promise that no data ever leaves Europe. Review service eligibility, configuration requirements, customer-directed transfers, and documented limited transfers. It also doesn't automatically provide single-country/region residency or eliminate all possible legal jurisdiction outside the region.

Configuration matters. Regional Azure services deployed in eligible regions can be in scope. Nonregional services can require extra configuration. Microsoft 365 scope depends on tenant criteria, and Multi-Geo customers have different considerations. Check the current EU Data Boundary documentation before making an assurance about a workload.

The boundary can help simplify regulatory assessments, support European privacy expectations, reduce out-of-region data flows, and provide clearer documentation of transfers. It doesn't replace the organization's own compliance duties.

### Apply complementary controls

Microsoft 365 Advanced Data Residency provides extra storage-at-rest commitments for eligible services and local region geographies. Customer Lockbox supports approval of applicable support-access requests. Customer-managed keys and confidential computing can provide more control over encryption and supported data processing.

For AI, verify the specific service and deployment type, including prompts, responses, model artifacts, logging, and dependencies. Don't infer that every AI workload processes all data within the EU Data Boundary merely because the customer is based in Europe.

## Protect and defend Europe's cybersecurity

Microsoft's European cybersecurity commitments include:

- A dedicated Deputy Chief Information Security Officer (CISO) for Europe, reporting to Microsoft's CISO and focused on regional security responsibilities.
- Work under the Secure Future Initiative to strengthen security and support compliance with evolving requirements, including the Cyber Resilience Act.
- Independent validation of European commitments.
- Crisis response, threat intelligence sharing with European governments, and investment in cybersecurity capacity and resilience.
- Partnerships to disrupt cyberattacks and address increasingly sophisticated threats.

These measures support a broader security posture. Customers still need their own identity, configuration, monitoring, incident response, and recovery processes.

## Strengthen competitiveness, including open source

Microsoft's AI Access Principles support access to AI platforms for both proprietary and open-source business models. Open APIs, model choice, interoperability, and export mechanisms can help organizations innovate and reduce switching barriers.

The European commitments also describe support for startups, research institutions, and established businesses. Customers can choose technologies and models based on their needs rather than assuming sovereignty requires one vendor-specific architecture.

The April 2025 announcement described removing data-transfer fees when customers switch from Azure to another cloud provider.

> [!TIP]
> This migration benefit doesn't make all routine data egress free. Applicable migration terms and conditions still matter.

Together, the five commitments combine infrastructure, governance, legal protection, privacy, security, and ecosystem investment. Use them as inputs to a workload-specific assessment. Support that assessment with current service documentation and contractual terms.

::: zone-end
