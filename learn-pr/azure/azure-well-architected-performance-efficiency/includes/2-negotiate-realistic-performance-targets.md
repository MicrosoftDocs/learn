| :::image type="icon" source="../media/goal.svg"::: The intended user experience is defined, and there's a strategy to develop a benchmark and measure targets against the pre-established business requirements. |
| :----------------------------------------------------------------------------------------------------------------------------- |

From a performance perspective, it's ideal to have well-defined performance targets to start your design process. To set those targets, you need to have a good understanding of the business requirements and the anticipated quality of service that the workload is expected to deliver. Define the expectations in collaboration with the business stakeholders. Instead of only focusing on technical metrics, determine the acceptable effects on the user experience for the key flows.

There's a circular dependency. You can't measure what you haven't defined, and you can't define without measurement. So, it's also important to measure the workload performance until you achieve a satisfactory definition of acceptable threshold with collective agreement.

There's a strong correlation between performance and reliability targets, which help determine the quality of service in terms of performance, availability, and resilience. Without a clear definition, it's challenging to measure, alert for, and test performance. After you establish the targets and identify actual numbers through testing over time, you can implement automation for continuous testing against these targets.

Adhere to best practices in defining targets at the macro level, even if they're approximate or within a range.

**Example scenario**

Contoso Bicycle is a direct to consumer bicycle brand in the United States. Their development team has begun work on building an app in support of Contoso's planned mobile bicycle repair service offering. The app is currently in the proof of concept phase.  Technicians will use a mobile app to manage their schedule and work orders, as well as taking payments. A website will be used for customers to schedule service.  The web app, mobile app, and the backend API are all likely to be hosted on Azure App Service.

## Prepare to negotiate performance targets

**Prepare for effective negotiation by understanding technical concepts, exploring design possibilities with the available infrastructure, and using results from concrete experimentation, if available. Use historical data to get visibility into usage patterns and bottlenecks. Bring insight from external factors, such as input from market analysis, experts, and industry standards.**

You can make informed decisions based on practical insights.

The performance targets are focused on user experience that's based on what's feasible, industry best practices, and current market trends.

*Contoso's challenge*

- In discussions about the application with business stakeholders, performance hasn’t yet been discussed.
- The development team is new to Azure and so they don't have familiarity with performance and scaling capabilities of the platform.
- Without guidance from the stakeholders and practical knowledge of what is possible, the team is worried that they will have to deploy infrastructure for testing only to rebuild later.
- The team is also worried that no one will be prepared to talk about realistic performance targets when they meet next.

*Applying the approach and outcomes*

- The Contoso business analysts and developers discuss their concerns and come up with a plan: The business analysts will research performance expectations through competitive analysis and informal polling, and the development team will research Azure's capabilities and options for different pricing tiers.
- The teams regroup with business stakeholders bringing the data they've compiled and use the data as the foundation for their negotiations about performance targets. Through discussions about potential performance capabilities and associated costs, all parties leave feeling good about using App Services for the workload.

## Negotiate performance targets effectively

**Collaborate with the business owners to understand user promises, in terms of quality and regulatory compliance, if applicable. Maintain a broad perspective and avoid diving into granular details at this stage. Be explicit about what represents acceptable performance, based on the investments, and understand the business context and anticipated growth.**

By adopting this approach, you'll avoid making assumptions that might not align with the business goals. It also drives clarity and motivation within the workload team.

Having a business context on functional and nonfunctional requirements might uncover design changes in other Azure Well-Architected pillars and help you make informed tradeoffs.

Defining parameters early on helps avoid costs associated with potential solution redesigns later; it enables you to ensure that performance targets cover future projections, so you can align current efforts with long-term goals.

*Contoso's challenge*

- The architecture team has rough ideas of what might be acceptable, but no specifics yet.  The architects feel generally that they should be able to avoid rework with their choice of application platform, but they would feel more confident with a bit more specificity than what they've gotten so far.
- Up to this point, the performance discussions have been vague, with statements like, "The website needs to be fast."
- Without a bit more specificity, the architects worry that they might over-engineer the design for performance, or face delays that push back the release to production.

*Applying the approach and outcomes*

- The business partners and the technical team meet to gain consensus on general but realistic targets and some absolute limits that must be avoided.  With these in hand, the architects can do proof to concepts as part of their initial design to get broad agreement on the application platform, and present some findings for performance vs pricing.
- One of the outcomes of this meeting is knowing that Contoso Bicycle plans on only operating in the southwest United States for the first year, but will expand nationwide in year two. This information will be factored into the design.

## Design with a flow-centric focus

**Identify the workload flows and prioritize the flows in the architectural diagram. Define each flow's performance tolerance as a range from aspirational to unacceptable performance. Evaluate the entry and exit points for each flow, considering the path's criticality, usage frequency, and architectural intensity.**

By prioritizing flows, you can focus your resources on critical areas that have the most effect on user and business outcomes.

By breaking down the system into its parts and dependencies, you understand each component's function and influence on performance. You also become aware of potential issues.

It helps establish a performance baseline and drive optimization.

*Contoso's challenge*

- Thus far, the technical team has worked with stakeholders to identify high-level performance targets, but hasn't focused on individual flows yet. For the design team to be able to drill deeper into the flows, like the service locator and payment flows, they’ll need to understand requirements for those flows.
- Without those specific requirements, the design risks under allocating resources for key flows or over allocating resources for lower priority flows.

*Applying the approach and outcomes*

- After reviewing user flows with the business, the architecture team now has very specific targets documented for each flow.  The decomposition of the workload now takes into account the aspirational-to-unacceptable range per flow.
- The architects will strive to hit aspirational targets with their design to allow room for the system to develop over time with additional features, while compromising some degree to keep cost and other non-functional requirements under control.
- The team is able to complete the design around the targets that have been agreed upon and now the implementation team will be responsible for making sure those limits are honored and raising any concerns if they can’t be achieved with the design they’re working from.
