> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use spec-driven development and GitHub Spec Kit to create a greenfield application. Tasks include:

1. Create a project folder and initialize GitHub Spec Kit.
1. Examine GitHub Spec Kit's constitution command and files.
1. Update the constitution using stakeholder documentation.
1. Generate the spec.md file using stakeholder documentation.
1. Generate the plan.md file using stakeholder documentation and spec.md.
1. Generate the tasks.md file using the spec.md, plan.md, and constitution.md.
1. Implement the tasks required for an MVP application.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.





TODO - update the link below when available




[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2345806&azure-portal=true)



---



# Develop a greenfield application using GitHub Spec Kit

GitHub Spec Kit is an open-source toolkit that enables Spec-Driven Development (SSD) by integrating specifications with AI coding assistants like GitHub Copilot.

In this exercise, you learn how to use the GitHub Spec Kit to develop a new greenfield application. You begin by initializing the GitHub Spec Kit for a new .NET project. You then use GitHub Spec Kit workflows to create the constitution, specification, plan, and tasks documents for the new application. Finally, you use GitHub Spec Kit's implementation workflow to implement an initial MVP version of the application.

This exercise takes approximately **60** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment MUST include the following resources: Git 2.48 or later, .NET SDK 8.0 or later, Visual Studio Code with the C# Dev Kit and GitHub Copilot Chat extensions, Python 3.11 or later, the uv package manager, Specify CLI, and access to a GitHub account with GitHub Copilot enabled.

For help with configuring your lab environment, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2345907" target="_blank">Configure your GitHub Spec Kit lab environment</a>.

## Exercise scenario

You're a software developer working for a consulting firm. Your firm is moving to a spec-driven development (SDD) methodology using GitHub Spec Kit and GitHub Copilot in Visual Studio Code. You've been asked to start using SDD and GitHub Spec Kit as soon as possible. One of your clients, Contoso Corporation, needs you to develop an MVP version of RSS feed reader app. Using the SDD methodology with GitHub Spec Kit will help to ensure that the application is delivered quickly, and that additional features can be rolled out seamlessly when needed.

Contoso's stakeholders documented the project goals, features, and technical requirements for the RSS feed reader app. You'll use stakeholder documents to help generate the constitution, specification, plan, and tasks documents.

This exercise includes the following tasks:

1. Create a project folder and initialize GitHub Spec Kit.
1. Generate the constitution using stakeholder documentation.
1. Generate the spec.md file using stakeholder documentation.
1. Generate the plan.md file using stakeholder documentation and spec.md.
1. Generate the tasks.md file using the spec.md, plan.md, and constitution.md.
1. Implement the tasks required for an MVP application.

## Create a project folder and initialize GitHub Spec Kit

The Specify CLI is used to initialize GitHub Spec Kit in a project folder. GitHub Spec Kit uses the project folder to store configuration files, templates, scripts, and agents that support the spec-driven development workflows.

In this task, you create a new project folder and initialize GitHub Spec Kit in your project directory.

Use the following steps to complete this task:

1. Open a terminal window, and then navigate to the root of your C: drive.

    At the command prompt, to navigate to the root of your C: drive, enter the following command:

    ```powershell
    cd C:\
    ```

1. To create a new folder named for your RSSFeedReader project, enter the following command:

    ```powershell
    mkdir TrainingProjects\RSSFeedReader
    ```

1. To navigate to the new project folder, enter the following command:

    ```powershell
    cd TrainingProjects\RSSFeedReader
    ```

1. To initialize GitHub Spec Kit in the current directory, enter the following command:

    ```powershell
    specify init --here --ai copilot --script ps
    ```

    > **NOTE:** If you're using macOS or Linux with bash/zsh, replace `--script ps` with `--script sh`.

    This command specifies the following parameters:

    - `--here` - Initializes GitHub Spec Kit in the current directory (your existing RSSFeedReader project).
    - `--ai copilot` - Configures the project to use GitHub Copilot as the AI assistant.
    - `--script ps` - Specifies that PowerShell scripts will be used.

    The `specify init` command completes the following actions:

    - Creates agent prompt files in the `.github/agents/` and `.github/prompts/` directories.
    - Creates template files in the `.specify/memory/` and `.specify/templates/` directories.
    - Creates script files in the `.specify/scripts/powershell/` directory.
    - Creates a settings.json file in the `.vscode/` directory.
    - Displays a success message ("Project ready").
    - Suggests some optional next steps.

    When you use the `specify init` command for a brownfield project, it recognizes that the current directory isn't empty and asks for confirmation before proceeding. The command preserves any existing application files.

    **Troubleshooting**: If you encounter issues:

    - **"specify command not found"**: To ensure that you installed the Specify CLI, run `specify version`.
    - **Permission denied errors**: On Windows, ensure you're running PowerShell with appropriate permissions. On macOS/Linux, check file permissions.
    - **Git clone errors**: Verify that you're signed in to GitHub, and that you have access to your imported repository.
    - **GitHub Spec Kit commands not appearing**: Ensure `.github/prompts/` exists in your workspace root. Try reloading Visual Studio Code.

