Here you learn about processes you can implement to monitor site reliability. You learn about ongoing tuning of your alerts to reduce meaningless or non-actionable alerts.

## Monitoring and alerting

Monitoring and alerting enables a system to tell us when it’s broken, or perhaps to tell us what’s about to break. When the system isn’t able to automatically fix itself, we want a human to investigate the alert, determine if there’s a real problem, mitigate the problem, and determine the root cause of the problem.

When you are reviewing existing alerts or writing new alert rules, consider these things to keep your alerts relevant and your on-call rotation happier:

- Alerts that trigger a human call-out should be urgent, important, actionable, and real.
- They should represent either ongoing or imminent problems with your service.
- Remove noisy alerts – over-monitoring is a harder problem to solve than under-monitoring.
- You should be able to classify the problem into one of: availability & basic functionality; latency; correctness (completeness, freshness and durability of data); and feature-specific problems.
- Symptoms are a better way to capture more problems more comprehensively and robustly with less effort.
- Include cause-based information in symptom-based pages or on dashboards, but avoid alerting directly on causes.
- The further up your serving stack you go, the more distinct problems you catch in a single rule. But don't go so far you can't sufficiently distinguish what's going on.
- If you want a quiet on-call rotation, have a system for dealing with issues that need a timely response, but are not imminently critical.

## Monitor for your users

Monitoring for your users is also called *symptom-based monitoring.* This is in contrast to *cause-based monitoring.* Your users don't care if your data push is failing, they care about whether their results are fresh.

In general, users care about:

- Basic availability and correctness. no "Oops!", no 500s, no hung requests or half-loaded pages or missing Javascript or CSS or images or videos. - Anything that breaks the core service in some way should be considered unavailability.
- Latency. Fast. Fast. Fast. Also, fast.
- Completeness/freshness/durability. Your users data should be safe, should come back when you ask, and search indices should be up-to-date.
- Even if it is temporarily unavailable, users should have complete faith that it's coming back.
- Features. Your users care that all the features of the service work—you should be monitoring for anything that is an important aspect of your service even if it's not core functionality/availability.

There's a subtle but important difference between database servers being unavailable and user data being unavailable. The former is a proximate cause,the latter is a symptom.

## Cause-based alerts have their place

Sometimes there is no symptom to alert on but you still need to be alerted to a situation. For example, running low on memory. You want rules to notify you of issues that could become a problem before they cause a symptom. In this case, you can write a rule to alert on this condition.

However, don't write cause-based rules that trigger on call alerts for symptoms you can catch otherwise.

## Tickets, Reports and Email

Alerts that need attention soon, but not right away are *sub-critical alerts*. Here are some suggestions for logging sub-critical alerts for follow-up:

- Bug or ticket-tracking systems can be useful for this type of alert. An alert can open a bug, as long as multiple firings of the same alert get correctly threaded into a single ticket/bug. These bugs can then go through a triage process to be assigned for follow-up. It is important that these types of issues get addressed before they become critical. Take into account how much of your tem members' time can be devoted to bug-fixing.
- A daily (or more frequent) report can be useful as well. Write sub-critical alerts that are long-lived, for example, the database is over 90% full, to a report that shows all currently-firing alerts. Assign someone to triage this report daily.
- Every alert should be tracked through a workflow system to insure that they are being seen and addressed.

In general, create a system that has accountability for responsiveness, but doesn't have the high cost of immediate human intervention.

## Playbooks

Playbooks, sometimes referred to as runbooks, are an important part of an alerting system. Have an entry in the playbook that explains what to do in the case of each alert or family of alerts that catch a symptom.

## Tracking & Accountability

If an on-call is firing and the person determines that there is nothing wrong, that's a sign that you need to remove the rule, or demote it, or collect data in some other way. Alerts that are less than 50% accurate are broken. Even those that trigger false positives 10% of the time merit more consideration.

Having a system in place such as a weekly review of all triggered on-call alerts and analyzing quarterly alert statistics can help to see the bigger picture of your application and show patterns that are lost when focussing on individual alerts.

## When to seek the exception from the rule?

Here are some reasons you might break the above guidelines:

- You have a known cause that actually sits below the noise in your symptoms. For example, if your service has 99.99% availability, but you have a common event that causes 0.001% of requests to fail, you can't alert on it as a symptom because it's in the noise, but you can catch the causing event.
- You can't monitor at the entry point because you lose data resolution. For example, you tolerate some endpoints being slow, like credit card validation. At your load balancers, this distinction may be lost. You will need to walk down the stack and alert from the highest place where you have the distinction.
- Your symptoms don't appear until it's too late. For example, you've run out of quota. You need to page before it's too late, and sometimes that means finding a cause to page on for example, you usage is greater than 80% and will run out in less than 4 hours at the growth rate of the last 1 hour. However, you should also be able to find a similar cause that's less urgent For example, your quota is greater than 90% and will run out in less than 4 days at the growth rate of the last 1 day will catch most cases and deal with that as a ticket or email alert or daily problem report, rather than the last-ditch escalation that a page represents.
- Your alert setup is more complex than the problems they're trying to detect. The goal should be to tend towards simple, robust, self-protecting systems.
