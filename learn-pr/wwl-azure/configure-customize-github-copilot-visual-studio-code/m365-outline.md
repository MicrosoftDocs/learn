
# Configure and Customize GitHub Copilot in Visual Studio Code

## Module Overview and Objectives

In this module, experienced GitHub Copilot Chat users will learn how to configure and customize GitHub Copilot in Visual Studio Code to better fit their projects and workflows. We will cover how to use repository-specific Markdown instruction files to influence Copilot’s code suggestions, how to create custom Copilot agents with specialized behaviors, and how to chain these agents together to handle multi-step development tasks.

### Learning Objectives

After completing this module, learners are able to:

- Customize Copilot’s responses using repository-based instruction files (e.g. .github/copilot-instructions.md) to enforce project-specific coding styles, best practices, and guidelines.
- Create GitHub Copilot Custom Agents (specialized chat modes) in Visual Studio Code to assume roles like “Planner,” “Code Reviewer,” or “Tester,” each with tailored instructions and tool permissions.
- Configure and use agent handoffs (chaining) to orchestrate multi-step development workflows (for example, handing off from a planning agent to an implementation agent, then to a review agent) with Copilot Chat.
- Implement a real-world scenario in C# by defining custom instructions and chaining multiple custom agents to collaboratively complete a coding task.

## Unit 1: Introduction (1-introduction.md)

**Standard module introduction unit (developed using AI tools after creating content units).**

Overview of Module Topics: Briefly outline how the module will cover:

- Using repository-based custom instructions to influence Copilot’s coding style and guidelines.
- Defining and using custom Copilot Agents for specialized tasks (e.g., planning, coding, testing).
- Chaining agents through handoffs to accomplish multi-step development scenarios.

Relevance to Learners: Emphasize that the module is designed for developers already familiar with Copilot Chat in Visual Studio Code, aiming to boost their productivity with advanced features. Explain that these capabilities (custom instructions and agent chaining) can significantly streamline common 2026 developer workflows by embedding team knowledge and multi-step automation into the coding process.

## Unit 2: Examine the benefits of customizing GitHub Copilot (2-examine-benefits-customize-github-copilot.md)

Purpose: Introduce the value of customizing GitHub Copilot in Visual Studio Code for improved alignment with project needs and modern development workflows.

### Examine the benefits of customization

Discuss how out-of-the-box Copilot suggestions may not fully adhere to a team’s unique coding standards or project requirements. Explain that by providing custom instructions and creating custom agents, developers can guide Copilot to produce more relevant, accurate, and context-aware output. For example, a team might have specific architectural patterns, naming conventions, or security practices that they want Copilot to follow. Customization allows embedding this knowledge directly into the AI’s suggestions.

### Modern AI-assisted workflows

Highlight that software development in 2026 often involves AI “co-pilots” in various roles. Developers use AI not just for code completion, but also for planning tasks, automating tests, reviewing code, and more. Tailoring Copilot ensures these AI assistants understand project context and can take on specialized tasks effectively. For instance, a “Planner” agent could help break down a feature into tasks, while an “Implementer” agent focuses on writing code that adheres to project guidelines. Chaining these agents allows for seamless transitions between different stages of development, improving efficiency and consistency.

### Summary

Customizing Copilot allows developers to infuse project-specific knowledge into AI suggestions and leverage multiple AI “agents” in a coordinated way, enabling AI-assisted development from planning to coding to testing and review.

