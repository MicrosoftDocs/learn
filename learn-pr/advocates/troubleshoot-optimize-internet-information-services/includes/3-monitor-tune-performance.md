Troubleshooting fixes the immediate problem. Performance tuning prevents the next one. This unit covers the counters, settings, and configuration changes that keep IIS responsive under production load.

## Key performance counters for IIS

Performance Monitor (PerfMon) is the primary tool for quantitative IIS performance analysis. The counters that matter most fall into two categories: IIS-specific metrics and system resource metrics.

### IIS, HTTP.sys, and ASP.NET counters

| Counter | Object | What it indicates | Watch for |
|---------|--------|-------------------|-----------|
| Requests/sec | Web Service | Overall site throughput | Sudden drops under constant load indicate a bottleneck elsewhere |
| Current Connections | Web Service | Active client connections | Climbing without a matching rise in Requests/sec may indicate stalled connections |
| CurrentQueueSize | HTTP Service Request Queues | Requests waiting in the HTTP.sys queue for the application pool | Sustained growth indicates the worker process can't drain requests fast enough |
| Requests Queued (ASP.NET only) | ASP.NET | Requests waiting for an ASP.NET worker thread | Any sustained value above 0 signals the ASP.NET pipeline can't keep up |
| Request Wait Time (ASP.NET only) | ASP.NET | Time a request spent in the queue before processing began | Directly measures user-perceived latency from queuing |
| Requests Current (ASP.NET only) | ASP.NET | Requests currently in the pipeline (queued + executing) | Sustained high values combined with flat Requests/sec = bottleneck |
| Output Cache Hits % | Web Service Cache | Percentage of requests served from the output cache | Low values on cacheable content mean the cache isn't configured or is being invalidated too aggressively |

If the site isn't running ASP.NET, focus on the **Web Service** and **HTTP Service Request Queues** counters. The ASP.NET counters are only relevant for applications hosted on that stack.

### System resource counters

| Counter | Object | What it indicates | Watch for |
|---------|--------|-------------------|-----------|
| % Processor Time | Process (`w3wp`) | CPU consumed by IIS worker processes | Sustained > 80% indicates CPU-bound processing |
| Private Bytes | Process (`w3wp`) | Committed memory for the worker process | Steady growth over time without stabilization indicates a memory leak |
| Working Set | Process (`w3wp`) | Physical memory in use | Compare against available RAM to assess memory pressure |
| Available MBytes | Memory | Free physical memory system-wide | Below 500 MB on a dedicated web server suggests memory pressure |
| Avg. Disk sec/Read | PhysicalDisk | Average read latency | > 15 ms indicates slow storage and impacts static file serving and logging |
| Avg. Disk sec/Write | PhysicalDisk | Average write latency | High values affect IIS logging throughput |

### Capturing a baseline with Data Collector Sets

You can't identify abnormal behavior without knowing what normal looks like. Use a PerfMon Data Collector Set to capture a 24-hour baseline during typical production load.

1. Open Performance Monitor (`perfmon.msc`).
2. Expand **Data Collector Sets** > **User Defined**.
3. Right-click and select **New** > **Data Collector Set**. Name it `IIS Baseline`.
4. Choose **Create manually (Advanced)**.
5. Add a **Performance counter** data collector. Add the counters listed above.
6. Set the sample interval to **15 seconds**, frequent enough for trend analysis without excessive log volume.
7. Set a schedule and stop condition (for example, stop after 24 hours).
8. Start the collector during a representative traffic period.

The resulting `.blg` file can be opened later in PerfMon for analysis. Look for:

- **Steady-state values** for each counter. This is your baseline.
- **Peak values** and the time of day they occur.
- **Correlation** between counters. For example, does `CurrentQueueSize` (or `Requests Queued` for ASP.NET apps) spike when `% Processor Time` hits 90%? That confirms a CPU bottleneck.

## Application pool recycling tuning

IIS recycles application pool worker processes periodically to mitigate the effects of resource leaks and to ensure long-running processes don't accumulate state indefinitely. The default configuration recycles every 29 hours (1,740 minutes), which helps avoid recycling at exactly the same time every day.

### Recycling triggers

