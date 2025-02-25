While a blob is in the archive access tier, it's considered to be offline and can't be read or modified. In order to read or modify data in an archived blob, you must first rehydrate the blob to an online tier, either the hot or cool tier. There are two options for rehydrating a blob that is stored in the archive tier:

* **Copy an archived blob to an online tier**: You can rehydrate an archived blob by copying it to a new blob in the hot or cool tier with the [Copy Blob](/rest/api/storageservices/copy-blob) or [Copy Blob from URL](/rest/api/storageservices/copy-blob-from-url) operation. Microsoft recommends this option for most scenarios.

* **Change a blob's access tier to an online tier**: You can rehydrate an archived blob to hot or cool by changing its tier using the [Set Blob Tier](/rest/api/storageservices/set-blob-tier) operation.

Rehydrating a blob from the archive tier can take several hours to complete. Microsoft recommends rehydrating larger blobs for optimal performance. Rehydrating several small blobs concurrently might require extra time.

## Rehydration priority

When you rehydrate a blob, you can set the priority for the rehydration operation via the optional `x-ms-rehydrate-priority` header on a [Set Blob Tier](/rest/api/storageservices/set-blob-tier) or **Copy Blob/Copy Blob From URL** operation. Rehydration priority options include:

* **Standard priority**: The rehydration request is processed in the order it was received and might take up to 15 hours.
* **High priority**: The rehydration request is prioritized over standard priority requests and might complete in under one hour for objects under 10 GB in size.

To check the rehydration priority while the rehydration operation is underway, call [Get Blob Properties](/rest/api/storageservices/get-blob-properties) to return the value of the `x-ms-rehydrate-priority` header. The rehydration priority property returns either *Standard* or *High*.

## Copy an archived blob to an online tier

The first option for moving a blob from the archive tier to an online tier is to copy the archived blob to a new destination blob that is in either the hot or cool tier. You can use the [Copy Blob](/rest/api/storageservices/copy-blob) operation to copy the blob. When you copy an archived blob to a new blob in an online tier, the source blob remains unmodified in the archive tier. You must copy the archived blob to a new blob with a different name or to a different container. You can't overwrite the source blob by copying to the same blob.

Rehydrating an archived blob by copying it to an online destination tier is supported within the same storage account only for service versions earlier than 2021-02-12. Beginning with service version 2021-02-12, you can rehydrate an archived blob by copying it to a different storage account, as long as the destination account is in the same region as the source account. 

## Change a blob's access tier to an online tier

The second option for rehydrating a blob from the archive tier to an online tier is to change the blob's tier by calling **Set Blob Tier**. With this operation, you can change the tier of the archived blob to either hot or cool.

Once a **Set Blob Tier** request is initiated, it can't be canceled. During the rehydration operation, the blob's access tier setting continues to show as archived until the rehydration process is complete.

To learn how to rehydrate a blob by changing its tier to an online tier, see [Rehydrate a blob by changing its tier](/azure/storage/blobs/archive-rehydrate-to-online-tier#rehydrate-a-blob-by-changing-its-tier).

> [!CAUTION]
> Changing a blob's tier doesn't affect its last modified time. If there is a lifecycle management policy in effect for the storage account, then rehydrating a blob with **Set Blob Tier** can result in a scenario where the lifecycle policy moves the blob back to the archive tier after rehydration because the last modified time is beyond the threshold set for the policy.

