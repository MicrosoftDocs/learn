One of the essential steps in moving software more quickly to production is changing how we deliver software to production.

It's common to have teams that need to do overtime on the weekend to install and release new software in our industry.

It's caused by the fact that we have two parts of the release process bolted together. As soon as we deploy new software, we also release new features to the end users.

The best way to safely move your software to production while maintaining stability is by separating these two concerns. So, we separate deployments from our release.

It can also be phrased as separating your functional release from your technical release (deployment).

## What is a release, and what is a deployment?

When we talk about releases and deployments, we see that commonly used tools deal differently with the terminology as we did in the previous chapter.

To understand the concepts and the technical implementation in many tools, you need to know how tool vendors define the difference between a release and a deployment.

A release is a package or container containing a versioned set of artifacts specified in a release pipeline in your CI/CD process.

It includes a snapshot of all the information required to carry out all the tasks and actions in the release pipeline, such as:

 -  The stages or environments.
 -  The tasks for each one.
 -  The values of task parameters and variables.
 -  The release policies such as triggers, approvers, and release queuing options.

There can be multiple releases from one release pipeline (or release process).

Deployment is the action of running the tasks for one stage, which results in a tested and deployed application and other activities specified for that stage.

Starting a release starts each deployment based on the settings and policies defined in the original release pipeline.

There can be multiple deployments of each release, even for one stage.

When a release deployment fails for a stage, you can redeploy the same release to that stage.

See also [Releases in Azure Pipelines](/azure/devops/pipelines/release/releases).

## Separating technical releases from functional releases

When we want to separate the technical and functional release, we need to start with our software itself.

The software needs to be built so that new functionality or features can be hidden from end users while it's running.

A common way to do this is the use of Feature Toggles. The simplest form of a Feature Toggle is an if statement that either executes or doesn't execute a certain piece of code.

By making the if-statement configurable, you can implement the Feature Toggle. We'll talk about Feature Toggles in Module 3 in more detail.

See also: [Explore how to progressively expose your features in production for some or all users](/azure/devops/articles/phase-features-with-feature-flags).

Once we've prepared our software, we must ensure that the installation won't expose any new or changed functionality to the end user.

When the software has been deployed, we need to watch how the system behaves. Does it act the same as it did in the past?

If the system is stable and operates the same as before, we can decide to flip a switch. It might reveal one or more features to the end user or change a set of routines part of the system.

The whole idea of separating deployment from release (exposing features with a switch) is compelling and something we want to incorporate in our Continuous Delivery practice.

It helps us with more stable releases and better ways to roll back when we run into issues when we have a new feature that produces problems.

We switch it off again and then create a hotfix. By separating deployment from the release of a feature, you make the opportunity to deploy any time of the day since the new software won't affect the system that already works.

### Topics you might want to discuss are:<br>

 -  Does your organization need Continuous Delivery?
 -  Do you use Agile/Scrum?
    
     -  Is everybody involved or only the Dev departments?
 -  Can you deploy your application multiple times per day? Why or why not?
 -  What is the main bottleneck for Continuous Delivery in your organization?
    
     -  The Organization
     -  Application Architecture
     -  Skills
     -  Tooling
     -  Tests
     -  Other things?
