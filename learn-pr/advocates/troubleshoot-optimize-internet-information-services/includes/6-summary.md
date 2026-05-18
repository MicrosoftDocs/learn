This module covered a systematic approach to IIS troubleshooting and performance optimization, following the workflow: **symptoms → data collection → root cause → resolution → verification**.

### Key takeaways

**IIS has a layered diagnostic pipeline. Use the right layer for the problem.**

- **IIS request logs** show you what happened for every completed request. Start here.
- **HTTP.sys error logs** catch what IIS request logs miss: requests rejected before they reach the worker process.
- **Failed Request Tracing** provides module-by-module pipeline detail when logs alone don't explain the problem.
- **Performance Monitor** gives you quantitative baselines and bottleneck identification.

**Performance tuning starts with measurement.**

Capture a PerfMon baseline before changing anything. The most impactful tuning levers for most IIS environments are:

- **Application pool recycling:** Match the recycling strategy to the application's behavior. Use memory-based triggers for modern apps, and use time-based plus memory limits for leaky legacy apps.
- **Output caching:** Eliminates redundant processing for repeated requests. Kernel-mode caching is the fastest path.
- **HTTP compression:** Reduces bandwidth at a small CPU cost (static) or a moderate CPU cost (dynamic).
- **Concurrency settings:** Only adjust these after confirming the real bottleneck. Raising limits on a struggling server makes the problem worse.

**A documented runbook turns individual expertise into team capability.**

Build runbooks for your most common incident categories. Start with a small set of high-confidence alert thresholds based on baseline data. Review and refine monthly.
