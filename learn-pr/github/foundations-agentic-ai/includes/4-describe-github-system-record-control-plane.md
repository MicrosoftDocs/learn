Agentic systems need an environment that does more than store code. They need an environment that can capture intent, record actions, enforce validation, and apply policy. In this learning path, GitHub is that environment.

## In this unit, you'll learn

- What it means for GitHub to act as a system of record for agent workflows 

- How GitHub enforces control through repository policies and workflows 

- Which GitHub controls are used to supervise and constrain agent behavior

## GitHub as the system of record

GitHub is the system of record because it stores the artifacts through which development work is proposed and evaluated:

- Repositories and branches

- Commits and pull requests

- Issues and discussions (context and intent)

- Workflow runs and artifacts (evidence)

- Review history (decisions)

In an agentic workflow, these artifacts do double duty: they support development and make agent behavior inspectable after the fact.
 
> [!NOTE]
> This module focuses on general GitHub governance patterns. GitHub Advanced Security features such as secret scanning and push protection are not covered here, but can be integrated as additional validation signals in production environments.

## GitHub as the control plane

GitHub is the control plane because (when configured by policy) it provides enforcement points that shape what agent contributions can and cannot do.

### Controls at a glance

| **GitHub control**            | **What it enforces**                 | **Why it matters for agents**                              |
| ----------------------------- | ------------------------------------ | ---------------------------------------------------------- |
| Pull requests                 | Changes are proposed  before merging | Makes agent work  reviewable and discussable               |
| Required reviews              | Human + agent  approval gate         | Prevents unreviewed  merges and supports accountability    |
| Required status  checks       | CI evidence before  merging          | Converts evaluation  into enforceable policy               |
| CODEOWNERS                    | Review routing by  path              | Ensures the right  experts supervise high-impact changes   |
| Rulesets / branch  protection | Centralized branch  policy           | Prevents unsafe  merges and enforces consistent guardrails |
| Environments                  | Approvals for  deployments/secrets   | Controls sensitive  execution and secret access            |

 

> [!NOTE]
> These enforcement behaviors depend on configuration and permissions. For example, enabling required checks and rulesets is typically an admin task. The supervision model works everywhere; enforcement requires the controls to be turned on.

## GitHub Actions belongs in the control plane

Workflows are where execution is validated, but permissions matter as much as checks. A key security principle is least privilege:

- Set default workflow token permissions conservatively (for example, read-only where possible).

- Grant higher permissions only to the jobs that need them.

- Use environments and approvals to control access to sensitive secrets and deployments.

For agentic systems, "what the agent can do" often reduces to "what the workflow token and tool credentials can do." Controls and permissions must be designed accordingly.

## Implementation examples

- **Workflow execution is gated by humans** 
  In some agent PR workflows, a human may need to explicitly approve running workflows (for example, an "Approve and run workflows" action). This is a built-in guardrail: it reduces the risk of privileged workflows running automatically for untrusted changes.

- **Environments gate secrets and deployments** 
  If a workflow job targets an environment with required reviewers, the job waits until approval is granted. This prevents an agent-triggered workflow from accessing protected secrets or deploying without human review (when configured).

- **CODEOWNERS routes reviews for high-risk paths**
  If the agent changes files in a sensitive path (for example, .github/workflows/ or infra/), CODEOWNERS can automatically request review from the owners of those paths. When combined with required reviews, this helps ensure the right experts supervise high-impact changes.

## How GitHub enforces control in practice

The agent opens a pull request with a security fix. GitHub:

- Makes the change visible in the PR

- Routes it to the right reviewers via CODEOWNERS (when configured)

- Evaluates it through required checks and workflows

- Blocks merging until policy requirements are satisfied (when configured)

- Prevents access to protected environment secrets until approvals are granted (when configured)

This is what it means to say GitHub is the control plane: it is where enforcement happens.

GitHub is not just where agent work is stored. It is where agent work is supervised, validated, and governed. Repositories and pull requests make work visible; checks, reviews, CODEOWNERS, rulesets, branch protection, and environments make work controllable.

Now that you've seen how GitHub can constrain and validate agent behavior, the next step is to examine responsibility. In the next unit, you'll look at who remains accountable when agents act inside a workflow.
