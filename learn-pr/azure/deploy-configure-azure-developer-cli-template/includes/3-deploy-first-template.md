The Azure Developer CLI (`azd`) is built around developer-friendly commands and foundational application templates. The commands map to common development workflow tasks, such as provisioning or deploying resources. The templates include all of the necessary source code and configuration assets to complete these tasks. You can start using `azd` by either working off of one of the existing and extensible sample templates or by building your own.

When getting started with `azd`, it's often easiest to find an existing template that closely matches your desired environment architecture and use that as a starting point. You can explore a large set of available templates on the [Awesome AZD](https://azure.github.io/awesome-azd) site. You can also see a list of the available templates using the following command:

```azdeveloper
azd template list
```

For this example, you'll use the existing [todo-nodejs-mongo](https://github.com/Azure-Samples/todo-nodejs-mongo) template built around the Node.js and MongoDB stack. Even if you have never worked with these technologies, you can still complete the steps ahead, since `azd` handles most of the work for you. This template will create a set of resources in Azure that are similar to those outlined in the sample scenario at the beginning of the module.

> [!NOTE]
> The same `azd` steps described in this module also apply to templates built around other languages or technologies, such as C# or Python.

## Deploy the template

The most common starter workflow for `azd` only requires a few commands. You'll explore other commands and options later in the module to complete additional tasks. To initialize and deploy an `azd` template, complete the following steps:

1. Open a command prompt to an empty file directory.

1. Run the `azd init` command and specify the template you want to use as a parameter. `azd` will clone the template in your local environment.

    ```azdeveloper
    azd init --template todo-nodejs-mongo
    ```

1. When the command prompts you for an environment name, enter `azdlearn`. The environment name influences the naming of certain resources in Azure.

1. Run the `azd auth login` command to launch a browser window you can use to sign in to your Azure account.

    ```azdeveloper
    azd auth login
    ```

3. Run the `azd up` command to provision and deploy the template resources to Azure. When prompted, select the subscription and location you would like to deploy to.

    ```azdeveloper
    azd up
    ```

The `azd up` command may take several minutes to run. Each template provisions different Azure resources and configurations, which means different templates require varying amounts of time to complete. You should see updates printed out in the console as the process runs. When it completes, a link to the deployed site will be displayed. You should also see a link to the deployment process in Azure, which you can visit to view additional deployment information.

The deployed application should look similar to the following screenshot:

:::image type="content" source="../media/deployed-app.png" alt-text="A screenshot showing the deployed web application.":::

You can also view the resources that were created in Azure by navigating to your resource group in the Azure portal:

1. In the main Azure portal search bar, search for the resource group `azd` created for you by typing `rg-azdlearn`. By convention, the resource group will be the environment name you specified prefixed with `rg-`.

2. Select the resource group from the results to navigate to the overview page. You should see a list of the different resources that were created for you by `azd`.

    :::image type="content" source="../media/deployed-resources.png" alt-text="A screenshot showing the deployed resources.":::

## Monitor the application

Many `azd` templates also provision monitoring resources in Azure, such as Application Insights dashboards. These dashboards provide application health monitoring capabilities such as live metrics and logging. You can launch these dashboards using the `azd monitor` command and one of the following flags:

* **`--overview`** - Launches the main dashboard.
* **`--live`** - Launches the live metrics dashboard.
* **`--logs`** - Launches the logging dashboard.

For example, run the following command in your terminal to open the live metrics dashboard:

```azdeveloper
azd monitor --live
```

The browser should launch and display a page similar to the following screenshot:

:::image type="content" source="../media/live-metrics-small.png" alt-text="A screenshot showing a metrics dashboard."  lightbox="../media/live-metrics.png" :::

Congratulations! You provisioned, deployed and monitored your first app environment using `azd`. Next, you'll learn how to update the template and deploy your changes.
