Slow and failed responses create significant frustration for users and directly impact business outcomes. Performance issues reduce user satisfaction, decrease conversion rates, and increase support costs. Addressing performance problems systematically is essential for maintaining competitive user experiences.

## Triage performance issues

**Assess business impact:** Not all performance issues require immediate attention. Effective triage balances technical metrics with business context:

**Consider usage frequency:** If a page loads slowly but only 1% of users ever access it, the impact is limited. You might have higher-priority issues affecting more users. However, consider the page's purpose. A rarely used admin configuration page might not warrant immediate optimization. A rarely accessed but critical checkout flow deserves attention despite low traffic.

**Evaluate severity:** A page that consistently throws exceptions for all users who access it represents a critical issue regardless of traffic volume. Failed requests are worse than slow requests. Prioritize fixing failures before optimizing performance.

**Use impact data as guidance:** Application Insights provides affected user counts and traffic percentages. Use these metrics as starting points for prioritization, but gather additional context:

- What business function does the affected page serve?
- Are high-value customers or revenue-generating transactions affected?
- Does the issue affect new user onboarding or critical workflows?
- Is the problem visible to external customers or only internal users?

**Geographic considerations:** If performance issues are geography-dependent, set up [availability tests](/azure/application-insights/app-insights-monitor-web-app-availability) for those specific regions. Regional performance problems often indicate network issues, CDN misconfiguration, or data center problems rather than application code issues.

## Diagnose slow page loads

**Identify the bottleneck:** Page load time divides into several distinct phases. Understanding where time is spent guides optimization efforts:

**Open Browsers metric blade:** Application Insights segments browser page load time into components showing where delays occur:

### Send request time analysis

**High send request time indicates:** The server responds slowly, or the request contains large amounts of data.

**Investigation steps:**

- Review [performance metrics](/azure/azure-monitor/azure-monitor-app-hub) to understand server response time patterns.
- Identify if specific API endpoints or page renders have unusually high response times.
- Check if POST requests contain excessive data that could be optimized or compressed.
- Correlate slow responses with server resource utilization (CPU, memory, disk I/O).

**Common causes:**

- Database queries taking excessive time due to missing indexes or inefficient queries.
- Synchronous processing of operations that could execute asynchronously.
- Insufficient server resources for current load levels.
- Unoptimized algorithms or inefficient code paths.

### Dependency tracking

**Set up dependency tracking:** Configure [dependency tracking](/azure/azure-monitor/app/asp-net-dependencies) to identify if slowness originates from external services or databases rather than your application code.

**What dependency tracking reveals:**

- How long your application waits for database responses.
- External API call durations and failure rates.
- Cache hit rates and lookup times.
- Storage operation latencies.

**Using dependency data:** If dependencies consume most request time, optimization should focus on those external services. Consider caching strategies, query optimization, or service-level agreements with external providers.

### Receiving response analysis

**High receiving response time indicates:** Large pages with many dependent resources (JavaScript files, CSS, images, etc.) take time to download. Note that asynchronously loaded data appears separately.

**Investigation approach:** Set up an [availability test](/azure/application-insights/app-insights-monitor-web-app-availability) with the option to load dependent parts enabled. Availability tests show load times for each resource:

- Which JavaScript bundles are largest and slowest to download?
- Are images optimized for web delivery?
- Does CSS load efficiently?
- Are fonts loading from appropriate CDNs?

**Optimization opportunities:** Once you identify large resources, you can prioritize optimization efforts on files that contribute most to load time.

### Client processing time

**High client processing time suggests:** JavaScript executes slowly in the browser.

**Investigation techniques:**

- Use browser developer tools to profile JavaScript execution.
- Identify expensive operations like DOM manipulation, complex calculations, or inefficient frameworks.
- Consider adding custom timing instrumentation through Application Insights track metrics calls.
- Test performance across different browsers and devices to identify platform-specific issues.

## Improve slow pages

**Optimization strategies:** Based on diagnosis results, apply targeted optimizations:

### Large file optimization

- **Load asynchronously:** Load scripts and other resources asynchronously so they don't block page rendering.
- **Script bundling:** Combine multiple JavaScript files into bundled packages to reduce HTTP requests.
- **Code splitting:** Break applications into smaller chunks that load on demand rather than loading everything upfront.
- **Widget-based architecture:** Structure pages as widgets that load data independently, allowing critical content to render first.
- **Efficient data formats:** Replace HTML table rendering with JSON data transfer. Use JavaScript to populate tables client-side, reducing initial payload size.
- **Modern frameworks:** Consider frameworks like React, Vue, or Angular that optimize rendering, though be aware these introduce their own JavaScript overhead.

### Server dependency optimization

- **Geographic co-location:** Ensure web servers and databases reside in the same Azure region to minimize network latency.
- **Query efficiency:** Review database queries to retrieve only necessary data. Avoid SELECT \* queries that transfer unused columns.
- **Caching strategies:** Implement caching for frequently accessed data that changes infrequently. Consider Redis or other distributed caches.
- **Request batching:** Combine multiple separate requests into batch operations to reduce network round trips.
- **Connection pooling:** Ensure efficient database connection management to avoid connection establishment overhead.

### Capacity issue resolution

- **Monitor server metrics:** Track response times correlated with request counts. If response times spike disproportionately during request peaks, servers are resource-constrained.
- **Horizontal scaling:** Add more server instances to distribute load.
- **Vertical scaling:** Increase server resources (CPU, memory) if individual requests require more processing power.
- **Auto-scaling:** Configure automatic scaling based on load metrics to handle traffic variations without manual intervention.
- **Load testing:** Conduct load tests to identify breaking points and capacity limits before they affect production users.
