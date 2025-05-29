| :::image type="icon" source="../media/goal.svg"::: Put safeguards in place to keep performance from slipping while the system is running and as it grows or changes over time. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Development isn't a one-time effort. It's an ongoing process. Expect changes in performance as features change. User patterns and profiles can change, and even optimizations made in other areas of the Azure Well-Architected Framework can have an impact. Any of these changes can put extra pressure on your workload resources, so it's important to monitor how everything performs as the system grows and changes.

Safeguard the system from changes so that it doesn't slide back on performance targets. Build testing and monitoring right into the development process. Run performance tests in production by using real load, and simulate that load with automated testing before you go live. In both cases, have monitoring in place so you can verify how everything holds up and catch any problems early.

As you move through the development life cycle, run different types of tests at each stage. Early on, check the proof of concept (POC) to make sure the performance results aren't totally unexpected. As development moves forward, do some quick, manual tests to set performance benchmarks. In the build phase, start putting together automated performance tests that check latency, stress levels, load capacity, and any other traits outlined in the test plans.

Monitoring needs to be part of the whole process, not just something you do on the side. It helps you see how the system and its resources are performing over time. That way, you can make adjustments to get the most out of them and keep everything running up to performance standards.

Keep in mind that performance targets can shift over time as things change. Make sure to update the performance model based on the metrics you've tested and monitored. Be clear about whether those changes boosted performance, slowed it down, or didn't make a difference at all in how the flows are running.

Always be open to resetting expectations and having new conversations with business stakeholders when needed.

**Example scenario**

Contoso Event Solutions has a product that entrance staff can use to scan tickets on a mobile device and quickly let authorized guests into a venue. The system works in both a fully offline mode and a cloud-connected version, which is great for venues that are worried about ticket duplication. The offline mode runs really well, but the online version had been falling short of its performance goals.

The development team spent a couple of cycles improving it, and now it's meeting those targets. Business stakeholders are now looking to grow the customer base and start supporting larger venues soon.

## Test for performance in development

**Make performance tests part of your quality gates so they can either approve or deny a release from moving forward to production.**

These checkpoints ensure that each step in the deployment process meets the right performance standards before moving on. They help catch any unexpected drops in performance early. For example, if performance takes a big hit, you might hold off on releasing until it's back on track.

*Contoso's challenge*

- The team has put a lot of time and effort into getting the online version of the application to perform well, but right now, there's nothing in place to stop performance from regressing again.

- The next feature they plan to add will let venues choose to show a photo of the attendee along with the ticket scan for extra verification. There's a chance that pulling up and downloading the photo could slow things down a bit.
- Without a clear process in place, there's a real risk that adding new features could hurt the performance of both the online and offline versions, and they might end up missing their targets.

*Applying the approach and outcomes*

- The team has added automated performance tests to the build pipeline. By setting up strict "go or no-go" rules based on performance, they feel more confident that new features won't get released if they cause a performance regression.

- It was a smart move for the team to set up that testing because it caught a bug in the latest build. The bug made the app try to connect to the internet to download an image, even when the scanner was in offline mode, which caused a timeout every time someone scanned a ticket. Thanks to the automated tests, the team found the problem early and fixed it before the new version went out.

## Optimize through observability

**Set up a process that you can reuse to monitor real transactions in production and see when performance starts drifting from your targets. Also, run synthetic transactions in production and set up alerts to catch any performance slowdowns.**

You want a clear view of how your system actually performs when it handles real-world traffic, which is something that tests alone can't fully capture. Then you can get ahead of problems and spot areas to improve, like possible bottlenecks, resources that aren't being used effectively, and other concerns that might slow things down.

*Contoso's challenge*

- During an event where they're using online ticket validation, the back-end system is heavily used.

- There's an application performance monitoring (APM) system in place, but it hasn't been used to monitor the health of production transactions.

*Applying the approach and outcomes*

- The team decided to update their processes so they can track health metrics more effectively:
  - They set up alerts based on performance percentiles and outliers. If no alerts come up, it means that the system is handling most ticket scans within the expected range.

  - After an offline event is complete, the ticket scan telemetry is uploaded in batches. That data also goes through a check to look for any performance problems.
  - The team added synthetic transaction testing to boost their performance monitoring. Since most events happen on weekends and in the evenings, they run synthetic transaction tests during the week to build a more stable performance baseline. 

## Handle workload changes intelligently

**Address performance erosion as usage grows, features change, and data builds up over time so things keep running smoothly. If fine-tuning only gives you short-term benefits, it might be time to reset expectations and set new performance targets.**

By taking this approach, you can keep performance steady before it starts slipping in ways that hurt the user experience beyond what's acceptable.

Changing targets resets the performance model, and you don't waste time optimizing a system that has already reached its capacity.

*Contoso's challenge*

- The sales team has been aggressively onboarding new event venues into the system. Business is good.

- The workload monitoring system started to notice a steady dip in the performance budget over time, even though no new features have been added.
- If nothing changes, this trend could lead to a serious drop in performance. It could get bad enough that the workload might not hold up if something goes wrong.

*Applying the approach and outcomes*

- The team notices that as more customers come on board, the data lookup for online events is doing some heavy scanning across the dataset for a lot of queries.

- Some query tuning has helped keep the growing usage from making things worse. Looking ahead, the team plans to split different events into separate data partitions. This approach should cut down on how much scanning the queries have to do and help the workload keep scaling smoothly.
- They also realize that there's room to scale better by clearing out ticketing data from older events. Since the ticket validation system doesn't need to search through past events, that data can be moved to a separate store just for reporting and historical lookups.
