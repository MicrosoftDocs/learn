
When using Actions to create CI or CD workflows, you'll often need to pass artifacts created by one job to another.

The most common ways to do it are by using the **upload-artifact** and **download-artifact** actions.

## Upload-artifact

This action can upload one or more files from your workflow to be shared between jobs.

You can upload a specific file:

```YAML

- uses: actions/upload-artifact
  with:
    name: harness-build-log
    path: bin/output/logs/harness.log

```

You can upload an entire folder:

```YAML

- uses: actions/upload-artifact
  with:
    name: harness-build-logs
    path: bin/output/logs/

```

You can use wildcards:

```YAML

- uses: actions/upload-artifact
  with:
    name: harness-build-logs
    path: bin/output/logs/harness[ab]?/*

```

You can specify multiple paths:

```YAML

- uses: actions/upload-artifact
  with:
    name: harness-build-logs
    path: |
        bin/output/logs/harness.log
        bin/output/logs/harnessbuild.txt

```

For more information on this action, see [upload-artifact.](https://github.com/actions/upload-artifact)

## Download-artifact

There's a corresponding action for downloading (or retrieving) artifacts.

```YAML

- uses: actions/download-artifact
  with:
    name: harness-build-log

```

If no path is specified, it's downloaded to the current directory.

For more information on this action, see [download-artifact.](https://github.com/actions/download-artifact)

## Artifact retention

A default retention period can be set for the repository, organization, or enterprise.

You can set a custom retention period when uploading, but it can't exceed the defaults for the repository, organization, or enterprise.

```YAML

- uses: actions/upload-artifact
  with:
    name: harness-build-log
    path: bin/output/logs/harness.log
    retention-days: 12

```

## Deleting artifacts

You can delete artifacts directly in the GitHub UI.

For details, you can see: [Removing workflow artifacts](https://docs.github.com/actions/managing-workflow-runs/removing-workflow-artifacts).
