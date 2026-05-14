Agents need structured memory to complete tasks reliably. Instead of relying on a single stream of context, memory should be organized so the agent can focus on the current task while still accessing important information when needed.

In GitHub workflows, this typically involves combining in-session context with durable artifacts such as issues, pull requests, and repository instructions.

In this unit, you'll learn:

- The difference between short-term, long-term, and external memory 

- How to choose where information should be stored 

- How to scope memory to relevant information 

- How to define memory expiration, pruning, and reset rules 

## The memory hierarchy

Agent memory can be grouped into three categories.

### Short-term memory

Short-term memory is the working context for the current task. It includes recent instructions, feedback, and the immediate steps needed to proceed.

This memory is useful during execution but is not preserved across sessions.

### Long-term memory

Long-term memory contains curated knowledge that can be reused across tasks. It is more stable and typically includes summarized or structured information.

Examples include key decisions, patterns, and reusable knowledge.

### External memory

External memory is stored outside the agent in durable systems. In GitHub, this includes artifacts such as issues, pull requests, documentation, and workflow outputs.

External memory acts as the source of truth because it is persistent and can be reviewed at any time.

## Choose where to store information

Different types of information should be stored in different places.

Requirements and acceptance criteria should be stored in durable artifacts such as issues or pull request descriptions. This allows the agent to revisit the goal and validate its work.

Plans and decisions should also be stored in the same locations. This helps maintain consistency and allows work to continue without reinterpreting earlier steps.

Repeatable processes should be stored as instructions or reusable skills. This avoids redefining the same workflow for every task.

## Scope memory to relevant information

Memory should be limited to information that affects the outcome of the task.

Relevant information includes:

- Requirements and constraints 

- Decisions that affect implementation 

- Validation and testing approaches 

Information that does not affect the outcome should not be stored. This includes temporary intermediate steps or duplicated context.

Limiting memory reduces confusion and helps prevent the use of outdated information.

## Define a source of truth

Each type of information should have a single, clear location.

For example:

- Requirements → Issue 

- Decisions → Pull request or documentation 

- Validation rules → Repository instructions 

- Results → Workflow logs and artifacts 

Defining a source of truth helps prevent conflicting information and keeps the agent aligned across sessions.

## Memory expiration and pruning

Memory should be maintained over time to prevent it from becoming outdated.

Some information should expire after a certain period, especially temporary outputs such as logs or artifacts.

Outdated or unnecessary artifacts should be removed to reduce clutter and avoid stale context.

In cases where detailed history is no longer needed, it can be summarized into key points and references.

Reset rules should also be defined to handle situations where requirements change or previous assumptions are no longer valid.

## Key takeaway

Effective agent memory is structured and selective. Short-term memory supports the current task, long-term memory preserves useful knowledge, and external memory provides a durable source of truth. Clear rules for storage, scope, and maintenance help ensure consistent and reliable agent behavior.