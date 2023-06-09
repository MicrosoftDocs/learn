Cloud computing has resulted in software solutions that are more reliable and more available than ever before. But reliability and availability don't happen by accident. They are the product of careful design, and they must be ensured by constant monitoring that alerts administrators when problems occur (or preferably *before* they occur). Monitoring is as important in mission-critical solutions deployed to the cloud as the solutions themselves. Without it, you don't know whether a solution is serving its users' needs.

Monitoring takes on many forms. It can be as simple as a software component that periodically pings a running application to make sure it's still running. It can also be more complex, keeping running track of key metrics such as request wait times (the length of time a request waits in a queue before it is processed by the system) and CPU utilization. Monitoring can trigger actions such as increasing the number of virtual machines to handle increased workloads or notifying an administrator of a condition that warrants attention. Because it's not reasonable to expect human operators to monitor systems 24x7, monitoring is automated through software. That software can come from third parties, or it can come from the cloud platform itself.

This module deals with the subject of monitoring the behavior of IT systems, which concerns both the infrastructure of these systems and the applications they host. We begin by making the case for automated monitoring, and then examine some of the more common application performance monitoring (APM) platforms. Next, we address the topic of metrics, which are the key measurements a monitoring platform should track, and discuss how these metrics are put to work ensuring system integrity and improving efficiency and robustness. Finally, we tackle the concept of remediation planning, which defines how performance issues are resolved and mitigated.

## Learning objectives

- Explain the main argument in favor of continual and consistent monitoring and oversight in cloud-based IT systems
- Describe the three types of quantitative measurements that play a role in monitoring
- Understand the mechanics of monitoring platforms that utilize agents to collect and report back information
- Understand the mechanics of monitoring platforms that rely upon pre-existing sources of information such as service logs to analyze performance
- Understand the metrics that are the most beneficial to monitoring
- Learn how measurements are used to judge performance levels
- Describe the justification for problem ticketing
- Describe what KPIs are and how they differ from metrics
- Discuss the concept of “everyday remediation”

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers
- Recognize cloud service models such as IaaS, PaaS, and SaaS and differentiate between them
- Be familiar with different organizational IT cost types like CapEx and OpEx
- Understand how cloud resource provisioning works
