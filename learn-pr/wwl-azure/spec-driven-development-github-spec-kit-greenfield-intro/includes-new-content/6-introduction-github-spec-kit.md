<!--
## Content Sources

This unit was built from the following source content:

**Primary Sources:**
- includes/3-examine-github-spec-kit.md
  - "What is GitHub Spec Kit?" section
  - "Key components of GitHub Spec Kit" section (Specify CLI, Markdown artifact files, Slash commands)
  - "GitHub Spec Kit's AI agent support" section (Multi-agent compatibility)
  - "Integrate GitHub Spec Kit with Git workflows" section (Project structure conventions)

**Supporting Sources:**
- includes/4-establish-project-principles-constitution-file.md
  - Constitution concept and purpose (for explaining project constitution)
-->

Now that you understand the principles and workflow of spec-driven development, let's introduce the tool that makes SDD practical: GitHub Spec Kit. This open-source toolkit transforms the SDD methodology from a manual process into an AI-assisted workflow that integrates seamlessly with your development environment.

## What is GitHub Spec Kit?

GitHub Spec Kit is an open-source toolkit developed by GitHub to facilitate spec-driven development. It's designed to integrate with AI coding assistants like GitHub Copilot and orchestrate the SDD workflow through structured commands, templates, and persistent artifacts.

Think of GitHub Spec Kit as a co-pilot for your co-pilot—it guides the AI through a structured process, ensuring consistent, high-quality output at each phase of development.

GitHub Spec Kit addresses a fundamental challenge in AI-assisted development: maintaining context and consistency across multiple interactions with coding assistants. Without structure, each chat session with an AI operates in isolation, lacking awareness of previous decisions or overall project requirements. GitHub Spec Kit solves this by:

- **Creating persistent artifacts:** Specifications, plans, and tasks are stored as Markdown files in your repository, creating a permanent record of requirements and decisions.

- **Standardizing the workflow:** A defined process guides you from high-level requirements through specification, planning, task breakdown, and implementation.

- **Providing reusable commands:** Built-in slash commands encapsulate best-practice prompting patterns, so you don't need to craft optimal prompts for each development phase.

Key point: GitHub Spec Kit isn't an AI model itself—it's a framework and CLI that works *with* your chosen AI agent. It helps transform a high-level idea into working code by generating the spec, plan, and tasks with AI, rather than requiring you to write everything manually.

## Core principles of GitHub Spec Kit

GitHub Spec Kit's design directly implements SDD principles:

**Executable specifications:** GitHub Spec Kit makes the spec "executable" by using it to drive code generation through commands. Your specification isn't just documentation—it's the input that produces implementation.

**Structured workflow enforcement:** GitHub Spec Kit guides you through phases in order. You can't effectively implement without first having a spec and plan, because the tool's workflow is designed to build each phase on the previous one.

**Intent-first approach:** You always start by explicitly stating intent (in the spec) in the tool's flow. The creators' goal was to let developers focus on product requirements and outcomes, while the AI handles the boilerplate code.

## Supported project types

GitHub Spec Kit works with different types of projects, adapting its approach to your situation:

### Greenfield projects

When starting from scratch with no existing code, you run GitHub Spec Kit on a blank project and it helps you create everything new. You describe your feature idea, and the toolkit guides you through generating a complete spec, plan, and task list. The lab exercise in this module demonstrates this scenario.

### Brownfield projects

When adding features to an existing codebase, GitHub Spec Kit can initialize in your existing repository. It can help summarize your codebase's structure and rules into a *project constitution*—a document capturing key existing design decisions that informs plans for new features. This ensures AI-generated code remains consistent with your existing code.

### Exploratory projects

When you're exploring multiple potential approaches, GitHub Spec Kit can generate multiple plans from the same specification. You can explore different optimization targets—performance, maintainability, or cost—by generating alternative plans and comparing them before choosing an approach.

### Refactoring and modernization

GitHub Spec Kit can guide refactoring efforts by treating the desired end state as a specification. You document what the refactored code should achieve (same functionality with improved structure), create a plan for the refactoring approach, and generate tasks for incremental changes.

## How GitHub Spec Kit aligns to SDD phases

GitHub Spec Kit provides a command or step for each SDD phase:

