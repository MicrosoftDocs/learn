<!--
## Content Sources

This unit was built from the following source content:

**Primary Sources:**
- includes/2-review-spec-driven-development-approach.md
  - "The shift to spec-driven development" section
  - "The spec-driven development workflow in practice" section
  - "The core principles of spec-driven development" section
  - "Why spec-driven development matters now" section

**Supporting Sources:**
- includes/5-write-effective-spec-file.md
  - "The spec as the single source of truth" section (Specify phase details)
- includes/6-create-technical-plan-file.md
  - "Understand the purpose of a technical plan" section (Plan phase details)
- includes/7-generate-implementation-tasks-file.md
  - "Benefits of task breakdown" section (Tasks phase details)
  - "Phase-based organization" section
-->

Spec-driven development (SDD) is built on a core philosophy: specifications drive code, not the other way around. Before you explore the tools and commands that support this methodology, it's important to understand the guiding principles and the four-phase workflow that makes SDD effective.

## Intent-first philosophy

In traditional software development, code is the ultimate source of truth. Developers write specifications, design documents, and diagrams, but these artifacts are often subordinate to the code itself. As code moves forward, specs rarely keep pace. The documentation becomes stale, and the gap between what was intended and what was built widens over time.

SDD inverts this relationship. The specification defines exactly what the software should do, and every implementation decision traces back to it. If functionality doesn't appear in the spec, it doesn't appear in the final product unless someone updates the spec and regenerates the artifacts.

This shift in mindset means that writing the spec is as important as writing code. The spec isn't a formality to satisfy project management—it's the artifact that drives AI-assisted code generation. When you modify requirements, you update the spec and regenerate the plan and tasks. The spec version-controlled in Git becomes the authoritative record of what each feature should accomplish.

This intent-first approach means:

- The specification becomes the primary artifact
- Code becomes an expression of the spec in a particular language and framework
- Maintaining software means evolving specifications
- Debugging means fixing specifications that generate incorrect code
- Refactoring means restructuring specs for clarity

## SDD workflow overview

The SDD workflow transforms an idea into working code through four distinct phases. Each phase builds on the previous one, creating a clear progression from vision to execution.

### Phase 1: Specify

The workflow begins with an idea—often vague and incomplete. Through iterative dialogue with AI, this idea becomes a comprehensive specification. The AI asks clarifying questions, identifies edge cases, and helps define precise acceptance criteria. What might take days of meetings and documentation in traditional development happens in hours of focused specification work.

The specification defines *what* the software should do, including:

- Feature summaries from an end-user perspective
- User stories that capture intent and value
- Specific, testable acceptance criteria
- Detailed functional requirements
- Nonfunctional requirements for performance, security, and scalability
- Edge cases and error handling scenarios

### Phase 2: Plan

A specification defines what you need to build. A technical plan defines *how* you build it. The planning phase transforms requirements into executable architecture decisions, ensuring your implementation aligns with both the specification and your project's governing principles.

The plan bridges the gap between high-level requirements and concrete implementation tasks. If you later need to switch technologies—say, moving from one storage service to another—you update the plan while the specification remains largely unchanged. The feature requirements haven't changed; only the implementation approach has changed.

A comprehensive technical plan contains:

- Architecture overview describing how components interact
- Technology stack and key decisions with rationales
- Implementation sequence outlining the order of steps
- Verification that proposed solutions align with project principles
- Assumptions and open questions that need addressing

### Phase 3: Tasks

Technical plans provide architectural direction, but implementation requires concrete, actionable steps. The tasks phase converts high-level architectural decisions into specific work items.

Each task represents a discrete unit of work that can be implemented, tested, and verified independently. This granular approach prevents overwhelming complexity and provides clear checkpoints throughout the implementation process. Tasks are:

- **Actionable**: The task clearly states what needs to be done
- **Testable**: You can verify when the task is complete
- **Independent where possible**: The task can often be completed without waiting for unrelated work
- **Time-bounded**: A developer can complete the task in a reasonable timeframe

Complex features benefit from phase-based organization, where each phase represents a logical grouping of related tasks that build toward a specific milestone. The task order matters—some tasks must complete before others can begin.

### Phase 4: Implement

Code generation begins as soon as specifications and their implementation plans are stable enough—but they don't have to be complete. Early generations might be exploratory, testing whether the specification makes sense in practice.

During implementation:

- Domain concepts become data models
- User stories become API endpoints
- Acceptance scenarios become tests
- Tasks are completed systematically with verification at each step

This phase merges development and testing through specification—test scenarios aren't written after code, they're part of the specification that generates both implementation and tests.

## Living artifacts

Unlike static requirements documents that are created once and gradually become outdated, SDD outputs are **living artifacts** that can evolve. The spec might get updated as you learn new information, and then you'd adjust the plan and tasks accordingly.

This concept parallels Agile's inspect-and-adapt philosophy, but in SDD, the spec itself adapts. When a product manager updates acceptance criteria, implementation plans can automatically flag affected technical decisions. When an architect discovers a better pattern, the specification updates to reflect new possibilities.

The feedback loop extends beyond initial development:

- Production metrics and incidents don't just trigger hotfixes—they update specifications for the next regeneration
- Performance bottlenecks become new nonfunctional requirements
- Security vulnerabilities become constraints that affect all future generations

This iterative dance between specification, implementation, and operational reality is where true understanding emerges.

## SDD and AI collaboration

SDD pairs naturally with AI assistance. The developer's role shifts to **steering**—crafting the spec, setting constraints, and verifying outputs—while the AI's role is to generate detailed artifacts and code from those instructions.

This partnership means developers can work at a higher level of abstraction, focusing on intent and design while trusting the AI to handle boilerplate or repetitive code generation under their guidance. AI assistants can:

- Help transform vague ideas into comprehensive specifications through iterative dialogue
- Generate technical plans that map requirements to architectural decisions
- Create detailed task breakdowns from high-level plans
- Produce code that implements the specified requirements
- Analyze specifications for ambiguity, contradictions, and gaps

Throughout this process, consistency validation continuously improves quality. AI analyzes specifications not as a one-time gate, but as an ongoing refinement—catching issues before they become implementation problems.

The key insight is that humans provide direction and verification, while AI provides draft outputs. This division of labor enables rapid iteration, systematic alignment, and continuous evolution of your software.

