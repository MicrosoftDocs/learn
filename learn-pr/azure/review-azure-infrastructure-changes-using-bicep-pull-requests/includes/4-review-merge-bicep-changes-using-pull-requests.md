You've learned how to use feature branches and how to apply branch protection to ensure changes are reviewed before they're merged. Now, you need to follow a consistent process to propose and review your changes before they're merged.

In this unit, you'll learn more about pull requests, including how you create and use them. You'll also learn how you can use pull requests to review Bicep code.

## Pull requests

A *pull request* is a *request* from you, the developer of a feature, to the maintainer of the main branch. You ask the maintainer to *pull* your changes into the main branch of the repository.

::: zone pivot="github"

### Pull requests and branch protections

When you configure branch protections, you can require that the owners of your code need to review the pull request. For example, you might include the project leads as reviewers for all of your pull requests. Or, you can specify that every pull request must be reviewed by a specific number of people.

::: zone-end

::: zone pivot="azurerepos"

### Pull requests and branch policies

When you configure branch policies, you can require that specific people, or a group of people, need to review the pull request. For example, you might include the project leads as reviewers for all of your pull requests. Or, you can specify that every pull request must be reviewed by a specific number of people.

You can also require that each pull request is linked to a work item. By using this configuration, you ensure you have the ability to trace from a work item that contains a feature request, to the code that implements the change, and even through to the deployment to your production environment.

::: zone-end

### Create a pull request

::: zone pivot="github"

You can create a pull request by using the GitHub web interface. You select the source branch, where you've made your changes, and the target branch, which is usually the main branch of the repository.

::: zone-end

::: zone pivot="azurerepos"

You can create a pull request by using the Azure DevOps web interface. You select the source branch, where you've made your changes, and the target branch, which is usually the main branch of the repository.

::: zone-end

When you create a pull request, you need to give it a name. It's a good practice to make your pull requests' names clear and understandable. This practice helps your team members to understand the context of what they're being asked to review. If they have different areas of expertise, a good name can help them to find pull requests that they can contribute meaningful feedback for, and skip those that aren't relevant. Also, pull request names often become part of your Git repository's history, so it's a good idea to make them understandable when somebody looks back at the history.

::: zone pivot="github"

You can also give pull requests a description. You can mention specific people, or refer to issues, in your descriptions. Many teams create standardized templates for pull request descriptions so that it's clear what each change is.

::: zone-end

::: zone pivot="azurerepos"

You can also give pull requests a description. You can mention specific people, or refer to work items, in your descriptions. Many teams create standardized templates for pull request descriptions so that it's clear what each change is.

::: zone-end

When you create a pull request, you can also invite people to review the changes.

Sometimes, you create a pull request just to get feedback from your colleagues - you might not want to immediately merge it. In these situations, you can specify the pull request is a *draft*. Reviewers will know that you're still working on the changes. Your reviewers can still provide feedback but it's clear that the changes aren't ready to merge yet. When you're satisfied with your changes, you can remove the draft status.

Even after you've created a pull request, you can keep making changes to the code on your feature branch. These changes become part of the pull request.

## Review a pull request

When you're reviewing a pull request, you can easily see all of the changes. You can comment on the entire pull request, or just on specific parts of the files that have been changed. The pull request author can respond to comments, and other reviewers can participate in discussions, too. These commenting features make collaborating on pull requests a very interactive experience.

When you review Bicep code, there are some key elements to look for. These include:

> [!div class="checklist"]
>
> * **Is the file deployable?** Deploy and test the Bicep code before it's merged. Ensure there are no linter warnings, and that the Azure deployment succeeds. In a future Microsoft Learn module, you'll learn about approaches to automatically deploy and verify your changes.
> * **Is the Bicep code clear and understandable?** It's important that your Bicep code is understood by everybody on your team. When you review a Bicep file in a pull request, ensure you understand exactly what every change is for. Are variables and parameters named well? Have comments been used to explain any complex sections of code?
> * **Is the change complete?** If this pull request represents part of a wider piece of work, then you need to ensure that your environment will work when this change is merged and deployed. For example, if the pull request reconfigures an Azure resource in preparation for a later change, verify that the resource continues to work correctly throughout the whole process. If the pull request adds a new Azure resource that isn't needed yet, consider whether a condition should be added temporarily so that the resource isn't deployed until it's needed.
> * **Does the change follow good Bicep practices?** In other Microsoft Learn modules, you've learned about the elements of good Bicep code. Ensure that the code you review follows those same best practices.
> * **Does the change match the description?** It's a good practice for pull requests to include a descriptive title, and many teams also require that pull requests include a description of the change and its purpose. Check that the changes to your Bicep code match the pull request details. If the pull request author has linked to work items or issues, verify that the changes in the pull request meet the success criteria defined in the work item.

## Complete a pull request

After the pull request is approved, it can be *completed*, which means the contents of the pull request are merged into the main branch.

::: zone pivot="github"

In some teams, the author of the pull request should also complete it. This process helps to ensure that the author controls when the merge happens and can be available to monitor any automated deployments. In other teams, approvers complete the pull request. Your team should decide who merges pull requests and when.

::: zone-end

::: zone pivot="azurerepos"

In some teams, the author of the pull request should also complete it. This process helps to ensure that the author controls when the merge happens and can be available to monitor any automated deployments. In other teams, approvers complete the pull request. Azure DevOps even enables you to automatically complete a pull request when its approval criteria are met. Your team should decide who merges pull requests and when.

::: zone-end