Managing digital content lifecycle is crucial for organizations to meet compliance requirements and manage operational risks effectively. Event-based retention in Microsoft Purview allows organizations to automate the retention and deletion of content based on specific events, ensuring that important information is preserved until it is no longer legally or operationally necessary.

## Understand event-based retention

Event-based retention triggers the start of a retention period based on specific events, rather than just the age of the content. This approach is particularly useful in scenarios like employee departures, contract expirations, or the end of a product's lifecycle. Here's how it works:

- **Employee departure**: Retain employee records for a specified period, say 10 years, from the employee's departure date.
- **Contract expiration**: Keep contract-related documents for a determined period, such as five years after the contract ends.
- **Product lifecycle**: Maintain records related to a product until a certain time after the product is no longer manufactured.

These retention labels help in automating the management of records and ensure that documents are disposed of in a compliant manner.

## Components of event-based retention

To implement event-based retention effectively, it's important to understand how event types, retention labels, events, and asset IDs interact. This interaction is the basis of how event-based retention is configured and executed within an organization.

   :::image type="content" source="../media/diagram-event-based-retention-1.png" alt-text="Diagram illustrating the relationship of the beginning of event-based retention.":::

   :::image type="content" source="../media/diagram-event-based-retention-2.png" alt-text="Diagram illustrating the relationship of the end of event-based retention.":::

Consider the example **Product Lifetime** event type to illustrate event-based retention. In this scenario, retention labels are assigned to various types of product-related documents. These documents are linked to the **Product Lifetime** event type, which triggers the start of a retention period based on the product reaching its end-of-life date. This means that all relevant records must be retained for a specific duration, such as 10 years, from the date a product is discontinued.

When setting up this type of retention:

- **Create and apply retention labels**: Assign retention labels to product records. These labels are connected to the **Product Lifetime** event type to ensure that the records are kept for the required duration after the product is discontinued.
- **Asset identification**: Assign an asset ID to each document within SharePoint and OneDrive, linking it directly to a specific product. This ID ensures that the retention schedule is accurately applied based on the unique lifecycle of each product.
- **Event trigger**: When a product is officially discontinued, an event is recorded with the specific asset ID or keywords related to the product. This action sets the start date for the retention period.
- **Synchronization and retention execution**: Once the event is logged, the specified retention period activates for all documents tagged with the corresponding asset ID or keywords. The system synchronizes this information across all labeled content, beginning the countdown until the retention period expires.

It's important to understand that if you don't specify an asset ID or keywords for an event, **all content** with a retention label of that event type will have its retention period triggered by the event. This means that our scenario, all content would start being retained. It's unlikely this outcome is what you intended.

Finally, remember that each retention label has its own retention settings. In this example, they all specify 10 years, but it's possible for an event to trigger retention labels where each label has a different retention period.

## Steps to implement event-based retention

Event-based retention helps manage document lifecycles by retaining and deleting content based on specific events.

### 1. Create a retention label based on an event

First, navigate to **File plan** within Microsoft Purview to create a new retention label. While defining the label settings, select the option **Retain items forever or for a specific period**. This setup starts your path to defining when your retention period will begin. You can select an existing event type from a dropdown or create a new one if your scenario requires a unique trigger.

   :::image type="content" source="../media/create-event-type.png" alt-text="Screenshot showing where to configure event-based retention.":::

Event-based retention requires retention settings that:

- Retain the content.
- Delete the content automatically or trigger a disposition review at the end of the retention period.

### 2. Create a new event type (if needed)

If creating a new event type is needed, provide a name and description, then save it. Make sure to select this event type back on the **Define the period** page.

### 3. Publish or auto-apply the retention label

- Publish the retention labels so they can be applied manually or automatically to content.

### 4. Specify an asset ID

Once the label is in use, specify an asset ID for each relevant item. This ID can be a product code, project number, or any identifier used by your organization to track content. This detail is important as it links specific content to the event type, ensuring correct application of the retention policy.

   :::image type="content" source="../media/event-type-retention-asset-id.png" alt-text="Screenshot showing assigning an asset ID for event-based retention.":::

### 5. Create an event

When an event occurs, such as a product reaching the end of its lifecycle, create the event in the Microsoft Purview portal or compliance portal:

- Navigate to **Events** in either the Microsoft Purview portal or Microsoft Purview compliance portal:
  
  - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/) > **Records management** card > **Events**.

    - If you don't see the **Records management** card, select **View all solutions** and find **Records management** under the **Risk & Compliance** section.
  
  - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/) > **Solutions** > **Records management** > **Events**.

- Select **+ Create** to create an event.

Up to 1,000,000 events are supported per tenant.

### 6. Associate content with the event

During event creation, select the appropriate event type that matches the one you used for your retention label. This ensures that all content tagged with this label will begin its retention period. If multiple labels or events are involved, adjust your settings to for each scenario.