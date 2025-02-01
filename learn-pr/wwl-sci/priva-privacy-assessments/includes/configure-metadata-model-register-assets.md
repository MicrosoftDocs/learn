Before assigning privacy assessments, organizations need a way to define and structure the data assets they evaluate. Privacy assessments are typically assigned to business assets, such as projects or business processes, rather than individual datasets like a database or table. These business assets provide context about how data is used across an organization.

Microsoft Purview’s metamodel helps organizations represent business assets in a structured way. By defining business assets and their relationships to physical data, organizations can ensure privacy assessments evaluate data usage within the correct context.

## Why configure the metamodel?

Privacy assessments evaluate whether personal data is being used appropriately in business operations. Instead of assessing individual datasets, organizations assess how data is used within broader processes like projects, applications, or business workflows.

Configuring the metamodel allows organizations to:

- **Define business assets** that represent data use cases, such as projects or business processes.
- **Establish relationships** between business assets and physical data assets, ensuring assessments reflect real-world data usage.
- **Ensure privacy assessments align** with business functions rather than focusing solely on technical data storage.

Teams responsible for curating data usage—such as business owners, compliance officers, or technical stakeholders—are typically involved in configuring the metamodel.

## What is the metamodel?

The metamodel is a feature in Microsoft Purview that enables organizations to represent logical business concepts, such as projects or business processes, and relate them to actual data assets. These relationships help organizations evaluate how personal data is used in different business contexts.

Organizations can use predefined asset types or create custom ones based on their needs. Examples of asset relationships in the metamodel include:

- **An organization asset** _has_ a department asset.
- **A department asset** _owns_ a business process.
- **A project or system asset** _uses_ a database or has a dataset, creating a relationship between business and physical data assets.

By defining these relationships, privacy assessments can evaluate data usage within a specific business process rather than looking at datasets in isolation.

## Prerequisites

Before configuring the metamodel and registering assets, ensure that your organization has access to the Microsoft Purview Data Map. Privacy Assessments rely on the Data Map to track relationships between business and physical data assets.

## Register an asset

To assign an asset to a privacy assessment, it must first be registered in Privacy Assessments. Follow these steps:

1. In **Privacy Assessments**, navigate to the **Assessment management** page.
1. On the **Assets** tab, select **Register asset**.
1. At **Asset type**, the default type is **Project**. You can leave  default setting or select a different type from the dropdown.
1. Enter a **Name** and an optional **Description**.
1. In the **Contacts** section, assign the appropriate owner to ensure they receive notifications about assessment activity, such as assignment, approval, or decline.
1. Select **Create**.

Once an asset is created, its details page displays privacy-related information. Any privacy assessments assigned to the asset will be listed under the **Privacy** section.

Organizations can also create logical business assets directly in Microsoft Purview Data Map and Unified Catalog, which allows for more advanced customization.

After registering assets, the next step is to assign privacy assessments to them.
