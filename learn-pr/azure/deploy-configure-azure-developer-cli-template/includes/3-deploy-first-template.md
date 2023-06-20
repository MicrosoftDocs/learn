The Azure Developer CLI (`azd`) is built around developer-friendly commands and foundational application templates. `azd` provides a set of commands that help onboard and manage your application on Azure using standardized project templates. These templates include all of the necessary source code and configuration assets to provision and deploy your app to Azure. You can start using `azd` by either working off of one of the existing and extensible sample templates or by building your own.

You can explore a large set of available templates on the [Awesome AZD](https://azure.github.io/awesome-azd) site. When getting started with `azd`, it's often easiest to find an existing template that closely matches your desired environment architecture and use that as a starting point. You can also see a list of the available templates using the following command:

```azdeveloper
azd template list
```

For this example, you'll use a pre-existing template built using React, Python, and MongoDB. Even if you have never worked with these technologies, you can still complete the steps ahead, since `azd` handles most of the work for you. This template will create a set of resources in Azure that are similar to those outlined in the sample scenario at the beginning of the module.

The most common starting workflow for `azd` only requires a couple of commands. You'll explore other commands and options later in the module to complete additional tasks. To initialize and deploy an `azd` template, complete the following steps:

1. Open a command prompt to an empty file directory on your computer.

1. Run the `azd init` command and specify the template you want to use as a parameter. The command will also prompt you for an environment name, which will you can set to whatever you'd like.

    ```azdeveloper
    azd init --template todo-python-mongo
    ```

2. Run the `azd auth login` command to launch a browser window you can use to sign in to your Azure subscription.

    ```azdeveloper
    azd auth login
    ```

3. Run the `azd up` command to provision and deploy the template resources to Azure. Select the subscription and location you would like to deploy to when prompted.

    ```azdeveloper
    azd up
    ```

The `azd up` command may take several minutes or longer to run. Each templates provisions different Azure resources and configurations, which means each requires various amounts of time to complete. You should see updates printed out in the console as the process runs. When it completes, a link to the deployed site will be displayed. You should also see a link to the deployment process in Azure, which you can visit to view additional deployment information.

The deployed application should match the following screenshot:

<img>

Congratulations! You provisioned and deployed your first app environment using `azd`. Next, you'll learn how to update the template and deploy your changes.