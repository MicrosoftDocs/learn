When you design for resiliency, you must understand the application's availability requirements. How much application downtime is acceptable? One way to approach this is to ask, "How much will potential downtime cost your business?" Also consider how much you should invest in making the application highly available. Define what it means for the application to be available. For example, is the application "down" if you can submit an order but the system can't process it within the normal time frame? Also consider the probability of an outage occurring and whether a mitigation strategy is cost-effective. Resilience planning starts with business requirements. Here are some approaches for thinking about resiliency in those terms.

## Assess by workload resiliency requirements

Many cloud solutions consist of multiple application workloads. The term "workload" in this context means a discrete capability or computing task that can be logically separated from other tasks in terms of business logic and data storage requirements. For example, an e-commerce app might include the following workloads:

- Browse and search a product catalog
- Create and track orders
- View recommendations

Workloads often have different requirements for availability, scalability, data consistency, and disaster recovery. Business decisions involve balancing cost against risk. While it might be useful for a leave-request application to be highly resilient, is it worth the added cost of implementing those resiliency features?

It's also important to consider usage patterns. Are there certain critical periods when the system must be available? For example, a tax-filing service can't go down right before the filing deadline and a sports video streaming service must stay up during a big game final. During the critical periods, you might have redundant deployments across several regions, so the application could fail over if one region failed. However, a multi-region deployment is potentially more expensive, so during less critical times, you might run the application in a single region.  

Qualifying applications into different tiers is a common strategy. Tier 1 applications are made up of those applications that shouldn't experience any loss in data. The Recovery Time Objective (RTO)/Recovery Point Objective (RPO) for this tier needs to be as close to zero as possible. Tier 2 applications consist of those applications that can lose minimal amounts of data with RTO and RPO in the order of a few minutes. Tier 3 and 4 applications are those that affect internal operations for a few hours and while inconvenient, don't pose a huge risk to the business.

The following table lists examples of different application tiers.

| **Tier** | **Application type** |
|:---|:---|
| Tier 1 | ATM transactions, telecommunications systems |
| Tier 2 | Video delivery, broadcast systems, online commerce |
| Tier 3 | Internal tools like knowledge management, project tracking |
| Tier 4 | Batch processing, data extraction, transfer, and load jobs |

## Service-level agreements and reliability objectives

A service-level agreement (SLA) is a contractual commitment between a provider and a customer. It defines the covered service, how availability is measured, applicable conditions and exclusions, and the consequences of not meeting the commitment.

For your workload, define service-level objectives (SLOs): measurable reliability targets based on business requirements and the experience of critical user flows. Use provider SLAs as design inputs, not as guarantees of your application's availability.

The following table illustrates cumulative downtime budgets for time-based availability objectives, using a seven-day week, a 30-day month, and a 365-day year. These conversions don't override the measurement periods or conditions in a provider's SLA.

| **Availability objective** | **Downtime per week** | **Downtime per month** | **Downtime per year** |
|:---|:---|:---|:---|
| 99% | 1.68 hours | 7.2 hours | 3.65 days |
| 99.9% | 10.1 minutes | 43.2 minutes | 8.76 hours |
| 99.95% | 5 minutes | 21.6 minutes | 4.38 hours |
| 99.99% | 1.01 minutes | 4.32 minutes | 52.56 minutes |
| 99.999% | 6 seconds | 25.9 seconds | 5.26 minutes |

As you strive for more 9s, the cost and complexity of achieving that level of availability grow. An uptime of 99.99% translates to about 5 minutes of total downtime per month. Whether it's worth the additional complexity and cost to reach five 9s depends on the business requirements.

High availability targets generally require rapid failure detection and automated recovery to limit manual delays. The higher the availability objective, the smaller the allowable cumulative downtime. Reducing the frequency of failures, reducing recovery time, or both can help meet that objective.

### Dependencies and availability

If a critical user flow requires both a web app and a database, either dependency can make that flow unavailable. A fallback can preserve some functionality, but first define whether that reduced functionality meets the flow's requirements.

