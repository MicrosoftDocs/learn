Classification protects sensitive data, but governance also requires a way to signal which data assets are trustworthy and ready for use. Fabric provides endorsement, tags, and the OneLake catalog to address this challenge.

## Understand endorsement levels

Endorsement is a Fabric feature that makes high-quality, trustworthy content more discoverable. Endorsed items display a badge in the Fabric portal and receive priority in searches and sorted lists. To endorse an item, open the item's settings and find the endorsement section. Fabric provides three endorsement levels, each representing a different stage of trust:

- **Promoted:** Any user with write permissions can promote an item to signal it's ready for team-level sharing and reuse. Promotion is a low-friction signal that doesn't require administrator involvement. Use it for items that have been tested and are ready for use within a single team or project.
- **Certified:** An organization-authorized reviewer verifies that the item meets quality standards and is ready for cross-team or organization-wide use. A Fabric administrator specifies which users can certify items, and certification can be delegated to domain administrators for each domain. Reserve certification for production assets that feed business-critical reports or decision-making processes.
- **Master data:** Only users specified by the Fabric administrator can apply this designation, and it applies only to items that contain data, like lakehouses and semantic models. Use it for core organizational reference data such as product catalogs, customer master lists, and financial hierarchies. The master data designation tells consumers that this item is the single source of truth for the data it contains.

Nearly all Fabric and Power BI items can be promoted or certified, including lakehouses, warehouses, semantic models, reports, notebooks, pipelines, and dataflows. The only exception is Power BI dashboards, which don't support endorsement.

Commonly, a data owner promotes items when they're tested and ready and then a domain-authorized reviewer certifies items that meet the organization's governance criteria.

Endorsement also determines which data Copilot and AI agents treat as trustworthy. When Copilot in Microsoft Fabric answers a question, it prioritizes certified and promoted semantic models over unendorsed items. Power BI also provides an explicit **Approved for Copilot** setting on semantic models that controls AI readiness at the item level. You explore this setting in more detail in the next unit.

If an item isn't promoted, it has no endorsement signal. In a well-governed environment, the absence of endorsement communicates that the item is personal, experimental, or not yet reviewed. This implicit signal helps both users and AI agents avoid relying on unvetted data.

> [!TIP]
> Before certifying an item, you should understand its contents, quality, and lineage. When in doubt, collaborate with the data owner or subject matter experts to verify it meets organizational standards. Endorsement should be determined by those who know the data best.

## Use tags for categorization

Tags are configurable text labels that Fabric administrators define. Data owners apply tags to categorize items beyond what endorsement and sensitivity labels communicate, for example by business domain (Sales, Finance, HR) or data refresh frequency (Daily, Weekly). Users can search and filter by tags in the OneLake catalog. An item can be certified and tagged as "Finance - Quarterly" to communicate both trust level and business purpose.

## Document data assets for discoverability

Well-documented items help users understand what data represents, how it was produced, and whether it's appropriate for their use case. Key documentation practices in Fabric:

- **Item descriptions:** Add clear descriptions to every item. Descriptions appear in the OneLake catalog and help users evaluate items without opening them.
- **Data lineage:** Use Fabric's lineage view to visualize how data flows from source to destination and understand dependencies between items.
- **Impact analysis:** Before changing an item, use impact analysis to identify downstream items that would be affected.
- **Domain assignment:** Assign items to the correct Fabric domain so they appear in the right context in the OneLake catalog. Domains group data by business area (for example, Sales, Finance, Operations).

## Discover and govern with the OneLake catalog

The OneLake catalog is a centralized experience for finding, exploring, and governing data assets across your Fabric environment. The catalog brings together all the governance signals you've applied, including endorsement, tags, descriptions, and sensitivity labels, into a single searchable experience. The catalog has three tabs:

- **Explore:** Browse and filter items using domain, item type, endorsement, and keyword filters.
- **Govern:** View governance posture for data you own. See recommendations to improve, such as adding descriptions or applying sensitivity labels.
- **Secure:** Manage security centrally by viewing and editing workspace roles and OneLake security roles.

The OneLake catalog is also embedded in Microsoft Teams, Microsoft Excel, and Microsoft Copilot Studio.

> [!TIP]
> Use the OneLake catalog regularly when starting a new analytics project. Search for existing certified or master data items before building new datasets. Reusing endorsed assets reduces duplication and ensures you're working with trusted data.

Good documentation and endorsement signals help users make informed decisions about which data to use. These governance practices also shape how AI agents interact with your data estate, as you explore in the next unit.
