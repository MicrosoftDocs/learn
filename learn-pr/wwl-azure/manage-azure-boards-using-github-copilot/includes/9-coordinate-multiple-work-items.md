As teams mature, they can delegate multiple independent work items in parallel. The key is deliberate coordination to avoid merge conflicts and hidden dependencies.

## Identify safe parallel candidates

Good parallel candidates usually:

- Touch different components or layers.
- Have independent acceptance criteria.
- Can be validated separately.

Avoid parallel delegation when items share the same critical files, migration steps, or tightly coupled logic.

## Coordination pattern

1. Refine both work items with explicit boundaries.
2. Delegate each item to a separate pull request.
3. Track each PR status in Azure Boards.
4. Use Copilot Chat to assess overlap risk before merge.

## Cross-PR validation questions

Before merging multiple Copilot-assisted PRs, ask:

- Do both PRs modify shared layouts or configuration files?
- Are there conflicting assumptions in validation logic?
- Does merge order affect runtime behavior?
- Are rollback options clear if one PR fails post-merge?

## Team guidance

Parallel execution improves throughput only when orchestration remains intentional. Keep work item scope tight, enforce review quality, and merge in a sequence that minimizes risk.
