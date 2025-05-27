Every data set has a unique lifecycle. Early in the lifecycle, users tend to access some of the data in the set, but not all of the data. As the data set ages, access to all of the data in the set tends to dramatically reduce. Some data set stays idle in the cloud and is rarely accessed. Some data expires within a few days or months after creation. Other data is actively read and modified throughout the data set lifetime.

Azure Blob Storage supports [lifecycle management](/azure/storage/blobs/lifecycle-management-policy-configure) for data sets. It offers a rich rule-based policy for GPv2 and Blob Storage accounts. You can use lifecycle policy rules to transition your data to the appropriate access tiers, and set expiration times for the end of a data set's lifecycle.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=ce48b339-bc3a-412a-bf97-fb8581084431]

### Things to know about lifecycle management

You can use Azure Blob Storage lifecycle management policy rules to accomplish several tasks.

- Transition blobs to a cooler storage tier (Hot to Cool, Hot to Archive, Cool to Archive) to optimize for performance and cost.

- Delete current versions of a blob, previous versions of a blob, or blob snapshots at the end of their lifecycles.

- Apply rules to an entire storage account, to select containers, or to a subset of blobs using name prefixes or blob index tags as filters.

#### Business scenario 

Consider a scenario where data is frequently accessed in the early stages of the lifecycle, but only occasionally after two weeks. After the first month, the data set is rarely accessed. In this scenario, the Hot tier of Blob Storage is best during the early stages. Cool tier storage is most appropriate for occasional access. Archive tier storage is the best option after the data ages over a month. To achieve this transition, lifecycle management policy rules are available to move aging data to cooler tiers.

### Configure lifecycle management policy rules

In the Azure portal, you create lifecycle management policy rules for your Azure storage account by specifying several settings. For each rule, you create **If - Then** block conditions to transition or expire data based on your specifications. As you review these details, consider how you can set up lifecycle management policy rules for your data sets.

:::image type="content" source="../media/blob-lifecycle-2854d812.png" alt-text="Screenshot that shows how to add a lifecycle management policy rule for blob data in the Azure portal.":::

- **If**: The **If** clause sets the evaluation clause for the policy rule. When the **If** clause evaluates to true, the **Then** clause is executed. Use the **If** clause to set the time period to apply to the blob data. The lifecycle management feature checks if the data is accessed or modified according to the specified time.
   - **More than (days ago)**: The number of days to use in the evaluation condition. 

- **Then**: The **Then** clause sets the action clause for the policy rule. When the **If** clause evaluates to true, the **Then** clause is executed. Use the **Then** clause to set the transition action for the blob data. The lifecycle management feature transitions the data based on the setting.
   - **Move to cool storage**: The blob data is transitioned to Cool tier storage.
   - **Move to cold storage**: The blob data is transitioned to Cold tier storage. 
   - **Move to archive storage**: The blob data is transitioned to Archive tier storage.
   - **Delete the blob**: The blob data is deleted.

By designing policy rules to adjust storage tiers in respect to the age of data, you can design the least expensive storage options for your needs.

> [!TIP]
> Expand your knowledge in the [*Manage the Azure Blob storage lifecycle](/training/modules/manage-azure-blob-storage-lifecycle/) training module. 

