In this unit, we look at Monitoring Java Application concepts.

# Why Monitoring?

Monitoring is as important in mission-critical solutions deployed to the cloud as the solutions themselves. In a fully monitored data-center environment, *instrumentation* is provided by software. Instrumentation generally takes on the three forms:

- **Logs** - Permanent, immutable records of events stored in a consistent, tabular format, if not in a full database. An *event* may be indicative of one of many conditions, including:

  - A change in the status of a monitored component (for example, from "busy" to "available")
  - The completion of a task or sequence of instructions
  - A milestone in the progression of data through a network, or the availability of units in a network
  - An error, which in this context is a behavior that the system or application has not been programmed to handle or mitigate

- **Metrics** - Values that represent the relative health, stability, and availability of a service or application or the infrastructure that hosts it

- **Traces** - Records of the paths of execution for programs and services, especially in a highly distributed system, indicating the sequence of instructions that may have triggered, either directly or indirectly, an event

## Tracing in Microservice Environments

A traditional application incorporates all of its code in a single, contiguous unit. Even if it utilizes portable libraries that were formally included in the code's declarations, they still exist inside the walls of the proverbial monolith. A monitoring platform observing an application from the outside usually waits for it to do something noticeable, like accept a query or produce a result, and then measures the service levels of these actions. When an enterprise network needs to improve the service levels for this network, it simply replicates these servers and places a load balancer in front of them to even out the traffic flow. Even modern VM platforms merely automate this simple process.

With microservices, the code modules of an application become applications unto themselves, which interact with and pass control between one another through the network. To find one another, they may use raw IP addresses, but more likely they use a DNS server for service discovery, or they might make use of a *service mesh* to discover each other's identities and locations. An orchestrator such as Kubernetes improves service levels by replicating as many of the individual microservices as the cluster needs to account for fluctuating traffic volume, and can then delete these replicas when traffic subsides.

Supporting a microservices environment with a conventional monitoring platform that observes events from the outside is like equipping a metropolitan area with a population of more than a million people with a single party-line telephone circuit. Theoretically it would work, given an infinite time constraint, but communications over such a system would be unworkably slow. Consequently, specialized APM platforms are preferred for monitoring microservice-based solutions.

## Azure's Integrated APM Platform

Increasingly, cloud service providers offer native monitoring services that are integrated into their cloud platforms. Azure, for example, supports Azure Monitor, which comprises a set of services that developers and administrators can use to collect, analyze, and act upon telemetry regarding the performance of applications and the infrastructure that hosts them. Events emanating from applications, virtual machines, and other resources are logged and used to compute performance metrics. Various services such as Azure Log Analytics and Microsoft Power BI can be connected to the data sources where logs and metrics are stored to generate actionable insights and create visual dashboards. In addition, developers can instrument their applications with Azure Application Insights to generate custom telemetry. This provides an extra layer of monitoring that is application-specific and that can be extremely beneficial in diagnosing errors and their root causes -- often without having to dive into the source code.

## Continuos Monitoring

Continuous monitoring of applications in production environments is typically implemented with application performance management (APM) solutions that intelligently monitor, analyze, and manage cloud, on-premises, and hybrid applications and IT infrastructure. APM solutions enable you to monitor your users' experience and improve the stability of your application infrastructure. It helps identify the root cause of issues quickly to proactively prevent outages and keep users satisfied.

## Next steps

In the next exercise, we'll configure your Sample Spring application and set it up for monitoring.
