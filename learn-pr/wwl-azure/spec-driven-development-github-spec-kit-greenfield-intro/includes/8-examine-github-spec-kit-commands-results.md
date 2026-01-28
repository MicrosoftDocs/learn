With GitHub Spec Kit installed, you're ready to use its commands to practice spec-driven development. This unit walks through each command in the workflow, explaining what it does, what output it produces, and how to work with the results. Understanding this process prepares you for the hands-on lab exercise.

## Command overview

GitHub Spec Kit provides two types of commands:

- **Terminal commands:** Run in your shell (like `specify init`, `specify check`)
- **Slash commands:** Run inside your AI assistant's chat interface (like `/speckit.specify`, `/speckit.plan`)

The workflow follows a specific sequence, with each command building on the outputs of the previous one:

| Order | Command | Type | Output |
|-------|---------|------|--------|
| 1 | `specify init` | Terminal | Project structure |
| 2 | `/speckit.constitution` | Slash | constitution.md |
| 3 | `/speckit.specify` | Slash | spec.md |
| 4 | `/speckit.plan` | Slash | plan.md |
| 5 | `/speckit.tasks` | Slash | tasks.md |
| 6 | `/speckit.implement` | Slash | Source code |

## Project initialization

Initialize your project with the `specify init` terminal command. This command sets up the necessary directory structure, configuration files, and templates for GitHub Spec Kit to work.

### The specify init command

Start every GitHub Spec Kit project with the `specify init` command in your terminal:

```bash
specify init my-project
```

This command creates a new directory with a standard GitHub Spec Kit structure:

```text
my-project/
├── .github/
│   ├── agents/
│   └── prompts/
├── .specify/
│   ├── memory/
│   │   └── constitution.md
│   ├── scripts/
│   └── templates/
├── specs/
│   └── (feature directories will go here)
```

For an existing project directory, use `--here` to initialize in place:

```bash
specify init --here
```

During initialization, you're prompted to select your AI coding assistant. Choose the one you plan to use (for this module, that's GitHub Copilot).

## Creating the constitution

The constitution defines your project's guiding principles, constraints, and non-negotiable requirements. It ensures consistency across specifications, plans, and code.

### The /speckit.constitution command

Before diving into features, establish your project's guiding principles. In your AI assistant's chat, type:

```text
/speckit.constitution
```

The AI generates a **constitution.md** file that captures project-wide principles, constraints, and requirements. For a greenfield project, the information could be provided as inline text or in documentation that outlines your coding standards and guidelines. For a brownfield project, the AI can analyze your existing codebase to suggest coding conventions.

### What constitution.md contains

A typical constitution includes:

- **Technology standards:** Required languages, frameworks, and services
- **Security requirements:** Authentication, authorization, and data protection rules
- **Performance expectations:** Response time targets, scalability requirements
- **Coding conventions:** Naming patterns, architectural patterns, testing requirements
- **Compliance needs:** Regulatory or organizational policy requirements

### Review and update

After generation, review the constitution carefully. The AI uses this document when generating plans and code, so it needs to be accurate. If your organization requires "all data storage must use Azure services" or "APIs must follow RESTful conventions," ensure those principles are documented here.

## Generating the specification

The specification defines what you're building - user stories, acceptance criteria, and requirements.

### The /speckit.specify command

With the constitution in place, create your first feature specification. In the AI chat, provide a description of what you want to build:

```text
/speckit.specify Create an RSS Feed Reader application that allows users to subscribe to feeds by URL, view articles sorted newest-first, and track read/unread status. Data should persist locally on the device.
```

The AI generates a **spec.md** file based on your description.

### What spec.md contains

The generated specification includes the standard sections you learned about in Unit 5: summary, user stories, acceptance criteria, functional requirements, nonfunctional requirements, and edge cases.

User stories describe features from the user's perspective. For example, a user story could be similar to the following example:

- *As a user, I want to add RSS feeds by URL so that I can follow my favorite websites.*

Acceptance criteria define how to verify functionality. For the RSS Feed Reader, acceptance criteria might include:

- User can add a feed by entering a valid RSS or Atom URL.
- Invalid feed URLs display a clear error message.
- New articles appear after refreshing feeds.

### Review and refine

The generated spec is a starting point - the AI's interpretation of your prompt. Your job is to:

1. **Verify completeness:** Does it capture all your requirements?
1. **Check accuracy:** Is everything correctly understood?
1. **Add missing details:** Fill in any gaps the AI missed
1. **Remove incorrect items:** Delete anything that doesn't belong

Think of it this way: could you hand this spec to a developer (or AI) and have them understand exactly what to build? If not, refine it until you can.

## Creating the technical plan

The technical plan outlines how you implement the specification - architecture, technology choices, and implementation sequence.

### The /speckit.plan command

With a complete specification, create the technical design. Provide guidance about your preferred technologies and constraints:

```text
/speckit.plan Use .NET 8 for the application, SQLite for local data persistence, and System.ServiceModel.Syndication for RSS/Atom parsing. Apply HTML sanitization for security.
```

