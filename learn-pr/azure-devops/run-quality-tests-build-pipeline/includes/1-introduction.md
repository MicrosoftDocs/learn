As you add a feature to your app, how do you _know_ whether the feature will work correctly, given all possible interactions? How do you know that the feature works well with and doesn't break other features? How do you know that your code is maintainable and can be easily understood by others?

You could run the app locally and try a few inputs, but that takes time and doesn't cover all cases. Plus, repeatedly testing existing features gets tedious and time consuming as you add new features.

This module demonstrates how to set up automated testing to help ensure that your latest feature works and that you haven't broken anything along the way.

In this module, you will:

* Learn the benefits of automated testing and the kinds of testing you can use.
* Run unit tests locally and then in Azure Pipelines.
* Add dashboard widgets to visualize test runs over time.
* Perform code coverage testing to see how much of your code is covered by unit tests.
* See a test fail in the pipeline and then fix the failure.

## Prerequisites

The prerequisites are the same as those in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure that your _Space Game_ project is loaded in Visual Studio Code and available on GitHub.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process that uses Azure DevOps.
