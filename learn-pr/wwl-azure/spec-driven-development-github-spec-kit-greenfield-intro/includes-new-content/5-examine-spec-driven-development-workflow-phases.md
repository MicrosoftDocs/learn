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

You've seen an overview of the SDD phases—now let's examine each phase in detail. Understanding the purpose, content, and output of each phase helps you apply SDD effectively to your own projects. 

Throughout this walkthrough, we'll follow a hypothetical feature—adding document upload capability to an employee portal—to illustrate how each phase builds on the previous one. This same example will appear when you learn about GitHub Spec Kit commands in Unit 8, showing how the tool automates what we describe here manually.

## From vision to execution

Imagine you have a feature in mind: employees should be able to upload PDF and Word documents to their personal dashboard for access from any device. How do you go from this idea to working code using SDD? The answer is a systematic progression through four phases, each producing artifacts that feed into the next.

## Phase 1: Specify (define the what and why)

The specification defines exactly what the software should do. Every implementation decision traces back to it. If functionality doesn't appear in the spec, it doesn't appear in the final product unless you update the spec.

### What a good spec contains

A well-structured specification includes several key sections:

**Summary:** A concise description of the feature from an end-user perspective. This section answers "What does this feature do?" in one or two sentences.

Example: *"This feature enables employees to upload PDF and DOCX documents to their personal dashboard. Files are stored securely and appear in the user's document list immediately after upload."*

**User stories:** Brief narrative descriptions of how users interact with the feature. User stories capture intent and value rather than technical implementation.

Example:
- As an employee, I want to upload documents to my dashboard so that I can access them from any device.
- As an employee, I want to see upload progress for large files so that I know the system is processing my request.

**Acceptance criteria:** Specific, testable conditions that must be true for the feature to be considered complete. Write these as observable facts.

Example:
- User can select PDF or DOCX files for upload
- Maximum file size is 50 MB
- Files larger than 50 MB display an error message
- Successfully uploaded files appear in the document list within 2 seconds

**Functional requirements:** Detailed descriptions of system behavior—how the feature works. These elaborate on user stories with specifics about interfaces, processes, and data handling.

**Nonfunctional requirements:** Quality attributes like performance, security, and scalability. These ensure AI-generated code meets enterprise quality standards, not just functional correctness.

**Edge cases:** Unusual scenarios, error conditions, and boundary behaviors. Explicitly documenting edge cases prevents AI from making assumptions that might not match your intent.

### The mindset shift

Writing the spec is as important as writing code. The spec isn't a formality to satisfy project management—it's the artifact that drives AI-assisted code generation. Invest the same care in crafting specs as you would in implementing features manually.

## Phase 2: Plan (define the how)

A specification defines what you need to build. A technical plan defines *how* you build it. The plan transforms requirements into architecture decisions, ensuring your implementation aligns with both the specification and your project's governing principles.

### What a good plan contains

**Architecture overview:** A high-level view of how components interact. For the document upload feature:

*"Implement a new back-end API endpoint to handle multipart file uploads. The React front end includes a new DocumentUpload component with a file picker and progress indicator. When a user selects a file, the front end validates size and type before uploading. The back end receives the file, validates again, stores it in cloud storage, and records metadata in the database."*

**Technology stack and key decisions:** Explicit documentation of technology choices and rationales. Each decision should align with both specification requirements and organizational principles.

Example decisions:
- Back end: .NET 8 Web API with Azure.Storage.Blobs SDK
- Front end: React with a standard upload component for UI consistency
- Storage: Azure Blob Storage container for file persistence
- Authentication: Microsoft Entra ID token from the portal's authentication context

**Implementation sequence:** The logical order of implementation steps. A typical sequence ensures foundational elements (database schema) exist before dependent components (API that writes to the database).

**Constitution verification:** A check that proposed solutions align with project principles. If your project constitution includes "All data storage must use Azure services," the plan verification confirms you're using Azure Blob Storage.

**Assumptions and open questions:** Documentation of assumptions and unresolved questions. This transparency helps identify potential issues before implementation begins.

### The separation of specification and plan

If you later switch technologies—say, moving from Azure Blob Storage to a different storage service—you update the plan while the specification remains largely unchanged. The feature requirements haven't changed; only the implementation approach has changed.

## Phase 3: Tasks (break it down)

Technical plans provide architectural direction, but implementation requires concrete, actionable steps. The tasks phase converts high-level decisions into specific work items.

### What good tasks look like

Each task should be:
- **Actionable:** The task clearly states what needs to be done
- **Testable:** You can verify when the task is complete
- **Independent where possible:** The task can often be completed without waiting for unrelated work
- **Time-bounded:** A developer can complete the task in a reasonable timeframe

**Example well-scoped task:** *"Implement POST /api/documents/upload endpoint that accepts multipart file uploads, validates file size is under 50 MB, stores the file in Azure Blob Storage, and returns the blob URL and document ID."*

This task is specific about what to build, what it accepts, what validations to apply, where to store files, and what to return.

### Phase-based organization

Complex features benefit from organizing tasks into phases:

- **Phase 1 – Foundation:** Set up configuration, create database schema, add required packages
- **Phase 2 – Core functionality:** Implement API endpoint, add validation, implement storage integration
- **Phase 3 – Front end:** Create upload component, add progress indicator, handle responses
- **Phase 4 – Security:** Add authentication checks, implement server-side validation, add audit logging
- **Phase 5 – Testing:** Write unit tests, create integration tests, document the API

### Task dependencies

The task order matters. Database schema changes typically come first because back-end code depends on schema existence. Back-end API endpoints come before front-end components that call those endpoints. Testing comes after the code being tested exists.

### Verification checkpoint

Before moving to implementation, review tasks against the plan and spec: if some requirement isn't covered by any task, add one; if a task doesn't tie to the plan or spec, question whether it's needed.

## Phase 4: Implement (code the solution)

By this point, if previous steps were done well, implementation should be straightforward—you're executing tasks one by one with clear guidance.

### The implementation process

1. Pick a task from the list
2. Write code to complete that task (with AI assistance)
3. Test that the task meets spec and plan expectations
4. Mark the task complete and move to the next

This continues until all tasks are done, meaning the spec's requirements are all implemented. Integrate and test frequently—possibly after each task or small group of tasks—to ensure the system works as a whole.

### Handling discoveries during implementation

During implementation, you might discover something that was missed or needs change. Rather than making ad-hoc code changes, SDD encourages you to go back and update the spec or plan accordingly, then adjust remaining tasks. This keeps artifacts in sync with reality, maintaining them as living documents.

## Iterative nature and checkpoints

While listed sequentially, SDD allows iteration. After writing a spec, you might get feedback that changes requirements—update the spec before creating the plan. Halfway through coding, an edge case might surface that isn't in the spec—pause, update spec and plan, add tasks, then continue.

This is a key advantage: the cost of change is lower because all knowledge is captured in the spec and plan, so changes propagate systematically. Additionally, emphasize the "don't move on until validated" rule at each phase—it's better to spend more time upfront than to fix issues later.

## The outcome of SDD workflow

The end state is a fully implemented feature where the code aligns with a spec, and you have documentation (spec and plan) that exactly matches the implementation. This is powerful for:

- **Maintenance:** Understanding what the system does and why
- **Onboarding:** New team members can read the spec and plan to understand the system
- **Trust:** The documentation accurately reflects reality—unlike many projects where docs drift from code

Writing all these artifacts by hand might sound laborious, but this is exactly why GitHub released Spec Kit—to automate the heavy lifting of creating spec, plan, and tasks using AI. In the next units, you'll learn how Spec Kit facilitates these phases.
