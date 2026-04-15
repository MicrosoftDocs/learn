In this module thus far, we've learned how to increase our operational awareness, expand our understanding and framing of reliability, and have seen the Azure Monitor tools we'll need for our work. Now, it's time to explore one of the most important ideas in this module and the processes to implement it.

Let's answer the question, "how do I use all of this stuff to improve the reliability in my organization?"

## Enter the feedback loop

Here's the big idea that can unlock the problem for us:

*The right feedback loops improve reliability in your organization.*

Improving reliability in your organization is an iterative process. In this unit, we're going to look at a highly effective practice from the site reliability engineering world to create and nurture the kind of feedback loop in an organization that helps it improve reliability. At the very least, it'll spark concrete conversations in your organization about reliability based on objective data.

Earlier in this module, we mentioned this as a definition for site reliability engineering:

*Site Reliability Engineering is an engineering discipline devoted to helping organizations sustainably achieve the appropriate level of reliability in their systems, services, and products.*

Here's where the concept of _appropriate level of reliability_ comes into play.

## Service Level Indicators (SLIs)

Service Level Indicators (SLIs) are connected to our previous discussion about the expansive understanding of reliability. Remember this diagram?

:::image type="content" source="../media/diagram-whole.png" alt-text="Diagram with the word reliability in a circle in the middle connected to circles at the end of each spoke. Each circle contains a word relating to reliability from a previous unit.":::

SLIs are our attempt to specify just how we're going to measure our system's reliability. What's the indicator that our service is behaving reliably (doing what we expect)? What can we measure to answer this?

### Example: web server availability and latency

Let’s say we're working with a web server and its availability. We might be interested in the number of HTTP requests it received and the number of HTTP requests it successfully responded to. More precisely, we want to understand how successful it's been at being a web server by understanding the ratio of successful requests to total requests.

If we divide the number of successful requests by the total number of requests, we get a ratio. We can multiply this ratio by 100 to get a percentage. For an example using round numbers, if our web server received 100 requests and responded successfully to 80 of them, we'd calculate 80/100 = 0.8. Multiply that by 100, and we can state that it has been 80% available.

Let’s try another one. This time, let’s specify a measurement associated with our web service's latency. We might be interested in knowing the ratio of number of operations that completed in less than 10 milliseconds against the number of total operations. If we do the same math—80 requests that returned faster than our threshold divided by 100 total requests—we again calculate 0.8. Multiply by 100, and here too we can say we've been 80% successful around our latency requirements by this measurement.

Just to be clear: this isn't just a website thing. If we had a pipeline service that processed data, we could say we need to measure coverage (for example, how much of the data we processed). Very different system, but the same basic math.

### SLIs: where to measure

For SLIs to be useful in concrete discussions using objective data, there's one other piece we need to specify beyond just what we're measuring. When creating an SLI, we need to note not only what we measured, but also *where* the measurement was taken.

For example, when we specified what we were measuring the availability of the web server mentioned before, we didn't say where we retrieved the success and total HTTP request numbers from. If you try to have a conversation about the reliability of this web server with some colleagues, and you look at the request statistics gathered at a load balancer in front of the server but they look at the statistics from the server itself, this conversation may not go so well. The numbers might be radically different, because the load balancer might see all of the requests coming into the network, but if there's a problem with the network or the load balancer itself, not all of the requests might reach the server. We'd be drawing conclusions based on two different datasets.

The simple way to address this is to be specific about data source in the SLI. For the web server, we'd say "the ratio of successful to
total requests *as measured at the load balancer*" for availability. For the latency, we'd say something like "the ratio of number of operations that
completed in less than 10 milliseconds to total operations *as measured at the client*."

This leads to the logical question: where's the best place to measure SLIs? Unfortunately, there isn't a universally "correct" answer. It’s a decision you must make with an understanding that there are tradeoffs either way. One piece of guidance we can offer harkens back to our previous discussion on reliability: try to measure things in a place that most accurately reflects your customer's experience.

## Service Level Objectives (SLOs)

Deciding what to measure (and where) is a great start, but it only gets us halfway towards our goal. Let's say we retrieve the metrics we need for our web server's availability SLI, and we find that it's indeed 80% available.

Is that a good or a bad thing? Is that the "appropriate level of reliability?"

To answer these questions, we're going to need to set an objective for that SLI: a Service Level Objective (SLO). This objective will clearly state our goal for that service.

The basic recipe for creating an SLO consists of these ingredients:

- **The “thing” you’re going to measure**: Number of requests, storage checks, operations; *what* you’re measuring.

- **The desired proportion**: For example, "successful 50% of the time," "can read 99.9% of the time," "return in 10ms 90% of the time."

- **The time horizon**: What's the time period we're going to consider for the objective: the last 10 minutes, during the last quarter, over a rolling 30-day window? SLOs are more often than not specified using a rolling window versus a calendar unit like "a month" to allow us to compare data from different periods.

Putting these components together and including the important *where* information, a sample SLO might look like this:

*90% of HTTP requests as reported by the load balancer succeeded in the last 30-day window.*

Similarly, a basic SLO measuring latency might look like this:

*90% of HTTP requests as reported by the client returned in <20ms in the last 30-day window.*

