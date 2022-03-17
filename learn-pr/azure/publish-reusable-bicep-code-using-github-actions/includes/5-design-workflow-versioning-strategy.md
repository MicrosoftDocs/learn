When you start to publish reusable Bicep code, you probably use a manual approach. It's easy for you to determine which Bicep file you need to publish, and you probably have a manual process for incrementing the version number. When you automate the publishing process, though, you need to consider how to automate these steps. In this unit, you'll learn how to adopt a versioning system that communicates the changes you've made to your code, and you'll also learn how you can scope your workflows to publish the code you expect. <!-- TODO mention environments too -->

## Version numbers

In previous Microsoft Learn modules, you learned about the importance of versioning for template specs and Bicep modules. There are many different versioning approaches you can use. In many situations, though, *semantic versioning* is a good choice.

When you use semantic versioning, a version number has several components:

:::image type="content" source="../media/5-version-number.png" alt-text="Diagram that shows the version number 1.4.6+20." border="false":::

In the example above, the major version is 1, the minor version is 4, the patch version is 6, and the build number is 20.

Changes in version numbers communicate important information about the types of changes in the code:

- **Whenever you make a breaking change, you should increment the major version number.** For example, suppose you add a new mandatory parameter or remove a parameter from your Bicep file. These are examples of breaking changes, because Bicep requires mandatory parameters to be specified at deployment time, and doesn't allow setting values for non-existent parameters. So, you would update the major version.

- **Whenever you add something new to the code, but it isn't a breaking change, you should increment the minor version number.** For example, suppose you add a new optional parameter with a default value. Optional parameters aren't breaking changes, so you would update the minor version.

- **Whenever you make backwards-compatible bug fixes or other changes that don't affect how the code works, you should increment the patch version number.** For example, suppose you refactor your Bicep code to make better use of variables and expressions. If the refactoring doesn't change your Bicep code's behavior at all, you would update the patch version.

- **Your workflow should also automatically append the workflow run number after major, minor, and patch version numbers.** This helps to ensure that your version numbers are always unique, even if you don't update the other components of your version number.

For example, suppose you're using a Bicep module published by somebody else. The module has a version number of `2.0.0+90`. You see there is a new version of the module available with the version number `2.1.0+102`. The only significant change is to the minor version number, which indicates that you shouldn't expect a breaking change when you use the new version.

### Versions and workflows

When you publish your code interactively, such as by using the Azure CLI, you probably think about the version number you assign to your template spec or module as you publish it. But in an automated deployment workflow, you need to change the approach you use to assign version numbers. Your workflow can't automatically detect breaking changes, or advise you when you should increment your major or minor version numbers. Ensure you carefully consider versioning before you publish the template spec or module.

One approach is to store a *metadata file* with your Bicep code, as illustrated in the following diagram:

:::image type="content" source="../media/5-metadata-files.png" alt-text="Diagram that shows a file system hierarchy with two modules and a template spec, each with an associated metadata dot J S O N file." border="false":::

Whenever you update your Bicep code, you update the version information in the correspnding metadata file. You need to ensure that you correctly identify breaking and non-breaking changes so you can increment the version numbers correctly.

> [!TIP]
> If your team reviews your Bicep code by using pull requests, ask the reviewers to validate whether any changes to your code require changing your major, minor, or patch version number.

You'll see how you can use a metadata file in the next exercise.

You can also choose to use a simpler versioning strategy, such as just using the workflow run number as your version number. While this approach is easier to implement, it means you can't effectively communicate the differences between versions to anybody who uses your code.

## How many workflows?

It's common to build up a collection of template specs and modules. Often, it makes sense to keep these in the same Git repository.

By using *path filters* in GitHub Actions, you can create separate workflows for each module or template spec within your repository. This approach helps to avoid publishing a new version of every Bicep file within the repository every time you change one file. You can use *reusable workflows* to define your workflow's steps in one centralized file.

For example, suppose you have a file structure similar to the one illustrated above. You could configure three separate workflows, one for each Bicep file. Select each tab to see the corresponding workflow definition, and its path filter:

# [module-1](#tab/module-1)

:::code language="yaml" source="code/5-publish-module-1.yml" highlight="7-8, 12-14" :::

# [module-2](#tab/module-2)

:::code language="yaml" source="code/5-publish-module-2.yml" highlight="7-8, 12-14" :::

# [template-spec-1](#tab/template-spec-1)

:::code language="yaml" source="code/5-publish-template-spec-1.yml" highlight="7-8, 12-14" :::

---

The approach of creating a workflow for each of your reusable Bicep files is simple, and you can use 

<!-- TODO -->

Should you create a single workflow for each module/TS, or use a shared workflow that deploys everything?

In this Microsoft Learn module, we'll use a single workflow for each template spec and module file. This approach works well when you work with a small number of files. If you build up a large set of template specs or modules, you might want to consider using GitHub Actions features path filters and reusable workflows to simplify your workflow definitions.

## Environments

Handling multiple environments (e.g. aliases)
