Monitoring and alerting enable systems to notify us when they're broken or about to break. Effective alerting distinguishes between genuine problems requiring human intervention and noise that wastes time and erodes trust in the monitoring system.

## The purpose of alerting

**When automatic recovery isn't possible:** Modern systems include self-healing capabilities like auto-scaling, automatic restarts, and failover mechanisms. When these automatic responses can't resolve an issue, human intervention becomes necessary. Alerts should trigger human investigation only when:

- A real problem exists that affects users or will soon affect users.
- The problem requires human decision-making or manual action.
- Automatic remediation has failed or isn't available.

**Clear investigation path:** When someone receives an alert, they should be able to:

1. Determine if there's a genuine problem.
2. Assess the severity and user impact.
3. Mitigate the immediate problem.
4. Investigate the root cause.
5. Implement preventive measures.

**Avoid vague alerts:** Unless you're doing security auditing on narrowly scoped system components, never trigger an alert simply because "something seems a bit weird." Vague alerts create alert fatigue and train teams to ignore notifications.

## Principles for actionable alerts

When reviewing existing alerts or writing new alerting rules, apply these principles to keep alerts relevant and on-call rotations sustainable:

### Urgency and importance

**Alerts that trigger call-outs should be urgent, important, actionable, and real.**

**Urgent:** The problem requires attention now, not tomorrow. If it can wait until business hours, it shouldn't page someone at 3 AM.

**Important:** The issue affects users, revenue, or critical business functions. Internal tooling issues might not warrant immediate wake-up calls.

**Actionable:** The person receiving the alert can take specific steps to address the problem. If the alert requires escalation to another team or vendor, reconsider who should receive the initial notification.

**Real:** The alert represents a genuine problem, not a false positive from overly sensitive thresholds or monitoring configuration issues.

### Problem representation

**Alerts should represent ongoing or imminent problems with your service.**

**Ongoing problems:** Users are currently experiencing issues. Response time is degraded, error rates are elevated, or functionality is unavailable.

**Imminent problems:** Metrics indicate a problem will occur soon if not addressed. Disk space will fill in 2 hours, certificate expires tomorrow, or cache hit rate is declining toward problematic levels.

**Not historical problems:** Don't alert on issues that have already resolved themselves. If response time spiked for 30 seconds but has returned to normal, an alert paging someone 10 minutes later wastes time.

### Balancing sensitivity

**Err on the side of removing noisy alerts. Over-monitoring is a more challenging problem to solve than under-monitoring.**

**Over-monitoring consequences:**

- Alert fatigue causes teams to ignore or silence notifications.
- Real problems get lost in noise.
- On-call stress increases without corresponding benefit.
- Teams spend more time investigating false positives than real issues.

**Under-monitoring risks:** You might miss some issues, but your team will remain responsive to actual problems. Under-monitoring is easier to fix by adding targeted alerts based on real incidents. Over-monitoring requires the difficult work of removing alerts teams have grown accustomed to.

**Practical approach:** Start with fewer alerts covering critical paths. Add new alerts based on real incidents where alerting would have helped. Remove alerts that frequently fire without indicating real problems.

## Problem classification

**Almost always classify problems into these categories:**

### Availability and basic functionality

Can users access the system? Do core features work? These are the most critical alerts:

- Service is completely unavailable.
- Authentication fails preventing user access.
- Critical transactions fail (payment processing, data submission).
- Database connectivity is lost.

### Latency

Is the system responding within acceptable timeframes?

- Response time exceeds SLA thresholds.
- User-facing operations take longer than users will tolerate.
- Background jobs miss processing deadlines.

### Correctness

Is the system producing correct results?

- **Completeness:** Are all expected results present? Missing data in reports, incomplete transaction processing.
- **Freshness:** Is data sufficiently current? Dashboards showing stale data, delayed processing pipelines.
- **Durability:** Is data persisted reliably? Failed backups, data replication issues.

### Feature-specific problems

Issues affecting particular features or user segments:

- Specific API endpoints failing while others work.
- Functionality broken for mobile users but working for desktop users.
- Features unavailable in certain geographic regions.

## Symptoms vs. causes

**Symptoms are a better way to capture more problems more comprehensively and robustly with less effort.**

### Alert on symptoms

**What users experience:** Response time is slow, errors occur, data is missing.

**Why symptom-based alerting is better:**

- One symptom alert can catch multiple different underlying causes.
- Symptoms directly correlate with user impact.
- You don't need to anticipate every possible cause.
- Symptom alerts remain valid even as infrastructure changes.

**Example:** Alert when "response time exceeds 2 seconds for 5 minutes" rather than creating separate alerts for high CPU, database slowness, and network issues. The symptom alert fires regardless of which underlying cause is responsible.

### Include causes in context

**Provide cause-based information in symptom-based pages or on dashboards, but avoid alerting directly on causes.**

**Why not alert on causes:** High CPU usage doesn't necessarily mean users are affected. The system might handle the load fine. Database query time increases might not impact user-facing operations if properly cached.

**Use causes for investigation:** When a symptom alert fires, responders should have access to cause information through dashboards, runbooks, or monitoring tools. This helps diagnose root causes without generating separate alerts.

**Example:** The symptom alert says "API response time is elevated." The associated dashboard shows database query time has tripled. The responder investigates the database without needing a separate "database slow" alert.

## Alert scope and abstraction

**The further up your serving stack you go, the more distinct problems you catch in a single rule. But don't go so far you can't sufficiently distinguish what is going on.**

### Higher abstraction benefits

Alerting at higher abstraction levels (user-facing metrics rather than low-level infrastructure) provides:

- Broader problem coverage with fewer alert rules.
- Better correlation with user impact.
- More resilient alerting as infrastructure changes.

**Example:** An alert on "checkout conversion rate drops 20%" catches database issues, payment gateway problems, and application bugs with one rule.

### Don't over-abstract

If alerts become too abstract, you lose diagnostic value:

- "Something is wrong" doesn't help responders know where to start investigation.
- Overly broad alerts might fire for unrelated reasons making pattern recognition difficult.
- You need sufficient detail to determine severity and appropriate response.

**Balance:** Alert at the highest level that still provides actionable context. User journey monitoring often provides this balance, tracking specific user flows through your system.

## Managing non-critical issues

**If you want an on-call rotation, it's imperative to have a system for dealing with things that need a timely response but aren't imminently critical.**

### Separate urgency levels

Not everything that needs attention requires immediate wake-up calls:

**Page-worthy (urgent):** Active user impact, revenue loss, data loss risk, security breaches.

**Next-business-day (important):** Issues that should be addressed soon but aren't currently affecting users. Disk space at 70% with days before it's critical, certificate expiring in a week, elevated error rates on non-critical features.

**Track-and-trend (informational):** Metrics worth monitoring for patterns but not requiring immediate action. Gradual performance degradation, increasing resource utilization within normal ranges.

### Implementation approaches

**Different notification channels:** Send urgent alerts to paging systems. Send important alerts to team channels monitored during business hours. Send informational data to dashboards and reports.

**Work queues:** Maintain issue queues categorized by priority. On-call handles urgent items immediately. Teams address important items during regular hours. Informational items inform capacity planning and optimization efforts.

**Regular review:** Schedule regular reviews of non-urgent alerts and informational metrics to catch gradual degradation before it becomes urgent.
