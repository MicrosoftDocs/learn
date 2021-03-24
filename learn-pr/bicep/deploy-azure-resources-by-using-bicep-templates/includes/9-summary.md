Our toy company needs to launch new products regularly to stay competitive. The shorter the time to market, the better. You've been able to create a template that will deploy a website and storage resources. This template is reusable for future product launches.

You created a Bicep template to deploy a basic storage account, an App Service plan, and an application. You parameterized the template to make it generalizable for future products. You then refactored it into modules to make the template more reusable, as well as easier to understand and work with. Finally, you added an output, to send information from our template deployment back to the person or tool that is executing the deployment.

Imagine how much work it would be to deploy these resources for each new product launch. We'd have to manually provision the resources and remember to configure them correctly.

Bicep makes it easy to describe our Azure resources and create reusable templates. We can parameterize the templates, and use modules to separate our templates into different components that we can reuse and work on individually. Now, when we want to prepare our resources for our next product launch, we can use the Bicep template we created with parameter values that are unique to that product launch, letting us quickly and easily provision our Azure resources.
