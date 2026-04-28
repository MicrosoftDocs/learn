:::image type="content" source="../media/designing-agent-architecture-integration.png" alt-text="Copilot banner for Designing Agent Architecture and SDLC Integration, with the Copilot name and title text on a promotional background." lightbox="../media/designing-agent-architecture-integration.png":::

Agentic systems are changing how software is built and maintained. Instead of relying only on developers to write and update code, teams are adopting systems that can interpret goals, propose solutions, and take action within repositories. In GitHub, an agent might create a branch, modify files, open a pull request, and then iterate based on feedback from tests, security scans, and code reviews.

However, capability alone does not make an agent reliable. Without a well-defined architecture, agents may act too early, produce unclear changes, or operate without sufficient validation. In production environments, these failures create real risks to code quality, security, and operational stability.

Designing an agent system in GitHub is not about giving the agent more freedom. It is about defining how work flows through the system using enforceable GitHub functions such as pull requests, workflows, and repository rules. A well-designed architecture ensures that every agent action leaves a visible record, is validated by objective signals, and is accepted only when it meets policy requirements.

## Glossary

**Key terms and definitions**

This module uses a small set of recurring terms. The definitions below clarify how they are used throughout the content.

- **Plan (artifact)**
    A structured description of intended changes, typically included in a pull request description. It outlines the goal, scope, steps, risks, and validation criteria for the work. 

- **Planning (agent capability)**
    The process by which an agent generates or refines a plan based on a task, issue, or user input. This can occur in different entry points, such as a GitHub issue or the Agents interface. 