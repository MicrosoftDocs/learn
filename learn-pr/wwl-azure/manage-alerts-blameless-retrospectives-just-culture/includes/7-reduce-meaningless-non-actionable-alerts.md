Monitoring and alerting enable a system to tell us when it's' broken, or perhaps to tell us what is about to break.

When the system can't' automatically fix itself, we want a human to investigate the alert. Determine if there's a real problem at hand, mitigate the problem, and determine the root cause.

Unless you're doing security auditing on narrowly scoped components of a system, you should never trigger an alert simply because "something seems a bit weird."

When you're reviewing existing alerts or writing new-alerting rules, consider these things to keep your alerts relevant and your on-call rotation happier:

 -  Alerts that trigger call-out should be urgent, important, actionable, and real.
 -  They should represent either ongoing or imminent problems with your service.
 -  Err on the side of removing noisy alerts – over-monitoring is a more-challenging problem to solve under-monitoring.
 -  You should almost always classify the problem into availability & basic functionality; latency; correctness (completeness, freshness, and durability of data); and feature-specific problems.
 -  Symptoms are a better way to capture more problems more comprehensively and robustly with less effort.
 -  Include cause-based information in symptom-based pages or on dashboards but avoid alerting directly on causes.
 -  The further up your serving stack you go, the more distinct problems you catch in a single rule. But don't go so far you can't sufficiently distinguish what is going on.
 -  If you want an on-call rotation, it's imperative to have a system for dealing with things that need a timely response but aren't imminently critical.
