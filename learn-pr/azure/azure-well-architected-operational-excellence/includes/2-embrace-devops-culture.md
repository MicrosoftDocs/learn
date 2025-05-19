| :::image type="icon" source="../media/goal.svg"::: Help development and operations teams work better together by encouraging collaboration, shared responsibility, and ownership, so they can keep improving how their systems and processes run. |
| :----------------------------------------------------------------------------------------------------------------------------- |

DevOps is all about teamwork, bringing together people with different skills and perspectives to work toward a shared goal. Instead of keeping knowledge siloed, teams should create a space where everyone learns from each other. Sharing tools and responsibilities can also help stretch limited resources further.

A strong DevOps culture thrives on shared responsibility. Development and operations teams should be on the same page about goals and priorities, and always keep the customer in mind. Development teams should involve the operations team in the feedback loop so other teams can also benefit from improvements. And in return, operations teams should support development teams by sharing helpful insights and resources that make it easier to reach business goals.

DevOps helps make everyday operations smoother and less stressful. To get the most out of DevOps, teams should use tech to streamline their processes and create a culture where open communication is the norm.

At the same time, DevOps makes it clear who’s responsible for what. No matter where the app runs, the workload team is responsible for it.

**Example scenario**

Contoso's human resources (HR) department is kicking off a project to develop a new line-of-business (LOB) app for their department's internal use. The app is currently in the planning phase, no design or implementation work has started yet.

## Collaborate efficiently

**Use common systems and tools so that everyone can easily communicate and track progress.**

Common tools and processes help everyone stay in the loop. Both development and operations teams can see what occurs across various environments, including what’s working, what’s not, and what needs attention.

If an incident occurs, teams already know about the existing escalation paths.

A shared backlog clearly lays out the next task, such as working on new features or fixing bugs.

*Contoso's challenge*

- Contoso has three technical teams, development, test, and operations, to development and maintain the new app. Right now, they all use different tools to communicate and track work.

- Historically, each team has been able to select their tools of choice. For internal messaging, some use Slack or Microsoft Teams. To track tasks, some use Azure DevOps or Excel. Each team uses a different document repository to share knowledge and incident response procedures. 
- In past projects, the overall technical organization has struggled with communications and collaboration due to the disparate tools being used. Going forward, Contoso HR would like to improve productivity and avoid situations that could slow down the project, like those encountered previously.

*Applying the approach and outcomes*
T
- Leads from the technical teams met with the project sponsors to choose the standard tools that will be used going forward. The group chose Azure DevOps to manage their backlog, code repository, and deployment pipeline. They also chose Microsoft Teams for communications and collaboration.

- Using a common set of tools allows the development, operations, and test teams to stay informed and in-synch about the status of the various environments, common project issues, and team achievements. Moreover, teams can access information about established escalation paths in case of incidents from a single well-known location.
- A shared backlog also helps to uniformly plan and stay aligned on priorities, such as developing new features or fixing bugs. 

## Embrace continuous improvement

**Build a continuous learning and experimentation mindset throughout the development cycle. Support knowledge sharing across teams and maintain documentation for reuse. And, conduct blameless analysis and debrief post-release and/or post-incident reviews.**

Through experimentation mechanisms, such as A/B testing and developing proofs of concept, you can encourage innovation while keeping costs low.

Share knowledge through collaboration that makes the team proficient in design approaches, tooling, and processes.

Doing retrospectives after a project helps identify areas for improvement and celebrate success.

*Contoso's challenge*

- To further facilitate information sharing and to foster a culture of collaboration and transparency, the team would like to have a centralized and easily accessible source of truth for the project documentation. Among other things, this would be helpful if a new developer joins the team and needs to quickly get up to speed with the project.

- Of particular interest for Contoso HR is a desire to make sure learnings from incidents that affect the availability of the application are captured and shared across the entire technical organization to help with future incidents and prevent recurrence as much as possible.
- To avoid repeating past mistakes designing the user experience of the application, the team also wants to use a more agile approach that would allow them to take real user feedback into consideration.

*Applying the approach and outcomes*

- The team builds a knowledge sharing wiki in Azure DevOps where all design specs will be posted along with all active operational procedures, incident response plans, and retrospective outcomes.

- Doing blameless retrospectives after incidents and every development iteration and documenting the learnings in the wiki is helping the project team to identify areas for improvement and celebrate success.
- The team has embraced an exploratory approach to the user experience design for the new application, leveraging A/B testing to find the best user experience out of several variants proposed by the UX consultants, taking user feedback into consideration to make data-driven decisions. 

## Codify development and operations procedures

**Set standards for all development and operational procedures and review and validate them at a regular cadence. These procedures include routine tasks, out-of-band processes, emergency drills and situations, choice of tooling, monitoring procedures, skilling plans, and even communication with stakeholders and customer disclosures. Be intentional and explicit about your decisions.**

Standards add predictability to operations and make processes and practices scalable. Validating standards is a great way to draw points of improvement.

Be prepared for emergency and recovery situations by conducting regular drills.

Execute with precision and enable governance to prevent anomalies that lead to risks.

*Contoso's challenge*

- One of the challenges that has affected the productivity and output quality of the development team in the past is a lack of standardization and consistency in the codebase. For instance, the absence of uniformity in naming conventions or the use of common software patterns makes it difficult for team members to understand each other's code, and that has affected efficiency.

- Also, without a properly documented common approach for operations, the operations staff may use different methods to achieve the same goal, leading to inefficiency and confusion.
- Motivated by the success they have had implementing other DevOps improvements, Contoso HR has decided to tackle this issue as part of the next development cycle.

*Applying the approach and outcomes*

- The development team gets together during the development cycle to agree on a set of development standards to implement. They will document the choices made and will start enforcing them during code reviews and through tooling. They are looking at topics like: Code Formatting and naming conventions, error handling, version control, and security practices. The team plans to pay close attention to the quality metrics and reports being generated in ADO to quantify the impact these changes will have on quality and productivity, so they can prove the value of these kinds of DevOps improvements to their management team.

- Likewise, the operations team dedicates time during the same period to extend their existing documentation of routine management and troubleshooting practices and publish it in the wiki. Moving forward, the wiki will serve as a single source of truth, saving time and energy that would otherwise be spent searching for information.