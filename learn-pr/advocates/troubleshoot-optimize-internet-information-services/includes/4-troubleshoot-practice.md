The tools and techniques in the previous units solve individual incidents. This unit shifts focus from reactive firefighting to a repeatable, team-wide operational practice. The goal: any administrator on your team can diagnose a common IIS issue by following a documented procedure, without relying on tribal knowledge.

## Building a diagnostic runbook

A diagnostic runbook is a step-by-step procedure for investigating a specific category of issue. It codifies the investigative steps that experienced administrators carry in their head and makes them available to the entire team.

### Runbook template

Every runbook should follow a consistent structure:

1. **Symptom trigger:** How is the issue detected? (User report, monitoring alert, health check failure.)
2. **Initial data collection:** Which logs, counters, and status checks to gather immediately, before making any changes.
3. **Decision tree:** Branching steps based on what the data shows. Each branch leads to a specific root cause or to further data collection.
4. **Resolution actions:** For each identified root cause, the specific fix and the commands to apply it.
5. **Verification:** How to confirm the issue is resolved. What should the logs and counters look like after the fix?
6. **Escalation criteria:** When the runbook's scope is exhausted. Clear criteria for handing off to application developers, infrastructure teams, or Microsoft Support.

### Example runbook: slow responses (time-taken > 10 seconds)

**Trigger:** Monitoring alert fires on average `time-taken` > 10,000 ms over a 5-minute window.

**Initial data collection:**
- IIS request logs: filter for `time-taken` > 10,000 ms. Note which URLs (`cs-uri-stem`) appear most often in slow requests.
- PerfMon snapshot: capture `HTTP Service Request Queues\CurrentQueueSize`, `ASP.NET\Requests Queued` (if applicable), `% Processor Time (w3wp)`, `Available MBytes`, `Requests/sec`.
- Application pool state: confirm pool is running.

**Decision tree:**

```
Is the app pool stopped?
├─ YES → Check Event Viewer for WAS events → restart pool → escalate if it stops again
└─ NO → Are requests queuing? (CurrentQueueSize > 0 sustained)
   ├─ YES → Is CPU > 80%?
   │  ├─ YES → CPU-bound. Review IIS request logs for the slowest and most frequent URLs.
   │  │        Then enable FREB on time-taken > 10s to capture those requests.
   │  │        Short-term mitigation: enable output caching for frequently requested URLs.
   │  │        Long-term: escalate to dev team with trace data.
   │  └─ NO → Is Available MBytes < 500?
   │     ├─ YES → Memory pressure. Check Private Bytes trend for leak.
   │     │        Short-term: recycle the app pool. Set private memory limit.
   │     └─ NO → External dependency (database, API). Enable FREB to identify
   │              the slow module. Check network latency to the dependency.
   └─ NO → Requests aren't queuing but are still slow.
           Likely a single slow endpoint, not a system-wide issue.
           Check IIS request logs for patterns in affected URLs.
           Then use FREB traces to identify the specific URL and handler.
```

**Verification:** Average `time-taken` returns below baseline. `CurrentQueueSize` is 0 (and `Requests Queued` is 0 for ASP.NET apps). No new alerts fire for 30 minutes.

**Escalation:** If the slow URL is application code (identified via FREB traces showing delay in `ManagedPipelineHandler` or `AspNetCoreModuleV2`), escalate to the development team with the FREB trace files and the PerfMon data.

## Setting meaningful alert thresholds

Alerts are only useful if they fire on real problems and stay quiet during normal operation. Setting thresholds requires a baseline. You must know what "normal" looks like before you can define "abnormal."

### Baseline-first approach

Use the Data Collector Set technique from the *Monitor and tune IIS performance* unit to capture a 24-hour (or week-long) baseline during typical production traffic. Record:

- **p50 and p95 `time-taken`** from IIS logs.
- **Average and peak `Requests/sec`** from PerfMon.
- **Steady-state `% Processor Time`** for `w3wp`.
- **5xx error rate** as a percentage of total requests.

### Recommended starting thresholds

These are starting points. Adjust them based on your baseline data and your organization's tolerance for false positives.

| Metric | Threshold | Rationale |
|--------|-----------|-----------|
| 5xx error rate | > 1% of total requests over a 5-minute window | A small number of 5xx responses can occur during brief app restarts or transient backend failures. Sustained > 1% indicates a systemic issue. |
| p95 time-taken | > 2× the baseline p95 | Alerts on tail latency that exceeds your worst normal case. |
| HTTP Service Request Queues\CurrentQueueSize | Continuously > 10 for 30+ seconds | Brief queue spikes are normal under bursty traffic. A queue depth that stays above 10 indicates the worker process can't keep up with incoming requests. |
| Worker process crash / rapid-fail event | Any Event ID 5002 or 5011 | Rapid-fail protection fired (5002) or a worker process suffered a fatal communication error (5011). Always investigate. |
| Available MBytes | < 500 MB for 5+ minutes | On a dedicated IIS server, low available memory means the worker process or another process is consuming more than expected. |
| % Processor Time (w3wp) | > 85% sustained for 5+ minutes | The worker process is CPU-bound. Short spikes during traffic peaks may be acceptable, but sustained saturation isn't. |