> [!NOTE]
> We're using round numbers like 80% and 90% here to keep the math simple and the concepts clear. In practice, production web services typically target much higher availability (for example, 99% or 99.9%). When you create SLOs for your own services, work with your stakeholders to determine what's truly appropriate.

Start with simple, basic SLOs such as these when you introduce the practice into your organization. You can create more complex SLOs later if needed.

## SLIs and SLOs on Azure Monitor

As a final piece to this unit, let's see how we can represent a simple SLI/SLO in Azure Monitor using Log Analytics. To keep things consistent, we'll return to the web-server example. In a workspace-based Application Insights resource, request telemetry lives in the `AppRequests` table.

> [!NOTE]
> This example uses application-side telemetry from Application Insights, so it reflects app-observed availability rather than client- or load-balancer-observed availability. In your own SLI work, choose the measurement point that most closely reflects your customer's experience, as we discussed earlier. If you want an Azure-native measurement point closer to the user's perspective, standard Application Insights availability tests store synthetic results in the `AppAvailabilityResults` table.

A similar SLI built from `AppAvailabilityResults` is often a better fit when you want to measure whether users can reach the service from outside the app itself.

We learned in the last unit that we can create queries in Log Analytics using the Kusto Query Language (KQL). Here's a KQL query that displays an availability SLI for a web service:

```kusto
AppRequests
| where TimeGenerated > ago(30d)
| summarize Succeed = sumif(ItemCount, Success == true), Total = sum(ItemCount) by bin(TimeGenerated, 5m)
| extend SLI = todouble(Succeed) * 100.00 / Total
| project TimeGenerated, SLI
| render timechart
```

As before, we start by specifying the source of the data: the `AppRequests` table. We then narrow down the data with which we'll be working to just the last 30 days worth of information. We then collect (in five-minute buckets) the number of successful requests and the total number of requests. We use `sumif()` and `sum()` with `ItemCount` rather than `countif()` and `count()` because Application Insights can use sampling to reduce telemetry volume. Each sampled record's `ItemCount` field tells you how many actual requests that record represents, so summing `ItemCount` gives an accurate total even when sampling is active. The SLI is created using the easy arithmetic we saw before. We tell KQL we'd like to plot that SLI along with timestamps and then create a chart that looks something like this:

:::image type="content" source="../media/sli-example.png" alt-text="Graph showing an SLI; the graph shows SLI at 100% reliability followed by several dips":::

> [!IMPORTANT]
> This first chart plots only the SLI in five-minute buckets. It's a **trend view** that shows how the SLI varies over time, which is useful for spotting patterns and dips. In the next example, we'll add a target line for the SLO. Neither chart is the same as evaluating overall SLO compliance across the full 30-day window. To check whether you're meeting a 30-day SLO, you'd compute a single aggregate SLI across the entire window and compare it to your objective.

Now, let's layer on a simple representation of an SLO target line:

```kusto
AppRequests
| where TimeGenerated > ago(30d)
| summarize Succeed = sumif(ItemCount, Success == true), Total = sum(ItemCount) by bin(TimeGenerated, 5m)
| extend SLI = todouble(Succeed) * 100.00 / Total
| extend SLO = 80.0
| project TimeGenerated, SLI, SLO
| render timechart
```

There are two new lines in this example compared to the previous one. The first (`extend SLO = 80.0`) defines the number we'll use for the SLO target; the second adds `SLO` to the `project` statement so it's included in the chart. The result looks like this:

:::image type="content" source="../media/slo-example.png" alt-text="Graph showing an SLI and an SLO; graph shows SLI at 100% reliability, followed by several dips. The SLO is a solid line at the 80% mark.":::

In this chart, it's easy to see the time periods where our SLI dipped below our availability target.

## Using SLIs/SLOs

Invariably, there's some tuning that will have to take place with your SLIs and SLOs (this is an iterative process, after all). But once that's done, what do you do with the information?

The good news is you'll probably notice just constructing the SLIs and SLOs will have positive effects on the organization. It requires discussions with stakeholders and other communication that sets things in a good direction. The next round of discussions on what to do with them can also be similarly helpful.

Ultimately, SLIs and SLOs are work-planning tools. They can help you make engineering decisions like "should we work on new features for the service or should we focus on reliability work instead?" They can help with the sort of feedback loops we discussed before.

A secondary but fairly common use for SLIs and SLOs is as part of a more immediate monitoring/response system. In addition to the work-planning aspect (which you should focus on first), many people use them as an operations signal. For example, they might choose to alert their personnel if the service drops below its SLO for a prolonged period of time.

The gap between your SLO and 100% is your **error budget** — the amount of unreliability your service can tolerate within the SLO window. For example, if your SLO is 99.9% availability over 30 days, your error budget allows roughly 43 minutes of downtime in that window. When the budget is being consumed faster than expected, it's a signal that the team should prioritize reliability work over new features. In practice, more advanced approaches like **burn-rate alerting** (which tracks how quickly you're consuming your error budget) tend to give earlier and more actionable signals than simple threshold alerts, but a basic "below the SLO" alert is a reasonable starting point. That sort of alert leads us to our next unit in this module.
