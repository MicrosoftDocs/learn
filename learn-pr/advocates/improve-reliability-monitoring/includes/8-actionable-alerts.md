In this module so far, we've explored ways to think about, measure, and interact with our systems' reliability. But there's also a way that reliability interacts with _us_: alerts. It's easy to set up Azure Monitor and other tools to send you alerts based on various metrics and signals, including the SLIs and SLOs we've seen before. Azure can also send alerts based on service issues through the [Azure Service Health](https://azure.microsoft.com/features/service-health/) feature.

With the power of easily sending out alerts comes a potential peril. And that's where the word _sustainably_ comes into the picture in the SRE definition we've seen before:

*Site Reliability Engineering is an engineering discipline devoted to helping organizations sustainably achieve the appropriate level of reliability in their systems, services, and products.*

Alerts are designed to notify you when there's a problem with your systems. However, when alerts are improperly configured, it can undermine your goal of creating a sustainable operations practice. It's possible to derail all the effort you've put into bringing SLIs and SLOs into your organization if it translates into a hailstorm of alerts for your personnel. _Alert fatigue_ is a well know ailment in the operations community. This unit aims to help you prevent it from occurring in your organization.

A key contributor to alert fatigue is alerts that aren't actionable. Let's learn how to avoid creating them.

## What alerts are (and aren’t)

To understand why bad alerting can create a problem, you need to think about the purpose of alerts and how they differ from other operational signals.

Actionable alerts are _not_:

- **Logs**: Alerts aren't records of events; that’s a job for logs. If you're just trying to record that an event happened, write it to a log file, not a pager.

- **Notifications**: Alerts aren't intended to announce non-critical occurrences, such as the completion of a software build. You shouldn't have to interrupt someone, breaking their concentration and focus, just to deliver a piece of news.

- **Heartbeats**: Alerts shouldn’t be used as a reminder that your system is still running. We have seen situations where people say "Oh, if I don't get at least one page from that system every hour, I know something is wrong and I have to go deal with it." This is a terrible idea.

Actionable alerts are used for situations in which you need a human to investigate and intervene to remediate the problem. Alerts should be communications that something exceptional or unexpected has happened requiring someone’s attention.

If the event is something that the system can handle through automated processes, such as scaling resources within a preset limit, an alert isn't necessary. The system should just handle it and write a line to a log. It shouldn't page you at 2 AM to tell you that there was a situation it successfully handled.

## Create actionable alerts

In order for an alert to be actionable, it has to have:

- **Simplicity**: You don't want to make an alert that requires the recipient to have to puzzle over it before they know what to do. If the alert is too complex, the poor person who has just been woken up in the middle of the night is going to lose valuable time just trying to figure out what it means.

- **Scope**: One of the first things a person receiving the message will have to do in order to be able to triage it effectively is determine the problem's scope. Is the issue with a single server? One service? A whole region? Worldwide? To make it easier for the recipient, put this information in the alert.

- **Context**: What does the person who's going to receive that alert need to know to get started dealing with it? Let's dive further into this part.

### Provide context in the alert

Let’s look at some elements that an actionable alert should always include so the recipients have the context they need:

- **Where's the alert coming from?** Many organizations have multiple monitoring systems in use at any one time and a large number of interconnected systems. It can save someone a tremendous amount of time if the alert says "This alert for payroll system THX-1138 is coming from the 'prod' Azure Monitor subscription."

- **What expectation was violated?** An alert that just describes the current state of affairs is not nearly as helpful as it could be. Compare "the database server is running at 80% load" to "the database server has been running at 80% load for the last two hours when it should be running at 60% load or lower."

- **Why is this an issue (for the customer)?** Information about the effect or impact the situation has had or potentially will have on the customer gives us a way to determine importance and to appropriately gauge our reaction.

- **What are the next steps to take?** If possible, the alert should include what the person responding should do next, even if that's a pointer to a troubleshooting guide or some other documentation to find help in diagnosing and remediating this problem.

Including such helpful context and working to make your alerts actionable can make operations practices more sustainable and make responding to those alerts easier.
