Great work! You covered a lot of ground in this module. You learned how to map script commands on a build server to automated pipeline tasks that run when you push code to GitHub. The result of the pipeline was a .zip file that contains the built _Space Game_ web application. You were able to watch the build progress on the Azure Devops web site.

You also learned how to use templates to deploy an application to a pre-production environment, such as your QA lab, or a full production environment that your users can access.

Finally, you practiced your Git skills by pushing commits to a branch and building from that branch. Working from a branch enables you to work in isolation from the main code base. That helps you experiment and try new things without affecting the main development branch, `master`.

<!-- TODO: If we decide not to merge `build-pipeline` into `master`, call out that's what you would do and that you'll learn more in the next module. -->

Keep in mind that this build configuration focuses on building a .NET Core application. The tasks you choose will depend on the kind of application you're building, the tools you use to build it, and the programming languages it's written in.

When approaching your own builds, a good way to start is to ensure that you can build the application from scratch from the terminal or from a Bash or PowerShell script. From there, you can map each command to a pipeline task that accomplishes the same thing.

> [!NOTE]
> At this point, you have a build artifact that you could deploy to a quality or production environment. For the rest of this learning path, you'll focus on using Azure Pipelines to build and test your software. You'll learn how to use Azure Pipelines to deploy your applications in a future learning path.

## Additional resources

### Learn YAML

If you're interested in learning YAML, check out [Learn YAML in Y minutes](https://learnxinyminutes.com/docs/yaml?azure-portal=true). You can then review the Azure Pipelines [YAML schema reference](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema&azure-portal=true) to get a greater sense of how pipelines are structured.

### Explore the documentation

We provide complete [reference documentation](https://docs.microsoft.com/azure/devops/pipelines/?view=azure-devops&azure-portal=true) that goes deeper into the concepts and tasks we discussed here. The documentation also provides starter guides for many application types, such as Java, C++, and Node.js.

The [Build and release tasks](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops&azure-portal=true) section can help you map your existing build commands to built-in tasks.

### Create your own build pipeline

In this module, you created the pipeline from Azure DevOps. You can repeat a similar process to create your own pipeline. You can also create a pipeline from the Azure portal or from the GitHub Marketplace application.

* [Use the Azure portal](https://docs.microsoft.com/azure/devops/pipelines/get-started-azure-devops-project?view=azure-devops&azure-portal=true)
* [Azure Pipelines](https://github.com/marketplace/azure-pipelines?azure-portal=true) application on GitHub Marketplace