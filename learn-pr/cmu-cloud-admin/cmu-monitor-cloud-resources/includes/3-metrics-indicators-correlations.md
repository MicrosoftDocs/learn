Quality of Service (QoS) isn't a mythical quest. An information system such as a cloud-based IT solution cannot reach an optimum service level just by being "the best it can be." In the best-organized and best-managed data centers, optimum service levels are solutions to a formula. That formula may not necessarily be mathematical, but it may well end up being expressed that way. The variables of that formula are quantifiable attributes of the system that are obtained through automated observation.

Monitoring is automated observation. Until each facet of every stage of service delivery can be monitored, any optimum service level is a wild guess.

## Observable Telemetry

If you're a zoologist and you're observing a living organism, you look for the phenomena that consistently define its behavior. In an information system, the only way to express behavior is digitally, through data.

Recently, software developers have taken to extending the use of the term *telemetry* to encompass the production of data for monitoring tools and platforms. A spacecraft reports telemetry on its operating condition and relative location at regular intervals; when there's no telemetry, ground controllers begin procedures for mitigating catastrophic failure, even before they confirm whether it has happened. Servers aren't built like spacecraft. They don't have their own instrumentation for reporting their operating conditions, even at a basic level. In order for there to be any telemetry at all, software platforms and tools must provide the missing instrumentation.

The dashboard is the tool APM platforms use most often to convey the messages behind telemetry in a graphical format. APM platform vendors make the case that the real "consumer" of a dashboard (the person most likely to ask to see it) is a business manager. For that reason, they tend to demonstrate examples with simple, eye-catching components like world maps and multi-color bar charts as shown in Figure 7.

![Figure 7: A basic dashboard produced by Cisco AppDynamics. \[Courtesy Cisco\]](../media/fig7-7.png)

_Figure 7: A basic dashboard produced by Cisco AppDynamics. \[Courtesy Cisco\]_

In practice, however, dashboards consumed by IT administrators tend to look more like Figure 7.8: a network flow map showing the resources that make up a solution, the interdependencies between them, and the relative health of each resource.

![Figure 8: A network flow map produced by AppDynamics. \[Courtesy Cisco\]](../media/fig7-8.png)

_Figure 8: A network flow map produced by AppDynamics. \[Courtesy Cisco\]_

Usually the goal of dashboarding is to combine easily digested reports of several metrics together into a single screen or single page, with no more detail than the typical morning TV show weather report. Although it may not convey any level of sophisticated behavioral analysis, APM vendors say one goal of dashboard design is to make otherwise uninterested parties interested in the factors behind optimum performance.

## Common APM Performance Metrics

The easiest metrics for a dashboard graph to convey to interested parties in a few seconds' time, are singular, non-derivative, quantifiable measurements:

- **Requests per minute** - The volume of incoming requests or queries to a service over a given interval (often one second).

- **Response times** - Often expressed as medians, response times are the recorded time intervals between the delivery of requests to the server, and the receipt of responses from the server. Some platforms can graph the distribution of response times over a range of intervals. A more technical approach to this metric is *time-to-first-byte* (TTFB), which measures the interval between the exact moment the client dispatched a request to the server, and the moment the first byte of the server's response was received.

- **Idle connections** - The total number of network connections in which the server is awaiting requests from any client.

- **Service availability** - The percentage of a given interval when a service or application appeared to be responsive to requests.

- **CPU utilization** - Usually expressed as a percentage, this rate is a ratio comparing how much of a given interval of time the processor (or an aggregate of all the cores in a multi-core processor) is active.

- **Error rate** may mean different things to various platforms. In software development, an error is a condition or behavior that isn't true to the intent of the instructions, and for which there isn't a plan. Exception handling is a common tool developers use to "trap" behavior conditions and remediate them before unintended behavior can happen. However, some APM platforms track exception conditions (which are traceable events) and report their frequency over a given period as error rates, compounded with actual errors.

- **Garbage collector (GC) invocation** - This metric is especially important for a language interpreter such as Java, whose code uses data objects in memory, but then relies upon a "garbage collector" to free that memory when those objects are released.