| Trigger | Default | Configuration path |
|---------|---------|-------------------|
| Regular time interval | 29 hours (1,740 minutes) | `recycling.periodicRestart.time` |
| Specific times of day | None | `recycling.periodicRestart.schedule` |
| Request limit | Disabled (0) | `recycling.periodicRestart.requests` |
| Virtual memory limit | Disabled (0 KB) | `recycling.periodicRestart.memory` |
| Private memory limit | Disabled (0 KB) | `recycling.periodicRestart.privateMemory` |

### Tuning strategy

The right recycling configuration depends on the application:

**Applications with stable memory usage:**

If you've monitored the app pool over time and confirmed that `Private Bytes` stabilizes rather than growing without bound, disable time-based recycling and keep a private memory limit as a safety net. This avoids unnecessary restarts and the latency spike that occurs while a new worker process initializes. To reduce cold-start latency after a recycle, consider using **Application Initialization** (`applicationInitialization`) together with an app pool `startMode` of `AlwaysRunning` and explicit warm-up requests so the new worker process is ready before it serves traffic.

```powershell
# Disable time-based recycling
Set-ItemProperty "IIS:\AppPools\MyAppPool" -Name recycling.periodicRestart.time -Value ([TimeSpan]::Zero)

# Set a private memory limit (in KB). Recycle if the process exceeds 4 GB
Set-ItemProperty "IIS:\AppPools\MyAppPool" -Name recycling.periodicRestart.privateMemory -Value 4194304
```

**Legacy applications with known memory leaks:**

Set the private memory limit below the threshold where the leak causes problems. Additionally, schedule recycling during off-peak hours.

```powershell
# Schedule recycling at 3:00 AM
Add-WebConfiguration "/system.applicationHost/applicationPools/add[@name='MyAppPool']/recycling/periodicRestart/schedule" -PSPath "IIS:\" -Value @{value="03:00:00"}
```

**High-availability applications:**

Use **overlapped recycling** (the default behavior). IIS starts a new worker process and begins routing new requests to it before signaling the old process to shut down. The `shutdownTimeLimit` setting (default: 90 seconds) controls how long the old process has to drain its existing requests before IIS terminates it.

```powershell
# Increase shutdown time limit to 120 seconds for long-running requests
Set-ItemProperty "IIS:\AppPools\MyAppPool" -Name processModel.shutdownTimeLimit -Value ([TimeSpan]::FromSeconds(120))
```

> [!TIP]
> Enable recycling event logging to track when and why recycles occur. In the application pool's advanced settings, set **Generate Recycle Event Log Entry** for the triggers you want to monitor. This creates Event Viewer entries you can use to correlate recycles with user-reported issues.

## Output caching and compression

Caching and compression are the two highest-return performance options for most IIS workloads. They reduce the amount of work the server does per request.

### IIS output caching

IIS can cache the response body for a request and serve it to subsequent requests without re-executing the application. There are two cache modes:

- **Kernel-mode cache:** The response is cached in HTTP.sys memory. Requests are served directly by the kernel driver without involving the IIS worker process. This is the fastest possible path, but it only works for cacheable anonymous responses. In practice that means unauthenticated GET responses. It doesn't support authenticated content or vary-by-query-string scenarios.
- **User-mode cache:** The response is cached in the IIS worker process. Use this mode when you need more flexible caching behavior, such as query-string variation or other dynamic cache rules, but it doesn't have the same speed advantage as kernel-mode.

To configuring a cache rule, make the following changes in web.config or applicationHost.config:

```xml
<!-- In web.config or applicationHost.config -->
<system.webServer>
  <caching>
    <profiles>
      <add extension=".aspx" policy="CacheForTimePeriod"
           kernelCachePolicy="CacheForTimePeriod"
           duration="00:05:00" />
    </profiles>
  </caching>
</system.webServer>
```

This rule caches `.aspx` responses for 5 minutes in both user-mode and kernel-mode caches.

**Cache invalidation:** Cached entries are evicted when:

- The configured duration expires.
- The underlying file changes (for file-based content).
- Memory pressure forces eviction.
- You recycle the application pool, restart the site, or clear the cached responses in IIS Manager.

Monitor the **Output Cache Hits %** counter in PerfMon to verify that caching is effective. If the hit rate is low on content you expected to be cached, check whether query-string variation, authentication, or `Cache-Control: no-cache` headers from the application are preventing caching.

### HTTP compression

IIS supports two types of HTTP compression:

