Classification, endorsement, and metadata create governance signals on individual items. But **governance gaps are invisible until something goes wrong**. A dataset stays certified after its source goes stale. Someone who changed teams still has write access to a production lakehouse. OneLake catalog enables you to see the current state of your data estate and take action before problems reach consumers.

:::image type="content" source="../media/govern-secure-tabs.png" alt-text="Diagram of the Govern and Secure sections in the OneLake catalog showing their key capabilities.":::

## Monitor governance with the Govern section

The **Govern** section in the OneLake catalog shows the governance posture of data you own or manage. It provides:

- **Insights** that highlight governance gaps, such as items without descriptions, missing sensitivity labels, or unendorsed production data
- **Recommended actions** with guidance on how to close each gap, including a filtered list of items to review and fix in one place
- **Reports** that break down label coverage, endorsement status, and data freshness across your estate

Fabric admins see tenant-wide insights that refresh daily from admin monitoring storage, so there can be a short delay between changes and when they appear. Data owners see insights scoped to the items they own, refreshed when they access the section. Both views can be filtered by domain to focus on a specific business area.

Start with the recommendations that affect consumer trust most directly. Items without descriptions are invisible to consumers searching the catalog. Missing sensitivity labels leave sensitive data unprotected. Unendorsed production data looks the same as someone's experiment.

## Understand security through the Secure section

The **Secure** section provides a centralized view of who can access what across your data estate.

**Workspace roles** show which users and groups have access to each workspace and at what level.

**OneLake security roles** control access to specific tables and folders within items, giving more granular control than workspace roles alone.

**Role management** lets you audit user access. You can also create, edit, or delete security roles from one place without navigating to each item individually.

**Security and governance work together.** Classification tells consumers what's sensitive. Endorsement tells them what's trusted. Security controls determine who can actually open and use the data. When these signals align, consumers see clear, consistent information about what data they should use and what's restricted.

## How governance carries into AI experiences

The governance signals covered in this module also affect how AI experiences choose and use data. Copilot and data agents prioritize endorsed items over unendorsed ones. Sensitivity labels set the same access boundaries for AI that they set for human consumers. Robust metadata details give AI better context for generating accurate responses.

> [!TIP]
> What governance gaps do you have in your organization?
