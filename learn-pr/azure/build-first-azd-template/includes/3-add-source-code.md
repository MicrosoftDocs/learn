The Azure Developer CLI (`azd`) is designed to provision and deploy resources to Azure. In this unit, you'll create the app that will be deployed by the template. App source code conventionally lives in the `src` directory of the template. Later in the module you'll learn how to configure your template to deploy this app to Azure hosting resources such as App Service.

1. Open a terminal window in the root directory of your `azd` template.

1. Create a new `src` directory at the root:

    ```bash
    mkdir src
    ```

1. Change directory into the `src` folder of the template.

    ```bash
    cd src
    ```

1. Create a new web app using the `dotnet new` command:
    
    ```csharp
    dotnet new webapp
    ```

You should see the app source code populate in your `src` directory either in the file explorer or in your editor. `azd` will deploy this app to Azure after you complete some additional configurations.
