Consumers need to know which data is trusted and ready to use. Without explicit signals, a certified production data item looks the same as someone's unfinished experiment. A quarterly revenue report built on an outdated personal copy instead of the certified source can misdirect leadership decisions. **Endorsement and associated metadata make that difference visible.**

## Signal trust with endorsement

Endorsement is a Fabric feature that marks items as trusted. Endorsed items display a badge in the portal and get priority in catalog searches. There are three levels:

| | Promoted | Certified | Master data |
| --- | --- | --- | --- |
| **What it means** | Tested and ready for team-level use | Meets organizational quality standards | Authoritative source for core data |
| **Who can apply** | Any user with write permissions | Authorized reviewers only | Authorized reviewers only (data items only) |

Nearly all Fabric and Power BI items can be promoted or certified, except Power BI dashboards. Master data endorsement applies only to items that contain data, like lakehouses and semantic models.

**When no endorsement exists on an item, that absence is also a signal**. In a well-governed environment, unendorsed items are understood to be personal, experimental, or not yet reviewed.

:::image type="content" source="../media/endorsement-trust-levels.png" alt-text="Diagram of endorsement trust progression from no endorsement through promoted, certified, and master data.":::

## Make data discoverable with metadata

Endorsement signals trust, but consumers also need to understand what the data represents, which business area it belongs to, and where it comes from. Fabric provides several types of metadata that make items easier to discover and evaluate in the OneLake catalog.

- **Descriptions** appear in the catalog and help consumers evaluate items without opening them. A clear description explains what the data contains and how it's used.

- **Tags** are flexible labels that admins define and data owners apply to items and workspaces. Domains organize workspaces into business areas. Tags categorize individual items by project, refresh frequency, fiscal year, or any other grouping your organization needs. Consumers can search and filter by tags in the catalog.

- **Domains and subdomains** group workspaces by business area like Sales, Finance, or Operations. Fabric admins create domains and assign workspaces to them. Subdomains allow more specific groupings within a domain. Domains set ownership boundaries and control which items appear in each area of the catalog.

- **Lineage** shows how data flows from source to destination, so consumers can trace where data comes from and whether it's built on trusted sources.

Good metadata reduces the chance that someone builds on the wrong source or duplicates work that already exists.

> [!TIP]
> Think about a data asset in your organization. What would a consumer need to know to make an informed decision to use it or not?