## Complex Indicators

Many of the metrics tracked by APM platforms are actually the results of formulas for the relationships between more directly measurable conditions such as response times and error rates. Examples include Request Saturation Point and Application Performance Index.

### Request Saturation Point

Utilization and saturation are too often confused with one another. In all forms of engineering, including software, they are distinct. An underutilized resource is one that can be clearly measured as performing no work for too long a period. That same resource may become over-saturated as a direct result; the backlog of requests may stack up in its queue.

Measuring utilization is relatively simple; measuring saturation has been a matter of some contention. One method recommended by software engineers involves a metric called the *request saturation point*. This is a nuanced concept, which requires a full explanation to be appreciated.

When a server implements a REST API, it receives requests from clients using the HTTP or HTTPS protocol. A server or server cluster may respond to a variable number of requests within a given interval of time, such as one second. "Responsive" means the server will render informative responses to requesting clients during that time, as opposed to unintended responses, error messages, or silence. Some monitoring platforms refer to the quantity of requests handled by an application running on a server or cluster, as the *app load*. (On occasion, the entire request count on a server may still be called the "app load," even when a server is running more than one application.)

As app load increases, at some point the servers will begin to slow down. A slowdown might be acceptable and even necessary if the total load on these servers is high. But there could be a point at which server responses become so slow that client-side timeouts are triggered. An admin may think of this as the saturation point - a level beyond which wait times become unacceptable for clients. It may be possible for the admin to determine this saturation point after several observations of behavior patterns with negative outcomes. The correlation here in each case will be between the rate at which requests are received, as well as their rate of fulfillment.

### Application Performance Index (Apdex)

A typical Web transaction consists of a request followed by a response. The end-to-end response time makes up the interval between the moment the client-side browser sends the request to the server and the moment it receives the server's response.<sup>1</sup>

The best performing systems, services, and applications in a data center are ones that make optimum use of only those resources they need and no more, to produce the most reliable and accurate results achievable in a minimum of time. That sounds like an objective formula for a goal that can be obtained using quantitative measurements through something approaching a scientific method.

But there are some, including vendors in the APM market, who argue overall performance is a subjective, qualitative observation - that it is a phenomenon on its own. Entire conferences devoted to the subject of performance management have been headlined and keynoted by engineers and product managers arguing performance is something a user *feels*, and an application is infused with performance the way an athlete is infused with adrenaline. It's unusual for a company in the business of producing objective measurement tools to hypothesize that performance is a matter of opinion.

In 2007, a coalition of vendors in the then-burgeoning APM industry happened upon a formula, which they believed correlated user response times for an application with user satisfaction. Their Application Performance Index (Apdex)<sup>[2][^2]</sup> is a ratio incorporated into the metrics of several APMs, including New Relic and Dynatrace. It's based on the notion that every application is operated through a sequence of actions, which Apdex calls "tasks." A responsive application will have a target response time for each task in this sequence. For every task that has a response time at or below the target, we assume the user is satisfied. Meanwhile, if a response time falls between the target time and a higher time representing tolerance limits, we assume the user is tolerating the application. Any response time higher than the tolerance limit should be presumed intolerable by the user.

This index gives us three toleration zones on a scale between 0 and 100: "Satisfied," "Tolerating," and "Frustrated." The Apdex score for any given number of sample runs of one application is computed as the sum of the number of scores in the Satisfied zone and half the number of scores in the Tolerating zone, divided by the total number of samples. Many APM dashboards enable an operator to produce graphs of Apdex scores from specific transactions within an application. Some platforms generate alerts when the Apdex value for an application falls below a set threshold, or *T value*. New Relic, for instance, establishes a default T value of 0.5 second, and sets a multiplier for the upper threshold of the Tolerating zone to four times the T value. Also by default, New Relic will refrain from generating alerts and traces about an application's response time until it transcends this upper threshold into the Frustrated zone.

