Storing an item is rarely the end of the work. A price change might need to update a search index, a new order might notify a fulfillment service, and a renamed category might need to update every Product item carrying a copy of that name.

Applications can query for recently modified items, but polling repeatedly consumes request units even when nothing changed. It also requires the application to maintain its own checkpoint, doesn’t surface deleted items, and can’t recover intermediate versions of an item that changed multiple times between polls.

Azure Cosmos DB records changes made to the items in a container in the change feed. Changes are ordered within each logical partition, but there’s no global ordering across logical partitions. Applications can process the feed incrementally and resume from stored progress.

The available records depend on the change feed mode:

- **Latest-version mode** captures item creations and updates. If an item changes multiple times before it is read, only its latest version might be returned. It doesn’t capture deletes.
- **All-versions-and-deletes mode** captures creates, updates, deletes, and intermediate versions within the account’s continuous-backup retention period.

The Contoso catalog team meets both halves of this problem at once. Each product document stores a copy of the category name. If the category name changes in the metadata container, the copies in hundreds of product documents become outdated. They remain outdated until a process updates them. Separately, the team wants to move the catalog onto the hierarchical partition key they designed, and changing a container's partition key is a data movement operation rather than a settings change.

This module works through both problems. First, you learn what the change feed records and how to read it in two ways. You then implement a consumer that keeps a denormalized copy current. Next, you determine when a workload requires records of deletes and intermediate versions. You run the same logic in a serverless function. Finally, you copy the data to a container with a new partition key by using a copy job.

By the end of this module, you can build event-driven integrations on the Azure Cosmos DB change feed and move container data with container copy jobs.
