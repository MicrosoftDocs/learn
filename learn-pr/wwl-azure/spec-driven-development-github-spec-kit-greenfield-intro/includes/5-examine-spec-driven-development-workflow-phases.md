Each phase of the Spec-Driven Development (SDD) workflow plays a crucial role in transforming ideas into working software. Developers who understand the purpose, content, and output of each phase can apply SDD effectively to their own projects.

> [!NOTE]
> A greenfield application is used to illustrate how each phase of the SDD process builds on the previous phase. The same greenfield scenario is used later in the module when you learn about the GitHub Spec Kit commands that facilitate each phase.

## From vision to execution

Imagine you're building a new application: an RSS Feed Reader that lets users subscribe to feeds, see new articles, and track what they've read. How do you go from this idea to working code using SDD? The answer is a systematic progression through four phases, each producing artifacts that feed into the next.

## Phase 1: Specify

The specification defines exactly what the software should do. Every implementation decision traces back to it. If functionality doesn't appear in the spec, it doesn't appear in the final product unless you update the spec.

### What a good spec contains

A well-structured specification includes several key sections:

- **Summary:** A concise description of the feature from an end-user perspective. This section answers "What does this feature do?" in one or two sentences.

    For example: *"This application enables users to subscribe to RSS and Atom feeds, view articles sorted newest-first, and track read/unread status. Feed data persists locally on the device."*

- **User stories:** Brief narrative descriptions of how users interact with the feature. User stories capture intent and value rather than technical implementation.

    For example:

    - As a user, I want to add RSS feeds by URL so that I can follow my favorite websites.
    - As a user, I want to see unread articles sorted newest-first so that I can catch up on recent content.

- **Acceptance criteria:** Specific, testable conditions that must be true for the feature to be considered complete. Write acceptance criteria as observable facts.

    For example:

    - User can add a feed by entering a valid RSS or Atom URL.
    - Invalid feed URLs display a clear error message.
    - New articles appear after refreshing feeds.
    - Articles display with read/unread status that persists between sessions.

- **Functional requirements:** Detailed descriptions of system behavior - how the feature works. Functional requirements elaborate on user stories with specifics about interfaces, processes, and data handling.

- **Nonfunctional requirements:** Quality attributes like performance, security, and scalability. Nonfunctional requirements ensure AI-generated code meets enterprise quality standards, not just functional correctness.

- **Edge cases:** Unusual scenarios, error conditions, and boundary behaviors. Explicitly documenting edge cases prevents AI from making assumptions that might not match your intent.

### The mindset shift

Writing the spec is as important as writing code. The spec isn't a formality to satisfy project management - it's the artifact that drives AI-assisted code generation. Invest the same care in crafting specs as you would in implementing features manually.

## Phase 2: Plan

A specification defines what you need to build. A technical plan defines *how* you build it. The plan transforms requirements into architecture decisions, ensuring your implementation aligns with both the specification and your project's governing principles.

### What a good plan contains

A plan should include the following elements:

- **Architecture overview:** A high-level view of how components interact. For the RSS Feed Reader:

    *"Build a .NET application with a local SQLite database for storing feeds and articles. A FeedService handles RSS/Atom parsing and validation. The UI displays a feed list and article view with read/unread tracking. When a user adds a feed, the app validates the URL, fetches the feed content, parses articles, and stores them locally."*

- **Technology stack and key decisions:** Explicit documentation of technology choices and rationales. Each decision should align with both specification requirements and organizational principles.

    Example decisions:

    - Runtime: .NET 8 console application.
    - Data storage: SQLite with Entity Framework Core for local persistence.
    - Feed parsing: System.ServiceModel.Syndication for RSS/Atom support.
    - Security: HTML sanitization before rendering article content.

- **Implementation sequence:** The logical order of implementation steps. A typical sequence ensures foundational elements (database schema) exist before dependent components (API that writes to the database).

- **Constitution verification:** A check that proposed solutions align with project principles. If your project constitution includes "HTML content must be sanitized before rendering," the plan verification confirms you're using an HTML sanitization library.

- **Assumptions and open questions:** Documentation of assumptions and unresolved questions. This transparency helps identify potential issues before implementation begins.

### The separation of specification and plan

