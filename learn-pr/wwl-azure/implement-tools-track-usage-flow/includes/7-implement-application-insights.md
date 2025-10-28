This unit provides practical guidance for **implementing Application Insights** in your applications, covering the complete workflow from installation to ongoing monitoring and optimization.

## Monitor: Establish continuous visibility

After installing Application Insights in your app, set up [availability web tests](/azure/application-insights/app-insights-monitor-web-app-availability) to monitor your application from external perspectives. Then implement these monitoring practices:

### Set up dashboards for team visibility

**Create a [dashboard](/azure/azure-monitor/app/app-insights-dashboards) for your team room** to keep an eye on critical metrics:

**Key metrics to display:**

- **Load metrics:** Request rate, concurrent users, throughput
- **Responsiveness:** Response time percentiles (50th, 95th, 99th)
- **Dependency performance:** Database query times, API call latencies, cache hit rates
- **Client-side metrics:** Page load times, AJAX call performance
- **Error rates:** Failed requests, exceptions, dependency failures

**Dashboard best practices:**

- Update in real-time during deployments
- Display on monitors in team areas
- Color-code health indicators (green/yellow/red)
- Include SLA compliance metrics
- Show trends over time alongside current values

### Identify performance issues

**Discover which are the slowest and most-failing requests:**

- Sort requests by response time to find bottlenecks
- Identify requests with highest failure rates
- Correlate slow requests with dependencies
- Track performance regression across deployments
- Prioritize optimization based on user impact

### Validate deployments with Live Stream

**Watch [Live Stream](/azure/application-insights/app-insights-live-stream) when you deploy a new release:**

- **Know immediately** about any degradation
- Monitor error rates in real-time (1-second refresh)
- See failed requests as they occur
- Track dependency failures
- Validate performance before completing rollout

## Detect, Diagnose: Rapid issue resolution

When you receive an alert or discover a problem, Application Insights provides comprehensive diagnostic capabilities:

### Assess user impact

**Determine how many users are affected:**

- Query telemetry for affected user count
- Identify geographic distribution of impact
- Determine if issue affects all users or specific segments
- Calculate business impact (lost revenue, abandoned transactions)
- Prioritize resolution based on user impact severity

**Example KQL query:**

```kusto
requests
| where timestamp > ago(1h)
| where success == false
| summarize AffectedUsers = dcount(user_Id), FailedRequests = count() by resultCode
```

### Correlate related telemetry

**Correlate failures with exceptions, dependency calls, and traces:**

- **Operation ID linking:** All telemetry for a request shares an operation ID
- **End-to-end transaction view:** See complete request flow across services
- **Exception correlation:** Link exceptions to the requests that triggered them
- **Dependency analysis:** Identify which downstream service caused the failure
- **Log correlation:** View application logs in context of the failed request

**Investigation workflow:**

1. Start with failed request in diagnostic search
2. View all related telemetry using operation ID
3. Examine dependency calls to identify slow/failed services
4. Review exception details and stack traces
5. Check application logs for additional context

### Deep diagnostic tools

**Examine profiler, snapshots, stack dumps, and trace logs:**

**Profiler:**

- See code-level performance breakdown
- Identify which methods consumed the most time
- Find inefficient algorithms or queries

**Snapshot debugger:**

- Capture memory snapshots from production
- View local variable values at exception time
- Debug without reproducing locally

**Stack dumps:**

- Full stack trace for every exception
- Navigate from exception to source code
- Understand call chain leading to error

**Trace logs:**

- Application logs correlated with requests
- Search logs across distributed services
- Filter by severity, time range, custom properties

## Build, Measure, Learn: Data-driven development

[Measure the effectiveness](/azure/application-insights/app-insights-usage-overview) of each new feature you deploy using a structured, data-driven approach:

### Plan measurement strategy

**Plan to measure how customers use new UX or business features:**

**Before development:**

- Define success metrics (adoption rate, conversion rate, engagement)
- Identify key user actions to track
- Determine segmentation criteria (user type, geography, device)
- Establish baseline metrics for comparison
- Set targets for feature success

