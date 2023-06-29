
A release pipeline takes artifacts and releases them through stages and finally into production.

:::image type="content" source="../media/pipeline-7793ffc6.png" alt-text="Screenshot of a release pipeline with dev, QA and production stages.":::


Let us quickly walk through all the components step by step.

The first component in a release pipeline is an artifact:

 -  Artifacts can come from different sources.
 -  The most common source is a package from a build pipeline.
 -  Another commonly seen artifact source is, for example, source control.

Furthermore, a release pipeline has a trigger: the mechanism that starts a new release.

A trigger can be:

 -  A manual trigger, where people start to release by hand.
 -  A scheduled trigger, where a release is triggered based on a specific time.
 -  A continuous deployment trigger, where another event triggers a release. For example, a completed build.

Another vital component of a release pipeline is stages or sometimes called environments. It's where the artifact will be eventually installed. For example, the artifact contains the compiled website installed on the webserver or somewhere in the cloud. You can have many stages (environments); part of the release strategy is finding the appropriate combination of stages.

Another component of a release pipeline is approval.

People often want to sign a release before installing it in the environment.

In more mature organizations, this manual approval process can be replaced by an automatic process that checks the quality before the components move on to the next stage.

Finally, we have the tasks within the various stages. The tasks are the steps that need to be executed to install, configure, and validate the installed artifact.

In this part of the module, we'll detail all the release pipeline components and talk about what to consider for each element.

The components that make up the release pipeline or process are used to create a release. There's a difference between a release and the release pipeline or process. The release pipeline is the blueprint through which releases are done. We'll cover more of it when discussing the quality of releases and releases processes.

See also [Release pipelines](/azure/devops/pipelines/release).
