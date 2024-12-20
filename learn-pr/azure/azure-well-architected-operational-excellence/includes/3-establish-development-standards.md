| :::image type="icon" source="../media/goal.svg"::: Optimize productivity by standardizing development practices, enforcing quality gates, and tracking progress and success through systematic change management. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The development team is responsible for addressing workload issues prior to release with minimal friction. Be mindful of developer efficiency and optimize for fast turnaround cycles, from coding to testing results. Implement effective and right-sized processes that plan and standardize technical activities and also drive consensus within the team and the stakeholders.

**Example scenario**

Contoso Ticketing is a small startup that provides a ticketing line of business (LOB) SAAS solution for mid-size companies. Onboarding of new customers is a complex process that requires product customizations and custom development to integrate with the customer’s environment. The implementation team uses Azure DevOps as a platform for collaboration and delivery, but it does not follow any formal development methodology.

## Adopt industry standards for development

**Use an industry standard software development methodology that's appropriately tuned for the needs of your workload and team size. Maintain a backlog that's shared among all roles.**

Adoption of a well-known methodology sets the rhythm of the project. It removes process ambiguities by giving team members clear expectations and accountability.

By tracking against a common list, tasks can be refined and prioritized with standard practices. The project will have better chances of being delivered on time.

Standard methodologies help with risk management. With granular milestone reviews, developers can address potential issues before they become showstoppers.

*Contoso's challenge*

- The company’s main product has been gaining popularity and the integration team is now working on more simultaneous implementation projects than ever. To keep up with the increased workload, the team has had to increase its headcount.
- The team’s growth, paired with the lack of formal processes has led to some challenges, such as unclear communication among team members, random and unproductive meetings, and infrequent and unscheduled development cycles. Several of the onboarding projects are now behind schedule and the company’s leadership has asked the team to make the necessary changes to correct the situation. 

*Applying the approach and outcomes*

- To overcome these challenges, the team decides to adopt a scrum methodology, a popular agile framework for software development.
- Scrum will help the team address some of the issues it is facing. Among other things, Scrum provides a clear and consistent structure for the development process, with predefined roles, events, artifacts, and rules. A shared backlog and a cadence of short development sprints would help the team work on a shared vision and deliver value to the customers regularly and reliably.

## Shift left for testing

**Have quality assurance processes that emphasize testing early in the development lifecycle. Include all artifacts for planned test procedures, including application components, infrastructure, and data plane operations that are part of a feature release or update.**

Treat artifacts as immutable when they're promoted through environments, gaining confidence each time they pass through a quality gate.

Where practical, automate routine checks.

Quality assurance ensures that functional and nonfunctional requirements were met with confidence, which leads to positive customer impact.

*Contoso's challenge*

- The workload team's functional testing strategy uses a combination of automated and manual testing. Their testing approach does not cover all aspects of the system, such as performance, security, and usability. They also do not have a consistent way of deploying their code to different environments in a fully automated manner, which introduces variability and uncertainty. 
- The increase in the volume and complexity of the customer onboarding efforts has amplified the challenges of their testing strategy, leading to frequent bugs, rework, and customer dissatisfaction.  

*Applying the approach and outcomes*

- The workload team embarks on an effort to improve their testing strategy and to increase the consistency and predictability of their deployment pipelines.
- They start by creating test plans for each feature or customization under development, covering both functional and nonfunctional requirements. They use Azure DevOps to manage their test cases, test data, and test results. They set up quality gates in their deployment pipelines that verify the quality of the code, the configuration, and the deployment before promoting the artifacts to the next environment. 
- After implementing these improvements, the team sees a decrease in the number of failed deployments, as well as the number of bugs and incidents in production. As a result, quality, delivery speed, and customer satisfaction have increased substantially. 

## Measure development efficiency

**Report progress and trends to measure efficiency. Track and report on trends in bugs, failed updates, time to deploy and feedback loops to drive improvements in your development practices.**

*Contoso's challenge*

- The workload team has recently implemented several changes to enhance the quality and predictability of the customer onboarding processes. However, the company faces a challenge in measuring and reporting the impact of these changes. Unfortunately, the company does not have reliable data or metrics to show how much the quality and predictability have improved, or which changes have contributed to the improvement more than others.
- The company needs a way to quantify and communicate the benefits of its process investments, so that it can prioritize its resources and efforts in the future. 

*Applying the approach and outcomes*

- The team decides to start taking advantage of the reporting capabilities in AzDO, which the team is already using, to be able to quantify improvements over time and prioritize resource allocation for future investments.
- They start by making use of several out-of-the-box reports:
    - Velocity reports
    - Cumulative flow diagrams
    - Bug trends: how many bugs are created, resolved, and closed over time, and how they affect quality metrics.
    - Deployment stats: how long it takes to deliver software from code to production, and how it compares to targets and benchmarks.
- The team also plans to develop customized reports with Dashboard and Power BI Analytics reports in the near future.