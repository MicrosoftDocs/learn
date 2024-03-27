In this unit, you'll use the Azure portal to create a web app.

## Create a web app

Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

::: zone pivot="csharp"

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource. The **Create a resource** pane appears.

    Here, you can search for the resource you want to create, or select one of the popular resources that people create in the Azure portal.

1. In the **Create a resource** menu, select **Web**.

1. Select **Web App**. If you don't see it, in the search box, search for and select **Web App**. The **Create Web App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Details |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The web app you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs (or will belong, if you're creating it within the wizard). |
    | Resource Group | Select <rgn>[Sandbox resource group]</rgn> | The resource group to which the web app will belong. All Azure resources must belong to a resource group. |
    | **Instance Details** |
    | Name | *Enter a unique name* | The name of your web app. This name will be part of the app's URL: *appname*.azurewebsites.net.  The name you choose must be unique among all Azure web apps. |
    | Publish | Code | The method you want to use to publish your application. When publishing an application as code, you also must configure **Runtime stack** to prepare App Service resources to run your app. |
    | Runtime stack | .NET 6 (LTS) | The platform on which your application will run. Your choice may affect whether you have a choice of operating system - for some runtime stacks, App Service supports only one operating system. |
    | Operating System | Linux | The operating system used on the virtual servers that will run your app. |
    | Region | East US | The geographical region from which your app will be hosted. |
    | **Pricing plans** |
    | Linux Plan | Accept default | The name of the App Service plan that will power your app. By default, the wizard will create a new plan in the same region as the web app. |
    | Pricing plan | Free F1 | The pricing tier of the service plan being created. The pricing plan determines the performance characteristics of the virtual servers that power your app and the features to which it has access. Select **Free F1** in the drop-down. |

    :::image type="content" source="../media/3-create-web-app-dotnet.png" alt-text="Screenshot showing web app creation details.":::

::: zone-end

::: zone pivot="java"

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource. The **Create a resource** pane appears.

    Here, you can search for the resource you want to create, or select one of the popular resources that people create in the Azure portal.

1. In the **Create a resource** menu, select **Web**.

1. Select **Web App**. If you don't see it, in the search box, search for and select **Web App**. The **Create Web App** resource pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Details |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The web app you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs (or will belong, if you're creating it within the wizard). |
    | Resource Group | Select <rgn>[Sandbox resource group]</rgn> | The resource group to which the web app will belong. All Azure resources must belong to a resource group. |
    | **Instance Details** |
    | Name | *Enter a unique name* | The name of your web app. This name will be part of the app's URL: *appname*.azurewebsites.net.  The name you choose must be unique among all Azure web apps. |
    | Publish | Code | The method you want to use to publish your application. When publishing an application as code, you also must configure **Runtime stack** to prepare your App Service resources to run your app. |
    | Runtime stack | Java 11 | The Java runtime version used by your application.  |
    | Java web server stack | Apache Tomcat 9.0 | The platform on which you want your application to run. Your choice may affect whether you have a choice of operating system - for some runtime stacks, App Service supports only one operating system. |
    | Operating System | Linux | The operating system used on the virtual servers that will run your app. |
    | Region | East US | The geographical region from which your app will be hosted. |
    | **Pricing plans** |
    | Linux Plan | Accept default | The name of the App Service plan that will power your app. By default, the wizard will create a new plan in the same region as the web app. |
    | Pricing plan | F1 | The pricing tier of the service plan being created. The pricing plan determines the performance characteristics of the virtual servers that power your app and the features to which it has access. Select **Free F1** in the drop-down. |

    :::image type="content" source="../media/3-create-web-app-java.png" alt-text="Screenshot showing web app creation details.":::

::: zone-end

::: zone pivot="node"

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource. The **Create a resource** pane appears.

    Here, you can search for the resource you want to create, or select one of the popular resources that people create in the Azure portal.

1. In the **Create a resource** menu, select **Web**.

