**Azure Policy** is an Azure service that you can create, assign, and manage policies.

Policies enforce different rules and effects over your Azure resources, ensuring that your resources stay compliant with your standards and SLAs.

:::image type="content" source="../media/azure-policy-icon-8655ffca.png" alt-text="Screenshot of Azure Policy icon.":::


Azure Policy uses policies and initiatives to provide policy enforcement capabilities.

Azure Policy evaluates your resources by scanning for resources that don't follow the policies you create.

For example, you might have a policy that specifies a maximum size limit for VMs in your environment.

After you implement your maximum VM size policy, Azure Policy will evaluate the VM resource whenever a VM is created—or updated to ensure that the VM follows the size limit you set in your Policy.

Azure Policy can help maintain the state of your resources by evaluating your existing resources and configurations and automatically remediating non-compliant resources.

It has built-in policy and initiative definitions for you to use. The definitions are arranged into categories: Storage, Networking, Compute, Security Center, and Monitoring.

Azure Policy can also integrate with Azure DevOps by applying any continuous integration (CI) and continuous delivery (CD) pipeline policies that apply to the pre-deployment and post-deployment of your applications.

## CI/CD pipeline integration

The Check Gate task is an example of an Azure policy that you can integrate with your DevOps CI/CD pipeline.

Using Azure policies, Check gate provides security and compliance assessment on the resources with an Azure resource group or subscription that you can specify.

Check gate is available as a Release pipeline deployment task.

For more information, go to:

 -  [Azure Policy Check Gate task](/azure/devops/pipelines/tasks/deploy/azure-policy-check-gate).
 -  [Azure Policy](https://azure.microsoft.com/services/azure-policy/).
