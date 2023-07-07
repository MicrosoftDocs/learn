
When choosing the right Release Management tool, you should look at the possibilities of all the different components and map them to your needs.

Many tools are available in the marketplace, which we'll discuss in the next chapter. The most important thing to notice is that not every vendor or tool treats Release Management similarly.

The tools in the marketplace can be divided into two categories.

 -  Tools that can do Build and Continuous Integration and Deployment.
 -  Tools that can do Release Management.

In many cases, companies only require the deployment part of Release Management.

Many build or release tools can perform deployment or installation. Primarily because the technical aspect of the release is executing a script or running a program, Release Management, which requires approvals, quality gates, and different stages, needs a different kind of tool that tightly integrates with the build, and CI tools aren't the same.

## Artifacts and artifact source

Artifacts can come from different sources. Treating your artifact as a versioned package needs to be stored somewhere before your release pipeline consumes it. Considerations for choosing your tool can be:

 -  Which Source Control systems are supported?
 -  Can you have one or more artifact sources in your release pipeline? In other words, can you combine artifacts from different sources into one release?
 -  Does it integrate with your build server?
 -  Does it support other build servers?
 -  Does it support container registries?
 -  How do you secure the connection to the artifact source?
 -  Can you extend the artifact sources?

## Triggers and schedules

Triggers are an essential component in the pipeline. Triggers are required to start a release, but if you want multiple stages, create a deployment. Considerations for choosing your trigger can be:

 -  Does your system support Continuous Deployment triggers?
 -  Can you trigger releases from an API (for integration with other tools)?
 -  Can you schedule releases?
 -  Can you schedule and trigger each stage separately?

## Approvals and gates

Starting a release using scripts, executables, or deployable artifacts doesn't differentiate between a Continuous Integration/Build tool and a Release Management tool. Adding a release approval workflow to the pipeline is the critical component that does make the difference. Considerations When it comes to approvals:

 -  Do you need approvals for your release pipeline?
 -  Is the approvers part of your company? Do they need a tool license?
 -  Do you want to use manual or automatic approvals? Or both?
 -  Can you approve an API (integration with other tools)
 -  Can you set up a workflow with approvers (optional and required)?
 -  Can you have different approvers per stage?
 -  Can you've more than one approver? Do you need them all to approve?
 -  What are the possibilities for automatic approval?
 -  Can you have a manual approval or step in your release pipeline?

## Stages

Running a Continuous Integration pipeline that builds and deploys your product is a commonly used scenario. But what if you want to deploy the same release to different environments? When choosing the right release management tool, you should consider the following things when it comes to stages (or environments)

 -  Can you use the same artifact to deploy to different stages?
 -  Can you differ the configuration between the stages?
 -  Can you have different steps for each stage?
 -  Can you follow the release between the stages?
 -  Can you track the artifacts/work items and source code between the stages?

## Build and release tasks.

Finally, the work needs to be done within the pipeline. It isn't only about the workflow and orchestration; the code must also be deployed or installed. Things to consider when it comes to the execution of tasks.

 -  How do you create your steps? Is it running a script (bat, shell, PowerShell CLI), or are there specialized tasks?
 -  Can you create your tasks?
 -  How do tasks authenticate to secure sources?
 -  Can tasks run on multiple platforms?
 -  Can tasks be easily reused?
 -  Can you integrate with multiple environments? (Linux, Windows, Container Clusters, PaaS, Cloud)
 -  Can you control the tasks that are used in the pipeline?

:::image type="content" source="../media/azure-devops-marketplace-adc9761f.png" alt-text="Screenshot of the Azure DevOps marketplace.":::


## Traceability, auditability, and security

One of the essential things in enterprises and companies that need to adhere to compliance frameworks is:

 -  Traceability.
 -  Auditability.
 -  Security.

Although it isn't explicitly related to a release pipeline, it's essential.

When it comes to compliance, three principles are fundamental:

 -  four-eyes principle
     -  Does at least one other person review the deployed artifact?
     -  Is the person that deploys another person the one that writes the code?
 -  Traceability
     -  Can we see where the released software originates from (which code)?
     -  Can we see the requirements that led to this change?
     -  Can we follow the requirements through the code, build, and release?
 -  Auditability
     -  Can we see who, when, and why the release process changed?
     -  Can we see who, when, and why a new release has been deployed?

Security is vital in it. It isn't ok when people can do everything, including deleting evidence. Setting up the right roles, permissions, and authorization is essential to protect your system and pipeline.

When looking at an appropriate Release Management tool, you can consider the following:

 -  Does it integrate with your company's Active Directory?
 -  Can you set up roles and permissions?
 -  Is there a change history of the release pipeline itself?
 -  Can you ensure the artifact didn't change during the release?
 -  Can you link the requirements to the release?
 -  Can you link source code changes to the release pipeline?
 -  Can you enforce approval or the four-eyes principle?
 -  Can you see the release history and the people who triggered the release?
