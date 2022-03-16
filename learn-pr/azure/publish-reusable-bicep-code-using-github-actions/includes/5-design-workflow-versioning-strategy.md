## Semantic versioning

TODO Brief introduction to SemVer and why it’s a good choice for many scenarios

Whenever you make a breaking change, you should increment the major version number. For example, suppose you add a new mandatory parameter or remove a parameter from your Bicep file. These are examples of breaking changes, because Bicep requires mandatory parameters to be specified at deployment time, and doesn't allow setting values for non-existent parameters. So, you would update the major version.

Whenever you add something new to the code, but it isn't a breaking change, you should increment the minor version number. For example, suppose you add a new optional parameter with a default value. Optional parameters aren't breaking changes, so you would update the minor version.

Whenever you make backwards-compatible bug fixes or other changes that don't affect how the code works, you should increment the patch version number. For example, suppose you refactor your Bicep code to make better use of variables and expressions. If the refactoring doesn't change your Bicep code's behavior at all, you would update the patch version.

Your workflow should automatically append an identifier after major, minor, and patch version numbers. This helps to ensure that your version numbers are always unique, even if you don't update the other components of your version number.

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
