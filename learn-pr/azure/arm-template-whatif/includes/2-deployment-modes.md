Azure Resource Manager supports two different *deployment modes* - incremental and complete.

## Incremental mode

The default deployment mode is incremental. In this mode, Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are *added* to the resource group.

## Complete mode

You have to explicitly ask for your deployment to run in complete mode. When you use this mode, resources not specified in the template are *deleted*. Not all resources in your resource group will be deleted by complete mode. [Some resource types are exempt.](/azure/azure-resource-manager/templates/complete-mode-deletion)

> [!CAUTION]
> When you run the command in complete mode, whatever resources you have will be removed if they're not defined in the template file.

::: zone pivot="bicepcli,biceppowershell"

In Bicep, you can refer to an existing resource using the `existing` keyword. Referring to a resource in this way won't stop it from being deleted during a complete mode deployment. You need to define it as a fully fledged resource.

::: zone-end

### When should I use complete mode?

It might seem like a strange idea to allow Azure to delete your resources like this. However, there's a good reason why you might want to consider it. If all of your infrastructure is defined in templates, then using complete mode means that every time you deploy, you'll make sure there are no errant resources left afterwards. In other words, it helps to avoid *configuration drift* in your environment.

If you know for sure that what's in the template file constitutes the full state of your deployment, then go ahead and use this mode. If you use tools like the Azure CLI or PowerShell to update your state gradually, then incremental mode is the way to go.

## Deployment scopes

Complete mode is available when you deploy to a resource group. If you use templates to deploy resources to a subscription, management group, or a tenant, you won't be able to use complete mode.
