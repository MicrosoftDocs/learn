| :::image type="icon" source="../media/goal.svg"::: Optimize productivity by setting clear development practices, enforcing quality gates, and tracking progress and success through systematic change management. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The development team is in charge of sorting out workload problems before release, and they aim to do it with as little friction as possible. It’s important to keep things efficient and move quickly from coding to testing. Implement effective and right-sized processes to plan technical work, keep things consistent, and make sure everyone, both the team and stakeholders, is aligned.

**Example scenario**

Contoso Ticketing is a small startup that provides a ticketing line-of-business SaaS solution for mid-sized companies. Getting new customers set up can be tricky because it often involves customizing the product and doing some custom development to fit their setup. The implementation team uses Azure DevOps to collaborate and deliver work, but they don’t follow a formal development process.

## Adopt industry standards for development

**Use an industry standard software development methodology that fits your team and workload. Keep a shared backlog so everyone’s in sync.**

A well-known development method helps set the pace for the project and gives everyone clear roles and expectations.

When the whole team tracks work from the same list, it’s easier to prioritize and stay organized, which makes it more likely that the project finishes on time.

These methods also help manage risks. Regular milestone check-ins give developers a chance to catch and fix problems early, before they turn into bigger problems.

*Contoso's challenge*

- The company’s main product is getting more popular, and now the integration team is juggling more customer projects than ever. To keep up, they’ve had to grow the team.

- With more people and no formal processes in place, things have gotten a bit messy. Communication isn’t always clear, meetings aren’t very productive, and development cycles are infrequent and unscheduled. Several onboarding projects are now running behind, and leadership has asked the team to make changes to get things back on track.

*Applying the approach and outcomes*

- To help fix the issues they’ve been facing, the team decides to start using a Scrum methodology, a popular agile framework for software development.

- Scrum gives the team a clear structure to follow, with defined roles, events, artifacts, and rules, regular check-ins, and a shared backlog. Working in short sprints helps everyone stay aligned and deliver value to customers more consistently.

## Shift left for testing

Use quality assurance processes to make sure testing starts early in the development process. In your test plans, include everything, like app features, infrastructure, and data-related tasks, that's part of feature releases or updates.

**Have quality assurance processes that emphasize testing early in the development lifecycle. Include all artifacts for planned test procedures, including application components, infrastructure, and data plane operations that are part of a feature release or update.**

Treat artifacts as immutable when they're promoted through environments, gaining confidence each time they pass through a quality gate.

Where practical, automate routine checks.

Quality assurance ensures that functional and nonfunctional requirements were met with confidence, which leads to positive customer impact.

*Contoso's challenge*

- The workload team uses both automated and manual testing, but they don’t test aspects like performance, security, and usability. Also, their code deployment isn’t fully automated across environments, which can lead to inconsistencies and surprises.

- With more customers and complicated onboarding, their testing struggles have gotten worse. Bugs are occurring more often, there’s a lot of rework, and customers aren’t too happy.

*Applying the approach and outcomes*

- The workload team is improving how they test and deploy code to make pipelines more reliable and consistent.

- They’ve started writing test plans for each feature or customization, covering both what the feature does and how well it performs. They’re using Azure DevOps to keep track of test cases, data, and results. They also added quality checks in their deployment pipelines to verify the quality of the code, configuration, and deployment before moving code to the next environment.

- Since making these changes, they’ve seen fewer failed deployments, fewer bugs in production, and happier customers. Things are running smoother and faster now.

## Measure development efficiency

**Report progress and trends to measure efficiency. Track and report on trends in bugs, failed updates, deployment times, and feedback loops to drive improvements in your development practices.**

*Contoso's challenge*

- The workload team recently rolled out several changes to make customer onboarding better and more predictable. But right now, it’s tough to tell how much of a difference those changes are actually making. There’s no reliable data or metrics to show how much quality and predictability has improved, or which updates are making a real difference.

- To keep making smart decisions and focus efforts where they count, the company needs a better way to measure and share the impact of these process improvements.

*Applying the approach and outcomes*

- The team decides to start using the reporting tools in Azure DevOps, which they're already using, to help track improvements over time and figure out where to focus resources going forward.

- They start by making use of several out-of-the-box reports:
    - Velocity reports
    - Cumulative flow diagrams
    - Bug trends, including how many bugs are created, resolved, and closed over time, and how they affect quality metrics
    - Deployment stats, including how long it takes to deliver software from code to production and how it compares to targets and benchmarks
- The team also plans to develop custom reports by using the Azure DevOps dashboards and Power BI Analytics in the near future.