Smart detection notifications include rich diagnostic information to help you investigate and resolve performance issues efficiently. Understanding how to interpret this information accelerates problem resolution.

:::image type="content" source="../media/notifications-diagnostic-information-ec845555.png" alt-text="Diagram showing diagnostic information.":::

## Notification components

Smart detection notifications provide three types of critical information to guide your investigation:

### Triage information

**Impact assessment:** The notification shows how many users or operations are affected by the detected performance issue. This quantitative data helps you prioritize your response.

**User impact metrics:**

- **Affected user count:** Number of unique users experiencing degraded performance.
- **Affected operation count:** Number of requests or operations impacted.
- **Percentage of total traffic:** What portion of your overall traffic is affected.
- **Time range:** When the degradation started and how long it has persisted.

**Using triage data for prioritization:** High user impact combined with significant degradation severity requires immediate attention. Issues affecting small percentages of traffic or users might be investigated during normal working hours. Consider business context when prioritizing. For example, degradation affecting your checkout process deserves higher priority than degradation affecting a rarely-used admin page, even if fewer total users are affected.

### Scope information

**Traffic segmentation analysis:** The notification reveals which segments of your traffic experience the performance issue:

**Page-level scope:** Is degradation affecting all pages or specific routes? If only certain pages are slow, the problem likely lies in code specific to those pages rather than general infrastructure issues.

**Browser scope:** Does degradation occur across all browsers or only specific ones? Browser-specific issues often indicate client-side JavaScript problems, rendering inefficiencies, or compatibility issues.

**Geographic scope:** Are users in specific regions affected? Regional patterns suggest network connectivity issues, CDN configuration problems, or data center performance variations.

**Device scope:** Do mobile users experience different performance than desktop users? Device-specific patterns might indicate responsive design issues, resource optimization needs, or device capability constraints.

**Authentication scope:** Are authenticated users affected differently than anonymous users? Authentication-specific degradation often relates to session management, permission checking, or personalization queries.

**Using scope data for investigation:** Narrow scope points to specific components or code paths. If degradation affects only mobile users accessing a specific page, you can focus investigation on mobile-specific code for that page. Broad scope affecting all traffic suggests infrastructure-level issues like database overload, network problems, or resource exhaustion.

### Diagnostic information

**Performance signatures:** The notification often includes diagnostic clues suggesting the nature of the problem:

**Load correlation:** If response time degrades specifically when request rate increases, your servers or dependencies are likely overloaded. This pattern indicates capacity constraints requiring infrastructure scaling or optimization.

**Time-based patterns:** Degradation occurring at specific times (e.g., every night at 2 AM) suggests scheduled jobs, backup operations, or batch processes consuming resources.

**Dependency correlation:** If application response time degrades when specific dependency duration increases, the problem originates in that external service rather than your application code.

**Exception correlation:** Increased exceptions coinciding with response time degradation often indicate your application is experiencing errors that slow processing or cause retries.

## Investigation tools

**Performance blade in Application Insights:** Access detailed performance analysis through the Application Insights Performance blade:

**Request distribution analysis:** View response time distributions across different percentiles (50th, 90th, 95th, 99th). This shows whether degradation affects all requests or just tail latencies.

**Operation timeline:** See when specific operations became slow and how performance changed over time.

**Dependency analysis:** Identify which dependencies contribute most to overall response time.

**Server metrics correlation:** Correlate performance degradation with server resource utilization metrics like CPU, memory, and disk I/O.

### Application Insights Profiler

**What Profiler provides:** [Application Insights Profiler](/azure/application-insights/app-insights-profiler) captures detailed execution traces showing exactly where your application spends time during request processing.

**Profiler data available in notifications:** If Profiler captured traces during the degradation period, the notification includes links to those traces. Profiler traces show:

- Method-level timing showing which functions consume the most time.
- Call stacks revealing the execution path through your code.
- Database query execution times and patterns.
- External API call durations.
- Thread behavior and blocking operations.

**Using Profiler effectively:** Profiler data reveals performance bottlenecks with precision. For example, if a database query takes 2 seconds of a 3-second request, you know exactly where to focus optimization efforts. Without Profiler, identifying specific slow operations requires extensive manual instrumentation and guesswork.

### Snapshot debugger

**What snapshot debugger provides:** If exceptions are thrown during performance degradation, the [snapshot debugger](/azure/application-insights/app-insights-snapshot-debugger) captures the complete application state at the moment of exception.

**Snapshot capabilities:**

- Full call stack at exception time.
- Variable values and object states.
- Request context and parameters.
- Session and user information.

**When to use snapshots:** Snapshot debugger is particularly valuable when performance degradation correlates with increased exceptions. The snapshots reveal why exceptions occur and what application state led to the failures.

## Systematic investigation approach

1. **Assess impact and prioritize:** Review triage information to understand severity. Determine if immediate response is required or if investigation can wait for normal working hours.

2. **Identify scope:** Examine scope information to understand which traffic segments are affected. This narrows your investigation focus significantly.

3. **Form hypotheses:** Based on diagnostic information, develop hypotheses about potential causes. For example, if degradation correlates with high load and affects all traffic, hypothesis might be infrastructure capacity constraints.

4. **Use investigative tools:** Open the Performance blade and examine detailed telemetry. If available, review Profiler traces to identify specific code paths causing slowness. Check snapshot debugger if exceptions are involved.

5. **Correlate with changes:** Check what changed around the time degradation started. Recent deployments, configuration changes, database schema changes, or traffic pattern shifts often correlate with performance issues.

6. **Verify and remediate:** Once you identify the likely cause, implement a fix and verify that performance returns to normal baselines. Continue monitoring to ensure the issue is fully resolved.
