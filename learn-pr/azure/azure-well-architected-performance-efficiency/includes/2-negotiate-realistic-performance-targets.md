| :::image type="icon" source="../media/goal.svg"::: Have a clear idea of the user experience that you're aiming for. Create a benchmark and measure progress against the business requirements that you set. |
| :----------------------------------------------------------------------------------------------------------------------------- |

From a performance angle, it's best to kick off your design process with clear performance targets. To set those up, you'll need a solid understanding of what the business needs and the level of service that the workload is expected to deliver. Work with the business stakeholders to define those expectations together. Instead of just focusing on technical metrics, think about what kind of impact is acceptable on the user experience, especially for the most important flows.

There's a bit of a loop here. You can't measure what you haven't defined, and you can't define much without some measurement. That's why it's important to keep tracking how the workload performs until everyone agrees on what counts as an acceptable threshold.

Performance and reliability targets go hand in hand. They both help shape the quality of service when it comes to performance, availability, and resilience. Without a clear definition, it's tough to measure, set up alerts, or run tests for performance. After you define your targets and figure out the actual numbers through testing over time, you can start automating tests to keep checking against those targets.

Stick to best practices when you're defining targets at a high level, even if they're just rough estimates or ranges to start with.

**Example scenario**

Contoso Bicycle is a direct-to-consumer bike brand based in the United States. Their development team started work on a new app to support their upcoming mobile bike repair service. Right now, the app is in the proof of concept (POC) stage. Technicians will use a mobile app to handle their schedules, manage work orders, and take payments. On the customer side, there will be a website where people can book service appointments. The web app, mobile app, and back-end API will likely be hosted on Azure App Service.

## Prepare to negotiate performance targets

**To get ready for negotiation, it helps to really understand the technical details, explore what's possible with the infrastructure that you have, and lean on results from any hands-on testing that you've done. Use historical data to give you a clearer picture of usage patterns and where the bottlenecks are. It's also smart to bring in outside perspectives, such as insights from market research, advice from experts, or guidance based on industry standards.**

You can make smart decisions by leaning on insights that come from real-world experience.

Performance targets focus on the user experience, and they're shaped by what's realistic, what's considered best practice in the industry, and what's trending in the market right now.

*Contoso's challenge*

- When the team has talked about the app with business stakeholders, performance hasn't really come up yet.

- The development team is new to Azure, so they're not too familiar with how performance and scaling work on the platform.
- Without clear direction from stakeholders or hands-on experience with what Azure can do, the team is a bit nervous that they'll have to deploy infrastructure for testing and then end up rebuilding it later.
- They're also concerned that when everyone meets next, no one will be ready to have a real conversation about what realistic performance targets should look like.

*Applying the approach and outcomes*

- The Contoso Bicycle business analysts and developers talked through their concerns and came up with a plan. The business analysts would dig into performance expectations by doing some competitive research and informal polling, while the development team would look into what Azure can do and explore the different pricing tiers.

- When the teams got back together with the business stakeholders, they brought all the data they gathered and used it as the starting point for a real conversation about performance targets. After talking through what kind of performance they could expect and what the costs might look like, everyone walked away feeling confident that App Service was the right fit for the workload.

## Negotiate performance targets effectively

**Work with the business owners to get a clear picture of what's being promised to users, especially when it comes to quality and any regulatory requirements that might apply. Keep your view broad for now. This isn't the time to get into the details. Be upfront about what counts as acceptable performance, based on the investment being made. Make sure you understand the bigger business picture and where growth is expected.**

Taking this approach helps you steer clear of assumptions that might not line up with what the business actually needs. It also brings more clarity and energy to the workload team.

When you understand the business context, including both functional and nonfunctional requirements, you might find opportunities to tweak the design in other areas of the Azure Well-Architected Framework. That kind of insight helps you make smarter trade-offs.

Defining those parameters early on can save you from the cost and hassle of having to redesign the solution later. It also makes sure your performance targets aren't just about today. They're set up to support where the workload is headed in the future, so your current work stays aligned with long-term goals.

*Contoso's challenge*

- The architecture team has a general sense of what might be acceptable, but they don't have any specifics yet. They feel pretty confident that their choice of application platform will help them avoid rework, but they'd feel a lot better if they had more concrete details to go on.

- So far, performance conversations have been pretty vague, such as "The website needs to be fast." That insight isn't super helpful when it comes to making design decisions.
- Without more clarity, the architects worry that they might end up over-engineering the solution just to be safe, or run into delays that could push back the production release.

*Applying the approach and outcomes*

- The business partners and the technical team got together to agree on some general but realistic performance targets, along with a few hard limits that absolutely need to be avoided. With that clarity, the architects can move forward with POCs as part of their early design work. That gives them a chance to validate their choice of application platform and share some early findings around performance and pricing.

- One big takeaway from the meeting was learning that Contoso Bicycle plans to operate only in the southwest United States during the first year, with plans to expand nationwide in year two. That kind of detail is super helpful and will definitely be factored into the design.

## Design with a flow-centric focus

**Map out the different flows in your workload, and figure out which ones matter most. Highlight those flows in your architecture diagram. For each flow, define a performance range from what you'd ideally want to what would be totally unacceptable. Take a close look at where each flow starts and ends. Think about how critical that path is, how often it's used, and how complex it is from an architectural standpoint.**

When you prioritize workload flows, you're making sure that your time and resources go toward the areas that really affect the user experience and business results.

Breaking the system down into its parts and understanding how they depend on each other helps you see what each component does and how it affects performance. It also gives you a heads-up on where problems might happen.

This kind of analysis helps you set a good performance baseline and gives you a clear starting point for making improvements.

*Contoso's challenge*

- So far, the technical team has worked with stakeholders to agree on some high-level performance targets, but they haven't focused on specific flows yet. For the design team to dig into flows like the service locator and payment flows, they'll need to know what's expected for each one.

- Without those details, there's a risk that the design could miss the mark, either by not giving enough resources to the flows that really matter or by overbuilding for flows that aren't as critical.

*Applying the approach and outcomes*

- After going over the user flows with the business team, the architecture team now has clear, detailed targets written down for each one. They've broken down the workload in a way that reflects the full range of performance expectations for each flow, from an aspirational range to an unacceptable range.

- The architects are aiming for those aspirational targets in their design so the system has room to grow and support new features later on. At the same time, they're being mindful of cost and other nonfunctional requirements, so they're making some trade-offs where it makes sense.
- With those targets locked in, the design is now complete. It's up to the implementation team to stick to those limits and speak up if they run into anything that makes the targets hard to reach with the current design.