1. To open the RSSFeedReader project in Visual Studio Code, enter the following command:

    ```powershell
    code .
    ```

    The `code .` command opens the current directory (RSSFeedReader) in Visual Studio Code.

1. Use Visual Studio Code's EXPLORER view to expand the .github and .specify folders.

    You should see a folder structure that's similar to the following example:

    ```plaintext
    RSSFEEDREADER (root)
    ├── .github/
    │   ├── agents/                 (GitHub Spec Kit executable workflows that can be triggered via commands)
    │   └── prompts/                (GitHub Spec Kit prompt files that provide detailed instructions for each of the agent workflows)
    ├── .specify/                   (GitHub Spec Kit configuration)
    │   ├── memory/                 (GitHub Spec Kit stores the project constitution defining core principles and governance rules that all features must follow)
    │   ├── scripts/powershell/     (GitHub Spec Kit uses automation utilities (scripts) for creating features, setting up plans, and managing the specification workflow)
    │   └── templates/              (GitHub Spec Kit provides standardized markdown formats for specs, plans, tasks, and checklists to ensure consistent documentation across all features)
    └── .vscode/                    (Visual Studio Code configuration)
    ```

1. Ensure that GitHub Copilot's Chat view is open.

    GitHub Spec Kit works with GitHub Copilot through Visual Studio Code's chat interface. When you run "specify init --ai copilot" in your project directory, the toolkit configures your workspace to recognize "/speckit.*" commands.

1. In the Chat view, to verify that GitHub Spec Kit commands are available, type **/speckit**

    You should see autocomplete suggestions that show the available commands:

    - `/speckit.analyze` - Audit implementation plans.
    - `/speckit.checklist` - Validate specification completeness.
    - `/speckit.clarify` - Refine specifications through question and answer process.
    - `/speckit.constitution` - Define project governing principles.
    - `/speckit.implement` - Execute the implementation.
    - `/speckit.plan` - Generate technical implementation plans.
    - `/speckit.specify` - Create feature specifications.
    - `/speckit.tasks` - Break down work into actionable tasks.
    - `/speckit.taskstoissues` - Convert the tasks in tasks.md into GitHub issues.

    > **Note**: If the '/speckit.' commands don't appear, try closing and then reopening the project in Visual Studio Code.

1. Publish your project to a new GitHub repository.

    Publishing the project to a GitHub repository isn't required at this point in the process, but GitHub Spec Kit will eventually require a Git repository and it doesn't hurt to set one up now. Having a repository enables you to track changes, collaborate with others, and use GitHub's features for issue tracking and project management.

    You can use the following steps to publish the project to a new GitHub repository:

    1. Open Visual Studio Code's SOURCE CONTROL view.

    1. Select **Publish Branch**.

        The repository name, RSSFeedReader, is suggested automatically based on the local folder name.

    1. Select **Publish to GitHub private repository**.

        If prompted to sign in to GitHub, follow the sign-in process to authenticate your GitHub account.

1. Verify that the repository was created successfully.

    For example:

    Option 1: Open a browser and navigate to your GitHub profile page. You should see the new RSSFeedReader repository listed among your repositories. Refresh the page if necessary.

    Option 2: Open Visual Studio Code's notifications (bottom right). You should see a notification confirming that the repository was published successfully, along with a link to view it on GitHub.

With the project folder created, GitHub Spec Kit initialized, and source control configured, you're ready to begin using GitHub Spec Kit to create the constitution, specification, plan, and tasks for the RSS Feed Reader application.

## Generate the constitution using stakeholder documentation

The constitution.md file defines policies, requirements, and technical standards that must be followed throughout the development process.

GitHub Spec Kit includes several resources that help you create and maintain the constitution.md file:

- The .specify/memory/constitution.md file contains a template for the constitution document.
- The .github/agents/speckit.constitution.agent.md file contains detailed instructions that are used to generate (or update) the constitution.md file.
- The .github/prompts/speckit.constitution.prompt.md file contains a "routing stub" that tells Copilot Chat to run the agent named speckit.constitution when the /speckit.constitution command is invoked.
- The /speckit.constitution command is used to generate a constitution.md file for the project.

The initial version of the **constitution.md** file specifies that the constitution should include the following:

