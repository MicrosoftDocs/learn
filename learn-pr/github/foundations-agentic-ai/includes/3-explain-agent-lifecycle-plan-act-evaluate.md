Agentic systems do not make one decision and stop. They operate through cycles. A foundational model is the lifecycle of plan → act → evaluate. This lifecycle is not a one-time sequence. It is a loop: agents repeatedly plan, act, and evaluate until the task meets defined success criteria.

:::image type="content" source="../media/agent-lifecycle-diagram.png" alt-text="Copilot slide showing an agent lifecycle diagram with three steps-Plan, Act, and Evaluate-connected in a circular loop." lightbox="../media/agent-lifecycle-diagram.png":::

## In this unit, you'll learn

- How the plan → act → evaluate lifecycle works in practice 

- How planning, action, and evaluation are implemented in GitHub workflows

- How feedback signals drive iteration and completion

## Plan

In the planning phase, the agent interprets the goal and determines what steps are needed to complete it. In high-quality systems, plans are not hidden internal states. They are structured, reviewable artifacts that make the approach understandable and assessable.

Examples of planning artifacts in GitHub include:

- A structured plan in the pull request description

- A linked issue or checklist outlining scope and success criteria

> [!TIP]
> Plans become more reviewable when they include scope (what will change), success criteria (how you'll know it worked), and a rollback or escalation path.

## Act

In the action phase, the agent executes the plan in the repository. This can include:

- Creating a branch

- Changing files and pushing commits

- Opening or updating a pull request

- Responding to review feedback with revisions

This matters because it keeps execution bounded: actions occur in a specific repository, on a branch, and through pull request workflows rather than through uncontrolled direct changes to the default branch.

## Evaluate

In the evaluation phase, the agent and the humans supervising it use signals from the development system to assess results. In GitHub, common evaluation signals include:

- Workflow runs and status checks (build/test/lint)

- Code review feedback (requested changes, approvals)

- Security signals (code scanning results, secret scanning alerts, dependency alerts)

When configured by repository or organization policy, protections such as rulesets and branch protection can require checks to pass before changes merge-turning evaluation into an enforceable gate rather than an informal suggestion.

For security-oriented work, evaluation often includes:

- Code scanning (including SARIF upload workflows)

- Secret scanning alerts

- Push protection to prevent supported secrets from being committed

These capabilities reinforce a key lesson: agent evaluation must be grounded in system signals, not in the agent's confidence.
 
 Evaluation is not the final step. If checks fail, risks remain, or requirements are not met, the lifecycle continues: the agent must revise the plan, adjust its actions, and re-evaluate until the outcome is acceptable or handed off to a human.

For example, when an agent proposes a dependency update in a pull request, the plan defines which package changes, the action updates the files, and evaluation occurs through CI checks and security signals.

If workflows fail or the vulnerability remains unresolved, the work is not complete. The lifecycle must loop: revise the plan, adjust the change, or escalate to a human.

## A high-quality agent system makes every phase visible

- The plan is inspectable.

- Action is bounded to repository workflows.

- Evaluation uses objective signals.

When any piece is missing, trust degrades: plans become opaque, actions become risky, and outcomes become difficult to validate.

The lifecycle of plan, act, and evaluate is the operational core of agentic systems. It explains how agents move from intent to execution -and how GitHub's checks, workflows, reviews, and security signals provide feedback that enables safe iteration.

Once you understand how an agent behaves, the next question becomes where that behavior is controlled. In the next unit, you'll examine GitHub as the system of record and control plane for agent workflows.

I would recommend mentioning this earlier, either in the Evaluate section or in the intro, to make it immediately clear that plan/act/evaluate is a loop and not a linear sequence. It could be helpful to the learner to know this from the start, not discover it in the Scenario