<!--
## Content Sources

This unit was built from the following source content:

**Primary Sources:**
- includes/3-examine-github-spec-kit.md
  - "Key components of GitHub Spec Kit" → "Slash commands" section
  - "Leverage GitHub Spec Kit's optional enhancement commands" section (/speckit.clarify, /speckit.analyze, /speckit.checklist)
  - "Continuous workflow support" section (command chaining)

**Supporting Sources:**
- includes/4-establish-project-principles-constitution-file.md
  - Constitution purpose and structure (for /speckit.constitution context)
- includes/5-write-effective-spec-file.md
  - Spec structure and sections (for spec.md output context)
- includes/6-create-technical-plan-file.md
  - Plan structure and content (for plan.md output context)
- includes/7-generate-implementation-tasks-file.md
  - Task structure and organization (for tasks.md output context)
-->

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

During initialization, you'll be prompted to select your AI coding assistant. Choose the one you plan to use (for this module, that's GitHub Copilot).

## Creating the constitution

### The /speckit.constitution command

Before diving into features, establish your project's guiding principles. In your AI assistant's chat, type:

```text
/speckit.constitution
```

The AI generates a **constitution.md** file that captures project-wide principles, constraints, and requirements. For a greenfield project, this might be a template you fill in with your standards. For a brownfield project, the AI might analyze your existing codebase to suggest conventions.

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

### The /speckit.specify command

With the constitution in place, create your first feature specification. In the AI chat, provide a description of what you want to build:

```text
/speckit.specify Build a document upload feature that allows employees to upload PDF and Word documents to their personal dashboard. Files should be stored securely and appear in a document list immediately after upload. Users should see upload progress for large files.
```

The AI generates a **spec.md** file based on your description.

### What spec.md contains

The generated specification includes the standard sections you learned about in Unit 5: summary, user stories, acceptance criteria, functional requirements, nonfunctional requirements, and edge cases. For example, a user story might appear as:

> *As an employee, I want to upload documents to my dashboard so that I can access them from any device.*

And acceptance criteria as testable conditions:

> - User can select PDF or DOCX files for upload
> - Maximum file size is 50 MB
> - Files larger than 50 MB display an error message

### Review and refine

The generated spec is a starting point—the AI's interpretation of your prompt. Your job is to:

1. **Verify completeness:** Does it capture all your requirements?
2. **Check accuracy:** Is everything correctly understood?
3. **Add missing details:** Fill in any gaps the AI missed
4. **Remove incorrect items:** Delete anything that doesn't belong

Think of it this way: could you hand this spec to a developer (or AI) and have them understand exactly what to build? If not, refine it until you can.

## Creating the technical plan

### The /speckit.plan command

With a complete specification, create the technical design. Provide guidance about your preferred technologies and constraints:

```text
/speckit.plan Use .NET 8 Web API for the backend, React for the frontend, Azure Blob Storage for file storage, and Azure SQL Database for metadata. Follow RESTful API conventions.
```

The AI generates a **plan.md** file that translates specification requirements into technical decisions.

### What plan.md contains

The generated plan includes the sections covered in Unit 5: architecture overview, technology stack, implementation sequence, constitution verification, and assumptions. The AI translates your specification requirements into technical decisions. For example:

> *Implement a new back-end API endpoint `/api/documents/upload` to handle multipart file uploads. The React front end includes a DocumentUpload component with file picker and progress indicator.*

### Review and adjust

Check that the plan makes sense and aligns with your expectations:

- Are the technology choices appropriate?
- Does the architecture address all specification requirements?
- Is anything from the spec unaddressed in the plan?

If the AI proposed something you don't want (maybe it chose a database you don't prefer), edit the plan. The plan will drive task generation, so it needs to be correct before proceeding.

## Generating the task list

### The /speckit.tasks command

With a solid plan, generate the implementation task list:

```text
/speckit.tasks
```

This command reads the spec and plan to produce a **tasks.md** file—a checklist of discrete work items.

### What tasks.md contains

The generated task list reflects the phase-based organization and task characteristics you learned about in Unit 5. Tasks are organized into logical groups:

**Phase 1: Foundation**
- Set up Azure Blob Storage connection configuration
- Create DocumentMetadata table in SQL database

**Phase 2: Core Upload Functionality**
- Implement POST /api/documents/upload endpoint
- Add file validation logic (size, type)

**Phase 3: Front-end Implementation**
- Create DocumentUpload React component
- Implement upload progress indicator

### Review and verify

Cross-check the task list against the spec and plan:

- Do these tasks, if completed, fulfill everything in the spec?
- Is any requirement missing a corresponding task?
- Are any tasks too vague or too large to implement directly?

If a task says something like "Implement authentication," that's probably too broad—break it down into smaller, specific tasks.

## Implementing the tasks

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

**AI-assisted implementation:** Use `/speckit.implement` to have the AI generate code for each task. Review and validate each piece before moving on.

**Manual implementation with AI help:** Work through tasks yourself, using your AI assistant for code suggestions and completion as needed.

**Hybrid approach:** Use AI for some tasks (especially boilerplate or repetitive work) and write others manually.

### Verify each task

However you implement, verify each task against the specification:

- Does the code do what the spec requires?
- Does it follow the plan's architectural decisions?
- Does it align with constitution principles?

Run tests, manually check behavior, or use whatever verification is appropriate for the task.

### Keeping artifacts updated

If you discover something during implementation that changes the design—maybe you need a different approach than the plan specified—update your artifacts. Edit plan.md (and spec.md if requirements changed) to reflect reality. This keeps your documentation accurate and useful.

## Optional enhancement commands

GitHub Spec Kit provides additional commands for quality and consistency:

### /speckit.clarify

Analyzes your specification to identify ambiguities and missing details. The AI asks clarifying questions like:

> "The spec mentions file upload but doesn't specify maximum concurrent uploads. Should there be a limit?"

Answer the questions, and the AI updates the spec accordingly.

### /speckit.analyze

Performs cross-artifact consistency checking. It verifies that:
- The plan addresses all specification requirements
- Tasks cover all plan elements
- Everything aligns with the constitution

Run this after generating plan and tasks but before implementing.

### /speckit.checklist

Generates quality verification checklists for your specification. Use this for self-review before sharing specs with stakeholders.

## Best practices

**Always review AI outputs:** Don't blindly accept generated content. The AI assists, but you're the domain expert.

**Communicate clearly in prompts:** The quality of output depends on the quality of input. Include all important requirements and constraints.

**Use the constitution for consistency:** Document organizational standards early so all generated artifacts follow them.

**Commit your artifacts:** Save spec.md, plan.md, and tasks.md in your repository alongside code. They're valuable documentation.

**Know when to re-run vs. edit:** If output is significantly wrong, consider re-running with a better prompt. For minor issues, just edit the file directly.

**Follow the sequence:** Run commands in order—spec before plan, plan before tasks. Each builds on the previous outputs.
