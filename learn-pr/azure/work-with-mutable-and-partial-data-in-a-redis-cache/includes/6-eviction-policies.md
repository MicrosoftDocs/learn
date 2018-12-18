Memory is the most critical resource for Azure Cache for Redis, because it's an in-memory database. You can run into problems when you begin adding data that exceeds the amount of memory available. Azure Cache for Redis supports eviction policies, which indicate how data should be handled when you run out of memory.

Here, you'll set an eviction policy to determine what your data should do when you exceed the maximum amount of memory.

## What is an eviction policy?

An eviction policy is a plan that determines how your data should be managed when you exceed the maximum amount of memory available. For example, using an eviction policy, you could tell Azure Cache for Redis to delete a random key to make room for the new data being inserted.

### Types of eviction policies

There are six different eviction policies provided by Azure Cache for Redis. All of these values perform an action when you attempt to insert data when you're out of memory.

* **noeviction:** No eviction policy. Returns an error message if you attempt to insert data.

* **allkeys-lru:** Removes the least recently used key.

* **allkeys-random:** Removes a random key.

* **volatile-lru:** Removes the least recently used key out of all the keys with an expiration set.

* **volatile-ttl:** Removes the key with the shortest time to live based on the expiration set for it.

* **volatile-random:** Removes a random key that has an expiration set.

## How to set an eviction policy

Azure provides a simple drop-down menu to set the eviction policy for Azure Cache for Redis. Select **Advanced Settings**, and use the **maxmemory-policy** drop-down menu.

Since memory is critical to Azure Cache for Redis, there is support for eviction policies. An eviction policy determines what should be done with existing data when you're out of memory and attempt to insert new data.