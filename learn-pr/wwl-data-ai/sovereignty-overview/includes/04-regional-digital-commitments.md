::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=0fe0e4eb-7177-49bb-87b7-4de818c73ed8]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

Digital sovereignty requirements aren't identical in every market. Some prioritize residency, while others emphasize operational control, legal jurisdiction, auditability, or local ownership. A multinational organization needs a coherent strategy that still accounts for those differences.

## Understand three layers of commitments

For planning purposes, consider Microsoft's digital commitments and implementation options in three layers:

| Layer | What to evaluate |
| --- | --- |
| Global sovereignty baseline | Common security, privacy, governance, and sovereignty capabilities across Microsoft cloud services, with service-specific scope |
| Regional commitments | Commitments that address regional requirements, such as the EU Data Boundary and European operational oversight |
| Country/region-specific implementation patterns | National frameworks and delivery models, including locally owned and operated partner clouds |

This layered approach is a way to organize requirements.

> [!NOTE]
> It doesn't mean every country/region has identical contractual commitments or that every feature is available worldwide.

## Ask the right questions for each geography

Start by identifying the workload, the data classes, and the parties responsible for operations. Then establish:

- Where must data be stored and processed, including replicas and recovery copies?
- Who can access data and production systems, and under what approval and oversight controls?
- What audit evidence is required, and how can the organization obtain and verify it?
- Is local ownership or operation required, or is regional oversight sufficient?
- Which jurisdictions and legal processes could apply during an incident or escalation?
- What are the required recovery objectives, continuity arrangements, and acceptable dependencies?

Review applicable law, contracts, operating authority, and technical safeguards with qualified legal and compliance teams.

> [!IMPORTANT]
> Data residency alone doesn't resolve every jurisdictional question.

## Europe: Regional boundary and oversight

In the EU and European Free Trade Association (EFTA), evaluate:

- The [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn) for eligible services, defined data categories, required configurations, and limited transfer exceptions.
- [Sovereign Public Cloud](/azure/azure-sovereign-clouds/public/overview-sovereign-public-cloud) capabilities for residency, confidentiality, governance, and transparency.
- [Data Guardian](/azure/azure-sovereign-clouds/public/data-guardian) regional oversight and tamper-evident access records for in-scope systems.

Regional commitments can support audit readiness, but the customer must verify coverage and implement its own controls.

## France and Germany: National partner cloud patterns

Some workloads need local ownership and operation beyond residency. [National Partner Clouds](/azure/azure-sovereign-clouds/partner/overview-national-partner-clouds) provide a different operating model using Microsoft technology under national entities and frameworks.

- **Bleu in France** is a joint venture between Orange and Capgemini, designed to address French trusted-cloud requirements, including SecNumCloud.
- **Delos Cloud in Germany** is operated by an SAP subsidiary and aligned with German public sector cloud requirements.

Check each provider's current availability, customer eligibility, service catalog, and certification status. Alignment with a framework or a certification goal isn't the same as a completed certification for every service.

## Map requirements to a model

If a workload needs broad cloud innovation with more sovereignty controls, evaluate Sovereign Public Cloud. If it needs customer-managed infrastructure or disconnected operations, evaluate [Sovereign Private Cloud](/azure/azure-sovereign-clouds/private/overview/sovereign-private-cloud). If national ownership and operating authority are decisive, evaluate National Partner Clouds.

For example, an organization might run a public information service in public cloud, a critical local process on Azure Local, and a nationally restricted workload through a partner cloud. The global baseline keeps governance coherent; regional and country/region-specific controls address each workload's obligations.

> [!NOTE]
> For further reading, see [Digital sovereignty](/azure/azure-sovereign-clouds/digital-sovereignty), the [EU Data Boundary Trust Center](https://www.microsoft.com/trust-center/privacy/european-data-boundary-eudb), and [Azure data residency](https://azure.microsoft.com/explore/global-infrastructure/data-residency/).

::: zone-end
