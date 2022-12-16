Actions will often produce console output. You don't need to connect directly to the runners to retrieve that output.

The console output from actions is available directly from within the GitHub UI.

Select **Actions** on the top repository menu to see a list of executed workflows to see the output.

Next, click on the job's name to see the steps' output.

:::image type="content" source="../media/console-output-from-actions-63af6157.png" alt-text="Console Output from Actions.":::


Console output can help debug. If it isn't sufficient, you can also enable more logging. See: [Enabling debug logging](https://docs.github.com/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging).

## Release Management for Actions

While you might be happy to retrieve the latest version of the action, there are many situations where you might want a specific version of the action.

You can request a specific release of action in several ways:

### Tags

Tags allow you to specify the precise versions that you want to work.

```YAML

steps:
    -uses: actions/install-timer@v2.0.1
```

### SHA-based hashes

You can specify a requested SHA-based hash for an action. It ensures that the action hasn't changed. However, the downside to this is that you also won't receive updates to the action automatically either.

```YAML
steps:
    -uses: actions/install-timer@327239021f7cc39fe7327647b213799853a9eb98

```

### Branches

A common way to request actions is to refer to the branch you want to work with. You'll then get the latest version from that branch. That means you'll benefit from updates, but it also increases the chance of code-breaking.

```YAML
steps:
    -uses: actions/install-timer@develop
```

## Test an Action

GitHub offers several learning tools for actions.

[GitHub Actions: hello-world](https://github.com/skills/hello-github-actions)

You'll see a basic example of how to:

 -  Organize and identify workflow files.
 -  Add executable scripts.
 -  Create workflow and action blocks.
 -  Trigger workflows.
 -  Discover workflow logs.