- **Static compression:** Compresses files on disk (CSS, JavaScript, HTML) and caches the compressed version. The CPU cost is paid once, and subsequent requests serve the precompressed file. There's minimal reason to leave this disabled.

- **Dynamic compression:** Compresses responses generated by application code (ASP.NET pages, API responses) on every request. This trades CPU for bandwidth.

**Configuring compression:**

```powershell
# Enable static compression (usually enabled by default)
Set-WebConfigurationProperty -Filter "system.webServer/urlCompression" -PSPath "IIS:\" -Name doStaticCompression -Value $true

# Enable dynamic compression
Set-WebConfigurationProperty -Filter "system.webServer/urlCompression" -PSPath "IIS:\" -Name doDynamicCompression -Value $true
```

**Dynamic compression trade-offs:** On CPU-bound servers, dynamic compression adds load. Monitor `% Processor Time` for the `w3wp` process after enabling dynamic compression. If CPU utilization increases significantly and response times don't improve (because the server was already CPU-constrained), disable dynamic compression and address the CPU bottleneck first.

**Compression and caching interaction:** When output caching is enabled alongside compression, IIS can serve cached compressed responses, but the exact behavior depends on the `dynamicCompressionBeforeCache` setting. If dynamic compression occurs before the response is cached, subsequent requests can be served from cache without recompressing the response. If compression occurs after the cache is populated, IIS may cache the uncompressed response and compress it when sending it to the client.

## Connection and concurrency settings

IIS has several settings that control how many requests the server accepts and how they're queued. Misconfigured limits produce 503 errors under load. Overly generous limits allow a struggling server to accept more work than it can handle, making the problem worse.

### Key settings

| Setting | Default | Where it applies |
|---------|---------|-----------------|
| `appConcurrentRequestLimit` | 5,000 | Per-application request queue limit in `serverRuntime` |
| Application pool queue length | 1,000 | Per-pool limit on requests waiting in the HTTP.sys queue for a worker thread |
| `maxConnections` | 4,294,967,295 (effectively unlimited) | Per-site limit on simultaneous connections |
| Connection timeout | 120 seconds | Time a keep-alive connection can remain idle before being closed |

### Application pool queue length

This is the most commonly relevant concurrency limit. When the worker process can't drain requests fast enough, they accumulate in the HTTP.sys queue. If the queue fills to its configured length, HTTP.sys rejects additional requests with a 503 and writes a `QueueFull` entry to httperr.log.

**Raising the queue length** buys time during transient spikes but doesn't fix the underlying bottleneck. If requests are queueing, the worker process is overloaded, whether by CPU, memory, external dependency latency, or insufficient thread pool threads. Investigate with PerfMon counters before increasing the limit.

```powershell
# Increase queue length from default 1000 to 5000
Set-ItemProperty "IIS:\AppPools\MyAppPool" -Name queueLength -Value 5000
```

### `appConcurrentRequestLimit`

This `serverRuntime` setting limits how many requests can be queued for a single application. The default of 5,000 is sufficient for most servers. If you're hitting this limit, the application is processing requests too slowly or is under-provisioned. Investigate the bottleneck before raising it.

### Keep-alive and connection timeout

HTTP keep-alive allows clients to reuse TCP connections for multiple requests. This reduces connection setup overhead but means each open connection consumes memory on the server. The connection timeout (default: 120 seconds) controls how long an idle keep-alive connection persists.

On servers with many concurrent clients (thousands of connections), lowering the timeout to 30–60 seconds can free resources faster. On servers with a smaller number of clients making frequent requests, the default is appropriate.

```powershell
# Set connection timeout to 60 seconds for Default Web Site
Set-WebConfigurationProperty -PSPath "MACHINE/WEBROOT/APPHOST" `
    -Filter "system.applicationHost/sites/site[@name='Default Web Site']/limits" `
    -Name connectionTimeout -Value "00:01:00"
```

> [!IMPORTANT]
> Hitting concurrency limits under normal traffic usually means the real problem is elsewhere, such as slow application code, a slow database, or an exhausted thread pool. Raising limits masks the symptom. Always check `HTTP Service Request Queues\CurrentQueueSize` (and `Requests Queued` for ASP.NET apps), `% Processor Time`, and `time-taken` in the request logs before adjusting concurrency settings.
