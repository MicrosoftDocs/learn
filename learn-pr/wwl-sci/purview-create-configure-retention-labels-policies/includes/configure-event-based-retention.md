Managing digital content lifecycle is crucial for organizations to meet compliance requirements and manage operational risks effectively. Event-based retention allows organizations to automate the retention and deletion of content based on specific events, ensuring that important information is preserved until it's no longer legally or operationally necessary.

## Understand event-based retention

Event-based retention triggers the start of a retention period based on specific events, rather than just the age of the content. This method is ideal in scenarios like employee departures, contract expirations, or the end of a product's lifecycle. Here's how it works:

- **Employee departure**: Documents are kept for a predetermined time, for example, 10 years from departure.
- **Contract expiration**: Documents are retained for a set duration, such as five years after the contract ends.
- **Product lifetime**: Product-related documents are maintained Maintain until a period after the product is no longer manufactured.

These retention labels help in automating the management of records and ensure that documents are disposed of in a compliant manner.

## Components of event-based retention

Understanding the interaction between event types, retention labels, events, and asset IDs is important for effectively implementing event-based retention. These components determine how retention is configured and executed.

   :::image type="content" source="../media/diagram-event-based-retention-1.png" alt-text="Diagram illustrating the relationship of the beginning of event-based retention.":::

   :::image type="content" source="../media/diagram-event-based-retention-2.png" alt-text="Diagram illustrating the relationship of the end of event-based retention.":::

For products with a specific lifecycle, such as those that are at their end of life, event-based retention triggers document retention from the product's end-of-life date. For instance, documents might need to be retained for 10 years post-discontinuation.

Setting up this type of retention involves:

- **Retention labels**: Attach retention labels to product-related documents linked to the **Product Lifetime** event type, ensuring documents are retained as required.
- **Asset identification**: Assign an asset ID to each document in SharePoint and OneDrive, directly associating them with specific products to accurately enforce retention schedules.
- **Event triggering**: Log an event with relevant asset IDs or keywords when a product ends its lifecycle to start the retention period.
- **Synchronization and retention execution**: Post-event, the system synchronizes the start of the retention period across all tagged documents, initiating the countdown to expiration.

If you don't specify an asset ID or keyword, **all documents** under that event type start their retention period, potentially leading to over-retention. Each label's settings, such as a 10-year duration in this example, can differ based on the label's configuration, affecting the retention timeline.

## Steps to implement event-based retention

Event-based retention helps manage document lifecycles by retaining and deleting content based on specific events.

### 1. Create a retention label based on an event

Navigate to **File plan** in Microsoft Purview to create a new retention label. Select **Retain items forever or for a specific period** and choose an event that triggers the retention period. You can use either an existing event type from a drop-down or create a new one if your situation requires a unique trigger.

   :::image type="content" source="../media/create-event-type.png" alt-text="Screenshot showing where to configure event-based retention.":::

Event-based retention requires retention settings that:

- Retain the content.
- Delete the content automatically or trigger a disposition review at the end of the retention period.

### 2. Create a new event type (if needed)

If creating a new event type is necessary, provide its name and description, then save it. This new event type should be linked back to the retention label on the **Define the period** page.

### 3. Publish or auto-apply the retention label

Publish the retention labels so they can be applied manually or automatically to content.

### 4. Specify an asset ID

For each document that falls under the event-based retention category, assign a specific asset ID. This ID links the document to the event type, enabling precise retention management. This ID can be a product code, project number, or any identifier used by your organization to track content.

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

Ensure that the content tagged with the retention label is linked to the created event by selecting the appropriate event type during event creation.

If your scenario involves multiple retention labels with different event types, use the **Choose Existing Labels** option to associate the event with the appropriate labels. This allows for targeted application of retention periods based on the specific event types assigned to each label.

### 7. Enter keywords, query, or asset ID

Narrow down the affected content by specifying asset IDs or using queries. If no asset ID is provided, all tagged content with labels of that event type get the same retention date applied to them.

Select the date when the event occurred to start the retention period. Once you create an event, its date is synchronized to all relevant content, labeled with matching event types, asset IDs, or keywords. This synchronization process can take up to seven days. Once set, the retention settings immediately apply to indexed content. For new content tagged after the event's creation, a new event needs to be logged. Deleting an event doesn't reverse the retention settings already in effect, and events can't be canceled once triggered.
