As vector workloads grow beyond what a single database server can handle efficiently, you need strategies to scale capacity while managing costs. Azure Database for PostgreSQL provides several scaling options that address different aspects of the performance challenge.

## Vertical scaling on Azure

Vertical scaling increases the compute and memory resources available to your database server. For vector workloads, this directly addresses the CPU-intensive nature of similarity calculations and the memory requirements for keeping indexes cached.

Azure Database for PostgreSQL offers three compute tiers with different resource allocations. Each tier targets different workload profiles, balancing cost against performance capabilities. For vector search workloads, the memory-per-vCore ratio is important because it determines how much index data can remain cached in memory.

| Tier | vCores | Memory per vCore | Best for |
|------|--------|------------------|----------|
| Burstable | 1-20 | 2 GB | Development, low-traffic workloads |
| General Purpose | 2-96 | 4 GB | Balanced production workloads |
| Memory Optimized | 2-96 | 8 GB | Large working sets, vector workloads |

For the product recommendation scenario with two million vectors and high concurrency, Memory Optimized tiers provide the best fit. The extra memory per vCore helps keep HNSW indexes cached, reducing disk I/O during queries.

Vector query performance scales with both CPU cores (for parallel distance calculations) and memory (for index caching). For datasets under one million vectors, start with General Purpose 4-8 vCores, monitor memory pressure and cache hit ratios, and scale up if CPU utilization consistently exceeds 70% during peak load. For datasets of one to ten million vectors, start with Memory Optimized 8-16 vCores, ensure memory exceeds vector index size by at least 50%, and consider 32+ vCores for high concurrency (hundreds of concurrent queries). For datasets over ten million vectors, Memory Optimized 32+ vCores is typically required. Evaluate whether read replicas can distribute load, and consider architectural changes (partitioning, caching layer).

Vertical scaling has diminishing returns and hard limits. Scale up (larger server) when single-query latency is too high, memory pressure causes excessive disk I/O, or you haven't reached the tier's maximum resources. Scale out (replicas or caching) when total query volume exceeds what one server can handle, you have a read-heavy workload with acceptable staleness, or you hit vertical scaling limits. Vertical scaling is simpler to implement and manage. Start by scaling up until you hit limits or cost becomes prohibitive, then add horizontal scaling.

## Read replicas for query distribution

Read replicas maintain copies of your primary database that handle read queries independently. For vector search workloads that are predominantly reads, replicas can multiply your query capacity.

Azure Database for PostgreSQL uses physical streaming replication to keep replicas synchronized with the primary server. Changes written to the primary are streamed to replicas, which apply them asynchronously. The primary server handles both reads and writes, while each replica handles read queries only. You can create up to five read replicas per primary, and replicas can be located in different Azure regions. Each replica has its own connection endpoint, so your application must route queries to the appropriate server.

Because replication is asynchronous, replicas might be slightly behind the primary. This lag is typically milliseconds to seconds under normal conditions but can increase during heavy write activity on the primary, large transactions or bulk loads, network congestion between regions, or replica resource constraints. For product recommendations, replica lag is often acceptable. If a new product is added, its appearance in recommendations a few seconds later doesn't affect user experience. However, if your application requires immediate consistency (such as showing a user's just-updated preferences), those queries should go to the primary. Monitor replica lag using Azure Monitor metrics or query the replica directly with `SELECT EXTRACT(EPOCH FROM (now() - pg_last_xact_replay_timestamp())) AS lag_seconds;`.

Your application must direct queries to appropriate servers. Common patterns include application-level routing (choosing connection based on query type), DNS-based routing (using Azure Traffic Manager or custom DNS to distribute connections across replicas), and connection proxy (PgBouncer or similar proxies that route queries based on patterns). For the recommendation engine scenario, vector similarity searches are ideal candidates for replica routing since they're read-only and tolerance for slight staleness is high.

Replicas can be sized independently from the primary. For read-heavy vector workloads, you might use smaller replicas if query volume is the constraint (more replicas, smaller each), use equal or larger replicas if individual query performance matters, or place replicas in regions close to users for lower latency.

## Cache strategies for vector search

Caching reduces database load by serving repeated queries from faster storage. Vector search workloads have specific caching opportunities.

