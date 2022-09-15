In this unit, you'll learn more about how you can use the GitHub Script to improve your workflow.

## Add issues to a project board

In addition to using octokit/rest.js to create comments and open pull requests, you can also use octokit/rest.js to manage GitHub Projects. In the code sample below, you create a workflow that runs whenever anyone adds a new issue to the repository. This adds the issue to a project board, making it easier for you to triage your work.

```
name: Learning GitHub Script
on:
  issues:
    types: [opened]
jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/github-script@0.8.0
      with:
        github-token: {% raw %}${{secrets.GITHUB_TOKEN}}{% endraw %}
        script: |
            github.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: "🎉 You've created this issue comment using GitHub Script!!!"
            })
            github.projects.createCard({
            column_id: {{columnID}},
            content_id: context.payload.issue.id,
            content_type: "Issue"
            });
```
The first section of this workflow creates a comment whenever a new issue is created, which was covered in the previous unit. The next section creates a card based on this issue and adds it to the project board.

## Separate workflow into steps

One benefit of using actions is that you can separate jobs into smaller units of work called steps. In the example workflow above, you can separate the workflow into two steps. 

One advantage of breaking the current workflow into multiple steps is that it allows you to use expressions to apply logic. Using steps enables you to create rules around when steps are allowed to run and can help optimize your workflow run.

To separate the example workflow into steps:

- Name each step so you can track it from the Actions tab
- Use expressions to determine whether a step should execute (optional)

In this example, the two tasks in the original workflow file have been separated into individual steps.

```
name: Learning GitHub Script
on:
  issues:
    types: [opened]
jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
    - name: Comment on new issue
      uses: actions/github-script@0.8.0
      with:
        github-token: {% raw %}${{secrets.GITHUB_TOKEN}}{% endraw %}
        script: |
            github.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: "🎉 You've created this issue comment using GitHub Script!!!"
            })
    - name: Add issue to project board
      if: contains(github.event.issue.labels.*.name, 'bug')
      uses: actions/github-script@0.8.0
      with:
        github-token: {% raw %}${{secrets.GITHUB_TOKEN}}{% endraw %}
        script: |
            github.projects.createCard({
            column_id: {{columnID}},
            content_id: context.payload.issue.id,
            content_type: "Issue"
            });
```
Each step includes a descriptive `name` element that also helps you track it from the Actions tab. 

The `Add issue to project board` step also includes an `if` statement that specifies the issue should only be added to the project board if it's labeled `bug`.

## Use the Node.js environment

The GitHub Script also grants you access to a full Node.js environment. While the GitHub Script isn't recommender for writing the logic for complex actions, you can use it to add more functionality to the octo/rest.js API. 

One example would be to use the Node.js to display a contribution guide whenever an issue is opened. You can use the Node.js File System to read a file and use it as the body of the issue comment. To access files within the repository, include the `actions/checkout` action as the first step in the workflow. 

The example below makes the following changes to the workflow file:

- Adds the `action/checkout` action to read the templated response file located at `.github/ISSUE_COMMENT/comment.md`.
- Adds JavaScript to use the Node.js File System module to place the contents of our templated response as the body of the issue comment.

```
name: Learning GitHub Script
on:
  issues:
    types: [opened]
jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2
      - name: Comment on new issue
        uses: actions/github-script@0.8.0
        with:
          github-token: {% raw %}${{secrets.GITHUB_TOKEN}}{% endraw %}
          script: |
             const fs = require('fs')
             const issueBody = fs.readFileSync(".github/ISSUE_RESPONSES/comment.md", "utf8")
             github.issues.createComment({
             issue_number: context.issue.number,
             owner: context.repo.owner,
             repo: context.repo.repo,
             body: issueBody
             })
      - name: Add issue to project board
        if: contains(github.event.issue.labels.*.name, 'bug')
        uses: actions/github-script@0.8.0
        with:
          github-token: {% raw %}${{secrets.GITHUB_TOKEN}}{% endraw %}
          script: |
            github.projects.createCard({
            column_id: {{columnID}},
            content_id: context.payload.issue.id,
            content_type: "Issue"
            });
```

The GitHub Script enabled you to create comprehensive response to a new issue being opened. This response is also based on a template in the repository so it's easy to change in the future. Finally, you also included a trigger to add the issue to the project board so it can easily be triaged for future work.
