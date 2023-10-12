When you automate the publishing process for a template spec or a Bicep module, you need to ensure that everything you'd normally do on your own can be automated and run within the workflow. In this unit, you'll learn how to apply some of the principles you've previously learned when you publish template specs and Bicep modules from a deployment workflow.

## Template specs and modules

Bicep enables you to easily reuse your code. Two common approaches for reusing your Bicep code across deployments are:

- **Template specs**, which are optimized for the deployment of complete solutions. For example, suppose you've defined a set of security-hardened resources to deploy a complete virtual machine according to your company's specifications. You could publish this code as a template spec. Your colleagues could then use your template spec to deploy a complete virtual machine, even from the Azure portal.
- **Modules**, which are designed to be components of other deployments. For example, suppose you've created a Bicep file that creates a storage account. You're likely to need storage accounts in many other deployments, so you could publish the Bicep file to a registry and use it as a module throughout your organization's deployments.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as is throughout your organization, template specs are probably a good fit. But if you're likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better.

## Validate reusable code in a workflow

Unlike regular Bicep deployments, when you create a template spec or a module, you don't deploy the resources directly to Azure. Instead, you _publish_ the template spec or module. Then you can use the template spec or module in another deployment. That deployment will deploy the resources you've defined. Because of this difference, the ways that you validate and test your template specs and Bicep modules might be different from the process that you use for regular Bicep deployments.

Linting your Bicep code is good practice. The linter detects syntactical problems, and it warns you if you're not following the recommended practices.

Beyond linting, you might want to consider testing your template specs and modules by using _preflight validation_. You might even consider deploying your template specs and modules to Azure and testing that the resources they create behave as you expect. However, it can be challenging to run these types of tests from a deployment workflow for two reasons:

- Preflight validation and deployments require an Azure environment to deploy the resources to. You might need to maintain a dedicated Azure subscription or resource group to use for deploying and testing your modules.
- Many template specs and modules require you to specify a set of parameters. You might need to create a test set of parameters for your template specs or modules to use when they're deployed.

You should choose whether to include workflow steps that deploy and test your template specs and modules. In this Microsoft Learn training module, we lint the Bicep code but don't include other forms of testing. If you want to test your template specs and modules, consider how you'll deploy them to Azure. Also consider whether you'll use dedicated subscriptions or resource groups to deploy the resources.

> [!TIP]
> We recommend that you review [Test your Bicep code by using GitHub Actions](xref:learn.azure.test-bicep-code-using-github-actions) for more information on how to test your Bicep files in an automated workflow.

## Authentication and authorization

When you publish template specs to Azure yourself, your Microsoft Entra user needs to be granted access to the resource group that contains the template spec resource. Likewise, when you publish a Bicep module to a registry, your Microsoft Entra user needs to have permission to write to the Azure Container Registry instance that your organization uses for its Bicep modules.

When you work with an automated deployment workflow, the same principles apply. However, because you aren't the person running the deployment, you need to ensure that your workflow's identity is given the appropriate access to the resource group for publishing the template spec, or to the container registry for publishing modules.

> [!TIP]
> When you publish a module to a registry, the workload identity running the deployment probably doesn't need a lot of permission. When your registry uses Microsoft Entra authorization, the workload identity needs only the _AcrPush_ permission on the registry.
>
> Consider using the security _principle of least privilege_. Provide the workflow's identity with access only to the container registry, and not to a resource group or subscription.

## Publish template specs and modules from a workflow

When you publish a template spec from your own computer by using the Azure CLI, you use a command like the following:

```azurecli
az ts create \
  --name StorageWithoutSAS \
  --location westus3 \
  --display-name "Storage account with SAS disabled" \
  --description "This template spec creates a storage account, which is preconfigured to disable SAS authentication." \
  --version 1 \
  --template-file main.bicep
```

You can convert this Azure CLI command to a GitHub Actions step:

```yaml
- name: Publish template spec
  uses: azure/cli@v1
  with:
    inlineScript: |
      az ts create \
        --name StorageWithoutSAS \
        --location westus3 \
        --display-name "Storage account with SAS disabled" \
        --description "This template spec creates a storage account, which is preconfigured to disable SAS authentication." \
        --version 1 \
        --template-file main.bicep
```

The workflow uses the same process to publish the template spec that you would use yourself.

Similarly, when you publish a Bicep module from your own computer by using the Azure CLI, you use a command like the following:

```azurecli
az bicep publish \
   --file module.bicep \
   --target 'br:toycompany.azurecr.io/mymodules/myqueue:2'
```

You can convert this Azure CLI command to a GitHub Actions step, too:

```yaml
- name: Publish Bicep module
  uses: azure/cli@v1
  with:
    inlineScript: |
      az bicep publish \
        --file module.bicep \
        --target 'br:toycompany.azurecr.io/mymodules/myqueue:2'
```

> [!TIP]
> In this example, the Bicep registry's host name (`toycompany.azurecr.io`) is embedded in the workflow step definition. This isn't a good practice. You can use environment variables to set configuration settings like this. You'll see how this works later in this Microsoft Learn training module.

Shortly, you'll see how you can publish a template spec from a workflow by using the steps described in this unit.

## Use a module or template spec

In previous Microsoft Learn training modules, you learned how to deploy the resources defined in template specs, and how to use Bicep modules stored in registries. Whether you publish your template specs and modules manually or from a deployment workflow, you use and deploy them in the same way.

For example, you deploy a template spec or Bicep file to a resource group by using the `az deployment group create` Azure CLI command, or the `New-AzResourceGroupDeployment` cmdlet with Azure PowerShell.
