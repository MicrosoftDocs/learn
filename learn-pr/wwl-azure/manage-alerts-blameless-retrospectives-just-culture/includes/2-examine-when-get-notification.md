[Azure Application Insights](/azure/application-insights/app-insights-overview) provides automated performance analysis for web applications. Smart detection continuously analyzes application telemetry and automatically warns you about potential performance problems without requiring manual threshold configuration.

**Automatic performance monitoring:** Unlike traditional monitoring that requires you to manually define thresholds for alerts, Application Insights smart detection uses machine learning to understand your application's normal behavior. It then automatically detects when performance deviates significantly from established baselines. This automated approach catches performance issues you might not think to monitor explicitly.

**Minimal setup requirements:** Smart detection activates automatically once you configure Application Insights for your application. Supported platforms include [ASP.NET](/azure/azure-monitor/app/asp-net), [Java](/azure/application-insights/app-insights-java-get-started), Node.js, and [client-side JavaScript](/azure/application-insights/app-insights-javascript). No additional configuration is needed beyond basic Application Insights instrumentation. The feature becomes active when your application generates sufficient telemetry volume.

## When smart detection sends notifications

Application Insights smart detection identifies three primary categories of performance degradation:

### Response time degradation

**What it detects:** Your application has started responding to requests more slowly than its historical baseline. Response time degradation can manifest in two patterns:

**Sudden degradation:** Response times increase rapidly, often within hours. This pattern typically indicates a regression introduced by a recent deployment, configuration change, or infrastructure problem. For example, deploying code with an inefficient database query or introducing a memory leak can cause sudden response time increases.

**Gradual degradation:** Response times increase slowly over days or weeks. This pattern often indicates resource exhaustion that accumulates over time. Common causes include memory leaks, database table growth without proper indexing, cache expiration configuration issues, or gradual increases in load without corresponding infrastructure scaling.

**Why it matters:** Users notice slow response times immediately. Every hundred milliseconds of additional latency reduces user satisfaction and engagement. For e-commerce applications, slower response times directly impact conversion rates and revenue.

### Dependency duration degradation

**What it detects:** Your application makes calls to external dependencies including REST APIs, databases, storage services, or third-party services. Smart detection identifies when these dependencies respond more slowly than their established baselines.

**Common scenarios:**

- Database query performance degrades due to missing indexes, table growth, or increased concurrent load.
- Third-party API services experience performance issues affecting your application.
- Network connectivity between your application and dependencies degrades.
- Storage services experience increased latency during high-load periods.

**Why it matters:** Modern applications depend heavily on external services. Dependency performance problems cascade through your application stack. A slow database query affects every request that depends on that data. Identifying dependency degradation helps pinpoint whether problems originate in your application code or external services.

### Slow performance patterns

**What it detects:** Performance issues affecting specific subsets of requests rather than all traffic. Smart detection identifies patterns where certain conditions correlate with slower performance.

**Example patterns:**

**Browser-specific issues:** Pages load slower in specific browsers due to JavaScript compatibility issues, rendering performance differences, or browser-specific resource loading behavior.

**Geographic patterns:** Requests from certain regions experience slower response times due to network latency, CDN configuration issues, or regional infrastructure constraints.

**Server-specific issues:** One server in a load-balanced pool performs poorly due to hardware problems, configuration drift, or resource contention from co-located processes.

**User segment patterns:** Authenticated users experience slower performance than anonymous users due to personalization queries, permission checks, or session data retrieval overhead.

**Operation-specific patterns:** Specific API endpoints or page types perform poorly due to inefficient code paths, expensive computations, or problematic queries.

**Why it matters:** Pattern-based degradation often indicates specific fixable problems rather than general capacity issues. Identifying patterns helps you prioritize optimization efforts and understand which user segments are affected.

## Establishing performance baselines

**Learning period requirement:** Smart detection requires at least eight days of telemetry data at workable volume before it can reliably identify anomalies. During this learning period, Application Insights establishes baseline performance characteristics including typical response times, dependency durations, and normal variation patterns.

**Baseline factors considered:**

- Time of day patterns showing when load typically peaks or valleys.
- Day of week variations reflecting business cycles.
- Seasonal trends in traffic and usage.
- Normal performance variation ranges.
- Correlation between load levels and response times.

**After the learning period:** Once baselines are established, smart detection continuously monitors performance. Any significant deviation from normal patterns triggers notifications. The system adapts baselines over time as your application evolves and traffic patterns change.

## Understanding notification meaning

**Notifications are suggestions, not confirmations:** When you receive a smart detection notification, it doesn't definitively mean your application has a problem requiring immediate action. Rather, it's a suggestion that something unusual has occurred worth investigating.

**Why this distinction matters:**

**False positives occur:** Some detected anomalies represent legitimate changes rather than problems. For example, smart detection might notify you about increased response times after you intentionally deployed features that process more data per request. The increased processing time is expected and acceptable given the new functionality.

**Context is critical:** Whether a detected anomaly represents a real problem depends on business context, user impact, and acceptable performance standards. Smart detection provides technical signal that something changed, but you must evaluate whether that change is problematic for your specific situation.

**Investigation starting point:** Think of smart detection notifications as investigation triggers rather than definitive problem reports. They direct your attention to areas where performance changed significantly, allowing you to determine if action is needed.
