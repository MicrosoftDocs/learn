Throughout the lifecycle of a scale set, you might need to deploy an updated version of your application. With the Custom Script Extension, you can reference an updated deployment script and then reapply the extension to your scale set.

When you created the scale set in the preceding unit, you set `--upgrade-policy-mode` to *automatic*. This allows VM instances in the scale set to automatically update and apply the latest version of your application. When an updated Custom Script Extension definition is applied to the scale set, all VM instances are automatically updated to the latest definition. The latest application files are downloaded from GitHub, and the updated app then runs on each VM instance.

In this unit, we'll look at a simple example where the Custom Script Extension is manually applied to the virtual machine scale set. In practice, you can integrate code commits in GitHub with a trigger that applies an updated Custom Script Extension definition to a scale set. With this approach, the application development, testing, and deployment follow DevOps best practices.

DevOps is the union of people, process, and products to enable continuous delivery of value to users. The contraction of "Dev" and "Ops" refers to replacing siloed *Development* and *Operations* to create multidisciplinary teams that now work together with shared and efficient practices and tools. Essential DevOps practices include continuous integration and continuous delivery (CI/CD).

![Overview of DevOps lifecycle](../../media/deploy-custom-vmss-app/devops-overview.png)

At the end of the tutorial, you can check your knowledge about this information with a quiz challenge.
