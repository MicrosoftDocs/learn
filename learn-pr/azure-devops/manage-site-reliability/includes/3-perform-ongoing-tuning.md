copied from ILT Perform ongoing tuning to reduce meaningless or non-actionable-alerts

## Monitoring and alerting

Monitoring and alerting enables a system to tell us when it’s broken, or perhaps to tell us what’s about to break. When the system isn’t able to automatically fix itself, we want a human to investigate the alert, determine if there’s a real problem at hand, mitigate the problem, and determine the root cause of the problem. Unless you’re performing security auditing on very narrowly scoped components of a system, you should never trigger an alert simply because “something seems a bit weird.” When you are reviewing existing alerts or writing new alerting rules, consider these things to keep your alerts relevant and your on-call rotation happier:

Alerts that trigger call-out should be urgent, important, actionable, and real.
They should represent either ongoing or imminent problems with your service.
Err on the side of removing noisy alerts – over-monitoring is a harder problem to solve than under-monitoring.
You should almost always be able to classify the problem into one of: availability & basic functionality; latency; correctness (completeness, freshness and durability of data); and feature-specific problems.
Symptoms are a better way to capture more problems more comprehensively and robustly with less effort.
Include cause-based information in symptom-based pages or on dashboards, but avoid alerting directly on causes.
The further up your serving stack you go, the more distinct problems you catch in a single rule. But don't go so far you can't sufficiently distinguish what's going on.
If you want a quiet oncall rotation, it's imperative to have a system for dealing with things that need timely response, but are not imminently critical.

## Monitor for your users

I call this “symptom-based monitoring,” in contrast to "cause-based monitoring". Do your users care if your MySQL servers are down? No, they care if their queries are failing. Do your users care if a support (i.e. non-serving-path) binary is in a restart-loop? No, they care if their features are failing. Do they care if your data push is failing? No, they care about whether their results are fresh.

Users, in general, care about a small number of things:

Basic availability and correctness. no "Oops!", no 500s, no hung requests or half-loaded pages or missing Javascript or CSS or images or videos. - Anything that breaks the core service in some way should be considered unavailability.
Latency. Fast. Fast. Fast. Also, fast.
Completeness/freshness/durability. Your users data should be safe, should come back when you ask, and search indices should be up-to-date.
Even if it is temporarily unavailable, users should have complete faith that it's coming back.
Features. Your users care that all the features of the service work—you should be monitoring for anything that is an important aspect of your service even if it's not core functionality/availability.
That's pretty much it. There's a subtle but important difference between database servers being unavailable and user data being unavailable. The former is a proximate cause, the latter is a symptom. You can't always cleanly distinguish these things, particularly when you don't have a way to mimic the client's perspective (e.g. a blackbox probe or monitoring their perspective directly). But when you can, you should.

## Cause-based alerts are bad (but sometimes necessary)

“But,” you might say, "I know database servers that are unreachable results in user data unavailability." That's fine. Alert on the data unavailability. Alert on the symptom: the 500, the Oops!, the whitebox metric that indicates that not all servers were reached from the database's client. Why?

You're going to have to catch the symptom anyway. Maybe it can happen because of network disconnection, or CPU contention, or myriad other problems you haven't thought of yet. So you have to catch the symptom.
Once you catch the symptom and the cause, you have redundant alerts; these need separate tuning, and result in either duplication or complicated dependency trees
The allegedly inevitable result is not always inevitable: maybe your database servers are unavailable because you're turning up a new instance or turning down an old one. Or maybe a feature was added to do fast-failover of requests, and so you don't care anymore about a single server's availability. Sure, you can catch all these cases with increasingly complicated rules, but why bother? The failure mode is more bogus pages, more confusion, and more tuning, with no gain, and less time spent on fixing the alerts that matter.
But sometimes they're necessary. There's (often) no symptoms to “almost” running out of quota or memory or disk I/O, etc., so you want rules to know you're walking towards a cliff. Use these sparingly; don't write cause-based rules that trigger on call alerts for symptoms you can catch otherwise.

## Tickets, Reports and Email

One way or another, you have some alerts that need attention soon, but not right now. You can refer to these as “sub-critical alerts”.

