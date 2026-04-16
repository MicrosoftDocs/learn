Building on the principles and practices of monitoring discussed in another module from this learning path, you’ll now learn what to do when your monitoring reveals a problem. If you receive an actionable alert notifying you that your systems aren’t operating as expected, that’s the trigger for
a response to deal with the issue.

## What is an incident?

Incident response is about the actions you take when an incident occurs, but what exactly constitutes an incident? The answer can be subjective; even all engineers don’t agree on what an incident is. If you ask the question across different industries and organizations, you get many
different answers.

Some will label all disruptions as incidents, whether or not customers are impacted. In the context of this module, we can agree that an incident is defined as a service disruption: an occurrence or condition that affects the user’s ability to use the services on which they rely. Examples include
when systems are down or are malfunctioning in a way that impacts customers.

## What is incident response?

Preventing all problems is a laudable, but impossible goal. Things _go wrong, so we need a plan to limit the impact on our end users and return operations to normal as quickly as possible.

The key is to _respond with urgency_ rather than react. A reaction tends to be more impulsive and based in the present moment, without consideration of long-term effects. A response is well thought out, organized, and information based.

Your incident response approach determines your effectiveness at:

- Understanding what’s going on (diagnosing the problem).
- Triaging (determining the urgency) and prioritizing the problem.
- Engaging the right resources to mitigate the issue(s).
- Communicating with stakeholders about the problem.

After you've remediated the problem, you can then learn from the incident through a post-incident review process. That's an important subject, which has a whole separate module worth of discussion.

## Measuring incident response performance

You might be familiar with the acronym _TTR_, which is variously defined as "time to recover," "time to remediate," or "time to restore." All of these variants refer to the same idea: how long it takes to bring a service back to a state where it again meets customers' expectations.

Different frameworks use different names for this concept. DORA's current guidance refers to **failed deployment recovery time**, one of its five software delivery performance metrics. It measures how quickly a team can recover from a failed deployment that causes a production issue, making it one of the strongest indicators of incident response capability.

This metric is one way of measuring how well teams are performing when responding to incidents. The quicker you restore service, the less impact the outage, or degraded service has on your users.

It's important to know how well your organization is handling incident response. DORA's research continues to show a strong relationship between recovery performance and overall software delivery performance. Rather than treating benchmark bands as fixed targets, use recovery time to compare services over time, identify bottlenecks in your response process, and measure whether your improvements are working.

Teams with strong incident response practices recovers faster than low-performing peers and tend to pair that speed with stronger delivery performance overall. Good monitoring, clear ownership, practiced response plans, and automation all help reduce recovery time.

Why do teams with strong incident response practices recover so much more quickly than the rest? It’s at least partially because they understand the importance of having a good foundational response plan already in place when things inevitably go wrong.

As you go through this module, you learn about the characteristics and lifecycle of an incident and how to use that knowledge to create your own foundational plan.
