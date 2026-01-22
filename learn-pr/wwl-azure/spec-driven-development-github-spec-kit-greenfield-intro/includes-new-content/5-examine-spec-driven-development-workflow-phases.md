<!--
## Content Sources

This unit was built from the following source content:

**Primary Sources:**
- includes/5-write-effective-spec-file.md
  - "The spec as the single source of truth" section
  - "Specification structure" section (Summary, User Stories, Acceptance Criteria, Functional Requirements, Nonfunctional Requirements, Edge Cases)
  
- includes/6-create-technical-plan-file.md
  - "Understand the purpose of a technical plan" section
  - "Examine plan structure and content" section (Architecture overview, Technology stack, Implementation sequence, Constitution verification, Assumptions)
  
- includes/7-generate-implementation-tasks-file.md
  - "Benefits of task breakdown" section
  - "Examine task structure and organization" section (Phase-based organization, Task granularity, Dependencies)
  
**Supporting Sources:**
- includes/2-review-spec-driven-development-approach.md
  - "The spec-driven development workflow in practice" section (workflow flow narrative)
-->

You've seen an overview of the SDD phases - now let's examine each phase in detail. Understanding the purpose, content, and output of each phase helps you apply SDD effectively to your own projects. 

Throughout this walkthrough, we'll follow a greenfield application - an RSS Feed Reader - to illustrate how each phase builds on the previous one. This same example will appear when you learn about GitHub Spec Kit commands in Unit 8, showing how the tool automates what we describe here manually.

## From vision to execution

Imagine you're building a new application: an RSS Feed Reader that lets users subscribe to feeds, see new articles, and track what they've read. How do you go from this idea to working code using SDD? The answer is a systematic progression through four phases, each producing artifacts that feed into the next.

## Phase 1: Specify (define the what and why)

The specification defines exactly what the software should do. Every implementation decision traces back to it. If functionality doesn't appear in the spec, it doesn't appear in the final product unless you update the spec.

### What a good spec contains

A well-structured specification includes several key sections:

**Summary:** A concise description of the feature from an end-user perspective. This section answers "What does this feature do?" in one or two sentences.

Example: *"This application enables users to subscribe to RSS and Atom feeds, view articles sorted newest-first, and track read/unread status. Feed data persists locally on the device."*

**User stories:** Brief narrative descriptions of how users interact with the feature. User stories capture intent and value rather than technical implementation.

Example:
- As a user, I want to add RSS feeds by URL so that I can follow my favorite websites.
- As a user, I want to see unread articles sorted newest-first so that I can catch up on recent content.

**Acceptance criteria:** Specific, testable conditions that must be true for the feature to be considered complete. Write these as observable facts.

Example:
- User can add a feed by entering a valid RSS or Atom URL
- Invalid feed URLs display a clear error message
- New articles appear after refreshing feeds
- Articles display with read/unread status that persists between sessions

**Functional requirements:** Detailed descriptions of system behavior - how the feature works. These elaborate on user stories with specifics about interfaces, processes, and data handling.

**Nonfunctional requirements:** Quality attributes like performance, security, and scalability. These ensure AI-generated code meets enterprise quality standards, not just functional correctness.

**Edge cases:** Unusual scenarios, error conditions, and boundary behaviors. Explicitly documenting edge cases prevents AI from making assumptions that might not match your intent.

### The mindset shift

Writing the spec is as important as writing code. The spec isn't a formality to satisfy project management - it's the artifact that drives AI-assisted code generation. Invest the same care in crafting specs as you would in implementing features manually.

## Phase 2: Plan (define the how)

A specification defines what you need to build. A technical plan defines *how* you build it. The plan transforms requirements into architecture decisions, ensuring your implementation aligns with both the specification and your project's governing principles.

### What a good plan contains

- **Architecture overview:** A high-level view of how components interact. For the RSS Feed Reader:

    *"Build a .NET application with a local SQLite database for storing feeds and articles. A FeedService handles RSS/Atom parsing and validation. The UI displays a feed list and article view with read/unread tracking. When a user adds a feed, the app validates the URL, fetches the feed content, parses articles, and stores them locally."*

