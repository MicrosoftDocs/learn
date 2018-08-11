## Module Summary
In this module, you used Azure CLI commands to create a resource group, and deploy a web app by using a small set of commands. These commands could be combined into a shell script as part of automation solution.

The Azure CLI is a good choice for anyone new to Azure command-line and scripting. Its simple syntax and cross-platform compatibility help reduce the risk of errors when performing regular and repetitive tasks.

## Cleanup
Running web apps incurs costs against your subscription. Remove unneeded resources to avoid unnecessary charges. The easiest way to clean up your Azure subscription is to remove the resource group; this will also delete all the resources in the group. When you're finished with this module, run the following Azure PowerShell cmdlet:

    ```azurecli
    az group delete --resource-group popupResGroup
    ```

When you're asked to confirm the delete, answer **Yes**. The command may take several minutes to complete as resources are deleted. 