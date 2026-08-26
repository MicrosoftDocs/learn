All your organization's Fabric data lives in OneLake, but you still need to find the right item. The OneLake catalog gives you a searchable view of everything you have access to. From there, you evaluate quality, choose a connection method, and start building.

## Browse and search the catalog

The **Explore** tab shows all the Fabric items you have permission to see. You can filter items and view metadata to narrow your search.  This metadata helps you decide whether an item is worth opening before you invest time exploring its contents.

Endorsement is a trust signal for items in Fabric to help you choose the right item.

| Level | What it means | Who can apply |
| --- | --- | --- |
| Promoted | Ready for others to use | Any user with write permissions |
| Certified | Meets organizational quality standards | Authorized reviewers only |
| Master data | Authoritative source for core business data | Authorized reviewers only (data items only) |

You can also use the SQL analytics endpoint to query lakehouses and warehouses to see if it's the right fit for your needs.

## Choose how to use the data

Once you trust the data, you have two paths depending on what you plan to build.

**Connect directly** when the data is already in the shape you need:

- Create a semantic model from a lakehouse or warehouse for downstream reporting
- Build a report on a semantic model that already has the right measures and relationships
- Query the SQL analytics endpoint for ad-hoc analysis

No shortcut or copy needed. You work with the data where it lives.

**Create a shortcut** when you need to enrich, combine, or transform:

- A shortcut references data from another OneLake location and appears in your lakehouse like a local table
- The data stays in the source and stays in sync
- You can join tables from different teams and build curated layers without duplicating data
- Fabric checks your identity for internal shortcuts, so you need read access on the source

**External shortcuts** connect to data outside of Fabric (Azure Data Lake Storage, Amazon S3, Google Cloud Storage). These use a stored cloud connection instead of your personal credentials.

:::image type="content" source="../media/discovery-connection-flow.png" alt-text="Diagram of three connection options from discovered data: connect directly, internal shortcut, or external shortcut.":::

> [!TIP]
> Think about your organization. How do you know if your data sources are trustworthy? How do you connect to data and build with it?
