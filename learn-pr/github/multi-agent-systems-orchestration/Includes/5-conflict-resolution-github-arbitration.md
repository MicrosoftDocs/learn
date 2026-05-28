Conflicts are a natural part of multi-agent systems, especially when multiple agents work in the same repository. These can include merge conflicts (same files changed), semantic conflicts (changes break combined behavior), policy conflicts (different approval requirements), and duplicate work (multiple agents solving the same problem). Understanding these types helps design systems that can detect and resolve conflicts effectively.

In this unit, you'll learn

- How conflicts arise in multi-agent systems 

- How GitHub detects conflicts early 

- How to resolve conflicts using ownership and escalation 

- Why conflicts must be resolved intentionally

### Conflicts in multi-agent systems

Even with isolation, conflicts will occur. Multi-agent systems produce conflict not only in code, but also in policy and scheduling.

Common conflict types include:

- Textual merge conflicts (same files/lines changed).

- Semantic conflicts (clean merge, broken combined behavior).

- Policy conflicts (protected areas require different reviews/approvals).

- Duplicate effort (two PRs solving the same problem differently).

A stable system makes conflicts detectable early and provides a rule-based way to resolve them.

## How conflicts are detected and resolved

### Merge validation checks

GitHub PRs show merge conflicts, but teams often add a merge validation step so conflicts fail fast as checks:

```yml
\- name: Validate merge with main

 run: |

  git fetch origin main

  git merge --no-commit origin/main
```

If this is a required check, conflicts become enforceable and don’t depend on reviewers noticing them manually.

### Route sensitive changes using CODEOWNERS

CODEOWNERS routes review based on file paths, which is essential for arbitration in multi-agent systems.

```
\# File: CODEOWNERS

/security/ @security-team

/.github/workflows/ @platform-team

/infra/ @platform-team

\* @core-team
```

### Define escalation thresholds

Define escalation rules so automation stops before repeated failures create instability.

- if a PR conflicts twice after rebasing attempts,

- if required checks fail twice with the same failure signature, or

- if two agents propose incompatible fixes to the same alert.

Escalation should include a short report: what conflicted, what was attempted, and which options exist.

### What happens without structured conflict resolution

Without structured conflict resolution, outcomes are often determined by timing rather than correctness. Without arbitration rules, whichever pull request merges first becomes the "winner," which encourages instability and forces reviewers to untangle the system after the fact. This leads to increased unpredictability and makes coordination harder to manage.

This matters because reliable systems require consistent and enforceable resolution mechanisms. As a rule, escalate after repeated failures and enforce conflict detection through automated checks to ensure issues are identified early and handled predictably.

## Key takeaway

Conflicts must be detected early and resolved intentionally through ownership routing and explicit escalation. Escalate when conflicts repeat or when automated resolution fails twice.

Coordination and conflict resolution only work at scale when actions are visible and attributable. In the next unit, you will design observability so reviewers can understand which agent acted, what evidence exists, and how decisions were made.