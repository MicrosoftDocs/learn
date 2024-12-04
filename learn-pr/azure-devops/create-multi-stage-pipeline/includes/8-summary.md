Nice job! Your pipeline is taking shape. You and the Tailspin team moved from a basic proof of concept to a realistic release pipeline. You can use this pipeline to build an artifact and test it before you give it to your users.

In this module, you learned ways to control how changes move from one stage of a pipeline to the next. Let's review the pipeline you built in this module. This image shows your pipeline's overall shape:

:::image type="content" source="../media/2-add-staging-stage-approval.png" alt-text="Diagram where the whiteboard shows the final pipeline, which includes the Build, Dev, Test, and Staging stages.":::

The *Dev*, *Test*, and *Staging* stages each deploy the build artifact to their own Azure App Service environment.

- When a change is pushed to GitHub, a *trigger* causes the *Build* stage to run. The *Build* stage produces a build artifact as its output.
- The *Dev* stage runs only when the change happens in the *release* branch. You use a *condition* to specify this requirement.
- The *Test* stage runs at 3 A.M. each morning. This stage runs only when the *release* branch contains changes since the last run. You use a *scheduled trigger* to specify when the *Test* stage runs.
- The *Staging* stage runs only after you approve the changes in the *Test* stage. You add a *release approval* to the **staging** environment to pause the pipeline until you approve or reject the change.

This pipeline satisfies the requirements of the Tailspin team. Your pipeline's shape and how changes flow through it depend on the needs of your team, and of the apps and services that you build.

Although the team is improving their release cadence, there's room for more improvement. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team to automate more testing so that changes can move through the pipeline even faster.

## Learn more

In this module, you worked with conditions, triggers, and approvals. To learn more, explore these resources.

* [Conditions](/azure/devops/pipelines/process/conditions?azure-portal=true&tabs=yaml)
* [Build pipeline triggers](/azure/devops/pipelines/build/triggers?azure-portal=true&tabs=yaml)
* [Approvals and other checks](/azure/devops/pipelines/process/approvals?azure-portal=true)