- Project Name
- Section 1: Core Principles. The Core Principles section needs to include five core principles. Examples for the principles and their descriptions are provided in the template.
- Section 2: unnamed. Examples for the section name and content are provided in the template.
- Section 3: unnamed. Examples for the section name and content are provided in the template.
- Section 4: Governance. Examples for how the governance section is applied and governance rules are provided in the template.

The **speckit.constitution.agent.md** file provides instructions for updating the constitution.md file based on the text or file input provided with the `/speckit.constitution` command. When no guidance is provided, the agent uses what it can find in the codebase to fill in the constitution template.

The /speckit.constitution workflow uses text input, file input, and the codebase to collect the policies, standards, requirements, and guidelines that go into the constitution.md file. Providing detailed inputs helps to generate a more accurate and comprehensive constitution.

In this task, you download the stakeholder documents for the RSSFeedReader project, evaluate their relationship to the GitHub Spec Kit commands, and then use the stakeholder documents to generate the constitution.md file.

Use the following steps to complete this task:

1. To download the stakeholder documents, open the following link in a browser: [RSSFeedReader - stakeholder documents](https://github.com/MicrosoftLearning/mslearn-github-copilot-dev/raw/refs/heads/main/DownloadableCodeProjects/Downloads/GHSpecKitEx14StakeholderDocuments.zip).

1. Open the folder containing the downloaded ZIP file.

1. Extract the contents of the downloaded ZIP file to a temporary folder, copy the files, and then paste them into the root folder of the RSSFeedReader project.

    The updated RSSFeedReader project should resemble the following:

    ```plaintext
    RSSFEEDREADER (root)
    ├── .github/
    │   ├── agents/                 (GitHub Spec Kit executable workflows that can be triggered via commands)
    │   └── prompts/                (GitHub Spec Kit prompt files that provide detailed instructions for each of the agent workflows)
    ├── .specify/                   (GitHub Spec Kit configuration)
    │   ├── memory/                 (GitHub Spec Kit stores the project constitution defining core principles and governance rules that all features must follow)
    │   ├── scripts/powershell/     (GitHub Spec Kit uses automation utilities (scripts) for creating features, setting up plans, and managing the specification workflow)
    │   └── templates/              (GitHub Spec Kit provides standardized markdown formats for specs, plans, tasks, and checklists to ensure consistent documentation across all features)
    ├── .vscode/                    (Visual Studio Code configuration)    
    ├── StakeholderDocuments        (folder containing stakeholder supplied documents)
    └── README.md                   (a readme file describing the project documentation)
    ```

1. In Visual Studio Code's EXPLORER view, expand the **StakeholderDocuments** folder.

    The StakeholderDocuments folder should include the following files:

    - **ProjectGoals.md** - High-level project goals, purpose, scope, delivery approach, rollout plan, quality goals, and standards/guidelines.
    - **AppFeatures.md** - Detailed user-facing feature requirements.
    - **TechStack.md** - Technology choices and architectural rationale.

    These documents include natural language descriptions of the project goals and constraints, app features, and technical requirements. Understanding this context is essential for creating an effective specification, plan, and tasks. The level of detail is typical of what you might find in preliminary documentation for many real-world projects.

    Project documentation and the details provided by the documents can vary greatly depending on company policies and project complexity. The GitHub Spec Kit commands are designed to work with any level of detail that's available, and use that information to create the constitution, spec, plan, and tasks documents required for a successful spec-driven development process. However, detailed inputs lead to more predictable results.

1. In the Chat view, to start a constitution workflow using a combination of inline text and stakeholder documents, enter the following command:

    ```plaintext
    /speckit.constitution --text "Code projects emphasize security, maintainability, and code quality. Ensure that all principles are specific, actionable, and relevant to the project context." --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/AppFeatures.md StakeholderDocuments/TechStack.md
    ```

    > **NOTE**: The /speckit.constitution command can be run multiple times in the same project to refine or extend the constitution.md file. Providing detailed inputs helps to generate a more accurate and comprehensive constitution.

1. Monitor GitHub Copilot's response.

    It can take several minutes for GitHub Copilot to analyze the project requirements and then update the constitution.md file.

1. Once GitHub Copilot is finished generating the constitution, take a minute to review the suggested edits.

    Notice that the constitution workflow extracts underlying principles from your inputs (both text and files) and uses that information to add details to the constitution.

    Developers should review the constitution to ensure it captures requirements accurately. This step is important when you're working in a production environment where the constitution represents your business requirements and technical governance. For a training exercise, this review is mainly to help you become familiar with the constitution content.

    Each principle should be clearly stated and actionable. For example:

    - ❌ Vague: "Apply security best practices." is too general.
    - ✅ Clear: "All API endpoints MUST validate inputs before processing (URL format validation, length limits, null checks)." is specific and actionable.

    If critical requirements are missing or unclear, you can edit the constitution.md file directly to add or modify principles.

    For a real-world project, it's important to review the constitution against the following criteria:

    - Completeness: All major areas (security, privacy, accessibility, performance, reliability, observability, release management, documentation, dependency management, and code quality) are covered.
    - Clarity: Each principle is specific and unambiguous.
    - Consistency: Principles don't contradict each other.
    - Relevance: All principles relate to the RSSFeedReader project.

1. If the /speckit.constitution workflow updated files in the **templates** folder, take a minute to review those updates as well.

1. To accept the changes to all updated files, select the **Keep** button in the Chat view.

1. Save and then close the updated files.

1. Commit and push the updated files to your Git repository.

    For example:

    1. Open Visual Studio Code's SOURCE CONTROL view.
    1. Enter a commit message like "Updated constitution using stakeholder requirements."
    1. Stage and commit the changes.
    1. Push the changes to your Git repository.

    You can verify the commit by checking your GitHub repository in the browser. The updated constitution.md file should now appear with your commit message.

The constitution serves as a "contract" between business requirements and technical implementation, ensuring consistency throughout the spec-driven development process. When you use the GitHub Spec Kit to generate the spec, plan, and tasks, it references these principles to ensure the implementation aligns with specified requirements.

## Generate the spec.md file using stakeholder documentation

The specification (spec.md) defines what you're building from the user's perspective. It describes the features, user stories, acceptance criteria, and business requirements without prescribing how to implement them. A well-written spec serves as the foundation for creating the implementation plan and tasks.

In this task, you use GitHub Copilot's `/speckit.specify` command to generate a detailed specification for the RSS Feed Reader based on the requirements provided by Contoso's business stakeholders.

Use the following steps to complete this task:

1. Use Visual Studio Code's EXPLORER view to examine the **spec-template.md** and **speckit.specify.agent.md** files.

    Notice the following:

    - The spec-template.md file defines the structure and sections of a specification document. It includes examples and/or placeholders for feature descriptions, user stories, acceptance criteria, and other relevant information.
    - The speckit.specify.agent.md file provides detailed instructions for the /speckit.specify command. It guides GitHub Copilot on how to create a specification based on the provided requirements.
    - The speckit.specify.agent.md file generates a repository branch at the beginning of the workflow. Creating a branch generally requires user permissions, so GitHub Copilot prompts for permission when the workflow is run.

1. Use Visual Studio Code's EXPLORER view to examine the **ProjectGoals.md** and **AppFeatures.md** stakeholder documents.

    The AppFeatures.md file is your primary resource for user-facing feature requirements and provides the context needed to create a comprehensive specification. The ProjectGoals.md file provides information about the MVP and rollout plan that can also help to inform the specification.

1. Create a summary description of the RSS Feed Reader app based on the stakeholder documents.

    The summary description should be concise (a sentence or two) and capture the core functionality of the RSS Feed Reader app. For example:

    ```plaintext
    "MVP RSS reader: a simple RSS/Atom feed reader that demonstrates the most basic capability (add subscriptions) without the complexity of a production-ready application."
    ```

1. Close any files that you have open in the editor.

1. Ensure that the Chat view is open.

    Notice that GitHub Copilot retains the context of previous interactions in the current chat session. If you generated the constitution.md file in the current session, GitHub Copilot provides a **Build Specification** button near the bottom of the Chat view that could be used to start generating the specification. In this case, you want to provide the requirements document explicitly, so you don't use the Build Specification button.

1. In the Chat view, to start a specification workflow that generates a spec.md file using information from your stakeholders document, enter the following command:

    ```plaintext
    /speckit.specify --text "MVP RSS reader: a simple RSS/Atom feed reader that demonstrates the most basic capability (add subscriptions) without the complexity of a production-ready application." --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/AppFeatures.md
    ```

    If you don't specify the `--text` option, you might be asked to provide a description of the app features before you can continue.

1. Monitor GitHub Copilot's response and provide assistance as needed.

    > **IMPORTANT**: GitHub Copilot asks for assistance when generating the spec.md file. For example, GitHub Copilot requests permission to create a new branch for the repository. Grant permission when required by responding in the Chat view.

    It can take 4-6 minutes to create the spec.md file and the requirements checklist used to validate your specification. If the workflow process is inactive for more than 6 minutes without reporting successful completion, you can use GitHub Copilot's **retry** command to restart the workflow.

1. Once the specify workflow is complete, use Visual Studio Code's EXPLORER view to expand the **specs** and **checklists** folders.

1. In the EXPLORER view, select **spec.md**, and then take a couple minutes to review the spec.md file.

    The spec.md file is based on the template located in the **.specify/templates/spec-template.md** file. The updated spec.md file should include a detailed specification for the RSS Feed Reader app based on the stakeholder requirements that you provided.

    The specification should be clear, comprehensive, and well-structured. It should also provide a solid foundation for creating the technical plan and tasks.

    Ensure that the spec.md file includes the mandatory sections defined in the spec template. For example:

    - **User Scenarios & Testing**: User-focused descriptions of feature capabilities and how to test them.
    - **Requirements**: Detailed requirements that must be met, organized by category.
    - **Success Criteria**: Measurable outcomes, assumptions, and out-of-scope items.

1. Verify that the User Stories (and Acceptance Scenarios) in the **spec.md** file are specific and testable:

    The acceptance scenarios should follow the **Given-When-Then** format. The scenarios should provide clear conditions for success or failure. For example:

    - ✅ Good: **Given** the application is running, **When** the user enters a valid RSS feed URL and submits it, **Then** the feed is added to their subscription list.

    - ✅ Good: **Given** the user enters an invalid URL (not a proper URI), **When** they try to submit it, **Then** they see an error message indicating the URL is malformed.

    - ❌ Avoid: Vague criteria like "Upload should work well" or "System should be fast".

1. Verify that the Requirements section of the **spec.md** file includes key requirements from your stakeholder requirements document.

    For example, you should see requirements that are similar to the following:

    - System MUST allow users to add a feed subscription by providing a feed URL.

1. In the EXPLORER view, select **requirements.md**, and then take a minute to review the requirements.md file.

    Verify that no issues are reported in the **requirements.md** file. You should see that all checklist items passed successfully.

    > **NOTE**: The `/speckit.clarify` command can be used to identify ambiguities, gaps, and underspecified areas in your specification. In a production environment, it's recommended to run the clarification process after generating the initial specification to ensure all requirements are clear and complete before moving to the technical planning phase. For this lab exercise, you'll skip the clarification step.

1. Accept the suggested file updates, and then save the **spec.md** and **requirements.md** files.

1. Commit the specification files and publish the new branch to your Git repository.

    For example:

    Open Visual Studio Code's SOURCE CONTROL view, stage the changes, enter a commit message like "Add specification for the RSS Feed Reader app", and then publish the new branch to your Git repository.

The specification defines the "what" without the "how." It doesn't specify programming languages, frameworks, database schemas, or code organization - those implementation details are determined in the Plan and Tasks phases based on the constitution's technical constraints. The spec focuses on user needs and business requirements, making it easier to review with nontechnical stakeholders.

## Generate the plan.md file using stakeholder documentation and spec.md

The technical plan bridges the gap between the "what" (specification) and the "how" (implementation). It defines the architecture, technology choices, data models, API designs, and implementation approach while adhering to the constraints defined in the constitution.

In this task, you use GitHub Copilot's `/speckit.plan` command to generate a comprehensive technical implementation plan.

Use the following steps to complete this task:

1. Use Visual Studio Code's EXPLORER view to open the **plan-template.md** and **speckit.plan.agent.md** files.

1. Take a minute to review the **plan-template.md** and **speckit.plan.agent.md** files.

    Notice the following:

    - The plan-template.md file defines the structure and sections of a technical plan document.
    - The speckit.plan.agent.md file provides detailed instructions for the /speckit.plan command. It guides GitHub Copilot on how to create a technical plan based on the specification and constitution.

1. Close any files that you have open in the editor.

1. In the Chat view, to start the technical planning process, enter the following command:

    ```dotnetcli
    /speckit.plan --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/TechStack.md
    ```

1. Monitor GitHub Copilot's response and provide assistance in the Chat view.

    GitHub Copilot analyzes the constitution.md, spec.md, and your stakeholder files to generate the plan. Provide permission and assistance when required.

    It can take 6-8 minutes for GitHub Copilot to generate the technical plan and associated markdown files.

1. Once the plan workflow is complete, verify that the following files were added to the root of the **specs** folder:

    - **plan.md**
    - **research.md**
    - **quickstart.md**
    - **data-model.md**

    You might also see one or more files listed under a **contracts** folder.

1. Take a few minutes to review the **research.md**, **plan.md**, **quickstart.md**, and **data-model.md** files.

    - The research.md file captures research findings and technology decisions for the RSS Feed Reader app.
    - The plan.md file outlines the technical implementation plan for the RSS Feed Reader app.
    - The quickstart.md file provides setup instructions and a high-level overview of how to get started with the implementation.
    - The data-model.md file defines the data entities, properties, and relationships needed for the RSS Feed Reader app.

    For a production scenario, you need to ensure that the plan provides a comprehensive description of the technical context and a clearly defined implementation strategy for the new app/features. The research, quickstart, and data model files should complement the plan by providing additional context and details. For this exercise, focus on becoming familiar with the content associated with each of the files.

1. After reviewing the files, accept all of the suggested edits.

    If the plan omits important details or makes assumptions you disagree with, you can:

    - Edit the plan.md file directly, or
    - Ask follow-up questions in GitHub Copilot Chat.

    For example:

    ```plaintext
    The plan should include a section on how to handle feed parsing errors gracefully. Can you update the plan.md file to include this information?
    ```

1. Save the files, and then commit and sync your changes.

The technical plan now serves as a blueprint for implementation. It translates business requirements into concrete technical decisions while respecting organizational constraints.

## Generate the tasks.md file using the spec.md, plan.md, and constitution.md

The tasks.md file breaks down the technical plan into specific, actionable implementation steps. Each task should be small enough to complete in a reasonable timeframe (typically a few hours to a day when implemented without AI assistance) and have clear acceptance criteria.

In this task, you use the GitHub Spec Kit's `/speckit.tasks` command to generate a comprehensive tasks list and phased implementation plan.

Use the following steps to complete this task:

1. Use Visual Studio Code's EXPLORER view to open the **tasks-template.md** and **speckit.tasks.agent.md** files.

1. Take a minute to review the **tasks-template.md** and **speckit.tasks.agent.md** files.

    Notice that the tasks-template.md file organizes tasks into logical phases, while the speckit.tasks.agent.md file describes the steps that the /speckit.tasks workflow should follow:

    - What inputs to read (spec.md, plan.md, etc.)
    - What to produce (tasks.md)
    - How to sequence the tasks (by phase, user story, etc.)
    - How to define each task (specific, actionable, testable)
    - What checks/gates to apply (coverage, ordering, scope)

1. Close any files that you have open in the editor.

1. In the Chat view, to start generating the tasks.md file, enter the following command:

    ```dotnetcli
    /speckit.tasks
    ```

1. Monitor GitHub Copilot's response and provide assistance in the Chat view.

    GitHub Copilot analyzes the spec.md and plan.md files and generate tasks in the tasks.md file.

    It can take 4-6 minutes for GitHub Copilot to generate the tasks.md file. Provide permission and assistance when required.

1. Once the tasks workflow is complete, take a few minutes to review the **tasks.md** file.

    Verify that tasks are ordered logically by phase and user story. For example:

    - Setup and Foundation tasks come first.
    - Backend API tasks build on the foundation.
    - Frontend tasks reference backend endpoints.
    - Testing tasks come after implementation.
    - Deployment tasks come last.

    In a production scenario, you should also take the time to verify that every requirement (from spec.md) and every key design commitment (from plan.md) maps to at least one concrete task (usually several). For example:

    - Design commitments from the plan.md file should have corresponding implementation tasks.
    - User story acceptance criteria should have corresponding implementation and verification tasks.
    - Functional requirements should have corresponding implementation tasks.
    - Security requirements should have corresponding implementation tasks.
    - Performance requirements should have testing tasks.

1. Accept the suggested file updates, and then save the **tasks.md** file.

1. Commit the changes and then sync the updates.

The tasks.md file now provides a clear roadmap for implementation.

## Implement the tasks required for an MVP application

With a clear specification, technical plan, and tasks document in place, you're ready to implement the RSS Feed Reader app.

The tasks.md file provides a phased implementation strategy that breaks down the work into manageable chunks. The implementation can be approached in different ways, depending on project priorities and constraints. For example, you could consider one of the following strategies:

- Implementing the feature incrementally, phase by phase.
- Implementing the entire feature set at once.
- Implementing the MVP app features first, then building out additional features.

GitHub Spec Kit's implement workflow demonstrates how to use the tasks.md file to guide the implementation process.

In this task, you review the implementation strategy and then use `speckit/implement` to implement the MVP version of the application.

Use the following steps to complete this task:

1. Open the **tasks.md** file, locate the **Implementation Strategy** section, and then review the suggested MVP strategy.

    The MVP (or MVP First) strategy is intended to deliver a working app as quickly as possible. It should focus on completing the Setup (initialization) and Foundational (blocking) phases first before building out the first User Story (US1).

    For example, the MVP implementation strategy might be similar to the following example:

    ```plaintext
    **Phases**: Setup → Foundation → US1 only  
    **Tasks**: T001 - T050 (50 tasks)  
    **Deliverable**: Users can add a known-good feed URL; refresh; see items; restart and confirm persistence.
    ```

    The MVP First strategy isn't always limited to the first user story. Depending on the feature complexity, it might include several user stories. They should be listed sequentially after the foundational phase and clearly marked as part of the MVP implementation strategy.

1. In the Chat view, enter a command that starts the implement workflow for the MVP First strategy:

    Create a command that specifies the range of tasks required to implement the MVP version of the feature. Use the task range specified in the Implementation Strategy section of the tasks.md file, or calculate it based on the tasks listed under each phase.

    > **IMPORTANT**: The command that you enter must reference the specific task range defined in your tasks.md file.

    For example (referencing the MVP implementation example from the previous step), you might enter the following command:

    ```dotnetcli
    /speckit.implement Implement the MVP First strategy (Tasks: T001 - T050)
    ```

    This command instructs GitHub Copilot to begin implementing the tasks required for the MVP First strategy of the RSS Feed Reader app.

    In this exercise, you implement all of the tasks for the MVP First strategy using a single /speckit.implement command. In a production environment, you would probably follow a phased approach, such as implementing the tasks for the Setup and Foundational phases first, and then implementing the tasks for each User Story phase one at a time.

1. Monitor GitHub Copilot's response and provide assistance in the Chat view.

    The agent builds the app incrementally, task by task, following the order defined in the tasks.md file.

    > **NOTE**: GitHub Copilot displays frequent requests for assistance during the implementation phase. The time required to complete the implementation can be affected by how quickly you respond to requests for assistance/permission.

1. Continue with the implementation workflow until all tasks required for the MVP application are complete and the application is fully functional.

    GitHub Copilot should notify in the Chat view when the backend and frontend applications are fully functional.

1. Accept all changes made to the project files.

    For this lab exercise, it's okay to accept all changes made by GitHub Copilot without a review. However, in a production environment, it's important to review all code changes carefully to ensure they meet quality standards and align with project requirements.

1. Save all updated files.

1. First start the backend application, and then start the frontend application.

    Ensure that both applications start without errors.

    You can ask GitHub Copilot for the commands required to start both applications if you're unsure. For example, you could enter the following prompt in the Chat view:

    ```plaintext
    Can you provide the commands required to start both the backend and frontend applications?
    ```

1. Open a browser and navigate to the frontend application.

    The frontend URL should be similar to the following: `http://localhost:5213`.

    Report back to GitHub Copilot if you encounter any issues. For example:

    1. You start the backend application. The backend application is running locally on `http://localhost:5151`.
    1. You start the frontend application. The frontend application is running locally on `http://localhost:5213`.
    1. You open a browser and navigate to the URL specified for the frontend application.
    1. When the page loads, it reports an error: "An unhandled error has occurred. Reload".
    1. You select the "Reload" option, but the error persists.
    1. You open the browser's developer tools console to investigate further.
    1. In the developer tools console, you see the following error message:

        ```plaintext
        "Microsoft.AspNetCore.Components.WebAssembly.Rendering.WebAssemblyRenderer[100]
        Unhandled exception rendering component: The following routes are ambiguous:
        '' in 'RSSFeedReader.UI.Pages.Home'
        '' in 'RSSFeedReader.UI.Pages.Subscriptions'
        
        System.InvalidOperationException: The following routes are ambiguous:
        '' in 'RSSFeedReader.UI.Pages.Home'
        '' in 'RSSFeedReader.UI.Pages.Subscriptions'
        
        at Microsoft.AspNetCore.Components.RouteTableFactory.DetectAmbiguousRoutes(:5213/TreeRouteBuilder builder)
        at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/Dictionary2 templatesByHandler, IServiceProvider serviceProvider)    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/List1 componentTypes, IServiceProvider serviceProvider)
        at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/RouteKey routeKey, IServiceProvider serviceProvider)
        at Microsoft.AspNetCore.Components.Routing.Router.RefreshRouteTable((index))
        at Microsoft.AspNetCore.Components.Routing.Router.Refresh(:5213/Boolean isNavigationIntercepted)
        at Microsoft.AspNetCore.Components.Routing.Router.RunOnNavigateAsync(:5213/String path, Boolean isNavigationIntercepted)
        at Microsoft.AspNetCore.Components.Routing.Router.<>c__DisplayClass82_0.<RunOnNavigateAsync>b__1(:5213/RenderTreeBuilder builder)
        at Microsoft.AspNetCore.Components.Rendering.ComponentState.RenderIntoBatch(:5213/RenderBatchBuilder batchBuilder, RenderFragment renderFragment, Exception& renderFragmentException)"
        ```

        At this point you need to report the issue to GitHub Copilot:

    1. You report the issue in the Chat view.

        For example:

        ```plaintext
        I was able to start the backend and frontend apps successfully. I opened the frontend app in the browser at http://localhost:5213. When the page opens, I see an error message: "An unhandled error has occurred. Reload". Selecting reload doesn't resolve the issue. When I check the browser's developer tools console, I see the following error message: 

        "Microsoft.AspNetCore.Components.WebAssembly.Rendering.WebAssemblyRenderer[100]
        Unhandled exception rendering component: The following routes are ambiguous:
        '' in 'RSSFeedReader.UI.Pages.Home'
        '' in 'RSSFeedReader.UI.Pages.Subscriptions'
        
        System.InvalidOperationException: The following routes are ambiguous:
        '' in 'RSSFeedReader.UI.Pages.Home'
        '' in 'RSSFeedReader.UI.Pages.Subscriptions'
        
        at Microsoft.AspNetCore.Components.RouteTableFactory.DetectAmbiguousRoutes(:5213/TreeRouteBuilder builder)
        at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/Dictionary2 templatesByHandler, IServiceProvider serviceProvider)    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/List1 componentTypes, IServiceProvider serviceProvider)
        at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/RouteKey routeKey, IServiceProvider serviceProvider)
        at Microsoft.AspNetCore.Components.Routing.Router.RefreshRouteTable((index))
        at Microsoft.AspNetCore.Components.Routing.Router.Refresh(:5213/Boolean isNavigationIntercepted)
        at Microsoft.AspNetCore.Components.Routing.Router.RunOnNavigateAsync(:5213/String path, Boolean isNavigationIntercepted)
        at Microsoft.AspNetCore.Components.Routing.Router.<>c__DisplayClass82_0.<RunOnNavigateAsync>b__1(:5213/RenderTreeBuilder builder)
        at Microsoft.AspNetCore.Components.Rendering.ComponentState.RenderIntoBatch(:5213/RenderBatchBuilder batchBuilder, RenderFragment renderFragment, Exception& renderFragmentException)".
        ```

    1. GitHub Copilot analyzes the information you provided and begins debugging the issue.

        When you report an issue, GitHub Copilot uses the information you provided to begin debugging. A detailed description, including what is working, helps GitHub Copilot understand the problem better. GitHub Copilot might need extra details, such as specific error messages to resolve some issues. Provide any additional information requested by GitHub Copilot to help diagnose (and resolve) the problem.

        Continue to provide assistance until the issue is resolved. Once the issue is resolved, GitHub Copilot should ask you to resume manual testing.

1. Take a few minutes to verify the acceptance scenarios for the MVP application.

    Here are some feeds that you can use to test the application:

    - https://devblogs.microsoft.com/dotnet/feed/ (The .NET Blog)
    - https://devblogs.microsoft.com/visualstudio/feed/ (Visual Studio Blog)

    You can find the acceptance scenarios in the spec.md file. The acceptance scenarios listed under the **User Scenarios & Testing** section.

    For example, the acceptance scenarios for the MVP application might be similar to the following example:

    1. **Given** no subscriptions have been added, **When** the user loads the page, **Then** an empty state is shown (e.g., "No subscriptions yet" message)
    2. **Given** the subscription management interface is loaded, **When** the user enters a valid feed URL in the input field and clicks "Add Subscription", **Then** the system accepts the URL and confirms the subscription was added
    3. **Given** the user has entered a feed URL, **When** the user submits the form, **Then** the input field is cleared and ready for another URL
    4. **Given** the user enters an empty string or whitespace-only input, **When** they attempt to add the subscription, **Then** the system prevents submission (basic client-side validation)
    5. **Given** the user has added one subscription, **When** the page displays, **Then** the subscription URL is visible in the list
    6. **Given** the user has added multiple subscriptions, **When** the page displays, **Then** all subscription URLs are visible in the list in the order they were added (newest last)

    You can also ask GitHub Copilot for the steps required to perform manual testing of your MVP implementation. For example, you could enter the following prompt in the Chat view:

    ```plaintext
    Can you provide the steps required to manually test the MVP implementation?
    ```

    Use Visual Studio Code to run the application, and then manually test the RSS Feed Reader functionality to ensure that it works as expected.

1. Continue manual testing and reporting results until all acceptance scenarios for the MVP application pass successfully.

    Key Observations:

    - The implementation process is iterative and may require multiple rounds of testing and debugging.
    - Clear communication with GitHub Copilot is essential for effective troubleshooting.
    - Thorough testing ensures that the MVP application meets the specified requirements and functions as intended.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. For example, you might want to delete the ContosoDashboard repository. If you're using a local PC as your lab environment, ensure that you want to keep any tools that might have installed during the exercise. You can archive or delete the local clone of the repository that you created for this exercise.
