Business stakeholders have given you permission to add the Application Insights SDK to your video sharing app, with the expectation that the app will begin generating more interesting and useful telemetry.

In this unit, we'll create a web app and add the Application Insights SDK to it. We'll also create an App Service instance for deploying our web app, and configure it to use Application Insights.

## Create the web app source code

To create a web app, we'll use a quickstart template that's included with the ASP.NET Core command-line tools.

Run the following command in Azure Cloud Shell terminal window on the right.

```bash
dotnet new mvc -o videowebapp
```

## Add the Application Insights SDK

To reference the Application Insights SDK within the app, install the appropriate NuGet packages:

1. In Cloud Shell, make sure you're in the video app's directory by running the following command.

    ```bash
    cd videowebapp
    ```

1. To add the Application Insights SDK to the app, run this command.

    ```bash
    dotnet add package Microsoft.ApplicationInsights.AspNetCore
    ```

## Initialize the Application Insights SDK

To initialize the Application Insights SDK, you need to call the `UseApplicationInsights` method in the *Program.cs* file. Perform the following steps.

1. Open the source code for the app in Cloud Shell editor by running the following command.

    ```bash
    code .
    ```
 1. In the *Startup.cs* file, add a call to `UseApplicationInsights`in the *ConfigureServices()* method. The call should look like this.

    ```csharp
    services.AddApplicationInsightsTelemetry();
    ```

    > [!IMPORTANT]
    > Be sure to save files when you're done editing them. You can do this by using the ellipsis menu (...) or by using a keyboard shortcut (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Configure a deployment environment

We've created our app and initialized the SDK in our code. Now we need a deployment environment for it. We need a place to host the web app, and we also need an Application Insights resource. We'll follow the best practice mentioned in the last unit and configure the instrumentation key by using an environment variable in the deployment environment.

We'll host our app in Azure App Service. Instead of manually creating an Application Insights resource and configuring its instrumentation key with an application setting, we'll enable Application Insights runtime instrumentation on the app. This will create the Application Insights resource for us and automatically add the `APPINSIGHTS_INSTRUMENTATIONKEY` application setting with the correct value.

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal menu, or from the **Home** page under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu, under **Categories**,select **Web**, then select **Web App**. The **Create Web App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting                   | Value    |
    |---------------------------|------------------|
    | **Project Details** |
    | Subscription              | Concierge Subscription   |
    | Resource Group            | Select **<rgn>Sandbox resource group</rgn>** |
    | **Instance Details** |
    | Name                      | Choose a unique name. Make a note of it. You'll need it later on. |
    | Publish                   | **Code** |
    | Runtime stack             | **.NET Core 2.1 (LTS)**  |
    | Operating System          | **Windows** |
    | Region                    | Choose location close to you. |
    | **App Service Plan** |
    | Windows Plan              | Accept default: ASP-learn2ac17be8c3094f558b79eabec2-axxx |
    | Sku and size              | Select **Change size** to open the Spec Picker wizard. Select **Dev / Test**, select **F1**, and then select **Apply**. |

1. On the **Create Web App** pane, select **Next:Deployment (Preview)**, and then select **Next:Monitoring**. On the **Monitoring** tab, for **Enable Application Insights**, and then select **Yes**. 

    An alert will appear indicating that your app will be connected to an automatically created Application Insights resource with the same name as the app.

1. Select **Review + create** and after the input values have been verified, select **Create**.

    Creating your App Service web app will take a minute or two. The portal will notify you when it's finished.

## Confirm the Application Insights configuration

After the web app is created, we can observe how it's been configured to use Application Insights.

1. In the Azure portal, select **All Resources**, look for the **App Service** resource type, select the App Service. The **App Service** pane for your web app appears.

1. In the left menu, under **Settings**, select **Application Insights** and then, on the **Application Insights** pane, select **Turn on Application Insights**. settings that are listed and select the `APPINSIGHTS_INSTRUMENTATIONKEY` setting to see its value. When your app runs in App Service, this value will be available as an environment variable, and the Application Insights SDK will use it as configuration.

1. In the left menu pane, select **Application Insights**. At the top of the Application Insights pane, see **Link to an Application Insights resource** to collect to the Application Insights resource linked to the web app.

1. The instrumentation key for the Application Insights resource appears near the top of the pane. Note that it's the same as the one shown in the app's settings.

We've set up our app and deployment environment, but we're not going to deploy the app yet. First, we're going to add some custom event telemetry.
