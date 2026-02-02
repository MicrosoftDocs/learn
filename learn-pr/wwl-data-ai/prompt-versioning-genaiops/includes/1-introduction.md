
Quick prompt changes that break AI agents in production are hard to debug. Many teams struggle with managing prompt versions safely, leading to unexpected behavior, and difficult rollbacks.

## Scenario

Consider a customer service team at a software company that uses Microsoft Foundry to power their AI chat agent. Last month, someone updated the agent's system prompt to sound more friendly, but it caused the agent to give inconsistent responses to technical questions. The team couldn't figure out exactly what changed or quickly revert to the previous working version. Customer satisfaction dropped, and it took days to manually recreate a stable prompt from memory.

This scenario illustrates multiple challenges: lack of version control, missing approval workflows, inadequate testing, and poor knowledge management. These problems could be prevented with proper prompt versioning using GitHub, where changes are tracked, tested, and deployed systematically.

## What you learn

In this module, you learn how to work with GitHub and Microsoft Foundry to version and deploy AI agent prompts. You explore one approach for organizing your repository structure for collaboration. While multiple organizational strategies exist, this example demonstrates core concepts you can adapt to your needs. You also learn how to develop a safe workflow for testing and deploying prompt changes.
