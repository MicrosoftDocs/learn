## What is Azure Blueprints?

Azure Blueprints is a service that will enable you to define a repeatable set of Azure resources to implement your organization standards, patterns, and requirements. You will use Azure Blueprints in a declarative way to build and deploy new environments with a set of built-in components.

You should think in the Azure Blueprints like a package, which you will use deploy and deliver governance as code, since the blueprints are JSON files. A blueprint is composed by the following artifacts: 

* Role Assignments
* Policy Assignments
* Azure Resource Manager Templates
* Resource Groups

Those artifacts are embedded into the package, which can then be composed, versioned, and assigned to a management group containing multiple subscriptions, or directly to one subscription. 

Since assigned, the package will start the deployment of roles, policies, templates, or resource groups against the management group or the subscription chosen.

Another interesting feature from Azure Blueprints, is that besides of the ability to start from scratch with your own blueprint, you can start from some of the samples provided by Microsoft:

:::image type="content" source="../media/2-samples.png" alt-text="Samples of built-in Blueprints from Microsoft.":::

Let's suppose that you received a request to create the environment for a new project, which should be PCI-DSS compliant. In order to accomplish it, you should be aware about several rules and requirements from PCI. What if you could use something that can ensure some minimal requirements on it?

So this is a scenario where you can benefit from some built-in samples from Azure Blueprints. They can help you to cover some minimal requirements from diverse industry standards as well some Microsoft best practices like the Cloud Adoption Framework, or even some suggested common policies.