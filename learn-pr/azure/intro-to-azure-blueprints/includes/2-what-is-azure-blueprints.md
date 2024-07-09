Azure Blueprints is a service that lets you define a repeatable set of Azure resources to implement your organization standards, patterns, and requirements. You can use Azure Blueprints in a declarative way to build and deploy new environments with a set of built-in components.

You should think about Azure Blueprints as a package that you can use to deploy and deliver governance as code. Blueprints are JSON files, and are composed of the following artifacts: 

* Role assignments
* Policy assignments
* Azure Resource Manager templates
* Resource groups

These artifacts are embedded into the package, which can then be composed, versioned, and assigned to a management group containing multiple subscriptions, or assigned directly to a single subscription.

Once assigned, the package starts the deployment of roles, policies, templates, or resource groups against the management group or the subscription chosen.

Another interesting feature of Azure Blueprints, aside from the ability to start from scratch with your own blueprint, is that you can customize the samples provided by Microsoft.

:::image type="content" source="../media/2-samples.png" alt-text="Screenshot of built-in Azure Blueprints samples from Microsoft.":::

Suppose you receive a request to create the environment for a new project. The project should be compliant with the Payment Card Industry Data Security Standard (PCI-DSS). Prior to beginning the configuration, you should be aware of several rules and requirements from PCI. What if you could use something that ensures a minimal requirements set for the standard?

This is a scenario where you can benefit from the built-in samples provided with Azure Blueprints. The samples can help you to cover minimal requirements from diverse industry standards, as well some Microsoft best practices like the Cloud Adoption Framework, or even some suggested common policies.
