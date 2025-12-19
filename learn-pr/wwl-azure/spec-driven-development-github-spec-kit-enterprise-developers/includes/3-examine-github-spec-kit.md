GitHub Spec Kit is an open-source toolkit that enables spec-driven development by integrating specifications with AI coding assistants. GitHub Spec Kit transforms the way you work with tools like GitHub Copilot by providing structured workflows, templates, and commands that turn specifications into executable development artifacts.

## What is GitHub Spec Kit?

GitHub Spec Kit addresses a fundamental challenge in AI-assisted development: maintaining context and consistency across multiple interactions with coding assistants. Without structure, each chat session with GitHub Copilot operates in isolation, lacking awareness of previous decisions or overall project requirements.

GitHub Spec Kit provides three essential capabilities:

**Persistent artifacts**: Specifications, plans, and tasks are stored as markdown files in your repository, creating a permanent record of requirements and decisions.

**Standardized workflow**: A defined process guides you from high-level requirements through specification, planning, task breakdown, and implementation.

**Reusable commands**: Built-in slash commands encapsulate best-practice prompting patterns, so you don't need to craft optimal prompts for each development phase.

Instead of manually prompting GitHub Copilot with fragmentary instructions and hoping for consistent results, you invoke structured commands like `/speckit.specify` or `/speckit.plan` that guide the AI through a proven workflow. The specifications you create become direct input to code generation, ensuring alignment between intent and implementation.

## Key components of GitHub Spec Kit

The GitHub Spec Kit consists of several integrated components that work together to support specification-driven development.

### Specify CLI tool

The `specify` command-line tool initializes and manages spec-driven projects. You install it using the `uv` tool:

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

Or run it directly using `uvx` without permanent installation:

```bash
uvx --from git+https://github.com/github/spec-kit.git specify init
```

When you run `specify init` in your project directory, the CLI implements the following steps:

1. Prompts you to select your AI coding assistant (GitHub Copilot, Claude, ChatGPT, or others).
1. Creates a `.github/prompts/` directory with workflow templates.
1. Generates a project structure with folders for specifications.
1. Creates template files: `constitution.md`, `spec.md`, `plan.md`, `tasks.md`.
1. Configures integration with your chosen AI assistant.

The multi-agent support is significant—GitHub Spec Kit works with GitHub Copilot, Anthropic Claude, OpenAI's models, and over a dozen other AI assistants. This flexibility ensures you're not locked into a single AI provider, valuable in enterprise environments with multiple AI service options.

### Markdown artifact files

GitHub Spec Kit uses structured markdown files as primary development artifacts. These files aren't passive documentation—they actively drive AI code generation.

The main artifact files are:

- **Constitution (constitution.md)**: Captures project-wide principles, constraints, and non-negotiable requirements. This file encodes organizational standards, security requirements, and architectural decisions that must be honored throughout development.

- **Specification (spec.md)**: Defines what a specific feature should do. A well-structured spec includes summary, user stories, acceptance criteria, functional requirements, nonfunctional requirements, and edge cases.

- **Plan (plan.md)**: Translates the specification into a technical implementation strategy, defining architecture, components, data models, and implementation sequence.

- **Tasks (tasks.md)**: Breaks down the plan into discrete, actionable work items that can be implemented and tested independently.

### Slash commands

GitHub Spec Kit integrates with Visual Studio Code through custom chat commands that trigger specific workflow phases. These commands appear in the GitHub Copilot Chat panel after you initialize GitHub Spec Kit in your project.

The primary commands are:

- **`/speckit.constitution`**: Creates or updates project Constitution based on your principles and constraints.

- **`/speckit.specify`**: Generates a detailed specification from your high-level feature description. GitHub Copilot prompts for requirements and produces structured spec.md with all standard sections.

- **`/speckit.clarify`**: Analyzes the current specification and asks questions to identify gaps and ambiguities. You answer each question, and GitHub Copilot updates the spec accordingly.

- **`/speckit.plan`**: Produces a technical implementation plan based on the spec and Constitution. You can provide more context about existing systems or preferred technologies.

- **`/speckit.tasks`**: Breaks down the implementation plan into discrete tasks organized by phases or components.

- **`/speckit.implement`**: Guides you through implementing tasks one at a time, generating code for each task.

- **`/speckit.analyze`**: Verifies that specs, plans, and tasks are consistent with each other and the Constitution.

These commands are shortcuts to complex prompts that GitHub Spec Kit has optimized. When you run `/speckit.plan`, for example, the AI is instructed to produce output with specific sections (architecture, data models, Constitution verification) that ensure comprehensive planning. You don't need to be an expert in prompt engineering—GitHub Spec Kit provides the proven patterns.

## GitHub Spec Kit's AI agent support

GitHub Spec Kit supports multiple AI coding assistants beyond GitHub Copilot, enabling teams to use their preferred AI tools while maintaining consistent spec-driven development (SDD) practices.

### Multi-agent compatibility