If you later switch technologies - say, moving from SQLite to a different database - you update the plan while the specification remains largely unchanged. The feature requirements don't change; only the implementation approach changes.

## Phase 3: Tasks

Technical plans provide architectural direction, but implementation requires concrete, actionable steps. The tasks phase converts high-level decisions into specific work items.

### What good tasks look like

Each task should be:

- **Actionable:** The task clearly states what needs to be done.
- **Testable:** You can verify when the task is complete.
- **Independent where possible:** The task can often be completed without waiting for unrelated work.
- **Time-bounded:** A developer can complete the task in a reasonable timeframe.

Here's an example of a well-scoped task: *"Implement an AddFeed method that accepts an RSS/Atom URL. The method validates the feed format, parses the feed content, stores feed metadata and articles in SQLite, and returns the feed ID."*

This task is specific about what to build, what it accepts, what validations to apply, where to store data, and what to return.

### Phase-based organization

Complex features benefit from organizing tasks into phases:

1. **Phase 1 – Foundation:** Set up project structure, create database schema, and add required packages.
1. **Phase 2 – Core functionality:** Implement feed parsing, add URL validation, and implement article storage.
1. **Phase 3 – User interface:** Create feed list view, add article display, and implement read/unread tracking.
1. **Phase 4 – Security:** Add HTML sanitization, implement HTTPS-only feed fetching, and add error handling.
1. **Phase 5 – Testing:** Write unit tests, create integration tests, and document the application.

### Task dependencies

The task order matters. Database schema changes typically come first because back-end code depends on schema existence. Back-end API endpoints come before front-end components that call those endpoints. Testing comes after the code being tested exists.

### Verification checkpoint

Before moving to implementation, review tasks against the plan and spec. For example:

- If a requirement isn't covered by a task, add a corresponding task.
- If a task isn't associated with the plan or spec, evaluate whether the task is needed.

## Phase 4: Implement

If phases 1-3 are done well, implementation should be straightforward. You can execute tasks one by one with clear guidance.

### The implementation process

Implementation follows a simple loop:

1. Select the next task from the tasks list.
1. Write code to implement the task (manually or using AI assistance).
1. Test that the task meets spec and plan expectations.
1. Mark the task complete and move to the next task.

Implementation continues until all tasks are done, meaning the spec's requirements are all implemented. Integrate and test frequently - possibly after each task or small group of tasks - to ensure the system works as a whole.

### Handling discoveries during implementation

During implementation, you might discover something that was missed or needs to be updated. Rather than making ad-hoc code changes, SDD encourages you to go back and update the spec or plan accordingly, then adjust remaining tasks. This process keeps artifacts in sync with reality, maintaining them as living documents.

## Iterative nature and checkpoints

While listed sequentially, SDD allows iteration. Here are some examples:

- After writing a spec, you might get feedback that changes requirements. When requirements change, you should update the spec before creating the plan.
- Halfway through implementation, some edge cases might surface that aren't in the spec. When changes that affect implementation are discovered, you should update your spec, plan, and tasks documents before you continue your implementation.

Iteration is a key advantage. The cost of change is lower because knowledge is captured in the spec and plan. When changes occur, they propagate systematically.

Checkpoints between phases ensure quality and alignment. Before moving from spec to plan, verify the spec is complete and clear. Before moving from plan to tasks, ensure the plan is feasible and detailed enough. Before implementation, confirm tasks cover all requirements. It's better to spend more time upfront than to fix issues later.

## The outcome of SDD workflow

The end state is a fully implemented app or feature where the code aligns with a spec, and you have documentation (spec and plan) that exactly matches the implementation. The alignment between code and documentation provides the following benefits:

- **Maintenance:** Understanding what the system does and why.
- **Onboarding:** New team members can read the spec and plan to understand the system.
- **Trust:** The documentation accurately reflects reality - unlike many projects where docs drift from code.

Writing all these artifacts by hand might sound laborious, but AI tools like GitHub Spec Kit can automate the heavy lifting of creating spec, plan, and tasks.

## Summary

The four phases of spec-driven development - Specify, Plan, Tasks, and Implement - provide a structured workflow that transforms ideas into working software. Each phase produces artifacts that guide the next step, ensuring alignment between requirements and implementation. The living nature of these artifacts allows for continuous adaptation, while the systematic checkpoints maintain quality and coherence throughout the process.