**Measurement dimensions:**

- **Adoption:** What percentage of users try the new feature?
- **Engagement:** How often do users interact with it?
- **Completion:** Do users finish the workflow?
- **Performance:** Does the feature perform well?
- **Satisfaction:** Are users successful and happy?

### Implement custom telemetry

**Write custom telemetry into your code** to capture business-specific events:

**Custom events:**

```csharp
telemetryClient.TrackEvent("FeatureUsed",
    properties: new Dictionary<string, string> {
        {"FeatureName", "AdvancedSearch"},
        {"UserTier", "Premium"}
    },
    metrics: new Dictionary<string, double> {
        {"SearchResultCount", 42},
        {"SearchDurationMs", 150}
    });
```

**Custom metrics:**

```csharp
telemetryClient.TrackMetric("CartValue", orderTotal);
telemetryClient.TrackMetric("ItemsInCart", itemCount);
```

**Instrumentation best practices:**

- Use consistent naming conventions
- Add relevant properties for segmentation
- Include timestamps for temporal analysis
- Don't track personally identifiable information (PII)
- Keep telemetry lightweight (avoid high cardinality)

### Make data-driven decisions

**Base the next development cycle on hard evidence from your telemetry:**

**Analysis workflow:**

1. **Compare metrics:** Feature performance vs. baseline
2. **Segment analysis:** Performance across different user groups
3. **Funnel analysis:** Drop-off points in multi-step flows
4. **Cohort analysis:** Retention of users who adopted the feature
5. **Impact analysis:** Correlation with business outcomes

**Decision framework:**

**If metrics exceed targets:**

- Invest in expanding the feature
- Apply learnings to similar features
- Consider making feature more prominent

**If metrics meet targets:**

- Maintain and monitor
- Incremental improvements based on feedback
- Move resources to other priorities

**If metrics underperform:**

- Analyze why (usability, discoverability, value proposition)
- A/B test improvements
- Consider deprecation if no path to success

**Example scenario:**
New recommendation engine shows 60% adoption but only 15% conversion (target was 25%). Analysis reveals recommendations are accurate but UI is confusing. Next sprint focuses on UX improvements instead of algorithm enhancements.

## Get started: Implementation approaches

Application Insights is one of the many services hosted within **Microsoft Azure**, and telemetry is sent there for analysis and presentation.

### Prerequisites

Before you begin, you'll need a subscription to [Microsoft Azure](https://azure.com/):

**Subscription options:**

- **Free signup:** No credit card required for free trial
- **Pay-as-you-go:** Only pay for what you use
- **Enterprise Agreement:** Negotiated rates for organizations
- **Azure for Students:** Free credits for students

