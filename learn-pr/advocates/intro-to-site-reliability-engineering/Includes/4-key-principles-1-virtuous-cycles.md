If it really is true that in some sense “you are what you do”, then we’ve come to the heart of this module. In this unit, we're going to look at two of the practices that are often considered core to the practice of SRE. Both originate from the principle that it's important to create “virtuous cycles." Virtuous cycles in this context are practices that build feedback loops in an organization that help that organization continuously get better. We have entire follow-on modules on exactly these two practices so we’re only going to skim the surface with an overview of each here.

### Virtuous cycle #1: SLIs and SLOs

Earlier in this module, we emphasized our point about working towards the “appropriate level of reliability”. This section is precisely the place where that concept gets brought to bear.

Let’s say you have a new service you're planning to bring to production (either one that has been constructed or one that is still in the planning process). As part of that process, it's important to make some decisions about its desired reliability. If you aren't writing all of the code yourself, these decisions are made (and this point is crucial) in collaboration with the service’s owners — typically the developers building the service, the product owner, and any business stakeholders who care about the service’s reliability.

The first decision to make is, what should we use as indicators of the service’s health (a Service Level Indicator or SLI)? Another way to ask this question is “How do you know when it's up and working well?”. There are lots of ways to track SLI and we explore some in detail later. But, these indicators are typically:

- **Success vs. failure measures:** Does the service successfully complete an operation some percentage of the time?
- **Measures of timing:** Did we return an answer within a certain threshold of time?
- **Measures of throughput:** Did we process a certain amount of data?

Or, some combination of all of these measures.

For a simple example, we might say an SLI for our service is how often it returned success, indicated via an HTTP 200 code (vs. a 500 or some other code).

Now that we have a clear indicator that tells us how the service is doing, we want to decide what level of reliability we expect or desire from it. For example, do we expect over a period of a day to see a failure rate of 20% from the service? We're using round and large numbers here because they're easy to reason about in the beginning. In later modules, we increase the complexity and precision of statements like this (“which users see that error rate? some of them? most of them?” and so on). That expectation, created in collaboration with the service’s owners and stakeholders, is a Service Level Objective (SLO).

The SLO needs to be something that can be accurately measured and represented in your monitoring system. It’s meant to be an objective, well understood goal for the reliability for the service. What is the number that is good enough? There's no “well, I think the service has been doing ok for the last week or so, but it's kind of hard to tell” going on here. Either the service is meeting its SLO or it isn’t. The data should be clear. If it isn't meeting its SLO (especially repeatedly over a span of time), then something is wrong and needs to be addressed.

### Error budgets

We can understand that an organization might snap into action if a service doesn’t meet its SLO. However, SRE takes this whole concept another step forward for the cases where the SLO is being met or exceeded. Some organizations use SLOs to construct what they call “error budgets”.

To demonstrate this idea, let’s use the sample service we’ve been discussing and its SLO of 80% success (think of it as “must be up 80% of the time”). With the SLO of 80% uptime, we’ve declared that our service must be up 80% of the time. But what about the other 20%? If our service is down for that other 20%, the organization treats that downtime as an accepted cost of moving quickly — it’s within the agreed reliability allowance, so it doesn’t trigger a process response.

If that unreliability is within the agreed allowance and the error-budget policy permits it, what can we consider doing with the service? One option is to perturb the running service by upgrading it, perhaps with a new release that adds some features. If that new release stays up and doesn’t add any downtime, great. If the service has used 0% of its 20% budget so far and the new release causes errors for 10% of the period while it’s debugged, the service still meets the 80% SLO because total unreliability remains within the 20% budget. If it would push total unreliability past 20%, the budget would be exhausted and the policy should guide the response.

An error budget is the difference between the service’s potential perfect reliability and its desired reliability (100% − 80% = 20%). In this case, the error budget gives us an allowance of 20% unreliability — time during which the service can be down or degraded while still meeting its SLO. We can draw on and spend that allowance any way we’d like (perhaps with more releases) until it’s exhausted, just like any other budget.

Error budgets are also used in some organizations for the less happy case, the one where you aren’t making your SLO. In that case, you might choose to do something a little more stringent than just “take an action”. Let’s say our service has been having some issues and has been up just 60% of the time as indicated by the SLI we chose earlier. We didn’t make our objective (the SLO). Our service has used up its error budget. The organization may choose to hold back on a planned release because it knows that perturbing the system even further at this point is likely to only worsen the reliability situation. Usually, error budgets are calculated for a defined time window, such as a month, a quarter, or an integral number of weeks. That window can be rolling or calendar-aligned. Over time, if service reliability improves and errors fall out of the window, the budget can recover.

During this time of gated releases, the organization might choose to pivot some engineering resources away from feature development towards reliability work. With a goal to help uncover and improve the source of the problems that caused the service to blow its SLO.

The reason why we say “some organizations” when it comes to error budgets is their implementation, especially in the case where it's used to gate releases, requires a certain institutional buy-in. When faced with a release decision, the organization has to be willing to hold back the release if the reliability of the service to date hasn’t been up to snuff. That decision isn't one that all organizations are willing to make. This decision is also not the only possible response to a depleted error budget, but it's the one most talked about.

In a separate module, we talk in considerably more detail about SLIs, SLOs, and error budgets. However, it's worthwhile here to highlight the virtuous cycle aspect of these practices. In theory, it provides a way for an organization to describe, communicate, and act on the reliability of a service. While doing it in a way that gets everyone working towards better reliability. This feedback loop can be incredibly important.

## Virtuous cycle #2: blameless postmortems

The idea of a postmortem—the retrospective analysis of a significant, typically undesired event—isn't even remotely specific to site reliability engineering. It isn't even uncommon to the operations world. One thing that is closer to being distinctive is SRE’s insistence that postmortems need to be “blameless.” They need to focus on the failure of the process or the technology during the incident, not the actions of specific people. “What was it about the process we had in place that allowed X to do the thing that led to the failure? What information did that person not have available, or even prominent at the moment that led to them coming to the wrong conclusion? What guardrails should have been in place so that it wasn’t possible to have such a catastrophic failure?” These questions are the sort asked in a blameless postmortem.

The tenor and direction of these questions is crucial. We're searching for ways to improve the systems or processes, not ways to punish the individuals whose use of those systems or processes in good faith contributed to the outage. It's important to remember, “You can’t fire your way to reliability”. In our experience, an organization that fires a person every time there's a production incident (with few exceptions), doesn't learn from those incidents. Instead, they're left with a single individual, shaking in the corner, afraid to make any changes to anything at all.

But a well functioning post-mortem process in an organization creates a virtuous cycle. It lets the organization learn from its outages and continuously improve its systems (providing proper analysis and follow-up is done).

This relationship to failures and errors embraced by the organization as opportunities for learning and improvement is a core principle of site reliability engineering. The construction of virtuous cycles to make use of these opportunities and to guide the organization towards greater reliability is another.

Let’s explore some other principles and practices, centered on the human side of SRE, in our next unit.
