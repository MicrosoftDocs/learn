| :::image type="icon" source="../media/goal.svg":::  Protect against performance degradation while the system is in use and as it evolves. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Development isn't a one-time effort. It's an ongoing process. Expect changes in performance as features change. There's variance in user patterns and profiles, even changes from optimizations in other Azure Well-Architected pillars. Any change can strain workload resources.

Safeguard the system from changes so that it doesn't slide back on performance targets. Integrate testing and monitoring in the development process. Test the system's performance in production with real load and simulate that load with automated testing prior to production. In both cases, you should have monitoring practices in place for verification purposes.

Throughout the development lifecycle, conduct various types of tests at different stages. In the initial stages, test the proof of concept to make sure performance results aren't entirely unexpected. As development progresses, conduct manual, low-effort tests to establish benchmarks. In the build stage, start developing automated routine performance tests that evaluate latency, stress levels, load capacity, and other characteristics defined in the test plans.

Monitoring must be an integral part of that effort, rather than being an isolated exercise. You can see how the system and its resources perform over time. You can then fine-tune them to maximize their value, and ensure they continue to meet performance standards.

Keep in mind that performance targets vary over time, in response to changes. Update the performance model based on tested and monitored metrics. Clearly indicate increased, reduced, or no effect on the performance of the flows.

Always be ready to renegotiate and reset expectations with business stakeholders.

**Example scenario**

Contoso Event Solutions offers a product that event entrance staff can use to scan tickets on a mobile device and quickly allow entrance to a ticketed venue for those authorized.  The system is available with both a completely offline mode and also as a cloud-connected version for venues worried about ticket duplication.  The offline mode is highly performant, but the online mode was missing its performance targets. The development team recently invested a couple of development cycles to work on it, and now performance is much improved and meeting targets.  Business stakeholders would like to expand their customer base to support larger venues soon.

## Test for performance in development

**Formalize performance tests as quality gates that can approve or deny release promotion and the final deployment to production.**

These checkpoints ensure that each stage of deployment meets the required performance standards before you proceed to the next. The checkpoints help prevent unintended performance regression. For instance, if the performance is significantly below expectations, you might block a release until improvements are made.

*Contoso's challenge*

- The team has invested considerable time and effort to achieve acceptable performance for the online version of the application, but they don’t have any system in place presently to prevent a regression.
- The next feature they plan on adding is the ability for a venue to opt into showing a picture of the attendee along with the scan for additional verification. There is a risk that the extra photo lookup and download will slow the process.
- Without a formal process in place, there is a risk that the performance of both the online and offline versions could be negatively affected by the additional functionality and they may fall below their targets. 

*Applying the approach and outcomes*

- The team integrates automated performance tests into the build pipeline. By implementing strict performance-based “go/no-go” criteria in the build pipeline, the team is more confident that the new feature is not going to be released with a performance regression.
- The team was wise to implement this testing, as it caught a bug in the newest version of the build. The bug forced the app to attempt to connect to the internet to download an image while the scanner was set to offline mode, causing a timeout to occur with every ticket scan. Catching this bug with the automated testing allowed the team to fix the bug before releasing the new version.

## Optimize through observability

**Set up a repeatable process for monitoring real transactions in production and deviations against your performance targets. Additionally, use synthetic transactions in production and set up monitoring alerts on performance regressions.**

You want insight into the actual performance of your system under real-world load that couldn't be simulated through tests. Then you can proactively identify issues and areas of improvement such as potential bottlenecks, underutilized resources, and other concerns.

*Contoso's challenge*

- During an event where they are using online ticket validation, the backend system is heavily used.
- There is an application performance monitoring (APM) system in place, but it hasn't been used to monitor the health of production transactions.

*Applying the approach and outcomes*

- The team has decided to adopt updated processes to better capture health metrics:
    - They configure alerting based on performance percentiles and for performance outliers. No alerts indicates that the system is performing in acceptable ranges for most ticket scans.
    - After an offline event is complete, the telemetry for ticket scans is uploaded in batch and those metrics too go through a process to look for deviations from acceptable performance.
    - The team also implements synthetic transaction testing to augment their performance monitoring. Since almost all events take place on weekends and in the evening, the team uses synthetic transaction testing throughout the week to generate a more consistent performance baseline.

## Handle workload changes intelligently

**Address performance erosion as usage increases, features change, and data accumulates over time to sustain performance. Reset expectations and establish new targets, if fine-tuning brings only short-term benefits.**

By adopting this approach, you can preserve the performance state before degradation develops into problems that negatively affect user experience beyond the acceptable range.

Changing targets resets the performance model, and you don't waste time in optimizing the system that has already reached its capacity.

*Contoso's challenge*

- The sales team has been aggressively onboarding new event venues into the system. Business is good.
- The workload monitoring system has started to notice the performance budget is getting eaten into more and more over time, even without the introduction of new features. 
- Without a change, this trajectory may lead to an unacceptable regression in performance, putting the workload at risk of suffering an outage if an incident occurs. 

*Applying the approach and outcomes*

- The team realizes that as more customers onboard, the data lookup mechanism for online events is doing a very large scan over the data for many queries.
- Some query optimization has helped keep the increased usage from causing additional harm.  In the coming months, the team plans to break out different events into different data partitions to reduce the need for query scanning. This will support the continued scaling out of the workload.
- They also realize that they can further optimize the system to grow by removing ticketing data from old events. Searching for old events isn’t something that the ticket validation system should need to do, so that data can be moved into a store dedicated for reporting and historical lookup.