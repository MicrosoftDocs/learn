The use of source and version control is a fundamental DevOps practice. It's also a prerequisite for such practices as continuous integration and infrastructure as code, both of which are crucial to reaching the full DevOps potential.  The organization in our sample scenario should review its current collaborative software development strategy and transition to a distributed version control model such as Git, especially considering its plans to use GitHub for its software lifecycle management. This, however, requires sound understanding of the version and source control principles and their benefits, which we'll cover here.

## Source control and version control

:::image type="content" source="../media/2-source-control.png" alt-text="Screenshot of a source control system with multiple files and their version history.":::

The terms *source control* and *version control* are often used interchangeably, and in many contexts, they refer to the same concept. In general, both of them are associated with the practice of managing changes to code in a shared development environment. However, you might encounter more nuanced scenarios in which their meaning is slightly different. In these scenarios, *source control* designates a system that manages changes to source code files while *version control* includes change management of any file type for purposes that extend beyond source code alone. Going forward, for the sake of consistency, we'll be using the term *version control* to represent Git-based collaborative software repositories available in GitHub and Azure DevOps.

## What are the benefits of version control?

Version control keeps track of changes to files within its scope of management. This offers a wide range of benefits:

- **History and version tracking**: You have the ability to review history of changes to any file, including the ability to determine when each individual change took place and what was their scope. This also provides traceability, typically by associating each set of changes with a unique identifier.
- **Rollback and recovery**: If there's an error or an issue, you can easily revert changes to recover the known, working version of the affected file.
- **Branching and merging**: If you need to extend the functionality of the current code by adding another feature or fix a newly discovered bug, you can create a so-called branch, which allows you to work independently against the existing codebase. The new branch is initially identical to the *main* branch hosting the current code. Once you completed your changes, you merge the new branch with the main branch. While this might still lead to conflicts (if another developer decided to modify the same set of files in the meantime via another branch), their scope is limited and they can typically be easily identified and resolved.

    :::image type="content" source="../media/2-branch-strategy.png" alt-text="Screenshot of a branch strategy with multiple branches, including main, bugfix, and features.":::

- **Collaboration and parallel development**: Conflict resolution provisions supplemented by branching and merging facilitate having multiple developers working on the same codebase, which increases efficiency. With distributed control systems, such as Git, it's even possible to author code in a disconnected mode. Collaboration also involves mutual peer reviews of pull requests, promoting knowledge sharing and transparency.
- **Automation**: Version control is an essential part of continuous integration and automated deployments. Automated build and testing can be triggered automatically whenever a new version of the code is pushed to the version control repository or merged with the main branch. Different versions of the code can be deployed into different environments.
