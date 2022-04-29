Business demands continuous delivery of value. Value is created only when a product is delivered to a satisfied customer.

It's not created when one silo in the process is completed.

It demands that you reset focus from silos to an end-to-end flow of value.

The core idea is to create a repeatable, reliable, and incrementally-improving process for taking software from concept to customer.

The goal is to enable a constant flow of changes into production via an automated software production line.

Think of it as a pipeline. The pipeline breaks down the software delivery process into stages.

Each stage aims to verify the quality of new features from a different angle to validate the new functionality and prevent errors from affecting your users.

The pipeline should provide feedback to the team. Also, visibility into the changes flows to everyone involved in delivering the new feature(s).

A delivery pipeline enables the flow of more minor changes more frequently, with a focus on flow.

Your teams can concentrate on optimizing the delivery of changes that bring quantifiable value to the business.

This approach leads teams to continuously monitor and learn where they're finding obstacles, resolve those issues, and gradually improve the pipeline's flow.

As the process continues, the feedback loop provides new insights into new issues and barriers to be resolved.

The pipeline is the focus of your continuous improvement loop.

A typical pipeline will include the following stages: build automation and continuous integration, test automation, and deployment automation.

## Build automation and continuous integration

The pipeline starts by building the binaries to create the deliverables passed to the following stages. New features implemented by the developers are integrated into the central code base, built, and unit tested. It's the most direct feedback cycle that informs the development team about the health of their application code.

## Test automation

The new version of an application is rigorously tested throughout this stage to ensure that it meets all wished system qualities. It's crucial that all relevant aspects—whether functionality, security, performance, or compliance—are verified by the pipeline. The stage may involve different types of automated or (initially, at least) manual activities.

## Deployment automation

A deployment is required every time the application is installed in an environment for testing, but the most critical moment for deployment automation is rollout time.

Since the preceding stages have verified the overall quality of the system, It's a low-risk step.

The deployment can be staged, with the new version being initially released to a subset of the production environment and monitored before being rolled out.

The deployment is automated, allowing for the reliable delivery of new functionality to users within minutes if needed.

## Your pipeline needs platform provisioning and configuration management

The deployment pipeline is supported by platform provisioning and system configuration management. It allows teams to create, maintain, and tear down complete environments automatically or at the push of a button.

Automated platform provisioning ensures that your candidate applications are deployed to, and tests carried out against correctly configured and reproducible environments.

It also helps horizontal scalability and allows the business to try out new products in a sandbox environment at any time.

## Orchestrating it all: release and pipeline orchestration

The multiple stages in a deployment pipeline involve different groups of people collaborating and supervising the release of the new version of your application.

Release and pipeline orchestration provide a top-level view of the entire pipeline, allowing you to define and control the stages and gain insight into the overall software delivery process.

By carrying out value stream mappings on your releases, you can highlight any remaining inefficiencies and hot spots and pinpoint opportunities to improve your pipeline.

These automated pipelines need infrastructure to run on. The efficiency of this infrastructure will have a direct impact on the effectiveness of the pipeline.
