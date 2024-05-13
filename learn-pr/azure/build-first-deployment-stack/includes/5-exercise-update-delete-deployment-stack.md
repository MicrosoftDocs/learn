In this exercise, you update the Bicep file you previously created to include additional resources. You also update and delete the deployment stack that manages your resources.

> [!div class="checklist"]
>
> - Update the Bicep file to include an Azure SQL database.
> - Update the deployment stack to deploy the new database.
> - Validate the deployment stack's managed resources.
> - Delete the deployment stack and managed resources.
> - Validate the deletion of the deployment stack and the managed resources.

## Update the Bicep file to include the Azure SQL database

1. Open the _main.bicep_ file in Visual Studio Code.

1. Add the highlighted code to the parameters section of your file:

    :::code language="bicep" source="code/1-template-1.bicep" range="1-23" highlight="5-16:::

1. Add the following code to the bottom of the file:

    :::code language="bicep" source="code/1-template-1.bicep" range="44-63":::

1. Save the changes to the file.
