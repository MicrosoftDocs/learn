When you are finished working with your environment, make sure to delete any unused Azure resources to avoid unexpected costs.

## Delete resources using the Azure Developer CLI

 `azd` allows you to delete all of your provisioned resources with a single command.

1. Open a command prompt to your project root directory and run the following command:

    ```azdeveloper
    azd down
    ```

1. `azd` prints a message detailing the resource group(s) that will be deleted and ask for confirmation to continue. You can follow the link to the Azure portal to see the details of which resources are contained in the resource group.

1. If you are certain you would like to delete the resources, enter *y* to confirm. `azd` will delete the resources for you and print out a confirmation message when the task completes.
It's important to remember that `azd` templates implement infrastructure as code. This means you can simply run the `azd up` command again to recreate your environment exactly as it was before, assuming you implemented all of your changes through updates to the `azd` template. Any modifications you made through the Azure portal or other tools are not automatically tracked or updated in the `azd` template.

## Delete resources manually

You can also delete the resources created by `azd` using the Azure portal. You might choose this approach if you accidentally delete your local template before running `azd down`, or if you encounter any type of unexpected error with the `azd down` command.

1. Locate your resource group in the Azure portal by searching for it or by navigating to the **Resource Groups** listing page.

1. Select the resource group to open the overview page.

1. Select **Delete resource group** at the top of the page to open the **Delete a resource group** dialog. Enter the resource group name to confirm deletion, and then select **Delete**.

    :::image type="content" source="../media/azd-delete-resources.png" alt-text="A screenshot showing how to delete a resource group.":::

## Review

The goal of this module was to guide you through the process of building your own Azure Developer CLI templates. You learned how to complete the following tasks:

- Scaffold a new `azd` project using the available starter templates
- Add your own application source code to the template
- Create infrastructure as code files to provision resources for your app
- Define configurations that determine how `azd` deploys your app
- Configure a CI/CD pipeline for the template using the sample workflow files as a starting point

As you continue to build `azd` templates and convert your projects to use this tool you'll become more comfortable with the process. Explore the following resources for more training and content around building `azd` templates.

## References

- [What is the Azure Developer CLI?](/azure/developer/azure-developer-cli/overview)
- [Make your project `azd` compatible](/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create)
- [Introduction to infrastructure as code using Bicep](/training/modules/introduction-to-infrastructure-as-code-using-bicep/)
