Both GitHub and Azure DevOps support a range of DevOps planning capabilities. Considering that the organization in the sample scenario plans to rely on GitHub for its DevOps transition, with focus on the former. In particular, explore GitHub Projects and Project Boards, available to all GitHub customers.

## What are GitHub Projects?

GitHub Projects is a feature hosted by the GitHub platform providing the ability to organize, track and manage work in a collaborative and visual manner. This feature is suitable for managing software development lifecycle, although it can be used in practically any scenario that involves project-related work. It closely integrates with other GitHub components such as repositories, issues, and pull requests. It provides a way to plan, track progress, and coordinate tasks within a repository and across repositories.

:::image type="content" source="../media/5-github-projects.png " alt-text="Screenshot of GitHub Projects.":::

Each project is automatically accessible in the table, board, and roadmap layout. You also have the option of creating views by filtering, grouping, and sorting components included in the project, generating configurable charts, and adding custom fields based on your individual preferences or needs.

GitHub Projects support milestones, which represent target dates of specific goals or deliverables. Milestones implement a timeline for the project and allow teams to track their progress.

Projects include built-in workflows that you can use to update the status of items based on predefined events, such as automatically setting the status of a newly created issue to *Todo* or automatically setting the status to *Done* when the issue is closed. By default, two workflows are enabled in a newly created project:

- When issues or pull requests in your project are closed, their status is set to *Done*
- When pull requests in your project are merged, their status is set to *Done*.

## What is a GitHub Projects board?

A GitHub Projects board offers a visual representation of the corresponding project. It's accessible via the board layout and supports a Kanban experience. It consists of columns and cards that allow you to organize and track issues and pull requests. Columns can be customized to represent different project stages. Cards represent work items, such as issues, draft issues, or pull requests. You can drag cards between columns to reflect their current status or stage of completion and the value of those items adjust to match the column you drag them to. Each card can contain many fields including labels, assignees, due dates, and descriptions. These fields allow you to specify additional information about the work being tracked.

:::image type="content" source="../media/5-github-projects-board.png" alt-text="Screenshot of GitHub Projects board.":::

By using the views functionality, you have the option to create multiple boards within a repository, each with its own, distinct set of columns. You can also set a limit for the number of cards in a particular column in a board layout to implement a WIP limit.

## How to start with GitHub Projects boards?

Before you start a new GitHub project, create a repository. A repository stores all of your project's files and provides a platform for managing your work and collaborating with others. To track project-related work items, use issues. Issues provide a convenient method for communicating and making decisions within a team, including discussions on application lifecycle details, such as bugs or performance reports, project planning, or brainstorming a new idea. To provide suggestions for improvements, use pull requests containing proposed changes.

In addition, consider using the default labels included in every repository or creating custom ones. Labels help with keeping track of project goals, designating bugs, differentiating between various types of work, and indicating the status of issues or pull requests. For example, you can locate all bugs in your project by filtering for issues with the corresponding label.

When creating a project, you can either start from scratch or use many project templates with predefined board structures targeting the most common use cases, including, for example, *Team planning*, *Feature release*, *Kanban*, *Iterative development*, or *Bug tracker*.
