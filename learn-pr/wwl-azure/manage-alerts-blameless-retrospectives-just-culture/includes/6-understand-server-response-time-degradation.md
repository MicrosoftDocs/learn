Response time degradation alerts in Azure Application Insights notify you when your application responds to requests more slowly than its established baseline. Unlike sudden spike detection, this alert identifies gradual performance erosion that might otherwise go unnoticed until user complaints emerge.

## How response time degradation detection works

**Learning typical behavior:** Application Insights continuously gathers telemetry from your web application and builds statistical models of typical response times for different operation types. The system learns that certain requests naturally take longer than others:

- Complex database queries inherently require more time than simple lookups.
- Large data exports take longer than small result sets.
- Administrative operations might be slower than user-facing transactions.
- Image processing requests differ from text-based operations.

**Baseline establishment:** Over time (typically 8 days), Application Insights establishes baseline response time distributions for each operation type. The system tracks:

- Median response times for each operation.
- 95th percentile response times.
- Variance and standard deviation.
- Time-of-day patterns (some operations might be slower during peak hours).
- Day-of-week patterns (batch processes might affect weekend performance).

**Degradation detection:** When new telemetry indicates responses are consistently slower than the learned baseline, an alert generates. The detection focuses on sustained degradation rather than temporary spikes:

**Statistical significance:** Application Insights uses statistical analysis to distinguish genuine degradation from normal variance. Short-term fluctuations don't trigger alerts. Sustained performance changes that fall outside expected variance ranges do.

**Operation-specific analysis:** Each operation type is evaluated independently. A 20% slowdown in a typically fast operation might be significant, while the same percentage change in a naturally slow operation might be within normal variance.

## What response time degradation notifications tell you

Response time degradation notifications provide comprehensive diagnostic information to help you understand and resolve performance issues:

**Performance comparison:** The response time compared to normal response time for this operation. You see the percentage change and absolute time difference between current performance and the established baseline.

**User impact:** How many users are affected by the degradation. This helps you assess business impact and prioritize remediation efforts. A degradation affecting thousands of users requires more urgent attention than one affecting dozens.

**Detailed performance metrics:** Average response time and 90th percentile response time for this operation on the day of the detection and seven days before. The 90th percentile metric is particularly valuable because it shows how slower requests are performing, not just typical requests.

**Volume context:** Count of this operation requests on the day of the detection and seven days before. This helps determine if increased load is contributing to degradation. If request volume doubled while response time increased 50%, load might be the primary factor.

**Dependency correlation:** Correlation between degradation in this operation and degradations in related dependencies. If a database dependency simultaneously slowed down, that dependency might be causing the operation degradation.

## Diagnostic links provided

**Profiler traces:** Links to Profiler traces help you view where operation time is spent. These traces show method-level timing information, call stacks, and identify specific code paths consuming the most time. The link appears if Profiler trace examples were collected for this operation during the detection period.

**Performance reports:** Performance reports in Metric Explorer allow you to slice and dice time ranges and filters for this operation. You can compare performance across different time windows, identify patterns, and correlate with deployments or configuration changes.

**Call search:** Search functionality for this call to view specific call properties. You can examine individual request details including parameters, timing breakdowns, and associated telemetry to understand variations in performance.

**Failure reports:** If count > 1, failure reports indicate there were failures in this operation that might have contributed to performance degradation. Sometimes performance degradation and errors are related. Retry logic might cause slow overall response times even if requests eventually succeed.

## Requirements for effective detection

**Application Insights telemetry:** Response time degradation detection requires active Application Insights instrumentation in your application. The system needs continuous telemetry to build and maintain accurate baselines.

**Standard SDK conventions:** Detection works best when your application follows [standard Application Insights SDK platform conventions](/azure/azure-monitor/app/platforms). Proper instrumentation ensures:

- Request names are consistent and meaningful.
- Operation types are correctly categorized.
- Dependencies are properly tracked.
- Telemetry includes necessary context for analysis.

**Sufficient data volume:** The statistical models require adequate data to distinguish patterns from noise. Applications with very low traffic might not have enough data for reliable degradation detection.

**Consistent telemetry:** Regular telemetry flow enables accurate baseline maintenance. Large gaps in telemetry data can reduce detection accuracy.