Bug or ticket-tracking systems can be useful. Having alerts open a bug can work out great, as long as multiple firings of the same alert get correctly threaded into a single ticket/bug. This system fails if there's no accountability for triaging and closing bugs; if the alert-opened bugs might go unseen for weeks, this clearly fails as a way of dealing with sub-critical alerts before they become critical! It also fails if your team is simply overloaded or is not assigning enough people to deal with followup; you need to be honest about how much time this is consuming, or you'll fall further and further behind.
A daily (or more frequent) report can work too. One way this can work is to write sub-critical rules that are long-lived (e.g. “the database is over 90% full” or "we've served over 1000 very slow requests in the last day"), and send out a report periodically that shows all currently-firing rules. Again, without a system of accountability this amounts to less-spammy email alerts, so make sure the oncall person (or someone else) is designated to triage these every day (or every shift hand-off, or whatever works).
Every alert should be tracked through a workflow system. Don't only dump them into an email list or IRC channel. In general, this quickly turns into specialized “foo-alerts” mailing lists or channels so that they can be summarily ignored. Except as a brief (usually days, at most weeks) period to vet that a new rule will not page too often, it's almost always a bad idea. It's also easy to ignore the volume of these alerts, and suddenly some old, mis-tuned rule is firing every minute for all of your thousand application servers, clogging up mailboxes. Oops.
The underlying point is to create a system that still has accountability for responsiveness, but doesn't have the high cost of waking someone up, interrupting their dinner, or preventing snuggling with a significant other.

## Playbooks

playbooks (or runbooks) are an important part of an alerting system; it's best to have an entry for each alert or family of alerts that catch a symptom, which can further explain what the alert means and how it might be addressed.

In general, if your playbook has a long detailed flow chart, you're potentially spending too much time documenting what could be wrong and too little time fixing it—unless the root causes are completely out of your control or fundamentally require human intervention (like calling a vendor). The best playbooks I've seen have a few notes about exactly what the alert means, and what's currently interesting about an alert (“We've had a spate of power outages from our widgets from VendorX; if you find this, please add it to Bug 12345 where we're tracking things for patterns”.) Most such notes should be ephemeral, so a wiki or similar is a great tool.

## Tracking & Accountability

Track your on-call alerts, and all your other alerts. If an on-call is firing and people just say “I looked, nothing was wrong”, that's a pretty strong sign that you need to remove the rule, or demote it or collect data in some other way. Alerts that are less than 50% accurate are broken; even those that are false positives 10% of the time merit more consideration.

Having a system in place (e.g. a weekly review of all triggered on-call alerts, and quarterly statistics) can help keep a handle on the big picture of what's going on, and tease out patterns that are lost when the pager is handed from one human to the next.

## When to seek the exception from the rule?

Here are some great reasons to break the above guidelines:

You have a known cause that actually sits below the noise in your symptoms. For example, if your service has 99.99% availability, but you have a common event that causes 0.001% of requests to fail, you can't alert on it as a symptom (because it's in the noise) but you can catch the causing event. It might be worth trying to trickle this information up the stack, but maybe it really is simplest just to alert on the cause.
You can't monitor at the spout, because you lose data resolution. For example, maybe you tolerate some handlers/endpoints/backends/URLs being pretty slow (like a credit card validation compared to browsing items for sale) or low-availability (like a background refresh of an inbox). At your load balancers, this distinction may be lost. Walk down the stack and alert from the highest place where you have the distinction.
Your symptoms don't appear until it's too late, like you've run out of quota. Of course, you need to page before it's too late, and sometimes that means finding a cause to page on (e.g. usage > 80% and will run out in < 4h at the growth rate of the last 1h). But if you can do that, you should also be able to find a similar cause that's less urgent (e.g. quota > 90% and will run out in < 4d at the growth rate of the last 1d) that will catch most cases, and deal with that as a ticket or email alert or daily problem report, rather than the last-ditch escalation that a page represents.
Your alert setup sound more complex than the problems they're trying to detect. Sometimes they will be. The goal should be to tend towards simplicity, robust, self-protecting systems (how did you not notice that you were running out of quota? Why can't that data go somewhere else?) In the long term, they should trend towards simplicity, but at any given time the local optimum may be relatively complex rules to keep things quiet and accurate.
