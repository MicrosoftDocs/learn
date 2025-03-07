We used the term *agile* in the previous module to describe one of the essential elements of DevOps culture, representing the ability to rapidly respond to customer feedback and needs. This term also appeared several times in the unit describing the correlation between DevOps and the application lifecycle. However, there's also another, more specific meaning of *Agile* (in the capitalized format), which describes an approach to software development and project management. Such an approach is commonly associated with DevOps practices. In our sample scenario, transitioning from the traditional Waterfall approach to Agile would help the organization realize a range of DevOps benefits. In this unit, explore the primary characteristics of Agile and examine its correlation with DevOps.

:::image type="content" source="../media/3-agile-methods.png" alt-text="Diagram showing a cycle around a Kanban board.":::

## Agile principles and values

Agile is an approach to software development that promotes team collaboration, continuous improvement, and automation, with the ultimate goal of faster, more reliable, and customer-centric software delivery. The term originated from the Agile Manifesto, created in 2001 by a group of software developers, providing a set of guiding principles for modern software development. The manifesto included four foundational statements that prioritized individuals and interactions, working solutions, and customer collaboration over rigid processes and tools. In particular, these statements assigned more value to:

- Individuals and interactions over processes and tools.
- Working software over comprehensive documentation.
- Customer collaboration over contract negotiation.
- Responding to change over following a plan.

## Agile methods and practices

The Agile Manifesto and Agile principles provide a set of values and guidelines, but they're intentionally not prescriptive in terms of specific methods and practices. Instead, Agile is meant to be flexible and easily adaptable, allowing organizations and teams to choose a more detailed approach according to their preferences and needs.

These detailed, comprehensive approaches are commonly referred to as frameworks. Their purpose is to cover all phases of the DevOps lifecycle, including planning, development, delivery, and operations. Some of the more popular Agile frameworks include Scrum and Kanban.

## What is Scrum?

Scrum is a framework used by teams to manage work and solve problems collaboratively in short (typically between one and four weeks long) iterations called sprints. To facilitate collaboration and progress, sprints are structured based on events, artifacts, and roles.

- **Events**, commonly referred to as ceremonies, include meetings taking place daily (Daily Scrum, typically limited to 15 minutes, also known as daily standup) and at the beginning and end of each sprint (Sprint Planning, Sprint Review, and Sprint Retrospective).
- **Artifacts** define a prioritized list of features, enhancements, and fixes to develop. Such artifacts might cover the span of a project or a sprint (Product Backlog or Sprint Backlog, respectively), or they might aid Daily Scrum meetings (task boards and sprint burndown charts). A task board provides a visual way to track the progress of each backlog item. It displays backlog items divided into the tasks required to complete it. Tasks are placed in separate columns (labeled *To do*, *In progress*, and *Done*) based on their status. The sprint burndown chart serves as a visual indicator of whether the team is on track to complete its assigned work by the end of the sprint. It consists of a graph that displays the daily total of remaining work, typically shown in hours.
- **Roles** include the product owner, Scrum master, and Scrum team, each with its clearly defined responsibilities. The product owner represents the project stakeholders and is responsible for defining, maintaining, and prioritizing the product backlog. The Scrum master oversees the Scrum process, looking for areas for improvements, resolving any blocking issues, and ensuring that the Scrum principles are followed. The Scrum team is responsible for building the product, with the ownership of its engineering and quality components.

:::image type="content" source="../media/3-agile-scrum-lifecycle-diagram.png" alt-text="Diagram showing Agile Scrum lifecycle.":::

In the Sprint Planning event, the team chooses backlog items to work on during the upcoming sprint. The selection is made based on priority and an estimated amount of work required to complete an item. The metric called *velocity* is used to measure the amount of work a team can complete in a given sprint. Once the sprint execution starts, the team decides how to work on the Sprint Backlog items. During Sprint review, the team demonstrates their accomplishments to stakeholders. Sprint retrospective is part of continuous learning. It serves as the opportunity to review the most recently completed sprint, identify areas for improvement, and help determine the list of actions for the next sprint.