1. Select **Web App**. If you don't see it, in the search box, search for and select **Web App**. The **Create Web App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Details |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The web app you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs (or will belong, if you're creating it within the wizard). |
    | Resource Group | Select <rgn>[Sandbox resource group]</rgn> | The resource group to which the web app will belong. All Azure resources must belong to a resource group. |
    | **Instance Details** |
    | Name | *Enter a unique name* | The name of your web app. This name will be part of the app's URL: *appname*.azurewebsites.net.  The name you choose must be unique among all Azure web apps. |
    | Publish | Code | The method you want to use to publish your application. When publishing an application as code, you also must configure **Runtime stack** to prepare App Service resources to run your app. |
    | Runtime stack | Node 16 LTS | The platform on which your application will run. Your choice may affect whether you have a choice of operating system; for some runtime stacks, App Service supports only one operating system. |
    | Operating System | Linux | The operating system used on the virtual servers that will run your app. |
    | Region | East US | The geographical region from which your app will be hosted. |
    | **Pricing plans** |
    | Linux Plan | Accept default | The name of the App Service plan that will power your app. By default, the wizard will create a new plan in the same region as the web app. |
    | Pricing plan | F1 | The pricing tier of the service plan being created. The pricing plan determines the performance characteristics of the virtual servers that power your app and the features to which it has access. Select **Free F1** in the drop-down. |

    :::image type="content" source="../media/3-create-web-app-node.png" alt-text="Screenshot showing web app creation details.":::

::: zone-end

::: zone pivot="python"

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource. The **Create a resource** pane appears.

    Here, you can search for the resource you want to create, or select one of the popular resources that people create in the Azure portal.

1. In the **Create a resource** menu, select **Web**.

1. Select **Web App**. If you don't see it, in the search box, search for and select **Web App**. The **Create Web App** resource pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Details |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The web app you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs (or will belong, if you're creating it within the wizard). |
    | Resource Group | From the dropdown list, select <rgn>[Sandbox resource group]</rgn> | The resource group to which the web app will belong. All Azure resources must belong to a resource group. |
    | **Instance Details** |
    | Name | *Enter a unique name* | The name of your web app. This name will be part of the app's URL: *appname*.azurewebsites.net.  The name you choose must be unique among all Azure web apps. |
    | Publish | Code | The method you want to use to publish your application. When publishing an application as code, you also must configure **Runtime stack** to prepare App Service resources to run your app. |
    | Runtime stack | Python 3.8 | The platform on which your application will run. Your choice may affect whether you have a choice of operating system - for some runtime stacks, App Service supports only one operating system. |
    | Operating System | Linux | The operating system used on the virtual servers that will run your app. |
    | Region | East US | The geographical region from which your app will be hosted. |
    | **Pricing plans** |
    | Linux Plan | Accept default | The name of the App Service plan that will power your app. By default, the wizard will create a new plan in the same region as the web app. |
    | Pricing plan | F1 | The pricing tier of the service plan being created. The pricing plan determines the performance characteristics of the virtual servers that power your app and the features to which it has access. Select **Free F1** in the drop-down. |

    :::image type="content" source="../media/3-create-web-app-python.png" alt-text="Screenshot showing web app creation details.":::

::: zone-end

5. Leave any other settings as default. Select **Review + Create** to go to the review pane, and then select **Create**. The portal shows the deployment pane, where you can view the status of your deployment.

    > [!NOTE]
    > It can take a moment for deployment to complete.

## Preview your web app

1. When deployment is complete, select **Go to resource**. The portal shows the App Service Overview pane for your web app.

    :::image type="content" source="../media/3-web-app-home.png" alt-text="Screenshot showing the App Service pane with the URL link of the overview section highlighted.":::

1. To preview your web app's default content, select the URL under **Default domain** at the top right. The placeholder page that loads indicates that your web app is up and running and is ready to receive deployment of your app's code.

::: zone pivot="csharp"

:::image type="content" source="../media/3-web-app-online-dotnet.png" alt-text="Screenshot showing your App Service in a browser." loc-scope="other":::

::: zone-end

::: zone pivot="java"

:::image type="content" source="../media/3-web-app-online-java.png" alt-text="Screenshot showing your App Service in a browser." loc-scope="other":::

::: zone-end

::: zone pivot="node"

:::image type="content" source="../media/3-web-app-online-node.png" alt-text="Screenshot showing your App Service in a browser." loc-scope="other":::

::: zone-end

::: zone pivot="python"

:::image type="content" source="../media/3-web-app-online-python.png" alt-text="Screenshot showing the newly created App Service in a browser." loc-scope="other":::

::: zone-end

Leave the browser tab with the new app's placeholder page open. You'll come back to it after you've deployed your app.
