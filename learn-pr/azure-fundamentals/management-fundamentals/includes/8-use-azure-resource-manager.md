Tailwind Traders wants to operationalize their cloud deployments. The company needs a repeatable, reliable way to scale its operations during peak sales periods.  Because you'll be choosing a process for scaling your production environment, you need to ensure that your chosen service:

- Is efficient and can potentially create many resources in parallel.
- Creates all dependencies in the correct order.
- Can be used without worrying that it failed in the middle of provisioning the necessary infrastructure.  

## Which service should you choose?

Let's run through the decision criteria one more time.

First, in this scenario, does Tailwind Traders need to perform one-off management, administrative, or reporting actions? This time, we're not looking to support one-time or one-off management or administration tasks. We're looking for a technology to automate the deployment of an entire infrastructure, as needed.

Second, does Tailwind Traders need a repeatable and reliable way to deploy its entire infrastructure?  Yes, this is exactly what the company needs.  Our decision criteria lead us to choose Azure Resource Manager templates (ARM templates) for this scenario.

You could use Azure PowerShell or the Azure CLI, but these scripting technologies have significant limitations when it comes to deploying infrastructure. ARM templates can help overcome these limitations.

The third decision criterion assumes that you need to write a script by using imperative code. However, when you use ARM templates, you define your infrastructure declaratively by using JSON code. In some instances, you still might need imperative code for configuration or clean-up tasks.  In these cases, you can trigger the execution of scripts by using either Azure PowerShell or the Azure CLI to perform these tasks.

In this scenario, ARM templates are the correct choice.
