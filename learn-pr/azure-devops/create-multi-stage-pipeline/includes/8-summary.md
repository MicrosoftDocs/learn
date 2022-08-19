Nice job! Your pipeline is taking shape. You and the Tailspin team have moved from a basic proof of concept to a realistic release pipeline. You can use this pipeline to build an artifact and test it before you give it to your users.

In this module, you learned ways to control how changes move from one stage of a pipeline to the next. Let's review the pipeline you built in this module. This image shows your pipeline's overall shape:

:::image type="content" source="../media/2-add-staging-stage-approval.png" alt-text="Screenshot of a whiteboard showing the final pipeline, which includes the Build, Dev, Test, and Staging stages.":::

The _Dev_, _Test_, and _Staging_ stages each deploy the build artifact to their own Azure App Service environment.

* When a change is pushed to GitHub, a _trigger_ causes the _Build_ stage to run. The _Build_ stage produces a build artifact as its output.
* The _Dev_ stage runs only when the change happens in the _release_ branch. You use a _condition_ to specify this requirement.
* The _Test_ stage runs at 3 A.M. each morning. This stage runs only when the _release_ branch contains changes since the last run. You use a _scheduled trigger_ to specify when the _Test_ stage runs.
* The _Staging_ stage runs only after you approve the changes in the _Test_ stage. You add a _release approval_ to the **staging** environment to pause the pipeline until you approve or reject the change.

This pipeline satisfies the requirements of the Tailspin team. Your pipeline's shape and how changes flow through it depend on the needs of your team, and of the apps and services that you build.

Although the team is improving their release cadence, there's room for more improvement. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team to automate additional testing so that changes can move through the pipeline even faster.

## Learn more

In this module, you worked with conditions, triggers, and approvals. To learn more, explore these resources.

* [Conditions](/azure/devops/pipelines/process/conditions?azure-portal=true&tabs=yaml)
* [Build pipeline triggers](/azure/devops/pipelines/build/triggers?azure-portal=true&tabs=yaml)
* [Approvals and other checks](/azure/devops/pipelines/process/approvals?azure-portal=true)
