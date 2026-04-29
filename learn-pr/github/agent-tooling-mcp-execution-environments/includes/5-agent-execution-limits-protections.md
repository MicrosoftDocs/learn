Agents can take actions in repositories, but those actions run within platform limits and protections. On GitHub, Copilot cloud agent works in a GitHub Actions-powered environment, creates changes on a branch, and prepares those changes for review.

It does not finalize changes on its own. You decide whether those changes should become a pull request.

In this unit, you'll learn:

- What limits are placed on agent actions
- How branch and repository restrictions protect codebases
- How workflow and environment controls affect agent-driven changes
- How human review remains part of the process

## Repository and branch limits

Copilot cloud agent only has access to the repository where it is working. It cannot access other repositories.

Its changes are made on a separate branch, not directly on the default branch such as main. This ensures that all modifications are isolated before review.

## Pull request control

When Copilot cloud agent finishes its work, it prepares the changes for review, but it does not automatically create or merge a pull request.

You decide whether to:

- Create a pull request
- Review the generated changes
- Request updates or discard the work

This keeps the final decision in human control.

## Workflow controls

Agent work runs within workflows powered by GitHub Actions.

Repository and organization settings can control:

- Which workflows are allowed
- What actions can run
- What the GITHUB_TOKEN is permitted to do

These controls limit what the agent can execute through workflows.

Execution safeguards and resilience patterns.

In addition to platform-level limits, agent-driven workflows should include safeguards to handle failures, prevent repeated errors, and ensure accountability.

## Error handling

Workflows should explicitly handle failures during agent execution.

This can include:

- Failing fast when a step runs into errors
- Logging meaningful error messages
- Preventing partial or inconsistent changes

Example:

    ```
    - run: | 
            npx @github/copilot-cli -p "Run task" 
    continue-on-error: false
    ```

This ensures that errors stop execution instead of silently continuing.

## Retries

Retries help handle temporary failures such as network issues or transient errors.

You can implement retries by:

- Re-running failed steps
- Using retry logic in scripts
- Structuring workflows to allow safe re-execution

Example pattern:

    ```
    - name: Run agent task with retry 
    run: | 
    for i in 1 2 3; 
    do npx @github/copilot-cli -p "Run task" && break 
    sleep 5 
    done
    ```

This allows the workflow to recover from temporary issues without manual intervention.

## Rollbacks

If an agent produces incorrect or unsafe changes, rollback mechanisms ensure those changes do not affect the main codebase.

Rollback is naturally supported through:

- Branch-based isolation
- Pull request review before merge

Additional rollback strategies include:

- Closing or discarding the pull request
- Reverting commits if changes are merged

## Escalation paths

When an agent cannot complete a task or encounters uncertainty, escalation ensures a human can step in.

This can be implemented by:

- Requiring pull request review
- Assigning reviewers automatically
- Using workflow steps to notify maintainers

Escalation ensures that critical decisions are always handled by humans.

## Traceability and accountability

All agent actions should be traceable and auditable.

GitHub provides this through:

- Workflow logs
- Commit history
- Pull request discussions

To improve traceability:

- Use clear commit messages
- Keep changes scoped to a branch
- Review all actions through pull requests

This ensures that every agent action can be inspected, understood, and attributed.

These safeguards we discussed ensure that agent execution is:

- Resilient: can handle failures and retries
- Controlled:  prevents unsafe changes
- Auditable: all actions are visible and traceable
- Human-governed: escalation ensures oversight

## Environment protections

If agent-generated changes are used in deployments, environments provide additional safeguards.

Environments can:

- Require approvals before jobs continue
- Restrict access to secrets
- Control deployment targets

This ensures that sensitive operations are not executed automatically.

## Session visibility

Agent execution is visible while it runs.

You can:

- Monitor progress through logs
- Inspect the agent’s actions
- Provide follow-up prompts to adjust behavior

This visibility allows you to stay in control throughout the process.

## Trigger behavior and workflow limits

Workflows triggered using the GITHUB_TOKEN have restrictions.

Most actions performed with this token do not trigger additional workflow runs, which helps prevent unintended loops or repeated execution.

Other authentication methods, such as GitHub App tokens or personal access tokens (PATs), can trigger additional workflow runs depending on configuration. While this enables more flexible automation patterns, it also requires careful design to avoid recursive executions or unintended automation loops.

## Enabling agent actions safely

Agents can perform actions such as:

- Creating branches
- Updating code
- Preparing changes for review
- Triggering workflows through repository events

These actions are controlled through:

- Branch-based isolation
- Workflow validation
- Pull request review
- Workflow permissions

By combining these controls, agent actions can be enabled without allowing unrestricted access to the repository or execution environment.

## Key takeaway

Agent execution on GitHub is controlled through repository scope, branch isolation, workflow permissions, environment protections, and human decision points. Agents prepare changes, but you remain responsible for reviewing and finalizing them.