## What is Kanban?

:::image type="content" source="../media/3-what-is-kanban.png" alt-text="Diagram showing a Kanban board representation with multiple columns.":::

Kanban is the Japanese word for a signboard or billboard. In the context of Agile, the concept of Kanban has been conceived as a means for improving the efficiency of manufacturing processes, but, in recent years, it became prevalent in software development projects.

The key principle of this approach is visualization of project-related work in the form of *Kanban boards*. These can be physical boards or software applications that display cards arranged into columns representing the status of individual project items. Commonly used column names include **To-do**, **Doing**, and **Done**, although teams can customize them to accurately reflect all relevant stages in a project delivery workflow (such as development and testing). Visualizing work as cards in different states on a board simplifies the assessment of project status and identifying potential productivity issues.

:::image type="content" source="../media/3-agile-kanban-board-sample.png" alt-text="Diagram showing a Kanban board with three columns including To do, doing, and done.":::

These cards correspond to product backlog items in the Scrum framework. The cards can be customized to include references to other items in the product delivery process, such as tasks and test cases.

While the concept of a backlog is common in Kanban and Scrum, it's important to note that Kanban is more flexible and doesn't involve iterations. Work items can be added, reprioritized, or removed from the backlog based on the team's capacity and the changing needs of the project or service being managed with Kanban.

:::image type="content" source="../media/3-kanban-pull-model.png" alt-text="Diagram showing a Kanban board with people pulling work from the backlog.":::

In particular, Kanban promotes the use of a pull model, in which stakeholders add requests to the backlog list of tasks, items, or work that needs to be completed. The development team selects items from the backlog and adds them into the active work process depending on their priority and the team's resources availability. This minimizes the quality issues associated with the pull model, in which stakeholders arbitrarily assign work to development teams, frequently with unrealistic deadlines. In addition, to optimize productivity, Kanban supports imposing limits on the number of items that the development team is currently working on, referred to as *work in progress*  or simply *WIP*.

Kanban framework also relies on *lead time* and *cycle time* metrics to measure effectiveness and throughput of its workflow. Lead time is the total time it takes for a work item to transition from its inception until its delivery to the customer. Cycle time represents the duration of the actual work on an item once it has been pulled into the active work state.

Another commonly used component of Kanban is a *cumulative flow diagram (CFD)*. It's a chart that illustrates the number of items in each state over time, typically across several weeks. It resembles a stacked time series chart, with the horizontal axis representing the timeline and the vertical axis representing the cumulative number of work items. Each state is displayed as a differently colored area, facilitating identifying trends in backlog item processing. An increase in size of one or more colored areas typically indicates an issue in the workflow, such as a bottleneck or inefficiency.

:::image type="content" source="../media/3-agile-kanban-cumulative-flow-diagram.png" alt-text="Diagram showing sample Kanban cumulative flow diagram with an indication of a likely issue.":::

## What are the differences between Scrum and Kanban?

Both Scrum and Kanban are considered to be Agile frameworks with the common goal of improving the efficiency and effectiveness of software development. However, each of them offers a different approach to reaching this goal, including their respective principles and practices. In particular:

- **Work cadence**: Scrum uses fixed-length sprints, while Kanban operates based on a continuous flow model, with work being pulled by development teams according to the availability of their resources.
- **Roles and ceremonies**: Scrum has clearly defined roles and ceremonies, while Kanban doesn't prescribe any, instead allowing teams to adapt these according to their specific needs.
- **Work planning**: Scrum uses a prioritized backlog with work committed to during sprint planning. Kanban uses a dynamic backlog, with no commitments for a specific period. In addition, Kanban supports the concept of WIP limits.
- **Adaptability to change**: Scrum discourages changes to committed work during the sprint. Kanban facilitates adaptation to changes at any point.
- **Visualizations**: Scrum uses sprint boards and burndown charts. Kanban relies on Kanban boards.
- **Metrics**: Scrum uses sprint-related metrics such as velocity and burndown charts. Kanban emphasizes such metrics as lead time and cycle time.
