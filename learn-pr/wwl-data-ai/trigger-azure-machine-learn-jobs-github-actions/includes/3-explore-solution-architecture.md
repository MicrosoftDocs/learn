With your training scripts and job definitions in source control, the next challenge is protecting them. Two data scientists editing the same file on the `main` branch at the same time can create conflicts and, more importantly, accidental breaks in code that others depend on. Trunk-based development gives your team a structured way to evolve the model while keeping production code stable.

## Keep the shared branch stable

In trunk-based development, contributors integrate changes into one shared branch, typically `main`. Teams keep this branch healthy so it remains a reliable starting point for new work.

For the Proseware project, the team requires changes to reach `main` through pull requests. This policy gives reviewers and automated checks a chance to evaluate each change before integration.

## Short-lived feature branches

When a data scientist wants to experiment with a new feature — say, adding a BMI variable to the diabetes model — they create a short-lived branch from `main`. The work happens there, isolated from everyone else's code. When the experiment is ready to review, the data scientist opens a pull request.

Short-lived branches reduce the chance of diverging far from `main`, which makes merging easier and conflicts smaller.

## Pull requests, reviews, and required checks

A pull request does two things: it shows reviewers exactly what changed, and it becomes the trigger point for automated checks. Reviewers can ask questions, request changes, or approve the work. Automation runs in parallel with the review.

**Branch protection rules** or **rulesets** can enforce this process. Depending on repository settings, a rule on `main` can:

- Restrict direct pushes
- Require a minimum number of approvals before merging
- Require specific status checks to pass before merging

GitHub Actions workflows can produce the checks that a rule requires. You explore these checks in the next unit.

> [!NOTE]
> Branch protection rules and rulesets are GitHub repository settings, not GitHub Actions. The workflow defines *what* runs. The protection rule decides *whether a merge is allowed* based on the result.

> [!TIP]
> Consider a model change that needs several weeks of work. How could you split it into smaller changes that merge into `main` without leaving a long-lived branch?