**Supporting Resources:**
- [Want better AI outputs? Try context engineering. – The GitHub Blog](https://github.blog/ai-and-ml/generative-ai/want-better-ai-outputs-try-context-engineering/)
- [Customize AI in Visual Studio Code – Visual Studio Code Docs](https://code.visualstudio.com/docs/copilot/customization/overview)
- [About customizing GitHub Copilot responses – GitHub Docs](https://docs.github.com/en/copilot/concepts/prompting/response-customization)

## Unit 3: Customize GitHub Copilot responses using instruction files (3-customize-copilot-responses-instruction-files.md)

Purpose: Teach learners how to use custom instruction files in a repository to adjust and guide GitHub Copilot’s suggestions (particularly in VS Code’s Copilot Chat), aligning AI output with project standards and requirements.

### “Always-On” custom instructions

Introduce the concept of repository-level instructions. Explain how adding a Markdown file named .github/copilot-instructions.md at the root of a repository (or workspace) provides Copilot with additional context and rules for all suggestions in that project. These instructions act as always-on guidelines – for example, “Always use our team’s coding style and naming conventions”. They are automatically included in every Copilot Chat prompt within that workspace. This means that whenever a developer interacts with Copilot Chat, the model will consider these instructions to generate responses that better fit the project’s standards and practices. For instance, if the instruction file specifies “Use PascalCase for class names and camelCase for methods,” Copilot will attempt to follow these conventions in its suggestions. This can help reduce the amount of manual editing needed to align AI-generated code with team guidelines, improving efficiency and consistency across the codebase.

### Path-specific instructions

Describe the option of using path or file-specific instruction files (multiple *.instructions.md files under a .github/instructions/ directory). These files include a special YAML applyTo frontmatter that specifies which files or file patterns they apply to17 18. For instance, a file named database.instructions.md with applyTo: "DataAccess/**/*.cs" can contain rules that only apply to C# files in the DataAccess folder (e.g., “Use repository pattern for data access classes”). Such path-specific instructions are automatically merged with the repository-wide instructions when relevant.

### Organization-level instructions (Overview)

Mention that enterprises can define organization-wide instructions (applied across multiple repos). For example, a shared coding standard could be enforced by an org-level instruction profile so that all projects start with the same guidelines21. This ensures consistency across teams.

### How to create instruction files

Provide a brief step-by-step on creating these files:

1. **Enable and Locate the Feature**: Ensure “Enable custom instructions from .github files” is turned on in VS Code’s Copilot Chat settings (this is on by default).

1. **Add .github/copilot-instructions.md**: In the repository’s root, create a .github folder (if not present) and add a file named copilot-instructions.md inside it. Write natural language guidelines in Markdown (each guideline can be its own bullet or paragraph; blank lines are fine – they’ll be collapsed when sent to the model)25. For example, you might include: “Use PascalCase for class names; follow our secure coding checklist for API endpoints; always add error handling for database calls,” etc. These instructions will be automatically appended to every Copilot Chat prompt in the repo.

1. **Add .instructions.md (if needed)**: To target specific file types or sections of the project, create an instructions subfolder under .github. Add one or more Markdown files with names ending in .instructions.md (e.g. logging.instructions.md, sql.instructions.md). At the top of each, include a YAML header with an applyTo field listing file path patterns (globs) that the instructions should apply to28. Then write the specialized instructions in the Markdown body. (For example, a logging.instructions.md could specify applyTo: "**/*Logger.cs" and contain guidance on using a certain logging framework in those files.) If a file’s path matches an applyTo pattern, Copilot will combine both the general repo instructions and the relevant path-specific instructions for that context29 30. This allows fine-grained control over Copilot’s behavior in different parts of a codebase.

1. **Verification**: Explain how to confirm that Copilot is using your instructions. For instance, in Copilot Chat, the “References” section of a response will list the source of any custom instructions applied (you should see your copilot-instructions.md file cited there when it’s influencing answers)31. If the instructions aren’t being picked up, ensure the feature is enabled in settings and the file path/naming is correct.

### Benefits of custom instructions

Emphasize how repository-level instructions can align AI output with team conventions and reduce editing overhead. Examples: Reinforcing naming patterns (e.g., “private C# fields must start with _ underscore)33, enforcing certain library or framework usage, specifying desired code comment styles, or reminding Copilot of project-specific context and constraints (like architecture decisions, security policies, or performance considerations). Path-specific instructions allow for even more targeted guidance, ensuring that suggestions are relevant to the specific area of the codebase (e.g., different rules for frontend vs. backend code). This can lead to more accurate and useful suggestions, improving developer efficiency and code quality.

### Limitations

Note that custom instructions do not affect inline autocomplete suggestions (the basic single-line or inline completion) – they apply to Copilot Chat and other high-level requests, not the low-level auto-complete engine36. Also, advise keeping instructions concise and relevant: large, unfocused instruction files might lead to diluted or unpredictable results37. 

### Summary

Learners understand how to configure .github instruction files and the impact on Copilot’s chat responses. They should be able to create both a global repository instruction file and optional path-specific instruction files to customize Copilot’s behavior for their project.

**Supporting Resources:**
- [Adding repository custom instructions for GitHub Copilot – GitHub Docs](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)
- [Use custom instructions in Visual Studio Code – Visual Studio Code Docs](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [5 tips for writing better custom instructions for Copilot – The GitHub Blog](https://github.blog/ai-and-ml/github-copilot/5-tips-for-writing-better-custom-instructions-for-copilot/)

## Unit 4: Create custom GitHub Copilot agents in Visual Studio Code

Purpose: Explain what GitHub Copilot custom agents are and guide learners through creating and using their own custom agents in VS Code’s Copilot Chat. This unit covers defining an agent’s persona, tools, and behavior using the .agent.md file format.

### What are custom GitHub Copilot agents?

Introduce custom agents as specialized AI assistants (chat “personas”) that developers can configure for particular roles or workflows in Visual Studio Code. A custom agent encapsulates a set of instructions and tool permissions. When activated, it steers Copilot’s behavior to act as a specific kind of expert. For example, you might have an agent acting as a “Security Reviewer” to find vulnerabilities, or a “Test Writer” agent focusing on generating unit tests. Custom agents were introduced as an advanced feature (formerly called “custom chat modes”) to give developers more control and are available in Visual Studio Code as of version 1.106 (and in other IDEs in public preview).

### Examine how custom agents work

Explain that a custom agent is defined by a Markdown file with a .agent.md extension. Visual Studio Code automatically loads any .agent.md files in your workspace’s .github/agents folder (or in your user profile) as new agents in the Copilot Chat interface. Each agent file consists of:

- A YAML frontmatter header: where you specify metadata like the agent’s name, description, the tools it can use, and optional settings like which AI model to prefer or any handoffs to other agents.

- A body: where you write the agent’s instructions and context in Markdown (similar to writing a prompt). This content will be prepended to every user prompt whenever that custom agent is selected in Copilot Chat. The body might include guidelines or even step-by-step approaches that the agent should follow. For example, the Security Reviewer agent’s file might contain text like: “You are a senior security engineer. Analyze the user’s code for common security vulnerabilities (e.g., SQL injection, XSS) and suggest safe improvements.”.

### Define agent capabilities with tools

Describe how custom agents can be restricted or empowered with certain tools. In the .agent.md frontmatter, the tools list controls what the AI can do – e.g., read, edit, search, execute (shell), etc.51. By tailoring tools, you can ensure an agent only performs relevant actions. Example: A Planning agent might only need read and search tools (to gather information without editing code), whereas an Implementation agent would have edit capabilities to modify code files. If no tools are specified, an agent defaults to having all standard tools, but often it’s safer to limit them for focused behavior.

### Built-in vs. custom agents

Note that VS Code comes with some built-in agents (such as a default “Copilot” agent and specialized ones like “🤖 Plan” for planning code, “🤖 Fix Vulnerabilities,” etc.). Custom agents allow you to go further, creating your own roles. For instance, you could craft an agent called “Database Optimizer” that has guidelines about SQL best practices and permits only safe read-only analysis tools. Custom agents appear in the Copilot Chat’s agent dropdown alongside the built-ins, and can be selected anytime to switch the AI’s mode.

### Steps to create a custom agent

Provide a high-level procedure (which the learners will practice in the lab):

1. In VS Code’s Copilot Chat pane, open the Agents menu (the dropdown that normally shows “GitHub Copilot” as the default agent). Click “Configure Custom Agents…” and choose “Create new custom agent”. (Alternatively, create a .agent.md file manually in .github/agents as described above.)

1. Choose the scope: Decide whether to store the agent file in the workspace (project-specific agent in .github/agents/) or in the user’s global profile (~/.copilot/agents) if you want to reuse it across projects. For this module, we’ll use a workspace agent so others on the team can share it via the repo.

1. Name and define the agent: When the new .agent.md file opens, edit the frontmatter. Set a descriptive name (e.g. “Planner” or “UnitTestGenerator”), a description (what the agent does; this text will show up as a hint in the chat input when the agent is selected59), and specify any tools the agent should have or not have (for instance, a ReadOnly agent might omit edit rights). Optionally, pick a model (if you want to force a specific AI model) and configure handoffs if this agent should connect to another (we’ll cover handoffs in the next unit).

1. Write the agent’s instructions: In the body of the .agent.md file (below the YAML), provide the custom instructions or style of interaction for that agent. This is effectively the agent’s “persona” or expertise. For example, for a “Code Reviewer” agent, the body might say: “You are an assistant that reviews code for potential issues in style, performance, and security. When the user provides code, respond with a code review highlighting any bugs, vulnerabilities, or improvements, formatted in bullet points.” These instructions will be automatically included (hidden from the user) whenever the agent is active, influencing how Copilot responds.

1. Save and activate: Save the file. The custom agent should now appear in the Copilot Chat agents menu (if user-invokable is true, which it is by default). Learners can now select this agent and start asking it to perform its specialized task.

### Examples of custom agents

Provide a couple of concrete examples to solidify understanding:

Example 1: “Planner” Agent: frontmatter includes a limited set of tools like ['search','read'] and maybe a handoff to an “Implementer” agent (so it can offer a button to continue to coding). Its description could be “Generates high-level implementation plans without writing code”, and body instructions focus on listing steps and asking clarifying questions instead of producing code.

Example 2: “Security Reviewer” Agent: as mentioned, it might only allow reading and searching tools (no editing) and have instructions to identify security flaws. This ensures the agent acts like a code security expert scanning code for OWASP top 10 issues, rather than writing new features.

Outcome: Learners grasp how to define custom Copilot agents in Visual Studio Code, modify their capabilities via tools, and shape AI behavior through the agent’s instructions. They should also know how to switch between agents in Copilot Chat to leverage these new modes.

**Supporting Resources:**
- [Custom agents in Visual Studio Code – Visual Studio Code Docs](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [About custom agents – GitHub Docs](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-custom-agents)
- [Your first custom agent – GitHub Docs](https://docs.github.com/en/copilot/tutorials/customization-library/custom-agents/your-first-custom-agent)

## Unit 5: Chain agents with handoffs for multi-step tasks

Purpose: Explain agent handoffs – how to connect multiple custom (or built-in) agents in sequence – and illustrate using them to tackle complex, multi-step development tasks. Learners will understand how to configure handoffs in an agent’s definition and see example use cases of chained agents working together.

### What are handoffs?

Handoffs allow one agent to suggest the next step with another agent, carrying over context. In VS Code’s Copilot Chat, when an agent finishes its response, it can present a button (a suggested “next action”) that, when clicked, automatically switches the chat to a target agent and (optionally) pre-fills a prompt to continue the workflow70 71. This enables a guided chain of agents, each handling a step of a larger process, with the developer’s oversight at each transition. For example, a Planner agent could produce a design plan and then offer a “Start Implementation” button that hands off to an Implementation agent, which would receive the plan as context and a prompt like “Now implement the plan above.” The developer can review the plan and click the button when ready to move to coding. This creates a structured multi-agent workflow that can be more efficient and organized than trying to do everything in one agent or manually switching contexts.

### Configuring handoffs

Demonstrate how to set up a handoff in a custom agent’s file by adding a handoffs section to the YAML frontmatter.

A handoff entry specifies:

- label: The text for the UI button (e.g., “Start Implementation” or “Run Tests”).

- agent: The name (or identifier) of the target agent to switch to (e.g., implementation for an Implementation agent).

- prompt: An optional message to send to the next agent (for instance, the Planner agent might provide a prompt like “Now implement the plan above” when handing off to the Implementation agent).

- send: A boolean that, if true, will automatically send the prompt to the next agent (i.e. the next agent begins working immediately) or, if false, will just populate the prompt for the user to review/edit before sending.

(The model field can also be set for the handoff to use a specific model, but that’s optional and advanced.)

Using these fields, a YAML snippet in the Planner agent might look like:

```yaml
handoffs:
  - label: "Start Implementation"
    agent: implementation
    prompt: "Now implement the plan outlined above."
    send: false
```

This would cause a “Start Implementation” button to appear after the planner agent writes out a plan. When clicked, Copilot Chat switches to the Implementation agent, carries over the conversation (including the plan text), and pre-fills “Now implement the plan outlined above.” as the user’s next question. The developer can then hit enter to have the Implementation agent start coding according to the plan.

### Reviewing and accepting handoffs

Note that handoffs always involve an explicit user action (clicking the button) unless configured with send: true. This ensures the developer stays in control of moving to the next step. Emphasize that each agent in the chain will operate within its defined tool and instruction set, which provides guardrails at each step (e.g., a planning agent that cannot edit code, a coding agent that doesn’t have internet access, etc.). This structured approach can make multi-step processes more reliable by breaking them into discrete phases with appropriate tools.

### Common multi-step workflows

Provide examples of development scenarios where chaining Copilot agents can boost productivity:

- Planning → Implementation: Use a Planner agent to analyze requirements and produce a detailed design or task list for a new feature. Then seamlessly hand off to an Implementation agent that writes the code according to that plan. This mimics a senior engineer planning work and a developer executing it, using AI for both stages.

- Implementation → Code Review: After code is generated (whether by a human or an AI agent), a handoff can switch to a Code Review agent that evaluates the new code’s quality, looking for bugs, style issues, or missing edge cases. The review agent can then either suggest improvements or even hand off to a “Fixer” agent to apply fixes, subject to developer approval.

- Write Failing Tests → Write Code to Pass: Apply Test-Driven Development (TDD) using two agents. First, a Test Generator agent creates failing unit tests for a specified requirement. Next, hand off to an Implementation agent to write the minimal code needed to make those tests pass82. This chain enforces a red-green testing cycle with AI assistance.

- Debugging and Patching: For a bug-fix scenario, an agent could be used to diagnose the cause of a failing test or error (e.g., a Debugging agent that reads logs and code to hypothesize the cause). Then hand off to a Patching agent (with editing rights) to apply a fix. Finally, the chain could invoke a Testing agent to run the test suite and verify the issue is resolved.

- Refactoring or Upgrading: Use a Planning agent to analyze an existing codebase and outline a refactoring or migration plan (for example, migrating a C# project from .NET Framework to .NET 6). Then hand off to an Upgrade agent to perform the code changes across files according to that plan, step by step, possibly followed by a test agent or review agent to check the updated code.

These scenarios reflect how 2026 developers leverage AI agents collaboratively – for instance, delegating a sequence of tasks (plan → code → test → review) to different specialized AI helpers while supervising each step. The result is a more efficient workflow where repetitive or complex tasks are handled by the AI, freeing the developer to focus on decision-making and verification.

### Summary

Learners understand how to define and use handoffs in custom agent files to enable multi-step workflows. They can identify scenarios in their own work that might benefit from agent chaining, and they know how to implement such patterns in Copilot Chat.

**Supporting Resources:**
- [Custom agents in Visual Studio Code (Handoffs section) – Visual Studio Code Docs](https://code.visualstudio.com/docs/copilot/customization/custom-agents#_handoffs)
- [Tutorial: Work with agents in Visual Studio Code – Visual Studio Code Docs](https://code.visualstudio.com/docs/copilot/agents/agents-tutorial)

## Unit 6: Exercise - Create and chain custom GitHub Copilot agents for a C# project

### Lab Objective

Configure a C# project to use custom Copilot instructions and create two or more custom agents that collaborate via handoffs.

### Lab Tasks

1. **Setup and Requirements**
2. **Create Repository Custom Instructions**
3. **Define a “Planner” Custom Agent**
4. **Define an “Implementer” Custom Agent**
5. **(Optional) Create a “Tester” Agent or Use Built-in Test Agent**
6. **Run the Chained Agents Workflow**
7. **Iterate and Improve**
8. **Wrap-up and Reflection**

### Application Scenarios for the Lab

- Plan → Implement
- Test-Driven Development
- Code Review & Refactor
- Auto-Debugging
- Refactoring or Upgrading

### Lab outcomes

Learners will gain hands-on experience in creating custom Copilot configuration files and agents, and orchestrating them to handle realistic development tasks in C#.

## Unit 7: Knowledge check

- Multiple-choice questions to assess understanding of:
  - Custom instruction files
  - Creating custom agents
  - Agent handoffs

## Unit 8: Summary

- Recap of customizing Copilot with instruction files.
- Creating and using custom agents.
- Chaining agents for multi-step workflows.
- Encouragement to apply skills in real projects.
