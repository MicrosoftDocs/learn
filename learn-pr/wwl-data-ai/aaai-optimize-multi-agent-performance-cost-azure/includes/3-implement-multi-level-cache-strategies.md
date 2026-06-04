Azure OpenAI Service includes built-in prompt prefix caching, and Azure Cache for Redis provides the infrastructure for semantic and result-level caching in multi-agent systems. Together, these services reduce redundant inference calls and lower the per-request cost at scale.

Every inference call that doesn't reach the model costs nothing and completes instantly. Adventure Works processes thousands of similar customer queries every day: "Where is my order?", "What's your return policy?", and "Do you ship to Canada?" Answering each query with a fresh model inference wastes compute and money when cached responses would serve most customers perfectly. But naive caching — simple key-value storage of exact query strings — misses 90% of cache opportunities because customers phrase the same question dozens of different ways. Effective multi-agent caching requires a layered strategy that addresses prompt reuse, semantic similarity, and deterministic result storage.

## Three cache levels for multi-agent systems

Multi-agent caching operates at three distinct levels, each optimizing a different aspect of the inference pipeline. The levels stack: a request flows through all three, and each level provides incremental cost reduction.

**Prompt caching** uses Azure OpenAI's built-in prefix caching to reduce costs when the system prompt remains constant across requests. Adventure Works' agents use long, detailed system prompts (1,500-3,000 tokens) that define the agent's role, provide policy context, and establish response formatting. These prompts never change within a deployment version. Azure OpenAI caches the prompt prefix automatically after the first request, and subsequent requests using the same prefix receive approximately 50% cost reduction on input tokens. The optimization is free — no infrastructure changes needed — but requires designing system prompts with stable prefixes. Variable content (customer context, retrieved documents) must appear after the cached prefix to maximize cache hit rates.

**Semantic caching** addresses the "same question, different words" problem using embedding similarity. Adventure Works uses two semantic caching patterns based on deployment constraints. One approach uses local cosine matching: generate a query embedding, scan a bounded Redis key set, and compute similarity in Python. If the previous question "What's the status of my delivery?" matches with 0.92 similarity, return the cached response without invoking the model. For vector-capable Redis deployments, the same pattern can be implemented with native vector search. Semantic caching requires careful threshold tuning: too low (0.80) produces false hits where dissimilar questions return incorrect cached responses, while too high (0.98) misses legitimate cache opportunities.

**Result caching** stores final agent outputs keyed by the complete input signature. This works best for deterministic workloads where the same input always produces the same output. Product catalog lookups, policy explanations, and store location queries are perfect candidates — the answers don't change unless the underlying data changes. Result caching requires careful cache invalidation: when the product catalog updates, all cached catalog responses must be purged. Adventure Works implements a tagging system where each cached result stores metadata about which data sources it depends on, enabling targeted cache invalidation when those sources change.

| Cache level | Hit rate | Cost reduction per hit | Implementation complexity |
|-------------|----------|------------------------|---------------------------|
| Prompt cache | 100% (automatic) | 50% on input tokens | Low (design-time only) |
| Semantic cache | 20-40% | 100% (no model call) | Medium (Redis + embeddings) |
| Result cache | 10-25% | 100% (no model call) | Medium (invalidation logic) |

The three levels compound: prompt caching reduces cost for all requests, semantic caching eliminates 20-40% of model calls, and result caching eliminates another 10-25%. Combined, a well-tuned caching strategy reduces overall inference costs by 60-70% at Adventure Works' scale.

## Semantic cache implementation with local cosine matching

Semantic caching transforms natural language questions into high-dimensional vectors that capture meaning rather than exact phrasing. When a request arrives, the system generates an embedding and then scans a bounded Redis key set to find semantically equivalent questions. Similarity is computed locally with numpy cosine matching rather than server-side Redis vector search.

Local cosine matching runs on standard Redis tiers without requiring extra Redis modules. In production environments that provide vector search support, you can replace the local scan with native vector queries while keeping the same threshold calibration and invalidation policies.