GitHub Spec Kit provides agent-specific configurations during initialization. When you run `specify init`, you select from supported agents:

- **GitHub Copilot**: Integration through Visual Studio Code chat interface.
- **Claude Code**: Integration through Anthropic's coding assistant.
- **Cursor**: Integration through Cursor's AI features.
- **Windsurf**: Integration through Windsurf coding environment.
- **Amazon Q Developer**: Integration through the Amazon Web Services's coding assistant.
- **And others**: Support for emerging AI coding tools.

Each agent receives templates formatted for its specific prompt format. The underlying specification artifacts (spec.md, plan.md, tasks.md) remain identical regardless of which AI assistant you use. This agent-agnostic approach prevents vendor lock-in and allows teams to experiment with different AI tools.

For enterprise development teams, this flexibility is valuable. You might use GitHub Copilot for front-end development in Visual Studio Code but use a different AI assistant for back-end services. GitHub Spec Kit ensures both assistants work from the same specifications.

### Template customization

While GitHub Spec Kit provides default templates optimized through research and real-world usage, teams can customize templates to match organizational needs.

Template files in `.github/prompts/` are markdown files with placeholder variables. You can edit these files to add organization-specific sections. For example, you might customize the spec template to include a "Compliance Requirements" section that prompts for industry-specific compliance needs.

Customization enables GitHub Spec Kit to adapt to enterprise processes. If you're in part of a team that requires security review sections in all specifications, you can add this section to the spec template. All future specifications generated with `/speckit.specify` automatically include this section.

### Environment variables for feature tracking

GitHub Spec Kit uses environment variables to track which feature you're currently developing. The `SPECIFY_FEATURE` variable indicates the active feature directory.

In Git-based workflows, GitHub Spec Kit infers the feature from your branch name. If you're on branch `feature/document-upload`, GitHub Spec Kit automatically works with the `features/document-upload/` directory.

For non-Git workflows or manual feature specification, set the environment variable explicitly:

```powershell
$env:SPECIFY_FEATURE = "001-document-upload"
```

This setting tells GitHub Spec Kit to read and write artifacts in the `features/001-document-upload/` directory regardless of Git branch.

This feature tracking ensures that when you invoke `/speckit.plan`, the AI reads the correct spec.md file for your current feature rather than mixing specifications from different features.

## Integrate GitHub Spec Kit with Git workflows

GitHub Spec Kit integrates into your existing development practices through several mechanisms.

### Version control integration

All GitHub Spec Kit artifacts are plain markdown files stored in your Git repository. This approach provides several advantages:

- **Change tracking**: Every modification to specifications, plans, or tasks creates a Git commit. You can review the history of requirement changes, understand why decisions were made, and revert problematic changes.

- **Branch-based development**: Create feature branches that contain both specification artifacts and implementation code. This approach keeps requirements and implementation synchronized and makes code review comprehensive—reviewers see both what you're building (spec) and how you built it (code).

- **Pull request workflows**: When you submit a pull request for a feature, include spec.md, plan.md, and tasks.md alongside code changes. Reviewers verify that implementation matches specifications and that specifications align with project goals.

For example, if you're implementing a new feature, your feature branch contains:

- `spec.md` defining upload requirements.
- `plan.md` describing Azure Blob Storage architecture.
- `tasks.md` listing implementation steps.
- Source code implementing the feature.
- Tests verifying specification compliance.

This complete picture enables thorough review. If a reviewer questions why files are limited to 50 MB, they can reference spec.md and see that this requirement came from stakeholder discussions.

### AI assistant integration scenario - GitHub Copilot

GitHub Spec Kit works with GitHub Copilot through Visual Studio Code's chat interface. After you run `specify init --ai copilot`, the toolkit configures your workspace to recognize `/speckit.*` commands.

When you open GitHub Copilot Chat and type `/speckit.specify`, GitHub Copilot accesses predefined templates from the `.github/prompts/` directory. These templates help to structure the AI's output to include all necessary specification sections: user stories, acceptance criteria, functional requirements, nonfunctional requirements, and edge cases.

The integration is seamless—you don't manage templates manually. GitHub Spec Kit handles template loading and context injection automatically. Your job is to provide feature descriptions and answer clarifying questions. GitHub Copilot handles specification formatting and completeness.

### Project structure conventions

