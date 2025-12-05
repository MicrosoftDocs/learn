| :::image type="icon" source="../media/goal.svg"::: Improve system efficiency within your defined performance targets to get more value out of your workload. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The targets set during the initial phase are based on a reasonable level of user experience, given various constraints. It's worth revisiting and adjusting those targets to make the experience even better. To do that, you need a clear picture of how the system's being used, how it's changed, and how the platform or technology has evolved. The cycle of monitoring, optimizing, testing, and deploying is an ongoing process.

When you optimize for efficiency, the workload can run by using fewer resources. That might leave you with extra capacity, which opens up a few options. You can use the capacity to make the system more reliable, reduce it to save on costs, or support new product features without needing more infrastructure.

When the system starts running more efficiently, it's a great time to set new performance targets and make sure you're keeping up with them.

**Example scenario**

Contoso's HR engineering team handles custom integrations to the company's HR information system. These integrations include finance for payroll, hiring data for government labor law reports, and a few others. Most of these integrations run as Azure functions written in C#, which are hosted on an Azure Arc-enabled Kubernetes cluster in the company's datacenter. Overall, the jobs run smoothly, but a few cause some stress for the team because delays in processing sometimes mean that the HR director doesn't get important data on time.

## Prioritize performance optimizations

**Set aside focused time to improve performance by tackling nonfunctional requirements and making improvements in functional areas. The main focus areas for this work include resource usage, code quality, data retention, and database queries.**

By going with this approach, you help create a culture that really values performance-focused improvements. It also keeps the team responsible for staying on top of performance trends and making sure the application keeps getting better.

*Contoso's challenge*

- The team is pretty scrappy, and their backlog is packed. Most of the time, they take a quick turnaround approach when building and launching integrations. They write the code, deploy it, and then jump straight into the next task.

- The team has been pulled into critical incident support often because senior leadership can't always get the data they need on time.
- Everyone on the team knows changes are needed, but they haven't made it a priority yet.

*Applying the approach and outcomes*

- The team now sets aside 20% of every sprint to tackle technical debt and focus on other performance improvements. That's giving them the space to focus on critical areas and make progress where it'll really count.

- By taking this approach the team is able to dedicate the time they need to fix the performance problems that have been slowing down data processing.

## Look for design improvements

**Improve the architecture by bringing in new design patterns and components that can boost performance, especially in ways that you didn't consider before because of tight timelines or budget limits.**

New design patterns and components can help fine-tune the system, which leads to a smoother user experience and saves money over time. For example, adding caching or bringing in a content delivery network can make a noticeable difference.

*Contoso's challenge*

- The team has used Azure Functions and trigger-based flows for several years, and they haven't taken time to look into other options.

*Applying the approach and outcomes*

- The team starts exploring other ways to use Azure Functions and finds that durable functions support a fan-out model, which can help them run a specific payroll task in parallel.

- The team adds this pattern to their design catalog for future use. It's also a good reminder that improving performance isn't just about cleaning up code or data. Sometimes it's about rethinking the approach altogether.

## Analyze telemetry and trends

**Use monitoring tools to dig into historical trends and find which flows and code paths could really use a performance boost. Tools like application performance monitoring (APM) and profilers are great for this task. They help you find operation hot paths and other spots in the system that might be slowing things down.**

After you find the areas that keep causing trouble, the team can focus their energy where it'll make the biggest difference.

*Contoso's challenge*

- The team has instrumented all functions with Application Insights.

- They mostly use Application Insights for break-fix problems and for the logging sink.
- Historically, they've relied on feedback from senior leadership to figure out where to focus improvement efforts.

*Applying the approach and outcomes*

- While the feedback is important, the team notices that Application Insights actually does a pretty good job of finding hotspots in the apps that it watches.

- The team starts making use of this feature, and since they already know which flows matter most, it's becoming a really useful part of their 20% time focused on technical improvements and efficiency.
- Using Application Insights, the team was able to proactively identify a risky integration and handled it before a leadership team member ran into a problem.
