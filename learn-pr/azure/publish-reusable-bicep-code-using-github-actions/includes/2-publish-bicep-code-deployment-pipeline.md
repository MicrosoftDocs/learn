TODO intro paragraph

## Validate reusable code in a pipeline

<!-- What types of Bicep validation/testing makes sense within a pipeline? Mostly linting, although you might choose to deploy a module/template spec and run some preflight validation or integration tests in some situations. -->

As it was explained in one of the previous units, modules that are published to a Bicep registry are not meant for complete deployments. You would still want to ensure they are valid and well written, but some forms of tests and validations are not applicable here. For example, you wouldn't run a _What-If_ test on a module that is published to a registry.

> [!TIP]
> We recommend you to review the [Test your Bicep code by using GitHub Actions](/learn/modules/test-bicep-code-using-github-actions/) Learn module for more information on how to test your Bicep templates in an automated pipeline.

You should choose, what jobs and steps you want to include to a workflow that will publish your template specs and modules. In this Microsoft Learn module, we lint the Bicep code but don't include other forms of testing. If you want to test your template specs and modules, consider how you'll deploy them to Azure, and whether you'll use dedicated subscriptions or resource groups to deploy the resources.

## Authentication and authorization

Before you or any other team or individual you authorize to access the registry can access it, you need to enable access to the registry by [TBA].

<!--
TODO: Explain granting access to the ACR instance for "users" vs. Service Principals.
TODO: Include a good diagram explaining it (showing transparently both GitHub and Azure components and the workflow)
-->

> [!TIP]
> When you publish a module to a registry, the permissions you need are narrower than in normal deployments. You could consider using the *principle of least privilege*, and provide the workflow's service principal with access just to the container registry, and not to a resource group or subscription.

## Publish template specs

The CLI commands to publish, and how these can be embedded into a pipeline.

## Publish modules

The CLI commands to publish, and how these can be embedded into a pipeline.
