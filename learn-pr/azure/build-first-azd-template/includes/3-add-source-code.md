The Azure Developer CLI (`azd`) is designed to provision and deploy resources to Azure. In this unit, you'll create the app that the template deploys. App source code conventionally lives in the `src` directory of the template. Later in the module you'll learn how to configure your template to deploy this app to Azure hosting resources such as App Service.

1. Open a terminal window in the root directory of your `azd` template.

1. Create a new `src` directory at the root:

    ```bash
    mkdir src
    ```

1. Change directory into the `src` folder of the template.

    ```bash
    cd src
    ```

1. Create a new directory called *web*. Subfolders inside of the `src` directory allow your template to logically group the different parts of your app, such as the frontend and backend services of a web app. The sample web app for this module will only have one code base in a single directory.

    ```bash
    mkdir web
    ```

1. Create a new web app using the `dotnet new` command:
    
    ```csharp
    dotnet new webapp
    ```

You should see the app source code populate in your `web` directory either in the file explorer or in your editor.

:::image type="content" source="../media/app-files.png" alt-text="A screenshot showing the source code files.":::

`azd` can deploy the app to Azure after you complete some additional configurations.
