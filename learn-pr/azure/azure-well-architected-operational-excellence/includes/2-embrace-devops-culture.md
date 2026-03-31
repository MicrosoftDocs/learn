| :::image type="icon" source="../media/goal.svg"::: Help development and operations teams work better together by encouraging collaboration, shared responsibility, and ownership, so they can keep improving how their systems and processes run. |
| :----------------------------------------------------------------------------------------------------------------------------- |

DevOps is all about bringing together people that have different skills and perspectives to work toward a shared goal. Instead of keeping knowledge siloed, teams should create a space where everyone learns from each other. Sharing tools and responsibilities can also help stretch limited resources further.

A strong DevOps culture thrives on shared responsibility. Development and operations teams should be on the same page about goals and priorities, and always keep the customer in mind. Development teams should involve the operations team in the feedback loop so other teams can also benefit from improvements. And in return, operations teams should support development teams by sharing helpful insights and resources that make it easier to reach business goals.

DevOps helps make everyday operations smoother and less stressful. To get the most out of DevOps, teams should use technology to streamline their processes and create a culture where open communication is the norm.

DevOps makes it clear who's responsible for what. No matter where the app runs, the workload team is responsible for its performance and reliability.

**Example scenario**

Contoso's human resources (HR) department is kicking off a project to develop a new line-of-business (LOB) app for their department's internal use. The app is currently in the planning phase. No design or implementation work has started yet.

## Collaborate efficiently

**Use common systems and tools so that everyone can easily communicate and track progress.**

Common tools and processes help everyone stay in the loop. Both development and operations teams can see what occurs across various environments, including what's working, what's not, and what needs attention.

If an incident occurs, teams already know about the existing escalation paths.

A shared backlog clearly lays out the next task, such as working on new features or fixing bugs.

*Contoso's challenge*

- Contoso has three technical teams, development, test, and operations teams, to development and maintain the new app. Right now, they all use different tools to communicate and track work.

- Historically, each team has selected their tools of choice. For internal messaging, some teams use Slack or Microsoft Teams. To track tasks, some teams use Azure DevOps or Excel. Each team uses a different document repository to share knowledge and incident response procedures. 
- In past projects, the overall technical organization had a tough time communicating and working together because everyone was using different tools. Moving forward, Contoso HR wants to boost productivity and avoid the kinds of slowdowns that they've seen before.

*Applying the approach and outcomes*

- Technical leads got together with the project sponsors to choose the standard tools that will be used going forward. The group chose Azure DevOps to manage their backlog, code repository, and deployment pipeline. They chose Teams for communications and collaboration.

- When everyone uses the same tools, it's easier for the development, operations, and test teams to stay on the same page about what's happening, like environment status, project problems, and team achievements. Plus, if something goes wrong, everyone knows exactly where to go to find the escalation steps.
- A shared backlog makes it easier for everyone to plan together and stay focused on what matters most, whether that's building new features or fixing bugs.

## Embrace continuous improvement

**Encourage a mindset of continuous learning and experimentation throughout the development cycle. Make it easy for teams to share knowledge and keep documentation handy for future use. And when something goes wrong, hold a blameless review to understand what happened and how to improve.**

Trying experiments, like A/B testing or building proofs of concept, is a great way to spark new ideas without spending a lot.

Share knowledge through collaboration to help the team get better at design approaches, tooling, and processes.

And after a project wraps up, doing a quick retrospective helps spot ways to improve and gives the team a chance to celebrate success.

*Contoso's challenge*

- The team wants to make it easier to share information and work together by keeping all project documents in one easy-to-find place. So if a new developer joins the team, they can get up to speed quickly.

- Contoso HR also wants to make sure that when something goes wrong and affects the app's availability, the lessons learned are shared across the whole technical organization to help prevent it from happening again.

- To avoid past mistakes with the app's user experience, the team wants to take a more agile approach. They want to get real feedback from users and adjust as they go.

*Applying the approach and outcomes*

- The team sets up a wiki in Azure DevOps to keep everything in one place, including design specs, operational procedures, incident response plans, and retrospective outcomes.

- After each incident or development cycle, they do a blameless retrospective and add what they learned to the wiki. It's been a great way to find areas to improve and reflect on the progress that they've made.
- For the new app's user experience, the team is taking an exploratory approach. They're using A/B testing to try out different ideas from the UX consultants and using real user feedback to make smart, data-driven choices.

## Codify development and operations procedures

**Set clear standards for how development and operations should be done, and check in on them regularly to make sure they still make sense. These procedure should include everyday tasks, emergency plans, tool choices, monitoring, training, and even communication with stakeholders and customers. Be clear and intentional about the decisions you make.**

Clear standards make things run more smoothly and help the team scale. Reviewing them regularly is a great way to figure out what could be better.

Run regular emergency drills so the team's ready for emergencies and recovery.

Focus on doing things right and having good checks in place to catch problems early and avoid risks.

*Contoso's challenge*

- One thing that's slowed the development team down in the past is not having consistent standards in the codebase. Without shared naming conventions or common patterns, it's harder for team members to understand each other's code, which hurts productivity.

- If operations doesn't have a clear, documented way of doing things, people end up using different methods to get the same job done, which can lead to confusion and inefficiency.
- After seeing good results from other DevOps improvements, Contoso HR is ready to tackle these problems next in the upcoming development cycle.

*Applying the approach and outcomes*

- During the development cycle, the team gets together to agree on a set of coding standards. They write down their decisions and start using them in code reviews and tools. They're focusing on things like formatting, naming, error handling, version control, and security. They plan to pay close attention to quality metrics and reports in Azure DevOps to see how these changes affect productivity and code quality. They can show the value of these DevOps improvements to leadership.

- The operations team is also using this time to update and expand their documentation about how they handle day-to-day tasks and troubleshooting. They're putting everything in the team wiki so it's easy to find and everyone's working from the same place. This practice should save time and reduce confusion going forward.