- **Technology stack and key decisions:** Explicit documentation of technology choices and rationales. Each decision should align with both specification requirements and organizational principles.

    Example decisions:

    - Runtime: .NET 8 console application
    - Data storage: SQLite with Entity Framework Core for local persistence
    - Feed parsing: System.ServiceModel.Syndication for RSS/Atom support
    - Security: HTML sanitization before rendering article content

- **Implementation sequence:** The logical order of implementation steps. A typical sequence ensures foundational elements (database schema) exist before dependent components (API that writes to the database).

- **Constitution verification:** A check that proposed solutions align with project principles. If your project constitution includes "HTML content must be sanitized before rendering," the plan verification confirms you're using an HTML sanitization library.

- **Assumptions and open questions:** Documentation of assumptions and unresolved questions. This transparency helps identify potential issues before implementation begins.

### The separation of specification and plan

If you later switch technologies - say, moving from SQLite to a different database - you update the plan while the specification remains largely unchanged. The feature requirements haven't changed; only the implementation approach has changed.

## Phase 3: Tasks (break it down)

Technical plans provide architectural direction, but implementation requires concrete, actionable steps. The tasks phase converts high-level decisions into specific work items.

### What good tasks look like

Each task should be:

- **Actionable:** The task clearly states what needs to be done
- **Testable:** You can verify when the task is complete
- **Independent where possible:** The task can often be completed without waiting for unrelated work
- **Time-bounded:** A developer can complete the task in a reasonable timeframe

Here's an example of a well-scoped task: *"Implement AddFeed method that accepts an RSS/Atom URL, validates the feed format, parses the feed content, stores feed metadata and articles in SQLite, and returns the feed ID."*

This task is specific about what to build, what it accepts, what validations to apply, where to store data, and what to return.

### Phase-based organization

Complex features benefit from organizing tasks into phases:

- **Phase 1 – Foundation:** Set up project structure, create database schema, add required packages
- **Phase 2 – Core functionality:** Implement feed parsing, add URL validation, implement article storage
- **Phase 3 – User interface:** Create feed list view, add article display, implement read/unread tracking
- **Phase 4 – Security:** Add HTML sanitization, implement HTTPS-only feed fetching, add error handling
- **Phase 5 – Testing:** Write unit tests, create integration tests, document the application

### Task dependencies

The task order matters. Database schema changes typically come first because back-end code depends on schema existence. Back-end API endpoints come before front-end components that call those endpoints. Testing comes after the code being tested exists.

### Verification checkpoint

Before moving to implementation, review tasks against the plan and spec: if some requirement isn't covered by any task, add one; if a task doesn't tie to the plan or spec, question whether it's needed.

## Phase 4: Implement (code the solution)

By this point, if previous steps were done well, implementation should be straightforward - you're executing tasks one by one with clear guidance.

### The implementation process

1. Pick a task from the list
2. Write code to complete that task (with AI assistance)
3. Test that the task meets spec and plan expectations
4. Mark the task complete and move to the next

This continues until all tasks are done, meaning the spec's requirements are all implemented. Integrate and test frequently - possibly after each task or small group of tasks - to ensure the system works as a whole.

### Handling discoveries during implementation

During implementation, you might discover something that was missed or needs change. Rather than making ad-hoc code changes, SDD encourages you to go back and update the spec or plan accordingly, then adjust remaining tasks. This keeps artifacts in sync with reality, maintaining them as living documents.

## Iterative nature and checkpoints

While listed sequentially, SDD allows iteration. After writing a spec, you might get feedback that changes requirements - update the spec before creating the plan. Halfway through coding, an edge case might surface that isn't in the spec - pause, update spec and plan, add tasks, then continue.

This is a key advantage: the cost of change is lower because all knowledge is captured in the spec and plan, so changes propagate systematically. Additionally, emphasize the "don't move on until validated" rule at each phase - it's better to spend more time upfront than to fix issues later.

## The outcome of SDD workflow

The end state is a fully implemented feature where the code aligns with a spec, and you have documentation (spec and plan) that exactly matches the implementation. This is powerful for:

- **Maintenance:** Understanding what the system does and why
- **Onboarding:** New team members can read the spec and plan to understand the system
- **Trust:** The documentation accurately reflects reality - unlike many projects where docs drift from code

Writing all these artifacts by hand might sound laborious, but this is exactly why GitHub released Spec Kit - to automate the heavy lifting of creating spec, plan, and tasks using AI. In the next units, you'll learn how Spec Kit facilitates these phases.
