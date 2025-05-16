In this unit, you'll learn how GitHub Script enables you to automate common GitHub processes by using GitHub Actions workflows.

## What is GitHub Script?

[GitHub Script](https://github.com/actions/github-script?azure-portal=true) is an action that provides an authenticated [Octokit](https://octokit.github.io/rest.js/?azure-portal=true) client and enables JavaScript to be written directly in a workflow file. It runs in [Node.js](https://nodejs.org/?azure-portal=true), so you have the power of that platform available when writing scripts.

## What is Octokit?

Octokit is the official collection of clients for the GitHub API. One of these clients, rest.js, provides JavaScript access to the GitHub REST interface.

You have always been able to automate the GitHub API via octokit/rest.js, although it could be a chore to properly set up and maintain. One of the great advantages to using GitHub Script is that it handles all of this overhead so you can immediately start using the API. You don't need to worry about dependencies, configuration, or even authentication.

### What can octokit/rest.js do?

The short answer is that it can do virtually anything with respect to automating GitHub. In addition to having access to commits, pull requests, and issues, you also have access to users, projects, and organizations. You can retrieve lists of commonly used files, like popular licenses or `.gitignore` files. You can even render Markdown.

If you're creating something that integrates GitHub, the odds are good that you'll find what you're looking for in [the full octokit/rest.js documentation](https://octokit.github.io/rest.js/?azure-portal=true).

### How is using GitHub Script different from octokit/rest.js?

The main difference in usage is that GitHub Script provides a preauthenticated octokit/rest.js client named `github`.

So instead of

`octokit.issues.createComment({`

you use

`github.issues.createComment({`.

In addition to the `github` variable, the following variables are also provided:

- `context` is an object that contains the [context of the workflow run](https://github.com/actions/toolkit/blob/master/packages/github/src/context.ts?azure-portal=true).
- `core` is a reference to the [@actions/core](https://github.com/actions/toolkit/tree/master/packages/core?azure-portal=true) package.
- `io` is a reference to the [@actions/io](https://github.com/actions/toolkit/tree/master/packages/io?azure-portal=true) package.

## Creating a workflow that uses GitHub Script

GitHub Script actions fit into a workflow like any other action. As a result, you can even mix them in with existing workflows, like those you might have already set up for CI/CD. To illustrate the convenience of GitHub Script, you'll now construct a complete workflow that uses it to automatically post a comment to all newly created issues.

You'll start off with a `name` and an `on` clause that specifies that the workflow runs when issues are opened:

```yaml
name: Learning GitHub Script

on:
  issues:
    types: [opened]
```

Next, you'll define a job named `comment` that runs on Linux with a series of steps:

```yaml
jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
```

In this case, there's only one step: the GitHub Script action.

```yaml
      - uses: actions/github-script@0.8.0
        with:
          github-token: ${{secrets.GITHUB_TOKEN}}
          script: |
            github.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: "🎉 You've created this issue comment using GitHub Script!!!"
            })
```

Using GitHub Actions can really help automate the events that take place in your repositories. Imagine that a repository visitor created a new issue containing information about a critical bug. You might want to thank them for bringing the bug to your attention, but this simple task can become overwhelming as your repository attracts more visitors. By automating an issue comment, you can automate the process of thanking visitors every time.

### Using actions/github-script@0.8.0

The `actions/github-script@0.8.0` action, also known as GitHub Script, does all the difficult work for your integration with the GitHub API.

This action requires a `github-token` that's provided at runtime so that requests are authenticated. This is automatically done for you, so you can use that code as-is.

The `script` parameter can be virtually any JavaScript that uses the octokit/rest/js client stored in `github`. In this case, it's just one line (split across multiple lines for readability) that creates a hardcoded comment.

After the workflow runs, GitHub Script logs the code it ran for review on the **Actions** tab.

![Screenshot of a completed GitHub Script workflow.](../media/2-completed-workflow.png)

### Running from a separate file

You might sometimes need to use a significant amount of code to meet your GitHub Script scenario. When that happens, you can keep the script in a separate file and reference it from the workflow instead of putting all the script inline.

Here's an example of a simple workflow that uses that technique:

```yaml
on: push

jobs:
  echo-input:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/github-script@v2
        with:
          script: |
            const path = require('path')
            const scriptPath = path.resolve('./path/to/script.js')
            console.log(require(scriptPath)({context}))
```

Check out [more GitHub Script examples](https://octokit.github.io/rest.js/?azure-portal=true).