Not all vector search results benefit equally from caching. The best candidates have high request frequency, low change rates, and bounded key spaces. Random similarity queries against arbitrary vectors have an infinite query space and don't cache well, but lookups for specific items or precomputed recommendations cache effectively. Good caching candidates include popular product embeddings requested frequently, precomputed "similar items" for top products, user embedding lookups for personalization, and category-level aggregate embeddings. Poor caching candidates include arbitrary vector similarity queries (infinite query space), rapidly changing data (high invalidation rate), and queries with many filter combinations.

Azure Cache for Redis provides sub-millisecond response times for cached data. For vector workloads, consider caching embedding lookups and precomputed recommendations. The following example demonstrates caching product embeddings with a one-hour TTL.

```python
import redis
import json

redis_client = redis.Redis(host='your-cache.redis.cache.windows.net',
                          port=6380, ssl=True, password='your-key')

def get_product_embedding(product_id):
    cache_key = f"embedding:{product_id}"
    cached = redis_client.get(cache_key)

    if cached:
        return json.loads(cached)

    # Fetch from database
    embedding = fetch_embedding_from_db(product_id)

    # Cache for 1 hour
    redis_client.setex(cache_key, 3600, json.dumps(embedding))
    return embedding
```

Stale recommendations are usually acceptable for short periods, but eventually caches need refreshing. The right invalidation strategy depends on how quickly your data changes and how sensitive users are to outdated results. Most vector search applications can tolerate minutes of staleness, making simple time-based expiration effective. Set TTL (time to live) based on acceptable staleness. For product recommendations, 15-60 minutes is often reasonable. For event-driven invalidation, clear specific cache entries when underlying data changes. For background refresh, proactively refresh popular items before expiration to avoid cache misses.

## Monitor capacity and plan for growth

Proactive monitoring helps you scale before performance degrades noticeably.

Track database-level metrics through Azure Monitor including CPU percentage (sustained >70% indicates scaling need), memory percentage (approaching limits causes swapping), storage IO percentage (high values suggest insufficient caching), and active connections (approaching max_connections indicates pooling issues). Also track query-level metrics including P95/P99 query latency for vector searches, query throughput (queries per second), and cache hit ratio (if using PostgreSQL's buffer cache effectively).

Configure Azure Monitor alerts to notify you before problems affect users. Set a warning alert when CPU percentage exceeds 80% for 5 minutes to send email to the ops team. Set a critical alert when memory percentage exceeds 90% for 5 minutes to page the on-call engineer.

Effective capacity planning requires understanding your current usage patterns and projecting future needs. Without this foundation, you risk either over-provisioning (wasting budget) or under-provisioning (degrading user experience during growth). Establish baselines by measuring current query volume, latency, and resource utilization during normal and peak periods. Identify growth drivers such as catalog size growth, user growth, or query complexity changes. Model future load by projecting resource needs based on growth rate. If your catalog doubles annually and you're at 60% CPU, plan to scale within six months. Test scaling options before you need them by validating vertical scaling and replica deployment in non-production environments. Document thresholds that define when each scaling action should trigger.

## Cost optimization

Performance optimization must balance against budget constraints. Several strategies help control costs while maintaining acceptable performance.

Over-provisioning wastes money while under-provisioning hurts users. Review resource utilization regularly. If average CPU is below 30%, consider scaling down. If memory utilization is consistently low, General Purpose might suffice instead of Memory Optimized. If you have replicas with low utilization, consolidate.

Azure offers significant discounts (up to 65%) for one-year or three-year reserved capacity commitments. If your baseline workload is predictable, reservations reduce costs substantially. Calculate your baseline (minimum always-on capacity) and reserve that amount. Use on-demand pricing for burst capacity above the baseline.

Storage costs accumulate for large vector datasets. Remove unused indexes (each HNSW index adds ~50% to vector storage). Archive old vectors that are rarely queried. Use appropriate precision (float4 vs float8) for your accuracy needs.

Non-production environments don't need production-scale resources. Use Burstable tier for development. Scale down staging when not in active testing. Use smaller datasets in non-production (representative samples, not full copies).

## Additional resources

- [Compute and storage options in Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-compute-storage)
- [Read replicas in Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-read-replicas)
- [Azure Cache for Redis documentation](/azure/azure-cache-for-redis/)
- [Azure Monitor for Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-monitoring)
