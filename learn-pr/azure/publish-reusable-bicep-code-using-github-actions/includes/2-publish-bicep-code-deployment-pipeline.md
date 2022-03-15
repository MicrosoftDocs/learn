TODO intro paragraph

## Validate reusable code in a pipeline

<!-- What types of Bicep validation/testing makes sense within a pipeline? Mostly linting, although you might choose to deploy a module/template spec and run some preflight validation or integration tests in some situations. -->

As it was explained in one of the previous units, modules that are published to a Bicep registry are not meant for complete deployments. You would still want to ensure they are valid and well written, but some forms of tests and validations are not applicable here. For example, you wouldn't run a _What-If_ test on a module that is published to a registry.

> [!TIP]
> We recommend you to review the [Test your Bicep code by using GitHub Actions](/learn/modules/test-bicep-code-using-github-actions/) Learn module for more information on how to test your Bicep templates in an automated pipeline.

You should choose, what jobs and steps you want to include to a workflow that will publish modules to the Registry.

## Authentication and authorization

Before you or any other team or individual you authorize to access the registry can access it, you need to enable access to the registry by [TBA].

<!--
TODO: Explain granting access to the ACR instance for "users" vs. Service Principals.
TODO: Include a good diagram explaining it (showing transparently both GitHub and Azure components and the workflow)
-->

## Publish template specs

The CLI commands to publish, and how these can be embedded into a pipeline.

## Publish modules

The CLI commands to publish, and how these can be embedded into a pipeline.