**Pricing considerations:**
If you choose the basic [pricing plan](https://azure.microsoft.com/pricing/details/application-insights/) of Application Insights, **there's no charge until your application has grown to have large usage:**

- **Free tier:** First 5 GB/month ingestion included
- **Pay-per-GB:** Beyond free tier, pay only for data ingested
- **Commitment tiers:** Discounts for predictable usage

**Organizational access:**
If your organization already has a subscription, they could add your Microsoft account to it. Contact your Azure administrator for access.

### Implementation approaches

There are **several ways to get started**. Begin with whichever works best for you. You can add the others later.

### Approach 1: Runtime instrumentation

**Instrument your web app on the server** without code changes:

**Advantages:**

- **Avoids any update to the code:** No recompilation or redeployment needed
- **Immediate monitoring:** Start collecting telemetry within minutes
- **No SDK dependencies:** No changes to application dependencies
- **Production-ready:** Safe for existing production applications

**Requirements:**

- **Admin access to your server:** Needed to install monitoring agent
- **Supported platforms only:** Not all platforms support runtime instrumentation

**Supported platforms:**

**[IIS on-premises or on a VM](/azure/application-insights/app-insights-monitor-performance-live-website-now):**

- Windows Server with IIS 7.5 or later
- ASP.NET applications (Framework or Core)
- Installs Status Monitor or Application Insights Agent
- Automatically instruments without code changes

**[Azure web app or VM](/azure/azure-monitor/app/azure-vm-vmss-apps):**

- Enable Application Insights through Azure Portal
- One-click integration for Azure App Service
- VM extension for Azure Virtual Machines
- Automatic instrumentation with zero code changes

**[J2EE](/azure/application-insights/app-insights-java-live):**

- Java applications running on Tomcat, JBoss, or WebLogic
- Agent-based instrumentation
- Captures requests, dependencies, exceptions
- Works with Spring Boot, Jakarta EE

### Approach 2: Development-time SDK integration

**Add Application Insights to your code** for complete control and customization:

**Advantages:**

- **Custom telemetry:** Write business-specific events and metrics
- **Full control:** Configure sampling, filtering, processors
- **All platforms:** Not limited to web applications
- **Local debugging:** Test telemetry during development

**Requirements:**

- **Source code access:** Modify and recompile application
- **SDK integration:** Add NuGet/Maven/npm packages
- **Development time:** Initial setup and testing required

**Supported platforms:**

**[Visual Studio (ASP.NET)](/azure/azure-monitor/app/asp-net):**

- Visual Studio 2013 update 2 or later
- NuGet package installation
- Automatic instrumentation + custom telemetry
- IntelliSense for telemetry APIs

**[Java](/azure/application-insights/app-insights-java-get-started):**

- Maven or Gradle dependency
- Spring Boot auto-configuration support
- Jakarta EE and Micronaut frameworks
- Manual instrumentation for custom events

**Node.js:**

- npm package installation
- Express, Koa, Hapi framework support
- Automatic dependency tracking
- Custom event and metric tracking

**[Other platforms](/azure/application-insights/app-insights-platforms):**

- Python (Flask, Django)
- Ruby (Rails, Sinatra)
- PHP (Laravel, Symfony)
- Go, Rust, and more community SDKs

### Client-side instrumentation

**[Instrument your web pages](/azure/application-insights/app-insights-javascript)** for comprehensive monitoring:

**JavaScript SDK capabilities:**

- **Page views:** Track navigation in SPAs
- **AJAX calls:** Monitor API requests from browser
- **Client-side exceptions:** Capture JavaScript errors
- **Performance metrics:** Page load time, resource timing
- **User analytics:** Session tracking, user flows

**Implementation:**

- Add JavaScript snippet to HTML pages
- Automatic page view tracking
- Correlate client and server telemetry
- Works with React, Angular, Vue frameworks

### Mobile application monitoring

**[Analyze mobile app usage](/azure/application-insights/app-insights-mobile-center-quickstart)** by integrating with Visual Studio App Center:

**Mobile platform support:**

- iOS (Swift, Objective-C)
- Android (Java, Kotlin)
- React Native
- Xamarin, Flutter

**Mobile-specific features:**

- Crash reporting
- Analytics (sessions, events, user properties)
- Push notification tracking
- Distribution and testing integration

### Synthetic monitoring

**[Availability tests](/azure/application-insights/app-insights-monitor-web-app-availability):**

**Test types:**

- **URL ping tests:** Simple endpoint availability checks
- **Multi-step web tests:** Recorded user scenarios
- **Custom TrackAvailability:** Code-based availability tracking

**Test configuration:**

- Ping your website regularly from distributed locations
- Monitor from 5+ global Azure regions
- Alert when endpoints become unavailable
- Measure response time from user perspectives

### Choosing the right approach

| Scenario                                   | Recommended Approach                    |
| ------------------------------------------ | --------------------------------------- |
| Existing production app, can't modify code | Runtime instrumentation                 |
| New application development                | SDK integration at development time     |
| Need custom business events                | SDK integration (required)              |
| Web application only                       | Runtime instrumentation (easier)        |
| Mobile application                         | Visual Studio App Center + App Insights |
| Complete monitoring (server + client)      | SDK integration + JavaScript snippet    |
| External availability only                 | Availability tests                      |
