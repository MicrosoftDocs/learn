In this unit, you will learn:

- Why separating planning, execution, and validation improves reliability 

- Understanding the difference between a plan-first and a plan + execution workflows 

- How to enforce planning boundaries using capability limits and tool gating

## Why separation improves reliability

Reliable agent systems separate:

- Planning: what will be done and why.

- Execution: the concrete changes made to the repository.

- Validation: evidence that the outcome meets success criteria.

When planning and execution are mixed together, reviewers see only the final diff. They lose the ability to validate intent early, detect misunderstandings quickly, and control scope before impact.

## How separation maps to GitHub

GitHub naturally supports this separation:

- Planning appears in a PR description, an issue comment, or a Github/pull_request_template.md artifact.

- Execution appears as commits on a branch.

- Validation appears as checks, scans, artifacts, and review outcomes.

## Understanding the difference between a plan-first workflow and a plan + execution workflow

When working with agents, teams must decide when a plan becomes visible and when code changes are allowed to begin. In GitHub, planning and execution can start from different entry points-such as a GitHub issue (for example, assigning a Copilot Cloud Agent), or through the Agents tab where a plan is generated interactively.

These are separate ways of interacting with the agent, but they converge on the same governance model: all work is ultimately surfaced and reviewed in a pull request (PR)

The key design choice is therefore not where the plan starts, but when human validation is required relative to code changes.

### Option A: Plan-first pull request

In this approach, planning is completed and approved before any code changes are introduced.

**How it works in practice:**

- A plan is generated (for example, by assigning an agent to a GitHub issue or creating it in the Agents tab). 

- The agent opens a pull request that contains only the plan (no code changes yet). 

- Reviewers discuss, refine, and approve the plan directly in the PR. 

- After approval, the agent proceeds to implement the plan in follow-up commits or a new PR. 

This creates a clear separation between intent (plan) and execution (code).

### Option B: Plan + execution in the same pull request

In this approach, planning and execution are combined within a single PR.

**How it works in practice:**

- The agent opens a PR that includes both: 

  - a structured plan (in the description) 

  - initial code changes (commits) 

- The agent may continue updating the PR as the plan evolves. 

- Standard GitHub controls-required checks, CODEOWNERS reviews, and branch protection-prevent merging until all requirements are satisfied. 

Here, the plan is still visible, but it is presented alongside active changes rather than before them.

### Key difference: Timing of validation

Both options use the same GitHub controls. The difference is when those controls are applied relative to execution:

- **Option A (Plan-first):**
  Human validation happens *before* any code is written. 

- **Option B (Plan + execution):**
  Code is generated immediately, but validation is still required *before merge*. 

### Risk considerations

Both approaches can be safe when GitHub protections are correctly configured. The difference lies in when risk is introduced into the system:

- **Option A reduces early exposure.**
 Since no code is generated before approval, reviewers validate intent first. This minimizes unnecessary or unsafe changes and is preferred in high-risk environments (for example, production systems or security-sensitive areas). 

- **Option B introduces earlier exposure to change.**
 Code appears in the PR before the plan is fully validated. While this code cannot be merged without approval, it may: 

  - introduce unnecessary or incorrect changes that must be reviewed and rejected 

  - increase reviewer effort 

  - create temporary misalignment between plan and implementation 

Importantly, this risk exists during the proposal stage, not after merge. GitHub's enforcement mechanisms still prevent unsafe code from being deployed.

### When to use each option

- Use **Plan-first workflow** when: 

  - changes are high-risk or difficult to reverse 

  - alignment on intent is critical before execution 

  - you want strict separation between planning and implementation 

- Use **Plan and execution** workflow when: 

  - speed and iteration are more important 

  - changes are low-risk or easily reversible 

  - reviewers are comfortable evaluating plan and code together 

### Key takeaway

The choice is not whether work is reviewed-it always is. The choice is when the system allows code to be generated relative to human validation, and how early you want to introduce change into the workflow.

### Enforcing planning boundaries using capability limits and tool gating

1) Capability boundary (planning agents are read-only) A planning agent should be limited to read-only tools so it cannot modify files during planning.
2) Explicit transition (or handoff) to an implementation agent. Execution should occur only after plan approval, using a deliberate handoff.
3) Tool gating in orchestrators in automated orchestrations, you can force planning to run without tool execution and then enable tools only after the plan is accepted.
4) "Plan mode" workflows - Some interfaces support a planning-first experience that generates a plan artifact and pauses before any changes are applied.

### Decision guidance

- Use plan-first for high-risk work (workflows, infra, auth, production).

- Use plan + execution for medium/low risk work, but keep checks/reviews required.

- Treat "instructions not to edit" as guidance; treat tool allowlists and gates as enforcement.

**Key takeaway:** Separation creates an opportunity to review intent before accepting impact.

Next, you will enforce plan visibility and validation through pull request approval gates.
