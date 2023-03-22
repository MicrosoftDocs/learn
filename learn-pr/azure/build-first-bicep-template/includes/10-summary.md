Your company needs to launch new toys regularly to stay competitive. The shorter the time to market, the better.

You've created a template that deploys a website and storage resources. This template is reusable for future product launches, which means you've significantly cut the time it takes to launch a new product.

You created a Bicep template to deploy a basic storage account, an Azure App Service plan, and an application. You parameterized the template to make it useful for future products. You then refactored it into modules to make the template more reusable, and easier to understand and work with. Finally, you added an output to send information from a template deployment back to the person or tool executing the deployment.

Imagine how much work it would be to deploy these resources for each new product launch. You'd have to manually provision the resources and remember to configure them correctly each time.

Bicep makes it easy to describe your Azure resources and create reusable templates. You can parameterize the templates and use modules to separate your templates into different components that you can reuse and work on individually.

Now, when you want to prepare your resources for the next product launch, you can use the Bicep template you created with parameter values unique to the product launch. Your company can quickly and easily provision its Azure resources.

> [!TIP]
> In this module, you've only scratched the surface of Bicep's capabilities. Keep following the [Fundamentals of Bicep learning path](xref:learn.bicep-deploy-manage), and our other Bicep learning paths, to progress your understanding.

## References

- [Bicep documentation](/azure/azure-resource-manager/bicep)
- [Template reference for each Azure resource type](/azure/templates/)
- [Bicep functions](/azure/azure-resource-manager/bicep/bicep-functions)
