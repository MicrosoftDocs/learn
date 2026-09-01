With trunk-based development in place, every proposed change goes through a pull request. That pull request is also the natural moment to run automated checks. A change that breaks the training script shouldn't reach `main`, and a reviewer shouldn't have to catch every code error manually.

## Workflows, triggers, and the quality gate

A GitHub Actions **workflow** is a YAML file stored in your repository under `.github/workflows/`. It defines what to run, when to run it, and in what sequence. A **trigger** (the `on:` key) tells GitHub when to start it.

For the Proseware validation workflow, the `pull_request` trigger fits the task. By default, it runs when a pull request opens, reopens, or receives new commits. Its outcome appears as a **status check** on the pull request.

## Jobs, runners, and steps

A workflow organizes work into **jobs**. Each job runs on a **runner** — a virtual machine provided by GitHub or one your organization manages. A job contains ordered **steps** that check out the repository, install tools, and run commands.

For the Proseware training code, a validation job might:

1. Check out the repository.
2. Install a linter (such as Flake8 for Python) and run it against the training scripts.
3. Run unit tests (such as Pytest) to verify that script functions behave correctly.

These steps run automatically on every pull request. No one has to remember to run them locally.

## Making checks required

Running checks automatically is only half the protection. The other half is making those checks *blocking*. In branch protection settings, the **Require status checks to pass before merging** option lets you name specific jobs. A pull request can't merge until those named jobs succeed.

Together, trunk-based development and required status checks form a quality gate: the data scientist opens a pull request, the workflow runs, and the merge button stays disabled until the code passes.

> [!TIP]
> The status check is identified by the **job name** in the workflow file. Use a clear, stable name so it's easy to find in branch protection settings.

> [!TIP]
> Think about a preprocessing change with valid Python syntax but incorrect output. Which check could catch style problems, and which check must verify behavior?