Some APM platforms, including AppDynamics, shun the use of Apdex. Their engineers and other proponents claim the formula is largely based on arbitrarily set target time values. Users' expectations for responsiveness, or the appearance of speed, they argue, are tied to bandwidth levels that may vary, especially for a mobile application moving away from a metropolitan area and into rural territory.

## Correlations

In practice, IT administrators and software engineers know many of the most reliable measures of a system's health are *correlations* - comparisons of two or more sets of metrics to each other. For example, an admin can monitor the number of incoming traffic requests to a service, and over a period of time develop a sense of which quantity would indicate a normal traffic pattern. But when this quantity rises or spikes for indeterminate reasons, it wouldn't be considered abnormal unless it's correlated to another metric that indicates service degradation.

### The USE Method

Brendan Gregg, a software engineer at Oracle Corp. and formerly with Sun Microsystems, coined the acronym USE (Utilization, Saturation, Errors) to symbolize the most common correlation applied to evaluating the status of a solution.<sup>[3][^3]</sup> Gregg says he was inspired by the emergency checklists pilots follow when making an emergency landing. The three components of USE are defined as follows:

- **Utilization** - A level, often expressed as a percentage, representing the time over a given interval a resource is busy rather than idle

- **Saturation** - A determination of how many requests the resource processed over the same interval, often coupled with a measurement of the size of the queue of unprocessed requests during that time

- **Errors** - The number of incidents of unhandled exceptions and unfulfilled requests during the same period

There isn't a universal formula governing the relationship between these three factors. For any resource an administrator may monitor, there are ranges of values that represent "normal" behavior conditions. A properly engineered solution adapts to changing conditions and shouldn't have to wait until a condition becomes abnormal to adapt. Gregg's concept introduces the idea that most (by his estimate, four out of five) adaptations, mitigations, or remediations for a given resource that can be automated, require evaluations of these three factors for that resource.

### The RED Method

More recently, former Google and Kausal engineer Tom Wilkie, now with Grafana, has developed a derivative of USE he believes is better suited to microservices environments, and the types of applications orchestrated by Kubernetes and monitored by Prometheus. In such an environment, Wilkie notes, saturation rates are more difficult to determine. Called the RED method<sup>[4][^4]</sup>, it focuses entirely on these three factors relating to request responsiveness:

- **Rate** - The number of requests a service processes over a given interval (usually one second)

- **Errors** - The number of failed requests in that same interval

- **Duration** - The average time a service consumes in responding to a request before rendering a response<sup>5</sup>

Again, there's no standard formula or ratio relating these three factors. Wilkie and other engineers suggest observing these metrics over an extended period of time, to get a clear idea of what "normal" behavior looks like, and then take note of the range of relationships between them that fall inside the upper and lower bounds of normalcy.

Up to now, this module has focused primarily on the tools and platforms cloud administrators use to monitor how their information systems are performing. The next lesson concentrates on two important questions: How does an IT operator make a business case for undertaking an action that requires an expenditure? And how can an IT department develop remediation plans that could mitigate the need for future expenditures down the road?

### References

1. _From there, the browser usually begins preparing to render a page or HTML block, and it's this rendering that the user will perceive as the practical end of the transaction._

1. _APDEX. *Apdex Overview*. <https://www.apdex.org/>._

1. _Brendan D. Gregg. *The USE Method*. <http://www.brendangregg.com/usemethod.html>._

1. _The New Stack. *The RED Method: A New Approach to Monitoring Microservices*. <https://thenewstack.io/monitoring-microservices-red-method/>._

1. _In some presentations, Wilkie has instead called the "D" factor "Distribution of latency," which may be a more scientific method for framing the same concept._

[^2]: <https://www.apdex.org/>  "APDEX. *Apdex Overview*."

[^3]: <http://www.brendangregg.com/usemethod.html>  "Brendan D. Gregg. *The USE Method*."

[^4]: <https://thenewstack.io/monitoring-microservices-red-method/>  "The New Stack. *The RED Method: A New Approach to Monitoring Microservices*."
