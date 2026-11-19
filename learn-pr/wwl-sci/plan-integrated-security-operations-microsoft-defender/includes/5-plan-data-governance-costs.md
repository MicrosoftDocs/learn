With your capability choices and workspace decision in place, you next distinguish native Defender data from data that enters through a workspace. Your ISOC adoption plan treats data access, retention, billing, and operational ownership as related decisions rather than independent checkboxes.

## Classify security data

Start with two data categories:

- **Native Microsoft Defender data** is available directly in the Microsoft Defender experience. It doesn't need to be separately ingested into an ISOC workspace.
- **Additional Microsoft and non-Microsoft data** can be connected through an ISOC workspace by using data connectors. Additional ingestion charges might apply depending on the data ingested.

Supported Microsoft security data includes data from Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Defender for Identity, Microsoft Defender for Cloud Apps, Microsoft Defender for Cloud, and Microsoft Entra Identity Protection logs. Azure and Office 365 activity and audit logs use connectors.

This classification prevents duplicate-ingestion assumptions. It also helps you estimate the effect of each proposed data source instead of assigning one cost and retention model to all security data.

For every additional source, document:

- The operational use case and the decisions the data supports.
- The data owner and classification.
- Expected volume and ingestion method.
- Required parsing, normalization, or content.
- Users and workflows that need access.
- Retention and residency requirements.
- Expected ingestion and optional capability costs.
- A validation measure, such as improved coverage for a defined detection or investigation.

## Plan retention deliberately

During this phase of the preview, eligible customers receive 30 days of included retention for Defender data. Don't interpret this preview benefit as a universal retention policy for every data type or as a commitment that remains unchanged after preview.

Compare included retention with investigation, legal, audit, and threat-hunting requirements. If the organization needs longer retention, record the gap and identify an approved retention approach, data scope, and cost before implementation. Apply the relevant retention model to each category of data.

## Design access by task and scope

Access affects both functionality and the data shown to a user. Capability-specific permissions include examples such as:

- Microsoft Defender unified RBAC permissions for cases, workbooks, automation rules, and playbooks.
- Security Administrator for workspace creation.
- Azure subscription roles for provisioning workspace resources.
- Microsoft Sentinel roles for workspace-based scenarios.
- Access to the scopes and workloads referenced by workbook queries.

Define access from job responsibilities rather than job titles alone. Separate these responsibilities:

- Provision Azure resources.
- Administer ISOC capability settings.
- Manage cases and automation.
- View cases, workbooks, or security data.
- Review and approve changes.
- Audit activity and costs.

Use least privilege and scope access to the data and workloads each responsibility needs. Include periodic reviews, emergency access, separation of duties, and offboarding in the governance design.

## Estimate cost by decision

Build a cost model with separate entries instead of treating ISOC as one price:

| Cost area | Planning consideration |
| --- | --- |
| Eligible license | Confirm the tenant's active Microsoft Defender Suite, Microsoft 365 E5, or Microsoft 365 E7 eligibility. |
| Native Defender data | Don't assume a separate workspace-ingestion charge for data available directly in Defender. |
| Additional data | Estimate volume and possible ingestion charges for connector-based Microsoft and non-Microsoft data. |
| Optional capabilities | Validate separate pricing for capabilities such as UEBA. |
| Retention | Estimate the cost of meeting requirements beyond included retention or across other data categories. |
| Operations | Include testing, monitoring, content maintenance, access reviews, and analyst training. |

Use a range when volume or preview pricing is uncertain. Define who monitors consumption and which threshold triggers a review.

## Establish change controls

Preview capabilities can change. Add a review gate before each adoption phase to revalidate:

- Eligibility and licensing.
- Workspace requirements.
- Permissions and role names.
- Data handling and retention.
- Pricing and estimated consumption.
- Supported capability behavior.

Also define rollback or fallback criteria for workflows that depend on preview features. Avoid making a preview capability the only path for a critical production process unless the organization explicitly accepts that risk.
