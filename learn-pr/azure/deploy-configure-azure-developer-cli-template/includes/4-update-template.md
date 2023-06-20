The initial `azd` provisioning and deployment process is a great way to get started with your app in Azure. However, once the environment is running, you'll want to start making changes to your app code or the Azure environment. 

There are a few different workflows to choose from to update your Azure environment after making changes to the `azd` template. You can always run `azd up` to update your environment regardless of whether you changed your application code or infrastructure files. `azd up` will complete the package, provision, and deploy steps every time it is run, so it's a simple way to ensure all of your changes are pushed out to Azure.

However, `azd` also offers more granular commands that map to specific stages of the developer workflow. These commands can also save time by skipping unnecessary checks or steps that you know haven't changed.

* **`azd deploy`** - This command will package and redeploy your application source code to Azure. However, it will not execute any infrastructure as code files and will not apply changes to your Azure resources.

* **`azd provision`** - This command will create or update Azure resources based on the changes to your infrastructure as code files. For example, `azd provision` will create a new storage account in Azure if you add it to your Bicep or Terraform files. However, this command does not package or redeploy your application source code.

## Update the app code

Your team is building a ticket management app - not a Todo app, so you want to change header text accordingly. Complete the following steps to update your application code and redeploy your changes using `azd`:

1. Locate the `header.tsx` file in the `src/web/src/layout` directory of the template. If you're using Visual Studio Code, you can also use the `ctrl + p` shortcut to search for the `header.tsx` file directly.

1. Change the header display text from `Todo` to `Ticket manager` and save your changes.

1. Return to the command prompt you used earlier, and then run the `azd deploy` command.

    ```azdeveloper
    azd deploy
    ```

    Wait for a moment while `azd` redeploys your code.

1. When the command finishes, revisit your app in the browser. The text in the upper left of the header should now read *Ticker Manager*.

## Update the Azure resources

Your team is planning to add the ability for users to upload files with their ticket. These files might include images or screenshots of an issue they are encountering, or other documents detailing a problem. You want to add an Azure Storage account to your environment that will be used to hold these files. You also want to make sure this storage account is included from the start when this template is provisioned in the future. You can meet these requirements by modifying the infrastructure as code files for your template using the following steps:

1. Locate the `main.bicep` file in the `infra` folder at the root of your template.

1. The template already contains a Bicep module for creating storage accounts, so you can reuse it to add your own. Paste ths following code snippet at the bottom of the `main.bicep` file above where the output variables are defined:

    ```bicep
    module storage './core/storage/storage-account.bicep' = {
      name: 'storage'
      scope: rg
      params: {
        name: '${abbrs.storageStorageAccounts}${resourceToken}'
        location: location
        tags: tags
      }
    }
    ```

1. Make sure you have saved your changes, and then run the `azd provision` command. This command will use the infrastructure as code files in your template to update your Azure environment, but will not redeploy any of your app source.

    ```azdeveloper
    azd provision
    ```

1. When the command finishes, follow the URL that is printed out in the console to launch the Azure portal in your browser. You should see the resource group that holds all of your originally provisioned resources, including the new storage account.

    :::image type="content" source="../media/resources-storage.png" alt-text="A screenshot showing the deployed storage account.":::