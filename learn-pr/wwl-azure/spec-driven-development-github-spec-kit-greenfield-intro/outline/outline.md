# Get started with spec-driven development and GitHub Spec Kit

## Module Overview and Prerequisites

**Target Audience:** Professional software developers (2+ years experience) who have used AI-assisted coding tools like GitHub Copilot, but are new to Spec-Driven Development (SDD) and GitHub Spec Kit.

**Module Focus:** Teach the fundamentals of SDD methodology and how to apply it using GitHub Spec Kit. The module is language-agnostic in concept units, with a final lab in C# (.NET) on Visual Studio Code. This module lays the groundwork for the more advanced *"Implement Spec-Driven Development using the GitHub Spec Kit"* module (some foundational topics are migrated here from that module).

**What to Expect:** Learners will begin with an investigation of "what SDD is" and how it compares to other dev approaches. They will then learn about each phase of the SDD workflow (Specify → Plan → Tasks → Implement) at a high level. Next, the module introduces GitHub Spec Kit – the open-source toolkit that enables SDD with AI – covering what it is, how to install it in various environments, and how to use its commands. Finally, a guided lab will walk through creating a new (small) application with Spec Kit and GitHub Copilot, followed by an assessment to verify their understanding of the content and a summary with next steps.

**Prerequisites:** Before starting, ensure you have a suitable dev setup for the lab: **Visual Studio Code**, **GitHub Copilot** (or another supported AI assistant), and basic familiarity with using Visual Studio Code and Git. (The Spec Kit installation unit will detail additional requirements like Python, uv tool, etc., needed to run Spec Kit.) [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

---

## Module Outline

Use the following outline generate unit content in the "includes" folder. Each unit in the outline includes a goal, sections/topics, learning outcomes, and content development considerations.

### Unit 1: Introduction

Introduction unit is created separately. Existing unit content should not be modified.

### Unit 2: What is Spec-Driven Development (SDD)

- **Unit Goal:** Introduce the concept of Spec-Driven Development, emphasizing how it "flips the script" of traditional development. Motivate the need for SDD by highlighting current challenges with AI-assisted coding ("vibe coding") and how SDD addresses them.

- **Sections/Topics:**

    1. **From Vibe-Coding to Intent-First Coding:** Open with the problem SDD solves. Describe how with powerful coding AI, developers often just provide a high-level prompt and get a chunk of code that "looks right" but may miss the intent or have errors. This is "vibe coding" – fast but sometimes misaligned. Introduce SDD as the solution: it shifts focus to **clear intent and specifications up front**, so the AI isn't guessing the requirements. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Key features of spec-driven development** – Provide a concise definition. SDD is a methodology where **executable specifications drive the creation of software**, rather than code leading the way. In SDD, the spec isn't a throwaway document; it's a living artifact that directly contributes to code generation and validation. Essentially, *the spec becomes the code's single source of truth*. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Why SDD Matters Now:** Explain why SDD is emerging now, in the context of AI coding assistants. Traditional development often sidelined specs, but with AI, a clear spec can be used by the tool to generate reliable code. Emphasize benefits relevant to modern development: **fewer misunderstandings** (because AI has a precise blueprint), **higher quality code** (because requirements and constraints are explicit from the start), and **faster development** in complex projects (AI can generate large parts of the solution if steered correctly by a spec). Tie this to enterprise pain points: miscommunications, costly late fixes, etc., are reduced by having a solid spec that is continuously referenced. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

- **Learning Outcomes:** After Unit 2, learners should be able to **explain what Spec-Driven Development is** in their own words and **justify its importance**. They should grasp that SDD treats specifications as central, executable pieces of the development process (not just documentation), and be aware that this approach is particularly suited for AI-assisted development to avoid the pitfalls of vague prompts. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

- **Content Development Considerations:**

    - Use relatable analogies: e.g., comparing building software to construction – traditionally we might wing it with minimal plans (vibe coding), but SDD is like creating a detailed blueprint first that the builder (AI) strictly follows.

    - Avoid diving into any specific tools or phases yet; keep it high-level. However, you can foreshadow that an open-source tool (Spec Kit) exists to facilitate this approach (since it will be covered later).

    - Mention real-world scenario: for instance, how an AI might misinterpret a simple request ("build login feature") without details, versus having a precise spec for login (with security requirements, etc.). This primes the learner to appreciate the upcoming content.

    - Since this is the first unit, maintain an engaging tone. Perhaps include a quote or statistic from industry about project failures due to unclear requirements (if available) to reinforce why focusing on specs can save projects.

### Unit 3: Examine the spec-driven development principles and process

- **Unit Goal:** Establish the foundational principles of spec-driven development and outline the overall SDD workflow in broad strokes. This unit solidifies key ideas (like "intent-first" development) and provides a bird's-eye view of how an idea moves from specification to implementation in SDD.

- **Sections/Topics:**

    1. **Intent-First Philosophy:** Introduce the mindset change with SDD: *"Intent (the spec) comes before implementation."* Contrast this with normal code-first approaches. Highlight that in SDD, you invest effort up front to articulate **what** the software should do (the intention) in a way an AI or team can unequivocally understand. The philosophy treats the spec as the north star throughout development: if confusion arises, you return to the spec for answers. This sets the stage for all subsequent steps. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **SDD Workflow Overview:** Present the **four-phase SDD process** at a high level: **Specify → Plan → Tasks → Implement** (we will delve into each in Unit 5, so here just give a preview). Describe in one sentence each: [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Specify:** Define the desired outcome and requirements (focus on what and why, not how). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Plan:** Decide on the technical approach to fulfill the spec (architecture, tech stack, constraints). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Tasks:** Break down spec and plan into actionable, bite-sized development tasks. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Implement:** Write the code to complete each task, guided by the previous artifacts. Emphasize that *each phase has a checkpoint/validation step* before moving on – the spec must be reviewed for completeness, the plan for feasibility, tasks for coverage, and code for compliance with all of the above. This structured progression is key to SDD's reliability. A simple diagram in content (e.g., a linear flow or cycle) can reinforce this. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Living Artifacts:** Convey that in SDD, the outputs of each phase (spec document, plan, task list, code) are **living artifacts** that can evolve. Unlike a static requirements doc, the spec might get updated as you learn new info, and then you'd adjust plan/tasks accordingly. Draw parallel to Agile's inspect-and-adapt, but here the spec itself adapts. This concept will be touched again with Spec Kit's process, but it's important to plant the idea now that SDD is iterative (you can loop back to Specify/Plan if changes occur). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **SDD and AI Collaboration:** Since our audience uses AI tools, explain how AI fits into this workflow generally: The developer's role shifts to **steering** (crafting the spec, setting constraints) and **verifying** outputs, while the AI's role is to generate detailed artifacts and even code from those instructions. This partnership means developers can work at a higher level of abstraction (focusing on intent and design), trusting the AI to fill in boilerplate or repetitive code, albeit under guidance. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

- **Learning Outcomes:** Learners should come away with a clear mental model of the SDD process. They should be able to list the four phases in order and describe the purpose of each. For example, if asked, *"What happens after you finish writing a spec in SDD?"* they'd answer: *"You create a technical plan that addresses how to implement that spec."* They should also appreciate that SDD is a **disciplined, stepwise approach** that involves checking each output (spec, plan, etc.) before proceeding. Additionally, they should grasp that this process pairs well with AI assistance, with humans providing direction and AI providing draft outputs. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

- **Content Development Considerations:**

    - Include a visual or table summarizing the phases with a brief description for each. This acts as a reference point that can be revisited in later units (especially Unit 4 and the Spec Kit units).

    - Given this is abstract, you might use a running example to illustrate. Perhaps, "Imagine we want to build an Issue Tracker app." Then very briefly, "In Specify we'd outline user needs (report issues, track status, etc.), in Plan we'd decide e.g. to use a web app with database X, in Tasks we'd list features to implement (create issue API, UI for editing, etc.), and in Implement we'd code those features." This example can then be reused or expanded in later units or the lab.

    - Avoid tool-specific jargon here (no need to mention Spec Kit commands yet). However, you can reassure learners that **tools exist to support this workflow**. For instance: "Manually creating all these artifacts might sound like extra work, but modern tools (like GitHub Spec Kit, which we'll learn soon) automate much of the heavy lifting." This prepares them to be receptive in Unit 6 onwards.

    - Keep an eye on not overlapping too much with Unit 5 (phases). Unit 3 is the overview; Unit 5 will revisit the phases in more detail (albeit still high-level). Ensure Unit 3 stays at the summary level and whets appetite for the deep dive later.

### Unit 4: Compare spec-driven development with other methodologies

- **Unit Goal:** Position Spec-Driven Development relative to other well-known software development methodologies (such as Waterfall, Agile/Scrum, Test-Driven Development, Behavior-Driven Development). This helps learners connect SDD to concepts they already know and dispel any misconceptions (e.g., "Is SDD just TDD with AI?").

- **Sections/Topics:**

    1. **SDD vs. Waterfall:** Contrast how specs are used. In Waterfall, a requirements spec is written once and often becomes stale as development progresses. In SDD, the spec is continuously used and updated; it directly generates implementations rather than being just a phase document. Highlight that SDD retains the discipline of upfront planning from Waterfall but avoids Waterfall's rigidity by keeping the spec "alive" and revisitable (iterative). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **SDD vs. Agile/Scrum:** Compare SDD with iterative Agile practices. Agile values "working software over comprehensive documentation," which might sound opposite to SDD's spec focus. Clarify that SDD doesn't mean writing a huge spec and sticking to it no matter what – rather, *it means any given increment (even within a sprint) starts with a clear spec and plan*. SDD can operate within Scrum: e.g., each user story could be treated with an SDD micro-cycle (spec, plan, tasks, implement for that story). Emphasize that SDD and Agile share an iterative mindset; SDD simply brings more formalism to each iteration. Outcome: SDD supports agility by making changes easier – update spec, regenerate plan/tasks, continue (which is faster than ad-hoc mid-sprint pivots without clear docs). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **SDD vs. Test-Driven Development (TDD):** Identify the differences and how they can complement. TDD writes tests first to drive design; SDD writes a specification first to drive design and code. Point out: In SDD, you often still create tests (maybe as part of tasks or during implementation) but the *spec itself plays a role similar to a super-test by defining acceptance criteria* for all functionality. Also note that tasks in SDD function like a guide for the AI akin to how tests guide TDD development – each task is small and verifiable, almost like an acceptance test the AI aims to satisfy. However, TDD is very low-level (unit tests), whereas SDD works at a higher requirements level. They're not mutually exclusive: one could use SDD to produce a clear direction and still use TDD within implementation for quality. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **SDD vs. Behavior-Driven Development (BDD):** BDD focuses on examples and user behavior (Given-When-Then scenarios) to drive development. This is conceptually similar to SDD's "focus on what and why" in the spec phase. The difference is execution: BDD results in automated tests that developers then satisfy with code; SDD's spec and plan result in tasks and code generated with AI. Point out that one could integrate BDD-style scenarios into the SDD spec (for example, listing Gherkin scenarios as part of requirements), thereby having the best of both worlds: the AI could even use those scenarios to validate the implementation if tests are generated. Summarize: Both put requirements first; SDD uses AI to go further by creating actual code from those requirements. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Where SDD Shines (and doesn't):** Wrap up with an objective view. SDD is particularly powerful for:

        - **Complex Projects with Clear Goals:** where investing time to specify yields big returns (enterprise systems, critical apps).

        - **AI-Accelerated Development:** teams using AI tools will reap more benefits by structuring their input (specs) to the AI. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Cross-team Communication:** the spec and plan artifacts serve as clear communication mediums between product, dev, and even AI agent, reducing misalignment.

        Conversely, mention scenarios where SDD might be overkill: e.g., quick one-off scripts or prototypes where formal specs would slow you more than help. In those cases, a lightweight approach might suffice. This helps learners understand SDD is a tool in their toolkit, not a silver bullet for every single scenario.

- **Learning Outcomes:** Learners should be able to **distinguish SDD from Agile, TDD, BDD**, etc., stating at least one key difference for each. For example, they might explain: "In TDD you write tests first, whereas in SDD you write a spec first that covers high-level requirements, guiding even the test-writing step." They should also recognize that **SDD can integrate with existing practices** (it's not an all-or-nothing proposition). If asked when SDD is most useful, they should identify scenarios like large or long-term projects and when using AI for coding.

- **Content Development Considerations:**

    - Use a comparison table for clarity: columns for SDD, Waterfall, Agile, TDD, BDD; rows for aspects like "Primary driver artifact", "When written", "Role of automation/AI", "Iteration allowed or not", etc. This visual summary can help cement differences.

    - Provide concrete examples: e.g., "Let's say the requirement is to add a social login feature." Briefly outline how each methodology might approach it:

        - Waterfall: Detailed requirement spec -> months later code, spec possibly outdated.
        - Agile: Story in backlog -> code in sprints, maybe minimal documentation.
        - TDD: Write a test like "login with Google returns user data" -> write code to pass it.
        - BDD: Write a scenario "Given a user wants to login via Google…" -> automate it, then code.
        - SDD: Write spec detailing the user flow, security needs, third-party API interactions -> AI helps produce a plan (maybe pick OAuth library, data model), tasks (setup OAuth client, UI button, callback endpoint), and even code.

    - Reinforce complementarity: e.g., state that an Agile team can adopt SDD within each sprint, or an SDD process can produce tests (TDD/BDD) as part of tasks. Avoid framing it as SDD vs. everyone; instead, SDD as an evolution that stands on shoulders of those methods, enabled by AI.

    - Keep tone respectful to existing methods (some learners may be fans of TDD/BDD). We're introducing SDD as an improvement especially in an AI-driven world, not dismissing prior art.

### Unit 5: Examine the spec-driven development workflow phases

- **Unit Goal:** Provide a cohesive walk-through of all four SDD phases (Specify, Plan, Tasks, Implement) in one unit, giving learners a more concrete understanding of how each phase works and ties to the next. This unit operates at a higher level than a step-by-step tutorial, but deeper than the quick overview in Unit 3 – it illustrates the flow from start to finish in a narrative form.

- **Sections/Topics:**

    1. **From Vision to Execution:** Start by framing the scenario: You have a software idea or feature in mind – how do you go from idea to working code using SDD? This serves as an introduction to then break down the phases.

    1. **Phase 1 – Specify (Define the What and Why):** In this phase, you create the **Specification** document. Describe what a good spec contains in SDD: clear description of the problem, user personas or use cases, functional requirements (what the system should do), and acceptance criteria (how to tell if it's done right). It may also include non-functional requirements if known (performance needs, etc.), but not design or solutions. The spec should be detailed enough that an outsider (or an AI) understands exactly what needs to be built and why. Emphasize that this is written in natural language (often structured in Markdown), making it understandable and verifiable. The outcome of this phase is a draft spec that is reviewed and refined until it accurately captures the intended functionality. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Phase 2 – Plan (Define the How):** Now the focus shifts to design and architecture. Explain that in the **Plan** phase, the goal is to decide *how* to implement the spec. This produces a **Technical Plan** document. Key contents of the plan: chosen architecture (e.g., client-server, microservice, module breakdown), technology stack (programming language, frameworks, libraries – aligned with any organizational standards), data models or schemas, and major components or interfaces. Essentially, for each aspect of the spec's requirements, the plan outlines the solution approach. Importantly, it also documents constraints and principles (drawn from something like a project "constitution" if available – e.g., "all user data must be encrypted at rest" or "use existing payment service for transactions"). The plan should trace back to spec items (if spec says "user can upload photo", plan says "we will use Azure Blob Storage to store photos"). After drafting, this plan is reviewed to ensure it's feasible, complete, and in line with the spec (if the spec had a requirement and the plan doesn't address it, that's a gap to fix). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Phase 3 – Tasks (Break it Down):** With a solid plan, the next step is to create a **Task List**. Explain that tasks are derived from the plan – each task is a bite-sized piece of work that a developer (or AI) can implement and verify independently. Example: If the plan says "Implement authentication using OAuth2," tasks might be: "Create login page UI," "Set up OAuth2 client with Google," "Handle OAuth callback and store user profile." Emphasize what makes tasks good: *small scope*, *clear goal*, *testable outcome*. Mention that in SDD, tasks often include or imply their own acceptance checks (like "verify email format on registration" would naturally be tested when done). This phase ensures nothing from the plan is forgotten – you methodically go through the plan and turn each part into zero or more tasks until there's a comprehensive to-do list. A checkpoint here is to review the tasks against the plan & spec: if some requirement isn't covered by any task, add one; if a task doesn't tie to the plan/spec, question if it's needed. The final output is an ordered (or prioritized) list of tasks ready for implementation. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Phase 4 – Implement (Code the Solution):** The last phase is where coding happens. Stress that by this point, if previous steps were done well, implementation should be straightforward – it's about executing the tasks one by one. *Explain the implement phase process:* Pick a task, write code for it (with or without AI assistance, though presumably with AI in our context), then test that task's completion (does it meet the spec and plan expectations?). Then move to the next task. This continues until all tasks are done, meaning the spec's requirements are all implemented. In an SDD mindset, you typically integrate and test frequently (possibly after each task or small group of tasks) to ensure the system works as a whole and meets the spec. Also mention: during implementation, you might discover something that was missed or needs change – rather than hacking in code, SDD encourages you to **go back and update the spec or plan** accordingly, then regenerate or adjust remaining tasks. This keeps those artifacts in sync with reality (making them "living documents"). Once implementation of all tasks is complete and final testing shows the spec is satisfied, the development cycle is done. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Iterative Nature and Checkpoints:** Reiterate that while listed sequentially, SDD allows iteration. For instance, after writing a spec, you might get feedback that changes requirements – you update the spec (iteration in phase 1) before doing plan. Or halfway through coding, an edge-case is found that isn't in the spec – you pause, update spec and plan, maybe add tasks, then continue (that's an iteration back to earlier phases). This is a key advantage: *the cost of change is lower* because all knowledge is captured in the spec/plan, so changes propagate systematically. Additionally, emphasize the "don't move on until validated" rule at each phase – it's better to spend a bit more time upfront than to fix issues later. For example, catching a missing requirement while planning is much cheaper than discovering it when coding or after deployment. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Outcome of SDD Workflow:** Conclude the unit by painting the end state: a fully implemented feature or project where the code aligns with a spec, and you have documentation (spec and plan) that exactly matches the implementation. This is powerful for maintenance and onboarding new team members – they can read the spec/plan to understand the system and trust that it's accurate. Also, note how unusual this is compared to many projects where docs drift from code. This "single source of truth" outcome is a selling point of SDD.

- **Learning Outcomes:** By the end of Unit 4, learners should be able to **describe the purpose and content of each SDD phase** in detail. If asked to walk through how they'd approach a new feature using SDD, they should logically say: "First, gather requirements and write a spec. Second, come up with a design/plan to meet the spec. Third, break the plan into tasks. Fourth, code each task and verify the results." Additionally, they should internalize the importance of reviewing at each stage and how the phases flow into one another. They will be prepared to see this in action with Spec Kit in upcoming units.

- **Content Development Considerations:**

    - Since this is a lot of content in one unit, use subheadings or clearly labeled paragraphs for each phase (e.g., "**Specify:** ...", etc.) to enhance readability. Each sub-section can contain a mini-scenario or example outcome (like: Spec phase yields a file "spec.md" with X, Y, Z contents; Plan yields "plan.md" covering A, B, C... just conceptually, since we haven't introduced actual filenames yet but foreshadowing is okay as long as we don't confuse).

    - Leverage the GitHub blog's narrative if needed: it provides a vivid description of each phase (e.g., focusing on user experience in Spec, adding company standards in Plan, tasks as test-like for AI). You can paraphrase some of that to ensure we align with latest thinking. For instance, the idea that tasks are "like a test-driven process for the AI" is a nice insight to include. Or that during Implement, instead of giant diffs, the developer reviews small, focused changes. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    - Keep the tone encouraging: while it might seem like more upfront work, point out that tools will help (again hinting at Spec Kit coming up). Perhaps mention that "Writing all this by hand might sound laborious, but this is exactly why GitHub released Spec Kit – to automate the heavy lifting of creating spec, plan, and tasks using AI. Next, we'll look at how Spec Kit facilitates these phases." This creates a logical bridge to Unit 6 and ensures the learner doesn't feel overwhelmed by manual effort.

    - Use an illustrative example throughout the sub-sections (like continuing the Issue Tracker or Photo Album example). Show how in that example: Spec might list user stories like "User can create an issue with title/description", Plan might decide "Use Node.js + Express with MongoDB, define Issue schema with fields X, Y", Tasks might include "Implement POST /issues API", "Create Issue model and save to DB", Implement would involve coding those. This cohesive thread helps learners connect theory to a concrete case.

    - Avoid repeating too much from Unit 3 or 4; this is about deeper elaboration. Ensure any concept mentioned here that was in Unit 3 (like what a spec contains) is now enriched with finer points or examples rather than a verbatim repeat.

### Unit 6: Introduction to GitHub Spec Kit

- **Unit Goal:** Introduce **GitHub Spec Kit**, explaining what it is, why it was created, and how it supports the SDD approach. By the end of this unit, learners should understand Spec Kit's core principles, the types of projects it can handle (greenfield, brownfield, etc.), how it aligns with the SDD phases, and what components or tools it includes (project initialization, templates, commands, etc.). Essentially, this unit connects the theory of SDD to a practical toolkit that implements it.

- **Sections/Topics:**

    1. **What is GitHub Spec Kit?** – Present Spec Kit as an **open-source toolkit developed by GitHub** to facilitate Spec-Driven Development. It's designed to integrate with AI coding assistants (like GitHub Copilot, Claude, etc.) and orchestrate the SDD workflow. Use a metaphor if helpful: e.g., *Spec Kit is like a co-pilot for your co-pilot*, guiding the AI through a structured process. Key point: Spec Kit helps transform a high-level idea into working code by generating the spec, plan, and tasks with AI, rather than the developer writing everything manually. Emphasize that it's not an AI model itself, but a framework/CLI that works **with** your chosen AI agent. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

    1. **Core Principles of Spec Kit:** Link Spec Kit's design to SDD principles. For instance, Spec Kit makes the **spec "executable"** – by using the spec to drive code generation through commands. It enforces the "don't skip phases" rule by structuring the workflow into commands (you can't implement before having a spec/plan, because the tool literally guides you step by step). It also embodies the "intent-first" approach: you always start by explicitly stating intent (spec) in the tool's flow. Mention that the creators' goal was to let developers *focus on product requirements and outcomes, while the AI handles the boilerplate code*. (This phrasing is found in the README: focus on scenarios vs. vibe coding). [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/) [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    1. **Supported Project Types – Greenfield, Brownfield, Exploratory, Refactoring:** Explain that Spec Kit can be used for **new projects (greenfield, exploratory)** as well as **existing projects (brownfield, refactoring)**. Define these terms and supply examples. For example: *Greenfield* means starting from scratch – no existing code, just an idea, which Spec Kit will help develop stepwise. *Brownfield* means you have an existing codebase or product and want to adopt SDD for new features or to refactor; Spec Kit supports this by allowing you to create a "constitution" or documentation of the existing system that the AI can refer to. Give a brief scenario for each: [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Greenfield:** You run Spec Kit on a blank project, it helps you create everything new (the lab will actually demonstrate this).

        - **Brownfield:** You can generate a spec for a new feature in an existing app, and possibly initialize Spec Kit in an existing repository. Spec Kit can even assist in summarizing an existing codebase's structure or rules into a *Project Constitution* (a document capturing key existing design decisions, analogous to internal guidelines) which then informs the plan for new features. This way, the AI writes new code consistent with the old code. (Note: We don't deep-dive into how, since that's advanced, but mention that it's a use case.)

        - **Exploratory:** For situations where you're exploring multiple potential approaches, use GitHub Spec Kit to generate multiple plans from the same specification. Your constitution documents existing architectural patterns and constraints. New feature specifications reference these established patterns.

        - **Refactoring and modernization:** GitHub Spec Kit can guide refactoring efforts by treating the desired end state as a specification. You document what the refactored code should achieve (same functionality with improved structure), create a plan for the refactoring approach, and generate tasks for incremental changes.

    1. **How Spec Kit Aligns to the SDD Phases:** Map the four SDD phases to Spec Kit's workflow. Explain that Spec Kit essentially provides a command or step for each phase:

        - **Project Initialization/Constitution:** (Pre-Spec phase) – Sets up project context. In a new project, this means creating a scaffold (empty spec, plan files, etc.). In an existing project, this may involve generating a constitution (document of existing principles) via the AI.

        - **Specify →** the specify command (or /specify chat command) corresponds to the Specify phase, resulting in a **spec.md** file. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Plan →** the plan command (or /plan) corresponds to the Plan phase, resulting in **plan.md**. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Tasks →** the tasks command (or /tasks) corresponds to the Tasks phase, resulting in **tasks.md**. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Implement →** (no single file, but Spec Kit offers /implement to auto-run tasks, or you can manually code guided by tasks). Spec Kit's process ensures the implement step is guided—the tasks list essentially feeds into coding, sometimes even automated as a sequence. This one-to-one mapping shows that everything discussed in SDD isn't just theory – Spec Kit operationalizes it. Perhaps provide a quick example of each file's role (spec.md = requirements, plan.md = design, tasks.md = to-do list). [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

    1. **Components Included in Spec Kit (SDK elements):** Describe what comes with Spec Kit when you set it up:

        - **The Specify CLI**: a command-line tool (specify) that developers install. It's used to initialize projects and check environment setup. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Templates**: Spec Kit includes template files for spec, plan, tasks, etc., ensuring a standard structure. For example, when you start a new project, it may populate a skeleton spec.md with sections to fill in (like "Background, Requirements…"), or a constitution.md template with placeholder principles. These templates guide users on what information to include and keep outputs consistent. [[github.com]](https://github.com/github/spec-kit/blob/main/memory/constitution.md)

        - **AI Agent Integrations**: Spec Kit doesn't come with an AI model, but it supports hooking into various AI coding agents (GitHub Copilot, Claude, etc.). It provides a unified interface (the slash commands or CLI) that works across these. In practice, this means whether you're using Visual Studio Code + GitHub Copilot or a CLI-based AI like Cursor, Spec Kit's commands behave similarly. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Automation Scripts**: Mention that under the hood, Spec Kit includes scripts that automate tasks (the repo has a scripts folder). E.g., script to set up the plan environment or to handle tasks execution. While users don't run these manually (Spec Kit does that), it's part of the toolkit's components.

        - **Documentation and Guides**: The toolkit comes with docs (like the README, examples, and help commands) to assist developers. (We won't list these, just acknowledge that it's well-documented open source, so learners can consult those resources too.)

    1. **Why Use Spec Kit – Benefits Recap:** Conclude the unit by summarizing why one would use Spec Kit instead of doing SDD "manually." Points:

        - **Efficiency:** It drafts specs and plans quickly with AI. What might take hours to write from scratch, Spec Kit can generate in minutes (though you refine it).

        - **Consistency:** It enforces a consistent format (via templates) and approach every time, which is great for teamwork and repetition.

        - **Multi-Agent Support:** You can use the AI environment you prefer (Visual Studio Code/GitHub Copilot, etc.), it's flexible. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Enterprise Ready:** Built with enterprise scenarios in mind – e.g., the concept of a *constitution* means it's ready to encode company-wide best practices and ensure AI follows them in every plan. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Open Source & Extensible:** Companies can customize it, contribute, or integrate it with their systems (like CI pipelines, etc., though that's beyond our scope in this intro module).

- **Learning Outcomes:** Learners should be able to **describe GitHub Spec Kit's purpose and capabilities**. In a Q&A, if asked "What does Spec Kit do?" they might answer: "It helps you practice spec-driven development by generating the spec, plan, and task files using an AI, based on your input. It's an open-source tool that works with AI coding assistants to streamline the SDD workflow." They should also recognize terms like **greenfield vs brownfield** in context of Spec Kit, and identify at a high level what files/outputs Spec Kit produces (spec.md, plan.md, tasks.md, etc.). Essentially, they should see Spec Kit as the practical implementation of the SDD principles they learned, and be eager to learn how to use it.

- **Content Development Considerations:**

    - Use visuals if possible: e.g., an architecture diagram showing Spec Kit in the middle connecting to the developer on one side (providing input like prompts) and the AI on the other (producing outputs), with arrows for spec → plan → tasks flow. This can reinforce how Spec Kit orchestrates the process.

    - When explaining greenfield vs brownfield, be clear and not too abstract: maybe present it as "Spec Kit has two modes of adoption – starting fresh or integrating with existing projects." If space permits, you could incorporate a small **insight card** for each, highlighting one or two tips (e.g., *Greenfield:* immediately run specify init to start new; *Brownfield:* run specify init in an existing repo to create a Constitution from code). Since details on usage will come later, keep it conceptual here.

    - Ensure the term **"Project Constitution"** is explained in simple terms (it might be new to learners): basically a summary of rules/knowledge from an existing project, created by AI to inform the spec/plan. This concept shows Spec Kit's depth in handling brownfield.

    - Avoid going into *how* to install or run commands in this unit; that's for Units 7 and 8. Here say "Spec Kit provides commands like ... (we'll learn installation and usage next)." Keep the focus on *what* and *why*. For instance, mention "specify init creates a new project from the latest template" but don't detail how to invoke it (that's Unit 8). [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    - Given that the Spec Kit repo is active, ensure any descriptions align with the latest version (as of now, e.g., including the implement command if it exists, and the broad list of supported agents). For example, mention that it supports a wide range of AI agents beyond just GitHub Copilot (learners might not know those, but listing a couple like Claude and Cursor signals it's broadly applicable). [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    - Use a positive, excited tone to build interest: e.g., "Spec Kit empowers you to do in minutes what might take days – it's like having an AI project manager guiding your code generation." We want learners to look forward to using it in the lab.

### Unit 7: Examine the GitHub Spec Kit environment and installation scenarios

- **Unit Goal:** Walk learners through the prerequisites and installation process for GitHub Spec Kit, covering different supported environments. By the end, they should know what they need to have set up (OS, Python, etc.), what IDEs or AI tools are compatible, and the steps to install Spec Kit in their environment of choice. Essentially, this unit ensures everyone can get Spec Kit up and running, whether they use Visual Studio Code with GitHub Copilot or another AI platform.

- **Sections/Topics:**

    1. **Prerequisites and System Requirements:** Outline what needs to be in place before installing Spec Kit. For example: [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **Operating System:** Linux or macOS is recommended; Windows users should use WSL2 (Linux subsystem) since Spec Kit expects a Unix-like environment. [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **Programming Language Runtime:** Python 3.11+ must be installed (Spec Kit's CLI is a Python tool). [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **Git:** Ensure Git is installed on the system (likely used for pulling the toolkit). [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **uv Tool:** Explain that Spec Kit uses the uv (Universal virtual environment) tool for installation. If learners haven't seen uv: it's a modern package manager CLI that can install tools directly from GitHub. Provide a link or reference to where to get it (the blog mentioned docs.astral.sh) – essentially, *installing uv is a prerequisite step*. [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **AI Assistant:** Need at least one supported AI coding assistant set up. List a few: *GitHub Copilot (with Visual Studio Code), Claude Code, Cursor, Gemini CLI, CodeBuddy, etc.* At least one of these should be installed/accessible. (For our lab, we specifically will use GitHub Copilot in Visual Studio Code, so highlight that if they intend to follow along exactly, ensure GitHub Copilot extension is working and logged in, etc.). This section ensures learners won't be caught off guard by dependencies. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    1. **Supported IDEs and AI Tools:** Provide an overview of the environments Spec Kit supports (to reassure flexibility). Mention:

        - **Supported Agents** - provide a list that describes the supported agents.

        - **Visual Studio Code with GitHub Copilot** - popular setup (we'll use this in lab). Spec Kit can integrate via the GitHub Copilot chat (with slash commands) or via the specify CLI plus Visual Studio Code terminal.

        - **Command-line based AI tools** - e.g., Claude Code (Anthropic), Cursor (open-source editor with AI), Gemini CLI (Google), etc. These often have their own CLI/IDE where Spec Kit's commands can be invoked in a chat or terminal. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Other IDEs** - JetBrains IDEs or others through agents like IBM's Bob (which is mentioned as IDE-based with slash support). While details aren't needed, state that if an IDE supports slash commands or some integration, Spec Kit likely can work.

        Emphasize that **Spec Kit is AI-agnostic**: as the README shows, it supports a wide array of AI backends (the table shows nearly all major coding assistants). This means learners can choose the environment they're comfortable with. However, also be clear: to use Spec Kit, the environment must allow running its special commands. In Visual Studio Code with GitHub Copilot, this might involve using the CLI alongside GitHub Copilot (since GitHub Copilot doesn't natively have slash commands yet, one might trigger them via the CLI or soon via an extension). In tools like Cursor or Qoder, you can type the slash commands directly in the AI chat.

        For simplicity, mention that this module will demonstrate using Spec Kit with Visual Studio Code + GitHub Copilot, but the steps are analogous in other setups. If relevant, note that the *"Implement Spec-Driven Development..."* advanced module might showcase other environments or more enterprise scenarios like integration with Azure DevOps. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    1. **Installation Methods:** Explain the two main ways to install Spec Kit (the Specify CLI):

        - **Global Installation (Persistent):** The recommended approach – using uv to install specify-cli on the system. Show the command: `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`. This puts the specify command in your PATH so you can use it anywhere. List the benefits (from the docs): available in any project, easier to update (uv tool upgrade), no need to re-run long commands each time. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **One-time (no install) Usage:** For those who don't want a global install, you can run Spec Kit via uvx (which executes a tool directly). For example: `uvx --from git+https://github.com/github/spec-kit.git specify init.` This downloads and runs Spec Kit for that invocation only. It's good for trying out or if you can't install globally (maybe on a CI server, etc.). But caution that you'd have to prefix commands with uvx ... each time, which is less convenient.

        Make sure to clarify that in both cases, uv is being used (so having uv is a must). If some learners cannot use uv (corporate firewall, etc.), mention that because Spec Kit is open source, one could also clone the repo or use pip, but those methods are more involved – hence stick to the official uv approach here. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

    1. **Setting Up Spec Kit in Visual Studio Code (GitHub Copilot scenario):** Provide any additional steps needed specifically for Visual Studio Code users:

        - **Spec Kit Extension or Integration:** (Check if there is an extension; if not, it's CLI-driven). As of now, Spec Kit usage in Visual Studio Code might just be via terminal commands plus using GitHub Copilot Chat for reading the files. If a Spec Kit Visual Studio Code extension exists, note to install/enable it. (If none, skip detail.)

        - After installing specify CLI, verify it by running `specify check` in terminal. This will list if required tools (like git, or specific agent tools) are found, and confirm installation succeeded. Encourage learners to do this check. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - Ensure GitHub Copilot extension is installed and working (since our lab will rely on GitHub Copilot to assist in code generation). Perhaps instruct to open Visual Studio Code and sign in to GitHub Copilot, etc., if not already done.

        - **Launching an AI assistant**: The Ovil blog describes launching Claude CLI in the project directory and then using slash commands. For GitHub Copilot, you might mention launching a GitHub Copilot Chat window in Visual Studio Code (the left pane chat) and being in the right folder. If the slash commands don't work directly in GitHub Copilot chat, we'll rely on running specify init and then letting GitHub Copilot suggestions fill content, or using the CLI with GitHub Copilot just completing code blocks. (This is a nuance: possibly GitHub Copilot doesn't take /speckit.specify as input the same way, but we can simulate by open the markdown and having GitHub Copilot code it.) However, since the lab will guide specifically how to use GitHub Copilot with these files, we can keep it high-level here: e.g., "once installed, you will use the specify commands either via chat or terminal – we'll demonstrate in Visual Studio Code shortly." [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

    1. **Installing for Other Environments (brief):** If not using Visual Studio Code, give one example: e.g., *Claude Code* – once specify is installed, you'd open Claude's interface in your project folder and simply type the slash commands (/speckit.specify, etc.), since Claude Code supports them natively. Or *Cursor* – open the project in Cursor, ensure the agent is running, and use slash commands similarly. This is just to assure non-Visual Studio Code users that the process is similar: install CLI, then use the commands in your tool's way. Reference the Spec Kit README's "Supported AI Agents" table to show broad compatibility and maybe highlight that if a specific agent has a quirk (like the table note that Amazon Q CLI has a limitation with custom args), they should check the docs. But we don't need to dive deep; point to the README or guide for specifics per tool if needed. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

    1. **Troubleshooting Basic Install Issues:** Pre-empt common problems briefly:

        - If uv isn't recognized, ensure it's installed and on PATH (direct to documentation).

        - If specify isn't found after install, maybe re-open the terminal or add ~/.local/bin to PATH (common with uv/pip on Linux).

        - If specify check flags something (like "GitHub Copilot not found"), ensure the AI tool is correctly installed (e.g., have Visual Studio Code and GitHub Copilot running for it to detect).

        This helps in content so learners don't get stuck – though details can be minimal since full troubleshooting could be complex. Mention that the Spec Kit README and support channels can help if they encounter issues beyond the scope of this module.

- **Learning Outcomes:** Learners should be able to **identify what they need to install and the steps to install Spec Kit**. Specifically, they should know that uv is used to install the specify CLI, and recall the basic command for installation. They should also understand that Spec Kit needs an AI tool to function (it doesn't work standalone – it orchestrates an AI assistant). If quizzed, they might answer, "To install Spec Kit, I need Python3 and the uv tool, then I run a command to install the specify-cli from GitHub. I also need an AI coding assistant like GitHub Copilot or Claude set up, because Spec Kit uses those to generate the spec/plan/tasks." They should also feel confident about the environment they will use (most likely Visual Studio Code in our case) and know that the lab will guide them from there.

- **Content Development Considerations:**

    - Be mindful that readers might skip details if they already have things installed. Structure in a way that key steps stand out (clear sequential steps). Possibly use a **numbered list** for installation steps:

        1. Install prerequisites (Python, uv, etc.).
        1. Run install command for Spec Kit.
        1. Verify installation (specify check).
        1. Open your environment/AI tool and ensure slash commands/Spec Kit is accessible. This gives a quick reference.

    - Use code formatting for commands (`specify init`, `uv tool install ...`) to make them easy to spot.

    - Since this is a Microsoft Learn module, note if anything needs to be different on Azure Cloud Shell or similar (though likely not relevant here; local dev is assumed).

    - Mention any differences for Windows clearly (WSL needed) so Windows users prepare that upfront.

    - If the module is interactive, this unit might not have an exercise but could link to external instructions. We might include a short paragraph like "Follow the steps to install before proceeding. If you cannot install now, you can read through the next unit but you'll need the setup ready for the lab." This sets the expectation that they should ideally install Spec Kit to follow along.

    - Keep tone instructional and reassuring: installation is often a hurdle, so provide tips and make it sound manageable. Perhaps reference the one-line install and say "It's straightforward – a single command via uv installs Spec Kit in seconds." and highlight that it's reversible (they can uninstall easily too).

    - Ensure information is up-to-date: e.g., if Spec Kit distribution method changes (like if they publish a pip package or Visual Studio Code extension in the future), this content should reflect that. Based on current info, uv (Astral's Universal Virtual machine tool) is the primary method, so we stick with that.

### Unit 8: Examine GitHub Spec Kit commands and results

- **Unit Goal:** Describe how to use Spec Kit step-by-step, explaining each command in the Spec Kit workflow, what it does, and how to work with the generated outputs. By the end, learners will know the purpose and syntax of each core command (init, /speckit.constitution, /speckit.specify, /speckit.plan, /speckit.tasks, /speckit.implement) and understand how to review and refine the produced markdown files at each stage. This prepares them to execute these steps confidently in the lab.

- **Sections/Topics:**

    1. **Project Initialization (specify init and Constitution):** Describe the first command to run when starting with Spec Kit:

        - Running `specify init <project-name>` sets up a new Spec Kit project. Explain what happens: It creates a new directory (if name given, or uses current directory with --here) with a standard structure. This typically includes a .specify/ folder containing templates and configuration, and perhaps initial empty files like spec.md, plan.md, tasks.md, and a memory/constitution.md file if applicable. Essentially, it's bootstrapping the project with everything needed for the SDD workflow. If the project already exists (brownfield situation), you can use `specify init .` to initialize in place; this might prompt or require --force if it's not empty. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[github.com]](https://github.com/github/spec-kit/discussions/331)

        - **Constitution (for brownfield):** When in an existing project, the next typical command is /speckit.constitution in the AI chat. Explain that speckit.constitution (or possibly specify constitution via CLI if available) generates the **Project Constitution** – a markdown file recording the project's guiding principles and conventions. For a brand new project, this might instead create a boilerplate where you define those principles (like coding standards, performance goals). For an existing project, the AI might inspect the codebase to fill in things like "technology stack, naming conventions, existing modules" into the constitution. The constitution isn't a phase of SDD per se, but a supporting artifact used especially during Plan and beyond to ensure consistency. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md) [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - **Review/Update Constitution:** Advise that after generating the constitution, the developer should review it. Ensure it captured correct info (for existing projects) or properly states the agreed principles (for new projects). If anything is missing or incorrect, they should edit the constitution.md. This file will guide the AI in writing the spec and plan, so it should be accurate (e.g., if a principle is "All APIs must be RESTful," make sure that's written, so the plan follows it).

        - If the project is greenfield and one doesn't have specific principles, one might skip writing much here, but it's good practice to list a few (like "Performance: must handle 100 req/sec" or "Security: follow OWASP top 10") as these will propagate into design decisions.

    1. **Specify Command (/speckit.specify):** Now the first SDD phase via Spec Kit. The developer uses the **specify command** to generate the spec. In a chat interface (like GitHub Copilot Chat or Claude), this is triggered by typing something like `/speckit.specify <description of project>`. Explain how to formulate this prompt: you provide a concise but complete description of what you want to build, focusing on requirements and intended user experience, not how to implement. For example: "/speckit.specify Build an application that does X, with ability for users to do Y and Z…". The AI will then output a draft **spec.md**. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Generated spec.md Content:** Outline what to expect in spec.md. It usually has sections such as *Introduction or Overview*, *Requirements or User Stories*, *Acceptance Criteria*, maybe *Out of Scope* or *Future considerations* if the AI is thorough. For instance, the AI might list user stories (if you described user actions) or list functional requirements gleaned from your prompt. Emphasize that this spec is a starting point – it's the AI's interpretation of the prompt.

        - **Reviewing and Editing spec.md:** After generation, the developer's job is to carefully review spec.md. Does it correctly capture all the requirements? Are all the important details there, and nothing incorrect? Likely you will need to **update the spec.md manually** to fix omissions or clarify points. This is normal and expected – the AI assists but the human is the domain expert. For example, if the AI spec forgot an edge case or a requirement you implied, add it. Or if it added something you don't actually want, remove it. Ensure learners know this step is crucial: the quality of the spec will directly affect the plan. A good practice is to imagine you hand this spec to a developer – would they understand exactly what to build? If not, refine it. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - Mention that spec.md is saved in the project, and one can open it in Visual Studio Code to edit. The Spec Kit process may allow re-running /specify if needed (but generally one thorough pass is enough; further changes can just be manual).

    1. **Plan Command (/speckit.plan):** Next, the developer invokes the plan generation. They would type `/speckit.plan <technical guidance>`. This is where you tell the AI about the intended tech stack, architecture, and any constraints. For example: "/speckit.plan Use .NET 10 and C#, follow REST API conventions, deploy to Azure Functions, ensure the design is modular," etc. If a constitution was created, the AI will also factor in those principles automatically. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Generated plan.md Content:** The AI will produce a **plan.md** file. Typical content: an architecture overview (maybe listing components or layers), key decisions (which frameworks or services to use), data model outlines (like class or table structures), and how each feature from the spec could be implemented. For instance, if spec had a feature "user uploads photo," plan might say "We will have a PhotoController with an endpoint for upload, store images in Azure Blob, and metadata in a SQL DB." Essentially, it's a blueprint with enough detail to guide implementation tasks. [[github.blog]](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

        - The plan might also reference the constitution (e.g., "following the principle of XYZ from constitution, we do ...").

        - **Reviewing and Editing plan.md:** Again, the developer reviews the plan. Check if the AI's choices align with expectations. Are the suggested technologies acceptable? Did it account for all spec requirements? Perhaps the AI proposed something suboptimal (maybe it chose a NoSQL DB but you prefer SQL, or it missed using an authentication service that's required). The developer should edit the plan.md to correct any such issues or add detail. For example, if a requirement needed a specific design pattern, ensure the plan mentions it. If something in the spec is unaddressed in plan, you might add a section for it (or rerun the plan command with more guidance). The goal is a coherent plan that you agree with. This plan will be the basis for tasks, so it needs to be thorough and consistent with the spec.

        - It's worth noting that you can iterate between spec and plan at this point: if you realize the spec lacked a detail that affects architecture, you could update spec.md and then regenerate plan.md (or adjust plan accordingly). Spec Kit is flexible – you might use the commands multiple times until satisfied (though in practice one pass plus edits is often fine).

    1. **Tasks Command (/speckit.tasks):** With a solid plan in place, the developer triggers task generation: `/speckit.tasks` (no additional prompt needed usually, because it just reads spec+plan). The AI will output a **tasks.md** file, which is essentially a checklist of tasks. [[github.com]](https://github.com/github/spec-kit/blob/main/README.md)

        - **Generated tasks.md Content:** Expect a numbered or bullet list of tasks, each ideally a single sentence or a short paragraph describing the action. They will cover implementing features as per plan. Example tasks might be: "Create database model for Photo and Album", "Implement API endpoint for photo upload", "Implement UI for dragging photos between albums", etc., covering each aspect the plan laid out. The tasks should be granular – if any seem too big or vague, that's something to refine.

        - There might also be grouping of tasks or sections if the plan was complex (e.g., tasks under "Frontend" vs "Backend" categories). The exact formatting depends on the Spec Kit template, but clarity is the goal.

        - **Reviewing and Updating tasks.md:** The developer reviews the task list to ensure completeness and clarity. Cross-check: Do these tasks, if done, fulfill everything in the plan and spec? If something is missing a task, add it. If a task is ambiguous or too large, break it into smaller tasks or clarify its wording. You want tasks to be actionable chunks that you or any developer could pick up and implement without further breakdown. For example, if a task says "Implement authentication", that's too broad – better would be "Implement user login via OAuth as per spec section X". If the AI didn't break it down enough, the developer should do so now. Conversely, if something trivial is separate, it could be merged (but usually more granularity is fine). This is also the time to prioritize or order tasks if needed (Spec Kit likely outputs them in a logical order already, but one could rearrange if they prefer a different sequence).

        - Note: tasks.md is meant to be a living to-do list. You might tick them off or annotate during implementation (though likely outside scope of this module, but good to mention that tasks can be checked off, which also signals progress).

        - At this point, emphasize that we now have *all three key Markdown files*: spec.md, plan.md, tasks.md. Any changes to spec or plan have been made, and tasks reflect those. The project is ready for coding.

    1. **Implement Phase – Working through Tasks:** Spec Kit introduced an `/speckit.implement` command to automate execution of tasks. Explain two approaches here: [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **Automated Implementation (/speckit.implement):** Spec Kit's implement command aims to have the AI agent attempt each task sequentially on its own. For example, in a chat environment you could issue /speckit.implement, and the AI will start writing code for task 1, possibly show a diff or description, then proceed to task 2, etc., until all tasks are done or need input. In reality, this might generate a lot of code; the developer still needs to review each change. It's like an automated pair programmer that doesn't wait for you after each task unless it encounters uncertainty. You can also specify the tasks that you want completed, for example "/speckit.implement implement tasks 1-3". We should clarify that even with /implement, the developer must validate the code for each task – possibly one would use a version control to review the commit for each task. [[blog.ovilgroup.com]](https://blog.ovilgroup.com/how-to-install-and-use-github-spec-kit/)

        - **Manual Implementation with AI Assistance:** Mention that some coding tasks can be implemented manually (with or without AI assistance).

        - **Verifying Implementation:** However code is produced, after each significant piece, test it against the spec. For instance, run the application or run provided tests (if any) to see if it meets acceptance criteria. If a discrepancy is found, this might mean updating the spec/plan or just fixing the code – use judgment. Ideally, each task output is checked: unit tests pass, or scenario works manually. Spec Kit doesn't magically test everything for you (though the tasks might include "write tests" if spec/plan indicated). So developers still perform testing. Encourage a habit: after finishing tasks, do a final run-through of the spec's requirements to ensure all are met.

        - **Keeping Artifacts Updated:** If during coding something changed (maybe you decided to implement a slightly different plan), it's important to update the plan.md (and possibly spec.md) to match. Spec Kit is about living docs, so if e.g. the plan said "use SQLite" but you switched to Postgres, update the plan document. This ensures the next person or next iteration has accurate info. The module can instruct learners to make small adjustments like this to experience updating artifacts.

    1. **Summarizing the Workflow with Commands:** Provide a quick summary mapping:

        - `specify init` – creates project structure (and constitution template).
        - `/speckit.constitution` – produces constitution.md (rules/principles).
        - `/speckit.specify` – produces spec.md (requirements).
        - `/speckit.plan` – produces plan.md (design).
        - `/speckit.tasks` – produces tasks.md (to-do list).
        - `/speckit.implement` - AI executes tasks and writes code.

        Perhaps present this as a list or a flow diagram in content so it's easy to see the order and relationship with SDD phases (this recaps Unit 5 mapping but now with actual command usage context).

        Also note that each of these commands should be run in the correct order for a smooth experience. If run out of order, e.g., doing plan before spec might not work or produce nonsense. Spec Kit likely enforces some order by expecting files to exist. So follow the workflow.

        Mention the other /speckit commands: clarify, analyze, checklist.

    1. **Best Practices for Using Spec Kit:** Conclude with some usage tips:

        - Always read and tweak the AI-generated content (don't blindly accept spec, plan, or code).

        - Communicate clearly to the AI in commands: The quality of /specify output depends on the prompt you give. If you omit a key requirement, the AI can't include it. So think through the product before prompting.

        - Keep your spec/plan focused on "what/why" vs "how" appropriately - e.g., don't include code solutions in spec prompt; that belongs to plan. Conversely, don't omit necessary constraints in plan prompt - give the AI enough guidance.

        - Leverage the constitution for consistency: if organization has coding guidelines, put them there early, so the plan and tasks naturally align with them.

        - Save your work: spec.md, plan.md, tasks.md are part of your repository (text files). Commit them to source control along with code. This way you version control your documentation and can track changes over time.

        - Know when to re-run vs. edit: If an AI output is very off, you might scrap it and run the command again with a refined prompt. But minor issues are usually faster to just edit by hand. Spec Kit allows iterative prompts (like you could do "/specify add more details about X" to refine), but use what's efficient.

- **Learning Outcomes:** Learners should now be able to **enumerate and describe each Spec Kit command and its outcome**. They should confidently say, "First, I initialize the project with specify init. Then I run commands to generate the spec, plan, and tasks. I review each of those and edit them. Finally, I implement the tasks (manually or by running the implement command) to get the working code." If asked about a specific file (e.g., "What is the plan.md for?") they can answer ("It's the technical design, generated by the /plan command, which the AI produces and we refine."). They should also be prepared for the lab, knowing the sequence of actions they'll perform and what to pay attention to (like reviewing AI outputs). Basically, they have the playbook for using Spec Kit.

- **Content Development Considerations:**

    - Structure this unit as an ordered walkthrough, possibly using subheadings for each command or grouping (init+constitution, specify, plan, tasks, implement). That will mirror how they will execute it in the lab.

    - Include small excerpts of what each generated file might look like, to set expectations. For example, show a tiny snippet of a spec.md that was generated (a bullet list of requirements), a bit of plan.md (maybe an architecture outline), and tasks.md (a few task items). Keep these brief and perhaps stylize as blockquotes or monospace text for realism. This will make the process less of a black box. Ensure any example aligns with earlier example context (e.g., continue with the Photo Album app example: show one requirement from it, one plan entry, etc.).

    - Use call-out phrases like "**Review point:** After /specify, always review spec.md and adjust manually before moving on." to emphasize the human-in-the-loop moments. Possibly make it an **insight card** or bold text. The idea is to prevent learners from thinking the AI does everything perfectly; they must intervene thoughtfully.

    - Since the lab will actually do these steps, be careful not to turn this unit into the lab itself. It should describe and advise, but not necessarily have the user perform them yet (unless a small interactive exercise is intended, but usually the lab unit is where the doing happens). So phrase it as instruction rather than an activity. e.g., "You will use /specify to do X. Ensure to do Y when reviewing…" setting them up for the next unit where they'll actually do it.

    - Given that Spec Kit's features might expand, ensure we note all current main commands. We listed implement since it exists now; if it were experimental, we might say "Spec Kit even includes an experimental /implement for auto-coding tasks." But it seems part of the core as of now.

    - Avoid confusion between CLI vs in-chat commands: make sure it's understood that /speckit.specify is used inside an AI chat interface, whereas the specify init is a shell command. Perhaps mention, "Note: commands like init and check are run in your terminal, while commands prefixed with /speckit. are run inside the AI assistant's chat." This distinction can be highlighted to prevent mis-using them in the wrong place.

    - Finally, to keep it succinct: even though this is detailed, try not to repeat what was said in Unit 5 about what spec/plan/tasks are – focus on using the commands. If some recap happens, tie it to action (e.g., "We discussed the Plan phase earlier; now here's how /plan helps you create that plan.md automatically."). This reinforces knowledge through application.

### Unit 9: Exercise - Create a greenfield application using GitHub Spec Kit

Lab exercise unit is created separately. Existing unit content should not be modified.

### Unit 10: Knowledge Check

Knowledge check questions are created separately in YAML file. The markdown file isn't needed.

### Unit 11: Summary

Summary unit is created separately. Existing unit content should not be modified.

---

By following this detailed outline, content developers and instructional designers can create a comprehensive Microsoft Learn module that effectively teaches the principles of Spec-Driven Development and the practical usage of GitHub Spec Kit. The flow of topics ensures learners first understand **why and what** (SDD conceptually), then **how** (using Spec Kit commands), and finally **do it themselves** (lab), which aligns with adult learning best practices.