The semantic cache stores three components for each entry: the embedding vector of the original question, the agent's response to that question, and metadata including timestamp, agent ID, and data dependency tags. When searching for a cache hit, the workflow loads a bounded key set and computes cosine similarity scores in-process. If the highest score exceeds the threshold (0.92), the system returns the cached response. If no entry exceeds the threshold, the request proceeds to model inference, and the resulting response gets cached for future requests.

Cache invalidation for semantic caching requires time-based and content-based strategies. Time-based invalidation removes entries older than a configured TTL (time-to-live) — Adventure Works uses 7 days for general queries, 24 hours for time-sensitive information like shipping estimates, and 30 days for stable policy explanations. Content-based invalidation uses the dependency tags: when product data changes for product ID 12345, all cache entries tagged with that product ID are purged. The tagging system prevents stale responses while maximizing cache retention.

```python
import redis
import numpy as np
from datetime import datetime
from openai import AzureOpenAI
import os

class SemanticCache:
    def __init__(self, redis_host, redis_port, openai_client, threshold=0.92):
        self.redis_client = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)
        self.openai_client = openai_client
        self.threshold = threshold
        self.embedding_model = os.getenv("AZURE_EMBEDDING_DEPLOYMENT", "text-embedding-3-large")
    
    def get_embedding(self, text):
        """Generate embedding vector for input text."""
        response = self.openai_client.embeddings.create(
            input=text,
            model=self.embedding_model
        )
        return np.array(response.data[0].embedding)
    
    def cosine_similarity(self, vec1, vec2):
        """Calculate cosine similarity between two vectors."""
        return np.dot(vec1, vec2) / (np.linalg.norm(vec1) * np.linalg.norm(vec2))
    
    def check_cache(self, query_text, agent_id):
        """Check for semantically similar cached responses."""
        query_embedding = self.get_embedding(query_text)
        
        # Scan a bounded key set and compute similarity locally.
        search_key = f"cache:{agent_id}:*"
        cached_keys = self.redis_client.keys(search_key)
        
        best_match = None
        best_similarity = 0.0
        
        for key in cached_keys[:500]:  # Bound key scan for predictable performance.
            cached_data = self.redis_client.hgetall(key)
            if not cached_data:
                continue
            
            cached_embedding = np.array([float(x) for x in cached_data["embedding"].split(",")])
            similarity = self.cosine_similarity(query_embedding, cached_embedding)
            
            if similarity > best_similarity:
                best_similarity = similarity
                best_match = cached_data
        
        # Check threshold
        if best_similarity >= self.threshold:
            return {
                "hit": True,
                "response": best_match["response"],
                "similarity": best_similarity,
                "cached_timestamp": best_match["timestamp"]
            }
        
        return {"hit": False, "similarity": best_similarity}
    
    def store_cache(self, query_text, response, agent_id, dependencies=None):
        """Store new response in semantic cache with dependency tags."""
        query_embedding = self.get_embedding(query_text)
        cache_key = f"cache:{agent_id}:{hash(query_text)}"
        
        cache_entry = {
            "embedding": ",".join(str(x) for x in query_embedding),
            "response": response,
            "agent_id": agent_id,
            "timestamp": datetime.utcnow().isoformat(),
            "dependencies": ",".join(dependencies) if dependencies else ""
        }
        
        self.redis_client.hset(cache_key, mapping=cache_entry)
        self.redis_client.expire(cache_key, 604800)  # 7-day TTL
    
    def invalidate_by_dependency(self, dependency_id):
        """Invalidate all cache entries that depend on a specific data source."""
        all_keys = self.redis_client.keys("cache:*")
        
        for key in all_keys:
            cached_data = self.redis_client.hgetall(key)
            if dependency_id in cached_data.get("dependencies", "").split(","):
                self.redis_client.delete(key)
```

## Cache invalidation strategies for distributed agent systems

