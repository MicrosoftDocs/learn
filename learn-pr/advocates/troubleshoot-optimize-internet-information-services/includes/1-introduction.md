Imagine that your web application passed every test in staging. Within hours of you deploying it to production, users report intermittent "Service Unavailable" errors and page loads stretching past 10 seconds. The application code hasn't changed. The server shows no obvious hardware failure. Something between the client and the application is broken, and it's your job to find it.

This scenario is routine for IIS administrators. The challenge isn't that IIS lacks diagnostic data. Instead, the data is spread across multiple log streams, performance counters, and event sources. Knowing *which* source to check *first* is the skill that separates a five-minute fix from an hours-long investigation.

## Why troubleshooting and performance are a single discipline

In IIS, errors and performance problems share the same diagnostic pipeline. A 503 "Service Unavailable" response might be caused by a crashed worker process, or by a healthy worker process that can't drain its request queue fast enough. A slow page might be an application code problem, or a misconfigured recycling schedule that restarts the worker process under load. The tools and workflow are the same: collect logs, read traces, check counters, adjust configuration.

This module treats troubleshooting and performance tuning as a single workflow: **symptoms → data collection → root cause → resolution → verification**.

This module teaches you about:

- **Failed Request Tracing:** Captures the full request pipeline with per-module timing, letting you pinpoint exactly where a request stalls or fails. In older documentation and some elements of the UI, this is termed Failed Request Event Buffering (FREB).
- **HTTP.sys error logs:** Show requests that the kernel-mode HTTP driver rejected *before* they ever reached a worker process.
- **Performance Monitor counters:** Provide quantitative baselines and bottleneck identification for CPU, memory, disk, and request throughput.
- **Tuning:** Covers application pool recycling, output caching, compression, and concurrency settings that directly impact production performance.

## Diagnostic toolbox

The following table summarizes the tools you use throughout this module. Refer back to it as a quick-reference during investigations.

| Tool | What it tells you | When to use it |
|------|-------------------|----------------|
| IIS request logs (W3C) | Per-request status codes, time-taken, client IPs, URI stems | First stop for any reported error or slowness |
| HTTP.sys error log (`httperr.log`) | Requests rejected before reaching the IIS worker process | 503s, connection resets, queue-full conditions |
| Failed Request Tracing (FREB) | Full request pipeline trace with per-module timing | Intermittent errors or slow requests that don't reproduce on demand |
| Event Viewer (System + Application) | App pool crashes, worker process recycling events, configuration errors | Startup failures, unexpected recycling |
| Performance Monitor (PerfMon) | Real-time and logged counters for CPU, memory, requests, queues | Sustained load problems, capacity planning, baseline capture |
| Resource Monitor / Task Manager | Live process-level CPU, memory, disk, and network consumption | Rapid triage to determine whether IIS is even the bottleneck |
