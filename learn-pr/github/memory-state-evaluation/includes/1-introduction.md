As agents become more capable, they also take on longer and more complex tasks. These tasks may span multiple steps, tools, and environments, and may not be completed in a single session. To work effectively, agents must be able to retain relevant information, track progress, and stay aligned with the original goal.

In GitHub workflows, agents can create branches, open pull requests, run workflows, and interact with repository artifacts. This makes it important to define how memory is handled, how state persisted, and how results are evaluated.

This module introduces the foundations of agent memory, state management, and evaluation. You will learn how to structure memory, persist progress through GitHub artifacts, maintain consistency across environments, and define clear signals for success.

### Learning objectives

In this module, you will:

- Learn agent memory strategies using short-term, long-term, and external memory 

- Learn how to maintain and persistent agent state and manage context drift

- Learn how to manage agent state across tools and environments 

- Understand agent evaluation signals and success criteria 

### Prerequisites

Before starting this module, you should have:

- A GitHub account 

- Basic understanding of repositories, branches, and pull requests 

- Familiarity with GitHub Actions 

- General understanding of agent workflows in GitHub, IDE, or CLI environments 

Next, you will learn how to implement agent memory strategies by deciding what information to store, where to store it, and how long to keep it.