Maintaining cache consistency across a distributed multi-agent system is genuinely complex: a single data change can simultaneously invalidate cached responses across multiple independent agents. When product pricing changes, every cached response that mentioned that product's price becomes incorrect. When policy updates, every cached policy explanation becomes outdated. Adventure Works needs invalidation strategies that prevent stale responses without purging so aggressively that cache hit rates collapse.

**Dependency tagging** associates each cached response with the data entities it references. When caching a product recommendation response, tag it with the product IDs mentioned in the response. When caching a shipping estimate, tag it with the warehouse ID and carrier ID. When product 12345's price changes, invalidate all cache entries tagged with product 12345. The tagging system requires extracting entity references from responses — use simple regex patterns for structured IDs or a lightweight NER model for complex references.

**Version-based invalidation** handles schema changes and policy updates. Each data source (product catalog, policy database, inventory system) maintains a version number. Cached responses store the version numbers of all data sources they accessed. When product catalog v47 ships, all cache entries accessing versions lower than v47 are invalidated. This approach prevents gradual drift where some agents use stale policy while others use current policy.

**Cascading invalidation** addresses multi-agent dependencies. The recommendation agent's output depends on the inventory agent's stock levels and the pricing agent's current prices. When pricing data changes, invalidate not just the pricing agent's cache but also the recommendation agent's cache. Building the dependency graph requires tracing which agents call which other agents and which data sources each agent accesses.

Cache hit analysis identifies optimization opportunities. Track cache hit rate per agent, per hour, and per question category. Low hit rates indicate either excessive query variety (questions are too diverse to benefit from caching) or overly strict similarity thresholds. High hit rates with customer complaints about stale information suggest invalidation isn't aggressive enough. Adventure Works targets 30-40% semantic cache hit rates — lower suggests the cache isn't useful, higher suggests the workload is repetitive enough that the agents might be underutilized.

## Cost-benefit analysis of caching infrastructure

Implementing semantic caching requires investment: Redis infrastructure costs, embedding model inference costs for calculating query vectors, and engineering time for building invalidation logic. Adventure Works needs to verify that the cost savings from reduced model calls exceed the caching infrastructure costs.

The ROI calculation for semantic caching follows this formula:

- **Cache infrastructure cost** = Redis compute ($200/month for HA cluster) + embedding model costs ($0.0001 per request × 1M requests/month = $100/month) + engineering time (160 hours @ $100/hour = $16,000 one-time)
- **Savings per cached request** = Avoided model call cost (tier 2 average = $0.002 per request)
- **Monthly cache hits** = Total requests × cache hit rate = 1M requests × 35% hit rate = 350,000 hits
- **Monthly savings** = 350,000 × $0.002 = $700/month
- **Payback period** = One-time cost ÷ (monthly savings - monthly infrastructure cost) = $16,000 ÷ ($700 - $300) = 40 months

At this scale, semantic caching takes 40 months to break even. But Adventure Works processes 10M requests per month, not 1M. Recalculating at actual scale:

- Monthly cache hits = 10M × 35% = 3.5M
- Monthly savings = 3.5M × $0.002 = $7,000
- Payback period = $16,000 ÷ ($7,000 - $300) = 2.4 months

At production scale, semantic caching pays for itself in under three months. The lesson: caching infrastructure has high fixed costs but scales efficiently with request volume, making it most cost-effective at large scale.

With intelligent routing selecting the right model and multi-level caching eliminating redundant inference, Adventure Works has cut per-request costs significantly. The next optimization frontier: making each request that does require model inference as token-efficient as possible through aggressive context management.

## Key takeaways

- Multi-level caching is a powerful technique for reducing the cost of model inference in multi-agent systems.
- Dependency tagging, version-based invalidation, and cascading invalidation are essential strategies for maintaining cache freshness and accuracy.
- Cost-benefit analysis is crucial for determining the viability of caching infrastructure investments.
- At large scale, caching can provide significant cost savings and improve overall system performance.
