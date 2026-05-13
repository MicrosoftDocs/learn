## In this unit, you'll learn:

- How to define success criteria for agent tasks 

- How to use pull request checks and workflows for evaluation 

- How to enforce quality using required checks and rules 

- How to incorporate security scanning into evaluation 

## Defining success criteria

Evaluation begins with clear success criteria.

In GitHub workflows, success criteria should be defined in the issue or pull request. These criteria describe what must be true for the task to be considered complete.

For example:

- A feature behaves as expected 

- Tests pass successfully 

- No new security issues are introduced 

In practice:

- Write acceptance criteria directly in the issue 

- Reference those criteria in the pull request 

- Use them as the basis for validation 

Clear criteria allow both the agent and the reviewer to verify completion.

## Using pull request checks for evaluation

Pull requests are the primary place where evaluation occurs.

GitHub displays evaluation signals through:

- Status checks 

- Workflow runs 

- Check results in the “Checks” tab 

In practice:

- Configure workflows to run on pull request or push events 

- Ensure tests and validations run automatically 

- Review results in the pull request before merging 

These checks provide feedback on whether changes meet the required standards.

## Using workflows to validate changes

Workflows powered by GitHub Actions are used to automate evaluation.

Common workflow steps include:

- Running tests 

- Linting code 

- Building the application 

Example trigger:

```
on:
  pull_request:
   branches: [main]
```

In practice:

- Add workflows in `.github/workflows/` 

- Ensure they run on pull requests or pushes 

- Use workflow results as the source of validation 

Each workflow run produces logs and results that are visible in the pull request.

## Enforcing quality with required checks

GitHub allows you to enforce evaluation through required status checks.

Required checks ensure that certain conditions must be met before a pull request can be merged.

In practice:

- Configure branch protection rules 

- Enable "Require status checks to pass before merging" 

- Select specific checks to enforce 

This ensures that all required checks must pass before merging.

GitHub also supports requiring branches to be up to date before merging, depending on configuration.

## Using workflow outputs for visibility

Workflows produce logs and artifacts that support evaluation.

In practice:

- Review logs directly in the Actions tab 

- Use artifacts to store outputs such as test results or reports 

- Link workflow runs in pull requests for visibility 

Artifacts and logs are retained for a limited time and can be reviewed during that period.

By default, GitHub stores workflow logs and artifacts for 90 days, after which they are automatically deleted.

## Incorporating security into evaluation

Evaluation should include security checks to prevent unsafe changes.

In GitHub, this can include:

- Code scanning (for vulnerabilities) 

- Dependency review checks 

- Secret scanning and push protection 

In practice:

- Enable available security features for the repository 

- Treat security alerts or failed checks as blockers 

- Review security results in the pull request 

These checks help ensure that changes are safe before merging.

## Using rules and protections

GitHub provides controls to enforce evaluation policies.

These include:

- Branch protection rules 

- Required pull request reviews 

- Required status checks 

In practice:

- Require at least one approving review before merging 

- Combine reviews with required checks 

- Prevent direct pushes to protected branches 

Branch protection rules enforce these requirements before changes can be merged.

## End-to-end evaluation flow

A typical evaluation flow in GitHub looks like:

- An issue defines the task and success criteria 

- An agent creates a branch and opens a pull request 

- Workflows run automatically 

- Status checks appear in the pull request 

- Required checks must pass 

- A reviewer approves the changes 

- The pull request is merged 

This ensures that all changes are validated before being accepted.

## Key takeaway

Evaluation defines whether agent work is complete and correct. By using GitHub workflows, pull request checks, required status checks, and security scanning, you can enforce consistent quality and ensure that all changes meet defined expectations before merging.
