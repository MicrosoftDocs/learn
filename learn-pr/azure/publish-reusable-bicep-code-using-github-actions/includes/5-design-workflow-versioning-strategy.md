## Semantic versioning

Brief introduction to SemVer and why it’s a good choice for many scenarios

> [!IMPORTANT]
> Your workflow can't automatically detect breaking changes, or advise you when you should increment your major or minor version numbers. Ensure you carefully consider versioning before you publish the template spec or module. If your team reviews your Bicep code by using pull requests, ask the reviewers to validate whether any changes to your code require changing your major or minor version.

## Versions and pipelines

The complexities of versioning from a pipeline – figuring out when to increment major/minor versions

Using a simple metadata JSON file to handle major/minor versions

## How many workflows?

Should you create a single pipeline for each module/TS, or use a shared pipeline that deploys everything?

In this Microsoft Learn module, we'll use a single workflow for each template spec and module file. This approach works well when you work with a small number of files. If you build up a large set of template specs or modules, you might want to consider using GitHub Actions features path filters and reusable workflows to simplify your workflow definitions.

## Environments

Handling multiple environments (e.g. aliases)
