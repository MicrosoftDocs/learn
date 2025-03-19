When you design for resiliency, you must understand the application's availability requirements. How much application downtime is acceptable? One way of thinking about this is answering the question "How much will potential downtime cost your business?" You also should consider how much should you invest in making the application highly available? You also must define what it means for the application to be available. For example, is the application "down" if you can submit an order but the system can'no't process it within the normal timeframe? Also consider the probability of an outage occurring and whether a mitigation strategy is cost-effective. Resilience planning starts with business requirements. Here are some approaches for thinking about resiliency in those terms.

## Assess by workload resiliency requirements

Many cloud solutions consist of multiple application workloads. The term "workload" in this context means a discrete capability or computing task, which can be logically separated from other tasks, in terms of business logic and data storage requirements. For example, an ecommerce app might include the following workloads:

- Browse and search a product catalog
- Create and track orders
- View recommendations

Workloads often have different requirements for availability, scalability, data consistency, and disaster recovery. There are business decisions to be made in terms of balancing cost versus risk. Whilst it may be nice for the application leave applications to be highly resiliency, is it worth the added cost of implementing those resilient features?

It's also important to consider usage patterns. Are there certain critical periods when the system must be available? For example, a tax-filing service can't go down right before the filing deadline and a sports video streaming service must stay up during a big game final. During the critical periods, you might have redundant deployments across several regions, so the application could fail over if one region failed. However, a multi-region deployment is potentially more expensive, so during less critical times, you might run the application in a single region.  

Qualifying applications into different tiers is a common strategy. Tier 1 applications are made up of those applications that shouldn't experience any loss in data. The Recovery Time Objective (RTO)/Recovery Point Objective (RPO) for this tier needs to be as close to zero as possible. Tier 2 applications consist of those applications that can lose minimal amounts of data with RTO and RPO in the order of a few minutes. Tier 3 and 4 applications are those that affect internal operations for a few hours and while inconvenient, don't pose a huge risk to the business.

The following table lists some example of different application tiers.

| **Tier** | **Application type** |
|:---|:---|
| Tier 1 | ATM transactions, telecommunications systems |
| Tier 2 | Video delivery, broadcast systems, online commerce |
| Tier 3 | Internal tools like knowledge management, project tracking |
| Tier 4 | Batch processing, data extraction, transfer, and load jobs |

## Service Level Agreements (SLA)

A Service Level Agreement (SLA) is a commitment between a service provider and a client. It defines the expected level of service, including the availability and performance of the service. If the SLA for a particular service is 99.9%, it means you should expect the service to be available 99.9% of the time.

You should define your own target SLAs for each workload in your solution. An SLA makes it possible to evaluate whether the resiliency of the architecture meets the business requirements. 

The following table shows the potential cumulative downtime for various SLA levels.

| **SLA** | **Downtime per week** | **Downtime per month** | **Downtime per year** |
|:---|:---|:---|:---|
| 99% | 1.68 hours | 7.2 hours | 3.65 days |
| 99.9% | 10.1 minutes | 43.2 minutes | 8.76 hours |
| 99.95% | 5 minutes | 21.6 minutes | 4.38 hours |
| 99.99% | 1.01 minutes | 4.32 minutes | 52.56 minutes |
| 99.999% | 6 seconds | 25.9 seconds | 5.26 minutes |

As you strive for more 9s, the cost and complexity to achieve that level of availability grows. An uptime of 99.99% translates to about 5 minutes of total downtime per month. The answer to the question of whether it's worth the additional complexity and cost to reach five 9s depends on the business requirements.

Achieving four 9s (99.99%) requires minimizing manual intervention to recover from failures. To achieve this level of reliability, an application must be self-diagnosing and self-healing. This is because it is challenging to detect outages quickly enough to meet the SLA. The lower the SLA, the less frequently the service can go down, and the quicker the service must recover.

### Composite SLAs

Consider an App Service web app that writes to Azure SQL Database. At the time of this writing, these Azure services have the following SLAs:

- App Service Web Apps = 99.95%
- SQL Database = 99.99%

What is the maximum downtime you would expect for this application? If either service fails, the whole application fails. In general, the probability of each service failing is independent, so the composite SLA for this application is 99.95% × 99.99% = 99.94%. That's lower than the individual SLAs because an application that relies on multiple services has more potential failure points.

On the other hand, you can improve the composite SLA by creating independent fallback paths.

For example, if the SQL Database used by an application is unavailable, put transactions into a queue that can be processed later.  

With this design, the application is still available even if it can't connect to the database. However, it fails if the database and the queue both fail at the same time. The expected percentage of time for a simultaneous failure is 0.0001 × 0.001, so the composite SLA for this combined path is:

- Database OR queue = 1.0 − (0.0001 × 0.001) = 99.99999% The total composite SLA is:
- Web app AND (database OR queue) = 99.95% × 99.99999% = ~99.95%

There are tradeoffs to this approach. The application logic is more complex, you will have to pay for the queue, and there may be data consistency issues to consider.

### SLA for multi-region deployments

Another HA technique is to deploy the application in more than one region and use Azure Traffic Manager to fail over if the application fails in one region. For a multi-region deployment, the composite SLA is calculated as follows.

Let _N_ be the composite SLA for the application deployed in one region, and _R_ be the number of regions where the application is deployed. The expected chance that the application will fail in all regions at the same time is ((1 − N) ^ R).

For example, if the single-region SLA is 99.95%,

- The combined SLA for two regions = (1 − (0.9995 ^ 2)) = 99.999975%
- The combined SLA for four regions = (1 − (0.9995 ^ 4)) = 99.999999%

You must also factor in the SLA for Traffic Manager which, at the time of this writing is 99.99%. In addition remember that failing over is not instantaneous in active-passive configurations, which can result in some downtime during a failover.

## RTO and RPO

Two important metrics to consider are the recovery time objective and recovery point objective, as they pertain to disaster recovery. These are defined as follows:

- Recovery time objective (RTO) is the maximum acceptable time that an application can be unavailable after an incident. If your RTO is 90 minutes, you must be able to restore the application to a running state within 90 minutes from the start of a disaster. If you have a very low RTO, you might keep a second regional deployment continually running an active/passive configuration on standby, to protect against a regional outage. In some cases, you might deploy an active/active configuration to achieve even lower RTO.
- Recovery point objective (RPO) is the maximum duration of data loss that is acceptable during a disaster. For example, if you store data in a single database, with no replication to other databases, and perform hourly backups, you could lose up to an hour of data.

RTO and RPO are non-functional requirements of a system and should be dictated by business requirements. To derive these values, it's a good idea to conduct a risk assessment, and clearly understanding the cost of downtime or data loss.

## MTTR and MTBF

Two other common measures of availability are mean time to recover (MTTR) and mean time between failures (MTBF).  

### Mean time to recover (MTTR)

The average time that it takes to restore a component after a failure. MTTR is an empirical fact about a component. Based on the MTTR of each component, you can estimate the MTTR of an entire application. Building applications from multiple components with low MTTR values results in an application with a low overall MTTR — one that recovers quickly from failures.

### Mean time between failures (MTBF)

The runtime that a component can reasonably expect to last between outages. This metric can help you to calculate how frequently a service will become unavailable. An unreliable component has a low MTBF, resulting in a low SLA number for that component. However, a low MTBF can be mitigated by deploying multiple instances of the component and implementing failover between them.
