Tailwind Traders wants to operationalize their cloud deployments. They need a repeatable and reliable way to scale their operations during peak sales dates.  Since we'll be using this when we need to scale our production environment, we need to ensure that it's efficient and can potentially create many resources in parallel, that it creates all dependencies in the correct order, and can do so without worrying that it failed in the middle of provisioning the necessary infrastructure.  Which tool can we use?

## Which service should we choose?

Let's run through our decision criteria one more time.

First, in this scenario, does Tailwind Traders need to perform one-off management / administrative / reporting actions? This time, we're not looking for one-time or one-off management or administration tasks. In other words, we're looking for a technology we can use to automate the deployment of our entire infrastructure as needed.

Second, does Tailwind Traders need a repeatable and reliable means of deploying their entire infrastructure?  Yes, this is exactly what we need.  Our decision criteria leads us to choose Azure ARM Templates for this scenario.

We could possibly use Azure PowerShell or the Azure CLI, however these scripting technologies have significant limitations when it comes to deploying your infrastructure. ARM Templates overcome these limitations.

The third decision criteria assumes we need to write a script using imperative code.  However, using ARM Templates, you define your infrastructure declaratively using JSON.  However, in some instances, you still may need imperative code for configuration or clean-up tasks.  In these cases, you can trigger the execution of scripts, either Azure PowerShell or Azure CLI, to perfom these tasks.

In this scenario, Azure ARM Templates is the correct choice.