### Avoiding alert fatigue

Start with a small set of high-confidence alerts, specifically the five or six metrics above. Resist the temptation to alert on everything. Each alert that fires without requiring action erodes the team's trust in the alerting system.

Review alert effectiveness monthly:

- **Alerts that never fire** may have thresholds set too high, or may be monitoring the wrong metric.
- **Alerts that fire frequently without requiring action** need higher thresholds or should be downgraded to informational dashboards.
- **Alerts that fire and consistently lead to investigation** are good alerts. Keep them.

### Integration options

Windows Server provides built-in mechanisms for alert-based automation:

- **Performance Monitor alerts:** PerfMon can trigger a Data Collector Set, run a program, or write an event when a counter crosses a threshold.
- **Windows Event Forwarding (WEF):** Forward specific IIS and WAS event IDs from multiple servers to a central collector.
- **Task Scheduler + Event Viewer:** Attach a scheduled task to a specific Event ID to automate an initial response (for example, automatically collect diagnostic data when Event ID 5002 fires).

These approaches integrate with any monitoring tool that can consume Windows events or PerfMon data.

## Scenario exercise: slow site under load

This scenario ties together the full module workflow. Work through it as a mental exercise.

**Situation:** During business hours, your monitoring dashboard shows average response time climbing from 200 ms to 4 seconds. No deployments have occurred. No alerts fired overnight.

**Step 1: Gather data.**

Check PerfMon:
- `HTTP Service Request Queues\CurrentQueueSize` is climbing steadily and is currently at 150.
- `% Processor Time` for `w3wp` is at 90%.
- `Requests/sec` is flat at 500. It hasn't increased even though the queue depth shows more requests are arriving than the server can process.
- `Available MBytes` is stable at 2 GB.

**Step 2: Interpret.**

The application is **CPU-bound**. The worker process is at 90% CPU and can't process more requests per second. Incoming requests that exceed the processing rate accumulate in the queue, adding latency. Memory and disk aren't factors. CPU is the constraint.

**Step 3: Investigate further.**

Enable FREB with a time-taken threshold of 5 seconds. After a few minutes, examine the traces. You find that 80% of the slow traces are for the URL `/api/reports/generate`, and the time is spent in `ManagedPipelineHandler`, which is the application code.

Check the IIS request log for this URL:

```powershell
$logs = Get-Content "C:\inetpub\logs\LogFiles\W3SVC1\u_ex260414.log" |
    Where-Object { $_ -notmatch '^#' } |
    ConvertFrom-Csv -Delimiter ' ' -Header 'date','time','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs(User-Agent)','cs(Referer)','sc-status','sc-substatus','sc-win32-status','time-taken'

$logs | Where-Object { $_.'cs-uri-stem' -eq '/api/reports/generate' } |
    Measure-Object -Property 'time-taken' -Average -Maximum
```

Average time-taken: 3,200 ms. Maximum: 12,000 ms. This single endpoint is consuming most of the server's CPU.

**Step 4: Short-term mitigation.**

If the report output doesn't change frequently, enable output caching for this URL:

IIS output caching profiles use the `extension` attribute to match requests by file extension. For extensionless API URLs like `/api/reports/generate`, extension-based caching rules won't match. Instead, set caching within the application code itself. For example, in ASP.NET Core:

```csharp
[HttpGet("/api/reports/generate")]
[OutputCache(Duration = 600)] // Cache for 10 minutes
public IActionResult GenerateReport() { /* ... */ }
```

> [!NOTE]
> The `[OutputCache]` attribute requires the Output Caching middleware, available in ASP.NET Core 7 and later. Register it in `Program.cs` with `builder.Services.AddOutputCache()` and `app.UseOutputCache()`. The older `[ResponseCache]` attribute only sets HTTP cache headers (`Cache-Control`) and doesn't perform server-side caching by itself.

Or in ASP.NET MVC:

```csharp
[OutputCache(Duration = 600, VaryByParam = "none")]
public ActionResult GenerateReport() { /* ... */ }
```

If caching isn't appropriate (every request produces a unique result), scale out behind a load balancer or move the report generation to a background job rather than tuning CLR thread settings blindly.

**Step 5: Long-term fix.**

Share the FREB trace files and PerfMon data with the development team. The traces show that `/api/reports/generate` spends most of its time in a synchronous database query that scans a large table. The development team needs to optimize the query, add an index, or move the report generation to an asynchronous background job.

**Step 6: Prevent recurrence.**

Add a PerfMon alert on `% Processor Time (w3wp)` > 85% sustained for 5 minutes. Add a second alert on `HTTP Service Request Queues\CurrentQueueSize` > 10 sustained for 30 seconds. Document this incident in a runbook entry for "CPU-bound slow responses."
