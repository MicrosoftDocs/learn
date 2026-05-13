Agent workflows do not always succeed on the first attempt. Failures can occur due to incorrect assumptions, misuse of tools, or inconsistent context. These failures should be analyzed using available artifacts so that the agent’s behavior can be improved over time.

In GitHub workflows, failures are observable through logs, pull requests, workflow runs, and related artifacts. These provide the information needed to understand what happened and why.

## In this unit, you'll learn:

- How to analyze agent failures using logs, plans, and artifacts 

- How to classify root causes of failures 

- How to improve agent behavior through prompts, memory, and tool configuration 

## Analyzing failures using GitHub artifacts

When an agent fails to complete a task correctly, the first step is to review the available evidence.

In GitHub, this typically includes:

- Workflow logs in the Actions tab 

- Pull request changes and discussions 

- Commit history 

- Workflow run results and artifacts

In practice:

- Open the pull request and review recent changes 

- Check the "Checks" tab for failed workflows 

- Inspect workflow logs to identify errors 

- Compare the expected outcome with the actual result 

These artifacts provide a record of workflow execution and repository changes, helping identify where the failure occurred.

### Comparing intent with results

To understand a failure, compare what the agent was expected to do with what was produced.

In GitHub workflows, intent is typically captured in:

- Issue descriptions (requirements and acceptance criteria) 

- Pull request descriptions (plans and decisions) 

Results are captured in:

- Commits and code changes 

- Workflow outputs and logs 

Comparing these helps determine whether the agent:

- Misinterpreted the task 

- Implemented an incorrect solution 

- Failed during execution or validation 

## Classifying root causes

Failures can be grouped into common categories such as:

### Reasoning errors

Incorrect assumptions or decisions that lead to invalid changes.

Examples include:

- Misinterpreting requirements 

- Implementing incorrect logic 

- Ignoring acceptance criteria 

### Tool misuse

Incorrect use of workflows, commands, or repository operations.

Examples include:

- Misconfigured workflows 

- Incorrect commands or scripts 

- Failing to trigger or use workflows properly 

### Context issues

Missing, stale, or conflicting information that leads to incorrect behavior.

Examples include:

- Using outdated pull request state 

- Missing prior decisions 

- Conflicting information across artifacts 

This classification is a practical way to diagnose failures based on how the workflow behaves.

## Improving agent behavior

Once the root cause is identified, the next step is to improve how the agent operates.

This is typically done by adjusting three areas.

### Prompts and instructions

Improve clarity and specificity in prompts or repository instructions.

In practice:

- Clarify acceptance criteria 

- Add constraints or expectations 

- Update repository instruction files 

### Memory and state

Improve how information is stored and accessed.

In practice:

- Update issues or pull requests with clearer decisions 

- Remove outdated or conflicting context 

- Ensure a single source of truth is maintained 

### Tool configuration

Adjust workflows and execution behavior.

In practice:

- Update workflow files in .github/workflows/ 

- Ensure workflows trigger on the correct events (push, pull_request) 

- Verify permissions and required checks 

GitHub workflows and branch protection rules enforce how validation and execution occur.

## Using a feedback loop

Improving agent behavior is an iterative process.

A typical loop looks like:

- Run the agent on a task 

- Observe failures through logs and artifacts 

- Identify the root cause 

- Apply fixes to prompts, memory, or tools 

- Re-run the workflow 

GitHub supports this loop by allowing workflows to be re-run and by preserving logs and artifacts for inspection.

## Maintaining traceability

All improvements should be visible and traceable in GitHub.

In practice:

- Document changes in pull request updates 

- Reference related commits and workflow runs 

- Keep changes scoped and reviewable

This ensures that adjustments to agent behavior can be reviewed and audited over time.

## Key takeaway

Agent failures are a normal part of workflow execution. GitHub provides logs, workflow runs, and artifacts that make failures observable. By analyzing these outputs, identifying root causes, and improving prompts, memory, and tool configuration, you can continuously improve agent performance and reliability.