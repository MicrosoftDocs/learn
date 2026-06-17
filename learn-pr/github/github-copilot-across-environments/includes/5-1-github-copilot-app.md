## Learning objectives 

By the end of this module, you’ll be able to:

- Describe what the GitHub Copilot app is and explain its benefits
- Differentiate the GitHub Copilot app from Copilot in VS Code, Copilot CLI, and Copilot on GitHub.com
- Identify practical ways to use the GitHub Copilot app in real-world development workflows


## What is the GitHub Copilot app?

The **GitHub Copilot app** is a native desktop experience for macOS, Windows, and Linux that provides developers with a single place to manage their work end-to-end—from selecting what to build to shipping code.

It brings together:

- Agent-based development
- Code changes and diff review
- Pull request workflows (checks, feedback, and merge)

All within one application connected directly to GitHub.

### GitHub Copilot app: A home for end-to-end work

Instead of switching between multiple tools, the Copilot app allows developers to:

- Start from an issue or task  
- Generate and iterate on code  
- Review changes  
- Manage pull requests  
- Complete the merge process  

This is all accomplishable without leaving the app.

Modern development workflows often involve multiple disconnected tools:

- Terminals for agents or scripts  
- IDEs for editing code  
- Browsers for pull requests and reviews  

This creates friction through:

- Context switching  
- Manual setup of parallel workstreams  
- Increased effort to track pull request progress  

The GitHub Copilot app addresses these challenges by:

- Consolidating workflows into a single experience 
- Automatically creating isolated workspaces for parallel tasks 
- Keeping code, context, and pull request lifecycle tightly connected

### Benefits at a glance

- **Reduced context switching**  
- **Parallel task execution with isolation**  
- **Built-in pull request lifecycle management**  
- **Faster path from idea to merged code**


## How the GitHub Copilot app works

### Agent sessions (workspaces)

At the core of the experience are **agent sessions**, also called workspaces:

- Each session is tied to a branch or pull request  
- Sessions are isolated using Git worktrees  
- Multiple sessions can run in parallel without interfering  

This allows developers to orchestrate multiple streams of work simultaneously.  

### Built on Copilot CLI

The app is powered by the Copilot CLI runtime, meaning:

- Existing CLI setups carry forward  
- Developers can reuse their tools, skills, and configurations  
- Advanced workflows remain compatible  


## GitHub Copilot app vs other Copilot experiences

GitHub Copilot is available across multiple surfaces. Each is optimized for a different type of work.

### Comparison overview

| Surface | Best for | Key role |
|--------|----------|---------|
| **GitHub Copilot app** | Managing end-to-end agent workflows | Orchestrating work from issue → code → PR → merge |
| **Copilot in VS Code (IDE)** | Editing and debugging code | Hands-on development close to the code |
| **Copilot CLI** | Terminal-driven workflows | Automation, scripting, and environment-level control |
| **Copilot on GitHub.com** | Collaboration and planning | Issues, PR creation, and async coordination |

## Session modes

The GitHub Copilot app allows developers to choose how much autonomy they want to give an AI agent, depending on the complexity of the task and the level of oversight required.

| Mode | Description | Best for |
|--------|----------|---------|
| **Interactive** | The agent proposes changes and collaborates with the developer step-by-step, waiting for input and approval before proceeding. | Collaborative development and exploratory tasks |
| **Plan** | The agent first creates and presents a detailed implementation plan before making changes. The developer can review and adjust the plan before execution begins. | Complex tasks that require review, alignment, or additional oversight |
| **Autopilot** | The agent works autonomously to implement changes, run tests, iterate on fixes, and complete the task with minimal intervention. | Well-defined implementation work and routine development tasks |

By selecting the appropriate mode, developers can tailor the GitHub Copilot app to match both the complexity of the task and their preferred working style.

## Using session history with `/chronicle`

Because the GitHub Copilot app is built on GitHub Copilot CLI, it supports CLI session history capabilities such as `/chronicle`.

This allows developers to gain insights from previous work completed across both the GitHub Copilot app and Copilot CLI sessions.

### Common use cases
- `/chronicle standup`:	Generate a summary of recent work completed across sessions.
- `/chronicle`	Review previous activity and session history.

### Benefits
- Track work across multiple sessions
- Create standup updates quickly
- Maintain continuity across projects
- Improve visibility into agent activity

This feature is particularly valuable when managing multiple agent-driven workstreams simultaneously.

## Voice dictation

The GitHub Copilot app supports voice dictation, allowing you to speak prompts instead of typing them.

Voice dictation converts your speech into text and inserts the transcription directly into the prompt box, where you can review, edit, and submit it to Copilot. This can be useful when capturing ideas quickly, describing implementation requirements, or working hands-free.

### Configuring Voice dictation

Before using voice dictation:

1. Open Settings in the GitHub Copilot app.
2. Select the Voice Dictation tab.
3. Choose a keyboard shortcut.
4. Grant microphone permissions in your operating system.
5. Download the local transcription model.

### Using Voice Dictation

Once configured:

1. Press the configured shortcut to start recording.
2. Speak your prompt.
3. Press the shortcut again to stop recording.
4. Review or edit the generated text.
5. Submit the prompt to Copilot.


### Key Benefits
- Faster prompt creation enables capturing ideas and instructions without typing.
- Speech is transcribed using a local model installed on your device.

## Practical use cases

Here are some common ways developers use the GitHub Copilot app in real-world workflows.

### Running parallel development tasks

A developer can:

- Start multiple agent sessions for different features  
- Keep each task isolated in its own workspace  
- Switch between sessions without losing context  

Ideal for teams working across multiple issues simultaneously  

### Managing the pull request lifecycle

The app provides built-in support for:

- Reviewing code changes (diffs)  
- Monitoring checks and CI status  
- Responding to feedback  

With **Agent Merge**, the app can even help:

- Address review comments  
- Fix failing checks  
- Move the pull request toward completion  

Reduces the “last mile” effort needed to ship code  


### Reducing tool switching

Instead of moving between:

- Terminal  
- IDE  
- Browser  

Developers can stay in one application to:

- Generate code  
- Track progress  
- Manage PRs  

Improves focus and productivity  


### Creating repeatable workflows

Developers can:

- Turn prompts into reusable workflows  
- Schedule recurring tasks  
- Customize sessions with tools and skills  

Helps scale agent-based development across teams  


## Summary

The GitHub Copilot app introduces a new way to work with AI in software development by focusing on orchestration, not just code generation.

- It provides a **central workspace** for managing agent-driven development  
- It complements (not replaces) IDEs, CLI tools, and GitHub.com  
- It enables developers to **run parallel workstreams and ship code more efficiently**  

As development workflows evolve, the Copilot app helps teams move from isolated AI usage to a structured, scalable approach to agentic development.
