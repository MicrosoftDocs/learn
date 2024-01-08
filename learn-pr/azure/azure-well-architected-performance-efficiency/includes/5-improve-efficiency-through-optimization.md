| :::image type="icon" source="../media/goal.svg"::: Improve system efficiency within the defined performance targets to increase workload value. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The targets set during the initial phase are based on a reasonable level of user experience, considering various constraints. You should reassess and adjust targets to further enhance the experience. To further enhance the experience, it requires a clear understanding of how the system is used, how it has evolved, and how the platform or technology has changed over time. The cycle of monitoring, optimizing, testing, and deploying is a continuous process.

Efficiency optimization efforts allow a workload to work with lower resource consumption. They can cause the workload to be in an over-provisioned state with spare capacity. Use that capacity to improve reliability of the system. Eliminate capacity to improve the cost of the system. Or repurpose the capacity to support new product features on existing resources.

When the system gains efficiencies, take the opportunity to set and maintain new performance targets.

**Example scenario**

Contoso’s HR engineering team supports custom integrations into the organization’s human resources information system (HRIS). These integrations include finance integrations for payroll, hiring statistics for government labor law reporting, and others. Most of the integrations are Azure Functions written in C# which are hosted in an Azure Arc-enabled Kubernetes cluster in the organization’s data center.  Most of the jobs have been running well, but due to a delay in processing, a few make the team anxious as sometimes critical data isn’t available when the HR director needs it. 

## Prioritize performance optimizations

**Allocate dedicated cycles for performance optimization to address nonfunctional requirements and optimizations in functional areas. Targets for this optimization are resources, code, data retention, database queries, and others.**

By adopting this approach, you can build a culture of performance-driven optimization. You keep the team accountable for proactively monitoring performance patterns and also fine-tune the application.

*Contoso's challenge*

- The team is rather scrappy, and their backlog is long.  Most of the time they work in a "fire and forget" mindset when writing and deploying integrations; the integrations get written, deployed and then the team moves on to the next task.
- The team has been called for critical incident support issues frequently due to senior leadership not having access to data in a timely manner.
- The team is keenly aware that improvements need to be made, but haven't prioritized making the necessary changes.

*Applying the approach and outcomes*

- The team now allocates 20% of every sprint for technical debt and other optimization activities. This is buying the engineering team time to prioritize and address critical areas and other areas where impact can be most meaningful.
- By taking this approach the team is able to dedicate the necessary time to address the performance issues causing delays in processing data.

## Look for design improvements

**Enhance the architecture with new design patterns and components, which can boost performance, in ways that you previously didn't consider because of limited time or budget.**

New design and components can optimize the system, leading to better user experience and long-term cost efficiencies. For example, you can use caching or adding a content delivery network component.

*Contoso's challenge*

- The team has used Azure Functions and trigger-based flows for several years and haven't dedicated time to evaluate alternatives to this approach.

*Applying the approach and outcomes*

- The team looks into other ways to use Azure Functions, and finds that durable functions supports a fan-out model that can help them parallelize a particular payroll task.
- The team incorporates this pattern into their design catalog for future design. It was also a good reminder to look at other ways of addressing performance inefficiencies than just code optimizations and data cleanup.

## Analyze telemetry and trends

**Use monitoring tools to analyze historical trends and to identify the flows and code implementation paths that would benefit the most from a performance optimization effort. We recommend application performance monitoring (APM) tools and profilers for this purpose. Additionally, identify operation hot paths and other potential bottlenecks in the system.**

When you identify the recurring problematic areas, the team can focus where gains are the highest.

*Contoso's challenge*

- The team has instrumented all functions with Azure Application Insights.
- They mostly use Application Insights for break-fix issues and for the logging sink.
- Historically, their approach to targeting areas for improvements has been based on feedback coming from the senior leadership team.

*Applying the approach and outcomes*

- While the feedback is important, the team realizes that Application Insights does a fairly good job of detecting hotspots in the applications that it monitors.
- The team begins taking advantage of this functionality and combined with knowing which flows are important, it’s turning into a valuable tool for the team’s 20% effort on technical improvements and efficiency.
- Using Application Insights, the team is able to proactively identify a risky integration and handle it before a leadership team member experienced a problem.
