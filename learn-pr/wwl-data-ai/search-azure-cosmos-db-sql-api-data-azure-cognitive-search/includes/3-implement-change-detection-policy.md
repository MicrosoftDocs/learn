The default query for the Azure Cosmos DB SQL API data source is the following SQL query.

```sql
SELECT
    *
FROM
    c
WHERE
    c._ts >= @HighWaterMark
ORDER BY
    c._ts
```

This query only finds items whose **timestamp** (_ts property) is greater than or equal to a built-in high watermark field. The high watermark field comes from a built-in change detection policy that attempts to identify whether an item has been changed or not.

To accomplish change detection, the indexer will index all items returned by the query. It will then store a timestamp as the high watermark. The next indexer run will then index items with a timestamp greater than or equal to the stored high watermark. This strategy effectively indexes all items that have been created or changed since the last run.

If your SQL query sorts the items to index using the timestamp, then Azure Cognitive Search can implement incremental progress during indexing. If the indexer fails for a transient reason, sorting the timestamps will allow the indexer to resume indexing from the failure point instead of reindexing the entire container again. This setting must be enabled when configuring the data source.

In the default query example, the result set is sorted using the ``_ts`` field. If you write a custom query, you must sort using the same field to enable incremental progress when indexing.
