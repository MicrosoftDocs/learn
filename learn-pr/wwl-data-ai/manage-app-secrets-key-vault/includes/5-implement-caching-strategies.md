AI applications that process high volumes of requests can't afford the latency of a remote vault call for every operation. An AI inference service handling hundreds of requests per second would quickly exhaust Key Vault's throttling limits and introduce unnecessary latency if it retrieved secrets from the vault on every request. Caching secrets locally eliminates redundant calls, reduces latency from tens of milliseconds per vault call to microseconds for a local cache lookup, and keeps the application well within throttling boundaries. This unit covers caching patterns, cache invalidation strategies, and how to balance performance with security by controlling cache lifetime.

## Understand Key Vault throttling limits

Azure Key Vault enforces throttling limits to protect the service from excessive load. When your application exceeds these limits, Key Vault returns HTTP 429 (Too Many Requests) responses. Understanding these limits helps you design a caching strategy that prevents throttling while maintaining access to fresh credentials.

For secret operations, Key Vault allows up to 4,000 GET transactions per vault per ten-second window in a given region. Write operations (CREATE, IMPORT) share a collective limit of 300 transactions per ten-second window. Each Azure subscription has an additional aggregate limit of five times the per-vault limit across all vaults in a region.

> [!NOTE]
> Key Vault throttling limits and quotas change regularly. For the latest details, see [Azure Key Vault service limits](/azure/key-vault/general/service-limits).

These limits are generous for applications that cache secrets, but an AI service that calls `get_secret()` on every incoming request without caching can easily reach 4,000 reads in 10 seconds during traffic spikes. Caching transforms the access pattern from thousands of vault calls to a few periodic refreshes.

## Implement a time-based in-memory cache

The simplest caching pattern stores the secret value in memory with a timestamp and refreshes the value after a configurable interval. This approach works for secrets that change infrequently, such as API keys that rotate every 90 days. A short staleness window (such as 15 minutes or one hour) is acceptable for most AI workloads because credential rotation is a planned event with a transition period, not an instantaneous switch.

```python
# Code fragment - focus on time-based caching pattern
import time
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

class SecretCache:
    def __init__(self, vault_url, cache_ttl_seconds=900):
        credential = DefaultAzureCredential()
        self._client = SecretClient(vault_url=vault_url, credential=credential)
        self._cache = {}
        self._cache_ttl = cache_ttl_seconds

    def get_secret(self, secret_name):
        cached = self._cache.get(secret_name)
        now = time.monotonic()

        if cached and (now - cached["timestamp"]) < self._cache_ttl:
            return cached["value"]

        secret = self._client.get_secret(secret_name)
        self._cache[secret_name] = {
            "value": secret.value,
            "timestamp": now
        }
        return secret.value
```

The `cache_ttl_seconds` parameter controls how often the cache refreshes from Key Vault. A value of 900 seconds (15 minutes) means each secret is fetched at most four times per hour per application instance. For an AI service with 10 replicas, this translates to 40 vault calls per hour per secret instead of potentially millions of calls without caching. The `time.monotonic()` function provides a clock that isn't affected by system time adjustments, making it reliable for measuring elapsed intervals.

## Invalidate the cache with Azure Event Grid

Time-based caching introduces a staleness window where the application might use an old credential after rotation. For tighter cache freshness, you can subscribe to Key Vault's `SecretNewVersionCreated` event through Azure Event Grid. When someone stores a new secret version, Event Grid delivers a notification to your application through a webhook, Azure Function, or Service Bus queue. The application invalidates its local cache and retrieves the new secret on the next access. The event-driven invalidation process follows these steps:

1. A new secret version is stored in Key Vault.
1. Event Grid delivers a `SecretNewVersionCreated` event to the application through a webhook, Service Bus queue, or Azure Function.
1. The application invalidates the cached secret.
1. The next access retrieves the fresh value from Key Vault.

This event-driven approach combines the low latency of caching with near-real-time freshness. The cache only refreshes when a secret actually changes, rather than on a fixed timer. You can implement both patterns together as a defense-in-depth strategy: use Event Grid for immediate notifications and time-based expiration as a fallback in case an event delivery fails.

## Choose the right cache scope

The scope of your cache determines how many Key Vault calls your application fleet makes collectively. Different cache scopes involve different trade-offs between simplicity, consistency, and total API call volume.