GitHub Spec Kit organizes artifacts using consistent directory structure:

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
├── SourceCode/ 
│   └── ...
├── specs/
│   └── 001-document-upload-feature/
│       ├── plan.md
│       ├── spec.md
│       └── tasks.md
```

This structure separates specification artifacts from implementation code while keeping them in the same repository. Features are numbered sequentially (001, 002, 003) to track development order.

For teams working on multiple features concurrently, each feature has its own directory containing its complete specification, plan, and tasks. This isolation prevents confusion and enables parallel work without conflicts.

### Continuous workflow support

GitHub Spec Kit supports iterative development through command chaining. After generating initial specifications, you can refine them progressively:

1. Generate initial spec: `/speckit.specify`.
1. Identify gaps: `/speckit.clarify`.
1. Update spec based on answers.
1. Create implementation plan: `/speckit.plan`.
1. Verify consistency: `/speckit.analyze`.
1. Generate tasks: `/speckit.tasks`.
1. Implement incrementally: `/speckit.implement`.

At any point, if requirements change, you can return to earlier phases, update artifacts, and regenerate downstream artifacts. If a stakeholder changes their mind about file size limits after you generate tasks, you update spec.md, regenerate plan.md to reflect architectural implications, regenerate tasks.md with updated validation steps, then update implementation code.

This flexibility supports real-world development where requirements evolve. The specification-first approach ensures changes propagate systematically rather than being patched into code without updating documentation.

## Leverage GitHub Spec Kit's optional enhancement commands

Beyond the core workflow commands, GitHub Spec Kit provides optional commands that enhance specification quality and consistency.

### Use /speckit.clarify for gap analysis

The `/speckit.clarify` command analyzes your specification to identify ambiguities, missing details, and underspecified edge cases. After generating an initial spec, invoke this command to have the AI ask clarifying questions.

The AI reviews your spec and generates questions like:

- "The spec mentions file upload but doesn't specify maximum concurrent uploads. Should there be a limit?"
- "Error handling for network failures isn't specified. What should happen if upload connection is lost?"
- "The spec requires file validation but doesn't specify validation failure messages. What should users see?"

For each question, the AI often provides multiple-choice options for how to address the gap. You select an option or provide a custom answer, and the AI updates the specification accordingly.

This interactive refinement catches issues before implementation begins. It's like having an experienced analyst review your spec and point out what you missed.

### Use /speckit.analyze for consistency verification

The `/speckit.analyze` command performs cross-artifact consistency checking. It verifies that your plan implements all specification requirements, that tasks cover all plan elements, and that everything aligns with the constitution.

Run this command after generating plan.md and tasks.md but before starting implementation. The AI identifies inconsistencies:

- "Plan proposes using PostgreSQL, but constitution requires Azure SQL Database."
- "Specification requires audit logging, but plan doesn't describe logging implementation."
- "Task list omits database migration scripts mentioned in plan."

Each identified inconsistency is an issue that would surface during implementation or code review. Catching them during analysis phase prevents rework.

### Use /speckit.checklist for quality validation

The `/speckit.checklist` command generates custom quality checklists based on your specification. These checklists help verify requirement completeness, clarity, and consistency—like "unit tests for English prose."

The AI analyzes your spec and produces a checklist of verification questions:

- "Does every user story have corresponding acceptance criteria?"
- "Are all error scenarios documented with specific error messages?"
- "Do nonfunctional requirements include measurable success criteria?"
- "Are all external dependencies explicitly listed?"

You work through the checklist, answering each question. Any "no" answers indicate specification gaps that you need to address.

This self-review process improves specification quality before sharing with stakeholders or proceeding to implementation.

## Apply GitHub Spec Kit to different development scenarios

GitHub Spec Kit supports various development scenarios beyond building new features from scratch.

### Greenfield development

For new projects starting from nothing, GitHub Spec Kit excels at transforming high-level product vision into concrete implementation. You begin with `/speckit.constitution` to establish project principles, then use `/speckit.specify` for each feature as you build the application iteratively.

This scenario is GitHub Spec Kit's primary use case—the workflow was designed for 0-to-1 development where you're creating something that doesn't exist yet.

### Brownfield enhancement

For existing applications, you can use GitHub Spec Kit to add new features while maintaining consistency with existing codebase. Your constitution documents existing architectural patterns and constraints. New feature specifications reference these established patterns.

When you're adding the document upload feature to an existing employee portal, your specification acknowledges the existing React front end, .NET back end, and Azure infrastructure. The plan shows how the new feature integrates with current architecture rather than proposing a separate implementation.

### Refactoring and modernization

GitHub Spec Kit can guide refactoring efforts by treating the desired end state as a specification. You document what the refactored code should achieve (same functionality with improved structure), create a plan for the refactoring approach, and generate tasks for incremental changes.

This structured approach to refactoring prevents the common problem of starting refactoring and getting lost mid-process with partially working code.

### Exploratory development

For situations where you're exploring multiple potential approaches, use GitHub Spec Kit to generate multiple plans from the same specification. The stable specification represents what you want to achieve, while different plans explore different technical approaches.

You might generate one plan using Azure Blob Storage and another using Azure Files, both from the same upload specification. Implement both, compare results, and choose the better approach based on actual experience rather than assumptions.

## Summary

The GitHub Spec Kit is a powerful toolkit that enables spec-driven development by integrating structured workflows, persistent artifacts, and reusable AI command patterns. It transforms how you work with AI coding assistants like GitHub Copilot by providing a systematic approach to turning specifications into working implementations. By using GitHub Spec Kit, you can ensure alignment between requirements and code, maintain traceability of decisions, and enhance collaboration across development teams.