For a simplified probability example, assume availability estimates of 99.95% for a web app, 99.99% for a database, and 99.9% for a queue. Also assume that their failures are independent and that availability is measured consistently. Under these assumptions, the combined availability is:

- Web app AND database: `0.9995 * 0.9999` = 99.940005%, or approximately 99.94%.

If the business permits orders to be durably accepted into a queue and processed later, either the database or the queue can support the order-acceptance flow:

- Database OR queue: `1 - (0.0001 * 0.001)` = 99.99999%.
- Web app AND (database OR queue): `0.9995 * 0.9999999` = 99.949990005%, or approximately 99.95%.

This fallback preserves order acceptance, not necessarily immediate order completion. It adds cost and application complexity, and requires appropriate handling of delayed processing and data consistency.

> [!IMPORTANT]
> These numbers are illustrative assumptions, not published Azure SLAs or predictions of application uptime. Real failures can be correlated through shared infrastructure, dependencies, configuration, or application defects. Define workload SLOs and validate the design through failure mode analysis, monitoring, and recovery testing.

### Illustrative availability across independent regions

Deploying across regions can reduce the effect of a regional failure. For a simplified probability example, assume that each regional deployment can serve the complete workload, that failures are independent, and that routing and shared dependencies don't introduce additional failures.

Let N be each regional deployment's availability expressed as a fraction, and R the number of deployments. The probability that all deployments are unavailable is `(1 - N)^R`, so the modeled availability is `1 - (1 - N)^R`.

For N = 0.9995:

- Two regions: `1 - (0.0005^2)` = 99.999975%.
- Four regions: `1 - (0.0005^4)` = 99.99999999999375%.

> [!IMPORTANT]
> These are mathematical illustrations, not workload availability guarantees. Real designs must account for correlated failures, shared dependencies, available capacity, data recovery, and failover delays.

Azure Traffic Manager currently provides a 100% availability SLA for DNS query responses when failed DNS queries are retried as required by its SLA. This commitment doesn't guarantee uninterrupted access to your application. Include endpoint health detection, DNS caching and TTLs, and application and data recovery in your failover planning. Review the current [Traffic Manager reliability guidance and SLA information](/azure/reliability/reliability-traffic-manager#service-level-agreement) for coverage and conditions.

## RTO and RPO

Two important metrics to consider are the recovery time objective and recovery point objective, as they pertain to disaster recovery. These are defined as follows:

- Recovery time objective (RTO) is the maximum acceptable time that an application can be unavailable after an incident. If your RTO is 90 minutes, you must be able to restore the application to a running state within 90 minutes from the start of a disaster. If you have a very low RTO, you might keep a second regional deployment continually running an active/passive configuration on standby, to protect against a regional outage. In some cases, you might deploy an active/active configuration to achieve even lower RTO.
- Recovery point objective (RPO) is the maximum duration of data loss that's acceptable during a disaster. For example, if you store data in a single database, with no replication to other databases, and perform hourly backups, you could lose up to an hour of data.

RTO and RPO are nonfunctional requirements of a system and should be dictated by business requirements. To derive these values, conduct a risk assessment and clearly understand the cost of downtime or data loss.

## MTTR and MTBF

Two other common measures of availability are mean time to recover (MTTR) and mean time between failures (MTBF).  

### Mean time to recover (MTTR)

Mean time to recover (MTTR) is the average observed time taken to restore a component or workload after a failure. Low component MTTR values can help, but don't establish the application's recovery time. Dependencies, recovery sequencing, and validation can extend the overall recovery. Define the measurement boundaries and measure recovery across critical user flows. When checking the workload's RTO, measure from the start of the outage through validated recovery, including detection and response time.

### Mean time between failures (MTBF)

Mean time between failures (MTBF) measures the average operating time between failures. A lower MTBF indicates more frequent failures. The effect on workload availability also depends on recovery time and whether redundancy and failover prevent component failures from interrupting users. Multiple instances help only when the design addresses shared failure causes and can successfully route work to healthy instances.
