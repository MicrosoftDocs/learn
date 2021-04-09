Intro xxx with bulleted list of what you'll learn

- xxx



## non specific headings

and content xxx



Azure Cache for Redis improves app performance by supporting common application architecture patterns. These are described in the following table.

| Pattern                  | Description                                                  |
| :----------------------- | :----------------------------------------------------------- |
| Data cache               | Because databases are often too large to load directly into cache, it's common to use the *cache-aside* pattern. This pattern loads data into the cache only when needed. When the system makes changes to the data, the system can also update the cache, which is then distributed to other clients. Additionally, the system can set an expiration on data, or use an eviction policy to trigger data updates into the cache. |
| Content cache            | Many web pages are generated from templates that use static content such as headers, footers, banners. These static items shouldn't change often. Using an in-memory cache provides quick access to static content compared to backend datastores. This pattern reduces processing time and server load, allowing web servers to be more responsive. It can allow you to reduce the number of servers needed to handle loads. Azure Cache for Redis provides the Redis Output Cache Provider to support this pattern with ASP.NET. |
| Session store            | This pattern is commonly used with shopping carts and other user history data that a web application may want to associate with user cookies. Storing too much in a cookie can have a negative impact on performance as the cookie size grows and is passed and validated with every request. A typical solution uses the cookie as a key to query the data in a database. Using an in-memory cache, like Azure Cache for Redis, to associate information with a user is much faster than interacting with a full relational database. |
| Job and message queuing  | Applications often add tasks to a queue when the operations associated with the request take time to execute. Longer running operations are queued to be processed in sequence, often by another server. This method of deferring work is called task queuing. Azure Cache for Redis provides a distributed queue to enable this pattern in your application. |
| Distributed transactions | Applications sometimes require a series of commands against a backend data-store to execute as a single atomic operation. All commands must succeed, or all must be rolled back to the initial state. Azure Cache for Redis supports executing a batch of commands as a single transaction. |