The AI generates a **plan.md** file that translates specification requirements into technical decisions.

### What plan.md contains

The generated plan includes the sections covered in Unit 5: architecture overview, technology stack, implementation sequence, constitution verification, and assumptions. The AI translates your specification requirements into technical decisions. For example:

- *Build a .NET application with SQLite for local storage. A FeedService handles RSS/Atom parsing with System.ServiceModel.Syndication. Data access uses Entity Framework Core with a clean repository pattern.*

### Review and adjust

Check that the plan makes sense and aligns with your expectations:

- Are the technology choices appropriate?
- Does the architecture address all specification requirements?
- Is anything from the spec unaddressed in the plan?

If the AI proposed something you don't want (maybe it chose a database you don't prefer), edit the plan. The plan drives task generation, so it needs to be correct before proceeding.

## Generating the task list

The task list breaks down the plan into discrete, actionable work items for implementation.

### The /speckit.tasks command

With a solid plan, generate the implementation task list:

```text
/speckit.tasks
```

This command reads the spec and plan to produce a **tasks.md** file - a checklist of discrete work items.

### What tasks.md contains

The generated task list reflects the phase-based organization and task characteristics you learned about in Unit 5. Tasks are organized into logical groups:

- **Phase 1: Foundation**:

    - Create project structure and configure SQLite database.
    - Define Feed and Article data models with Entity Framework Core.

- **Phase 2: Core Feed Management**:

    - Implement FeedService with URL validation and RSS/Atom parsing.
    - Add feed refresh logic to detect new articles.

- **Phase 3: Article Display**:

    - Implement sorted article view (newest-first).
    - Add read/unread tracking with database persistence.

### Review and verify

Cross-check the task list against the spec and plan:

- Do these tasks, if completed, fulfill everything in the spec?
- Is any requirement missing a corresponding task?
- Are any tasks too vague or too large to implement directly?

If a task says something like "Implement authentication," that's probably too broad - break it down into smaller, specific tasks.

## Implementing the tasks

The implementation process uses the task list to generate working code, either with AI assistance or manually.

### The /speckit.implement command

GitHub Spec Kit provides an implement command that guides AI-assisted code generation:

```text
/speckit.implement
```

The AI works through tasks sequentially, generating code for each one. You can also target specific tasks:

```text
/speckit.implement implement tasks 1-3
```

### Implementation approaches

You have options for how to work through tasks:

- **AI-assisted implementation:** Use `/speckit.implement` to have the AI generate code for each task. Review and validate each piece before moving on.

- **Manual implementation with AI help:** Work through tasks yourself, using your AI assistant for code suggestions and completion as needed.

- **Hybrid approach:** Use AI for some tasks (especially boilerplate or repetitive work) and write others manually.

### Verify each task

However you implement, verify each task against the specification:

- Does the code do what the spec requires?
- Does it follow the plan's architectural decisions?
- Does it align with constitution principles?

Run tests, manually check behavior, or use whatever verification is appropriate for the task.

### Keeping artifacts updated

If you discover something during implementation that changes the design - maybe you need a different approach than the plan specified - update your artifacts. Edit plan.md (and spec.md if requirements changed) to reflect the latest design requirements. This process keeps your documentation accurate and useful.

## Optional enhancement commands

GitHub Spec Kit provides other commands for quality and consistency:

### The /speckit.clarify command

Analyzes your specification to identify ambiguities and missing details. The AI asks clarifying questions like:

- "The spec mentions refreshing feeds but doesn't specify how often to check for updates. Should there be an automatic refresh interval?"

Answer the questions, and the AI updates the spec accordingly.

### The /speckit.analyze command

Performs cross-artifact consistency checking. It verifies that:

- The plan addresses all specification requirements
- Tasks cover all plan elements
- Everything aligns with the constitution

Run this command after generating plan and tasks but before implementing.

### The /speckit.checklist command

Generates quality verification checklists for your specification. Use this command for self-review before sharing specs with stakeholders.

## Best practices

- **Always review AI outputs:** Don't blindly accept generated content. The AI assists, but you're the domain expert.

- **Communicate clearly in prompts:** The quality of output depends on the quality of input. Include all important requirements and constraints.

- **Use the constitution for consistency:** Document organizational standards early so all generated artifacts follow them.

- **Commit your artifacts:** Save spec.md, plan.md, and tasks.md in your repository alongside code. They're valuable documentation.

- **Know when to re-run vs. edit:** If output is wrong, consider rerunning with a better prompt. For minor issues, just edit the file directly.

- **Follow the sequence:** Run commands in order - spec before plan, plan before tasks. Each builds on the previous outputs.

## Summary

GitHub Spec Kit provides a structured set of commands that operationalize spec-driven development. By following the workflow from project initialization through constitution, specification, planning, task generation, and implementation, you can systematically transform ideas into working software. Each command produces artifacts that guide the next steps, ensuring alignment and quality throughout the process. Optional enhancement commands help clarify requirements and verify consistency, while best practices ensure effective use of AI assistance. With this understanding, you're ready to apply GitHub Spec Kit in your development projects.