| SDD Phase | GitHub Spec Kit Command | Output File |
|-----------|------------------------|-------------|
| Constitution (setup) | `/speckit.constitution` | constitution.md |
| Specify | `/speckit.specify` | spec.md |
| Plan | `/speckit.plan` | plan.md |
| Tasks | `/speckit.tasks` | tasks.md |
| Implement | `/speckit.implement` | Source code |

This one-to-one mapping shows that SDD isn't just theory—GitHub Spec Kit operationalizes it into concrete commands and artifacts.

### Constitution: project principles

Before diving into features, you can establish a project constitution that captures organizational standards, security requirements, and architectural decisions that must be honored throughout development. The AI references this constitution when generating plans and code.

### Specify: requirements capture

The `/speckit.specify` command generates a detailed specification from your high-level feature description. GitHub Copilot prompts for requirements and produces a structured spec.md with all standard sections: user stories, acceptance criteria, functional requirements, nonfunctional requirements, and edge cases.

### Plan: technical design

The `/speckit.plan` command produces a technical implementation plan based on the spec and constitution. You can provide context about existing systems or preferred technologies, and the AI produces architecture decisions, technology choices, and implementation sequences.

### Tasks: work breakdown

The `/speckit.tasks` command breaks down the implementation plan into discrete tasks organized by phases or components. Each task is specific enough to implement and verify independently.

### Implement: guided coding

The `/speckit.implement` command guides you through implementing tasks one at a time, generating code for each task while maintaining consistency with the spec and plan.

## Components included in GitHub Spec Kit

When you set up GitHub Spec Kit, you get several integrated components:

### Specify CLI tool

The `specify` command-line tool initializes and manages spec-driven projects. When you run `specify init` in your project directory, it:

1. Prompts you to select your AI coding assistant
2. Creates a `.github/prompts/` directory with workflow templates
3. Generates a project structure with folders for specifications
4. Creates template files: constitution.md, spec.md, plan.md, tasks.md
5. Configures integration with your chosen AI assistant

### Markdown artifact files

GitHub Spec Kit uses structured Markdown files as primary development artifacts. These files aren't passive documentation—they actively drive AI code generation:

- **constitution.md:** Project-wide principles, constraints, and non-negotiable requirements
- **spec.md:** Feature requirements, user stories, and acceptance criteria
- **plan.md:** Technical architecture and implementation strategy
- **tasks.md:** Discrete, actionable work items

### Slash commands

GitHub Spec Kit integrates with Visual Studio Code through custom chat commands that trigger specific workflow phases. These commands appear in the GitHub Copilot Chat panel after initialization.

### Templates

GitHub Spec Kit includes template files for spec, plan, tasks, and other artifacts, ensuring a standard structure. When you start a new project, templates provide sections to fill in, guiding you on what information to include.

## Multi-agent support

GitHub Spec Kit supports multiple AI coding assistants beyond GitHub Copilot. When you run `specify init`, you select from supported agents:

- GitHub Copilot (integration through Visual Studio Code)
- Claude Code
- Cursor
- Windsurf
- Amazon Q Developer
- And others

The underlying specification artifacts (spec.md, plan.md, tasks.md) remain identical regardless of which AI assistant you use. This agent-agnostic approach prevents vendor lock-in and allows teams to experiment with different AI tools while maintaining consistent SDD practices.

## Why use GitHub Spec Kit?

**Efficiency:** It drafts specs and plans quickly with AI. What might take hours to write from scratch, GitHub Spec Kit can generate in minutes (though you refine it).

**Consistency:** It enforces a consistent format via templates and a consistent approach every time—valuable for teamwork and repeatable processes.

**Multi-agent flexibility:** Use the AI environment you prefer (Visual Studio Code with GitHub Copilot, Claude, or others) without changing your workflow.

**Enterprise ready:** The constitution concept means GitHub Spec Kit is ready to encode company-wide best practices and ensure AI follows them in every plan.

**Open source and extensible:** Organizations can customize templates, contribute improvements, or integrate GitHub Spec Kit with their systems.

GitHub Spec Kit empowers you to accomplish in minutes what might otherwise take days—it's like having an AI project manager guiding your code generation while you focus on what matters: the product requirements and outcomes.

