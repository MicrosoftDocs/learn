> [!NOTE]
> A more robust configuration might specify the branches that participate in the build process. For example, to help verify code quality, you might run unit tests each time you push up a change on any branch. You might also deploy the application to an environment that performs more exhaustive testing. But you do this deployment only when you have a pull request, when you have a release candidate, or when you merge code to *main*.
> 
> For more information, see [Implement a code workflow in your build pipeline by using Git and GitHub](/training/modules/implement-code-workflow?azure-portal=true) and [Build pipeline triggers](/azure/devops/pipelines/build/triggers?azure-portal=true&tabs=yaml).
