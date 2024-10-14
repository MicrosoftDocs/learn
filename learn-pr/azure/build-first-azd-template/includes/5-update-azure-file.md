Your template includes the source code for your app and defines Bicep files to create the corresponding infrastructure. However, your template still needs to describe the relationship between the app source code and the Azure resources. You can use the `azure.yaml` file to describe one or more app services in your code base and how they should be deployed to the provisioned Azure resources.

1. At the root of your project, locate and open the `azure.yaml` file. The file contains various code comments that provide helpful guidance and examples of how to define services. Service definitions map a folder in your source code to a resource in Azure using a standardize YAML structure.

1. Copy and paste the following definition at the bottom of the `azure.yaml` file:

    ```yml
    services:
        web:
            language: csharp
            project: ./src/web
            host: appservice
    ```

    Each line of code in this example schema describes a different aspect of the services in your app:

    * **services** - Every `azure.yaml` file defines one top level `services` node that lists one or more services in your template.
    * **web** - A name of your choosing that maps to a service in your app code, such as `api` or `worker`. However, this name must match the value of the `azd-service-name` tag you assigned to the resource in your Bicep or Terraform code. For example, this service has a value of `web` because the App Service definition in the `app.bicep` file specified `tags: { 'azd-service-name': 'web' }`. This tag naming association is how `azd` understands which Azure resource the specified code directory should be deployed to.
    * **language** - A property that specifies the language of the code you want to deploy. `azd` currently supports language values of `csharp`, `python`, `javascript` and `java`.
    * **project** - A property that sets the path to where the code for the service is stored.
    * **host** - A property that defines what type of Azure service the app deploys to.

    > [!NOTE]
    > Again, make sure the name of your service (in this case: `web`) in `azure.yaml` matches the `azd-service-name` tag on the corresponding host resource defined in the Bicep file.

With the `azure.yaml` completed, all of the key structural components of your template are in place. In the next unit, you'll learn how to provision and deploy your template resources to Azure.