**Per-process cache** is the simplest approach. Each application instance maintains its own in-memory cache. This works well for stateless services where each instance independently retrieves and caches secrets. The total number of Key Vault calls scales linearly with the number of instances. For an AI service with 10 replicas and a fifteen-minute cache TTL, you get at most 40 vault calls per hour per secret across the fleet. This is the recommended starting point for most applications.

**Shared distributed cache** uses an external store such as Azure Managed Redis as an intermediate layer between the application and Key Vault. One process fetches the secret from Key Vault and writes it to the shared cache. All other instances read from the shared cache instead of calling Key Vault directly. This approach reduces total Key Vault calls to one per refresh cycle regardless of instance count. However, it adds operational complexity and introduces a dependency on the shared cache infrastructure. It also means secrets are stored in an additional location outside Key Vault, which requires its own access control and encryption considerations.

**Application startup preloading** retrieves all required secrets at application startup and stores them in memory for the lifetime of the process. This pattern works for containerized services with rolling updates where instances restart periodically, and for secrets that rarely change. You can combine startup preloading with a periodic background refresh to handle secrets that rotate during the application's uptime. This approach is straightforward to implement and ensures that all secrets are available before the application begins processing requests.

```python
# Code fragment - focus on startup preloading pattern
class AppConfig:
    def __init__(self, vault_url, secret_names):
        credential = DefaultAzureCredential()
        client = SecretClient(vault_url=vault_url, credential=credential)

        self._secrets = {}
        for name in secret_names:
            secret = client.get_secret(name)
            self._secrets[name] = secret.value

    def get(self, secret_name):
        return self._secrets.get(secret_name)

# At application startup
config = AppConfig(
    vault_url="https://kv-ragpipeline-prod.vault.azure.net/",
    secret_names=["openai-api-key", "cosmosdb-connection-string",
                  "blob-storage-key"]
)

# During request processing - no vault calls
api_key = config.get("openai-api-key")
```

## Balance cache lifetime with security requirements

The cache lifetime you choose depends on your rotation frequency and the acceptable staleness window. Shorter cache lifetimes provide fresher credentials but increase Key Vault API calls. Longer lifetimes reduce API calls but extend the window where a rotated-out credential might still be in use.

For API keys that rotate every 90 days, a one-hour cache TTL is appropriate. The staleness window is at most one hour, which is small relative to the ninety-day rotation cycle. For credentials that might be revoked on short notice (such as after a security incident), a shorter cache lifetime of five minutes or event-driven invalidation through Event Grid is necessary. In emergency rotation scenarios, you might also restart application instances to force an immediate cache refresh.

Consider these guidelines when choosing a cache TTL:

- **High-rotation secrets (daily or weekly):** Use a five-to-fifteen-minute TTL combined with Event Grid notifications.
- **Standard-rotation secrets (monthly or quarterly):** Use a thirty-to-sixty-minute TTL. Event Grid is beneficial but not critical.
- **Low-rotation secrets (annual or static):** Use startup preloading with periodic refresh every few hours.

## Handle throttling gracefully

When your application receives a 429 response from Key Vault, implement exponential backoff with jitter before retrying. The Azure SDK's built-in retry policy handles most transient errors, but your application should also log throttling events to identify opportunities for better caching. A pattern of frequent 429 responses indicates that the cache lifetime is too short or that some code paths bypass the cache.

The recommended retry sequence follows exponential backoff: wait one second, then two seconds, then four seconds, then eight seconds, and then 16 seconds. Adding random jitter to each wait interval prevents multiple application instances from retrying simultaneously and creating a thundering herd effect.

```python
# Code fragment - focus on logging throttling events for cache tuning
import logging

logger = logging.getLogger("keyvault")

def get_secret_with_monitoring(cache, secret_name):
    try:
        return cache.get_secret(secret_name)
    except HttpResponseError as e:
        if e.status_code == 429:
            logger.warning(
                "Key Vault throttled request for '%s'. "
                "Consider increasing cache TTL.", secret_name
            )
        raise
```

Monitoring throttle events across your application fleet helps you tune the cache TTL over time. If you never see 429 responses, your caching strategy is working correctly. If you see occasional 429 responses during deployment windows (when multiple instances start simultaneously and preload secrets), consider staggering instance startup or using a shared cache to reduce the burst of initial vault calls.

## Additional resources

- [Azure Key Vault throttling guidance](/azure/key-vault/general/overview-throttling)
- [Monitoring Key Vault with Azure Event Grid](/azure/key-vault/general/event-grid-overview)
- [Best practices for using Azure Key Vault](/azure/key-vault/general/best-practices)
