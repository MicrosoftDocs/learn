Unit 2: Get started with GitHub issues

Purpose: Make sure learners fully grasp how to use GitHub Issues effectively. Before fixing issues, they need to know how to read and manage them. Even those familiar with GitHub might pick up pro-tips on issue tracking.

## What are GitHub Issues?

Define them as the built-in way to track tasks, bugs, and feature requests on GitHub. Explain that each issue is like a ticket in a tracking system – it can be assigned, labeled, linked to code, etc. Use an analogy from experience: “Think of GitHub Issues as a team’s shared to-do list, but much smarter: each item can hold discussions, code references, and metadata to ensure the work gets done and doesn’t fall through the cracks.”

## Core Components of an Issue

GitHub issues contain the following core elements:

- Title: should be a concise summary (e.g., “SQL injection in product search endpoint”).

- Description: where the detail lives. Emphasize writing good descriptions: what’s happening, steps to reproduce (if a bug), why it’s important. A lead dev might say, “A well-written issue is half-fixed. It guides the developer straight to the problem.” If possible, show a brief example of a good issue description vs a poor one (perhaps via a quick before/after or just description).

- Comments: team discussion happens here. People can clarify the issue, propose solutions, or mention related information.

- Assignees: who is responsible. Maybe mention in our scenario, these issues are assigned to “you” (the learner) as the developer to fix. As a tip: “Always have one owner for an issue so it doesn’t languish. If you’re the assignee, it’s on you to drive it to resolution.”

- Labels: how issues are categorized (bug, enhancement, security, etc.). In our case, issues have a “security” label likely. Explain that experienced teams tag issues for filtering and prioritization. For example, a “P1” label might mean fix ASAP.

- Milestones: batches of issues tied to a goal (like a version release). Not critical for the lab, but mention for completeness that issues can be grouped.

## Issue Workflow in Practice

Outline the lifecycle of an issue:

1. Creation – often by a developer, tester, or user who notices something. 

    An expert tip: When you create an issue, include context and ideally how to know when it’s resolved. This sets the acceptance criteria.

1. Triage – the team lead or triage person prioritizes it, labels it, maybe assigns it. High-severity ones (like security issues) get flagged to address immediately.

1. Discussion – sometimes the implementer asks questions or records investigation findings in comments.

1. Code Fix – a branch is created, code changes made. In GitHub, typically a Pull Request (PR) is opened referencing the issue.

1. Linking to Commits/PRs – demonstrate that writing “Fixes #123” in a PR or commit ties it to the issue. This is a pro move: it automates closing and creates traceability. Anecdote: “In my early years, I’d fix something but forget to close the issue – and then scramble when someone asked if it was done. Linking commits saves that trouble and documents the fix.”

1. Closing – when the PR is merged, the issue is closed. Possibly mention that if testing reveals it’s not actually fixed, the issue can be reopened.

## Using GitHub Issues in VS Code

Many don’t know you can view and even create issues from VS Code (with the GitHub Pull Requests & Issues extension). Briefly mention it: “VS Code can integrate with GitHub Issues – you can see assigned issues and even create them without leaving your editor. This can streamline your workflow.” The lab doesn’t necessarily require using VS Code’s issue integration, but it’s worth noting as a productivity tip.

Why It Matters (Expert Perspective): Explain that clear issue tracking prevents things from slipping through cracks, especially in security. A lead dev might say, “I’ve seen teams ignore a minor-looking security issue in the backlog, only to regret it later when it became an incident. Treat security issues with urgency – if it’s in GitHub Issues, it’s visible and traceable. Use that visibility to your advantage.” Encourage learners to embrace issue-driven development: fix the issue, close it, move on – it’s satisfying and ensures completeness.

Transition to Copilot: Conclude this unit by bridging to the next: “Now that you know how to navigate issues, it’s time to actually solve them. That’s where GitHub Copilot comes in. Think of Copilot as a colleague who’s read millions of codebases and StackOverflow answers, ready to help you implement solutions. But like any colleague, you have to ask the right questions and review their work. Let’s see what common issues we’re up against and how Copilot will assist.”

By the end of Unit 2, learners should feel comfortable with GitHub Issues and understand their role in the development workflow. This foundational knowledge means when they see the issues in the lab, they’ll know how to read them and use them as a guide for their work.

