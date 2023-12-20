| :::image type="icon" source="../media/goal.svg"::: Empower development and operations teams to continuously improve their system design and processes by working together with a mindset of collaboration, shared responsibility, and ownership. |
| :----------------------------------------------------------------------------------------------------------------------------- |

DevOps is a community of practice where diversity of perspective and skills drives toward one mission. Teams must foster a collaborative environment of shared knowledge instead of siloed learning. Use shared functions to strive to overcome resource constraints.

A good DevOps culture thrives on shared responsibility. Development and operations teams should align their goals and priorities with the expectations of their customers and keep business focus in mind. The development team should involve the operations team in the feedback loop so the improvements are driven upstream and other teams benefit equally. Conversely, operations teams are responsible for making the development team successful in their business outcomes by sharing resources and feedback that are relevant to the workload.

At the same time, DevOps practices apply clear lines of ownership and accountability to each team. Regardless of where the application runs, the workload team is responsible for that application.

DevOps optimizes operational tasks so that they're effective but not burdensome. To reap the full benefit of DevOps, the culture should optimize processes through technology and have processes for people in the organization to promote transparent communication.

**Example scenario**

Contoso's Human Resources (HR) department is kicking off a project to develop a new line-of-business (LOB) app for their department's internal use. The app is currently in the planning phase, no design or implementation work has begun yet.

## Collaborate efficiently

**Use common systems and tools that promote a collaborative environment for communication and tracking progress.**

Common tools and processes enable transparent communication. Both development and operations teams benefit from situational awareness across various environments, common support issues, and overall challenges and wins.

Teams will already be familiar with existing escalation paths if there's an incident.

A shared backlog makes priorities, such as working on new features or fixing bugs, clear.

*Contoso's challenge*

- Contoso has three technical teams that will be involved in the development and maintenance of the new app:  development, test, and operations. Currently, there are no standard communication and project tracking tools that are consistently used across those teams.
- Historically, each team has been able to select their tools of choice. Some use Slack, while others use Microsoft Teams for internal messaging. Some use Azure DevOps (ADO) and others use Excel to track tasks, and each team uses a different document repository from the rest to share knowledge and incident response procedures. 
- In past projects, the overall technical organization has struggled with communications and collaboration due to the disparate tools being used. Going forward, Contoso HR would like to improve productivity and avoid situations that could slow down the project, like those encountered previously.

*Applying the approach and outcomes*

- Leads from the technical teams met with the project sponsors to choose the standard tools that will be used going forward. The group chose ADO to manage their backlog, code repository, and deployment pipeline. They also chose Microsoft Teams for communications and collaboration. 
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

- The team builds a knowledge sharing wiki in ADO where all design specs will be posted along with all active operational procedures, incident response plans, and retrospective outcomes.
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