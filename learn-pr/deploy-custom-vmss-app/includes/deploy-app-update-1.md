Throughout the lifecycle of a scale set, you may need to deploy an updated version of your application. With the Custom Script Extension, you can reference an updated deploy script and then reapply the extension to your scale set.

When the scale set was created in a previous module, the `--upgrade-policy-mode` was set to *automatic*. This setting allows the VM instances in the scale set to automatically update and apply the latest version of your application. When an updated Custom Script Extension defintion is applied to the scale set, all VM instances are automatically updated to the latest definition. The latest application files are downloaded from GitHub and the updated app then runs on each VM instance.

This module shows a simple example where the Custom Script Extension is manually applied to the virtual machine scale set. In practice, you could integrate code commits in GitHub with a trigger that applies an updated Custom Script Extension definition to a scale set. With this approach, the application development, testing, and deployment follows DevOps best practices.

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users. The contraction of "Dev" and "Ops" refers to replacing siloed *Development* and *Operations* to create multidisciplinary teams that now work together with shared and efficient practices and tools. Essential DevOps practices include continuous integration and continuous delivery (CI/CD).

![Overview of DevOps lifecycle](media/devops-overview.png)