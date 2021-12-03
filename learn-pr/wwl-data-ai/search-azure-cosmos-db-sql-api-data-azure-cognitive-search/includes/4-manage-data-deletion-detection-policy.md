If an item is deleted from a container in Azure Cosmos DB SQL API, that item may not be deleted from the index in Azure Cognitive Search. To enable tracking of deleted items, you must configure a policy to track when an item is deleted.

Azure Cognitive Search supports, exclusively, the ability to track if an item is deleted using a combination of a field and value in a soft-delete scenario. For example, consider this JSON document that has a property named ``_isDeleted`` with a value of ``true``.

```json
{
  "id": "E08E4507-9666-411B-AAC4-519C00596B0A",
  "categoryId": "86F3CBAB-97A7-4D01-BABB-ADEFFFAED6B4",
  "sku": "TI-R092",
  "name": "LL Road Tire",
  "_isDeleted": true
}
```

Using the soft-delete policy, the **softDeleteColumnName** for the data source (Azure Cosmos DB SQL API) would be configured as **_isDeleted**. The **softDeleteMarkerValue** would then be set to **true**. Using this strategy, Azure Cognitive Search will remove items that have been soft-deleted from the container.
