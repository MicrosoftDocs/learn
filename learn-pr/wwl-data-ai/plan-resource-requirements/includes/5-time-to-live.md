Azure Cosmos DB allows you to set the length of time documents live in the database before being automatically purged. A document's "time-to-live" (TTL) is measured in seconds from the last modification and can be set at the container level with the ability to override on a per-item basis.

Once set at the container level, Azure Cosmos DB will automatically purge documents at the specified time since they were last modified. The TTL value is defined as an integer in seconds.

> [!TIP]
> The maximum TTL value is 2147483647.

TTL expiration is a background task performed in the background using request units and is scheduled when quiescent.

## Configuring TTL on a container

The TTL value for a container is configured using the ``DefaultTimeToLive`` property of the container's JSON object.

| **DefaultTimeToLive** | **Expiration** |
| --- | --- |
| *Does not exist* | Items are not automatically expired |
| ``-1`` | Items will not expire by default |
| *n* | *n* seconds after last modified time |

The TTL value for an item is configured by setting the ``ttl`` path of the item. The TTL value for an item will only work if the ``DefaultTimeToLive`` property is configured for the parent container. If the ``ttl`` path is configured for the item, it will override the ``DefaultTimeToLive`` property of the parent container.

## Examples

| **Container.DefaultTimeToLive** | **Item.ttl** | **Expiration in seconds** |
| :--- | :--- | ---: |
| ``1000`` | *null* | ``1000`` |
| ``1000`` | ``-1`` |  *This item will never expire* |
| ``1000`` | ``2000`` | ``2000`` |

| **Container.DefaultTimeToLive** | **Item.ttl** | **Expiration in seconds** |
| :--- | :--- | ---: |
| *null* | *null* | *This item will never expire* |
| *null* | ``-1`` |  *This item will never expire* |
| *null*| ``2000`` | *This item will never expire* |
