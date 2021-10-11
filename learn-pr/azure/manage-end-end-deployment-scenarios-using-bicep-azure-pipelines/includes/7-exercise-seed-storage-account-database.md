TODO

## Add storage container

1. Open main.bicep

1. Add variable

   :::code language="bicep" source="code/7-main.bicep" range="34" :::

1. Add config settings to app

   :::code language="bicep" source="code/7-main.bicep" range="78-113, 118-121" highlight="25-36" :::

1. Add nested resources

   :::code language="bicep" source="code/7-main.bicep" range="134-153" highlight="9-19" :::

1. Add outputs

   :::code language="bicep" source="code/7-main.bicep" range="182-183" :::

1. Commit but don't push
    ```cmd
    git add .
    git commit -m "Add storage container"
    ```

## Add SQL server and database to Bicep file

1. Add parameters

   :::code language="bicep" source="code/7-main.bicep" range="22-27" :::

1. Add variables for names

   :::code language="bicep" source="code/7-main.bicep" range="35-36" :::

1. Add connection string variable

   :::code language="bicep" source="code/7-main.bicep" range="38-39" :::

1. Add SKUs

   :::code language="bicep" source="code/7-main.bicep" range="42-70" highlight="9-14, 22-27" :::

1. Add setting to app

   :::code language="bicep" source="code/7-main.bicep" range="78-120" highlight="37-40" :::

1. Add resources

   :::code language="bicep" source="code/7-main.bicep" range="155-178" :::

1. Add outputs

   :::code language="bicep" source="code/7-main.bicep" range="180-185" highlight="5-6" :::

## Add build steps for database project

1. Open build.yml file

1. Add step to build and publish the Visual Studio database project

   :::code language="yaml" source="code/7-build.yml" highlight="31-50" :::

## Add values to variable group

1. Add to ToyWebsiteProduction

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | ToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!111 |

   Make password a secret - TODO screenshot

   :::image type="content" source="../media/7-variable-group-edit.png" alt-text="TODO":::

1. Add to ToyWebsiteTest

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | TestToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!999 |

## Add parameter values to validate and preview stages

1. Open deploy.yml

1. Add parameter values to validate step

   :::code language="yaml" source="code/7-deploy.yml" range="23-31" highlight="7-9" :::

1. Add parameter values to what-if step

   :::code language="yaml" source="code/7-deploy.yml" range="49-57" highlight="7-9" :::

## Update deploy stage

1. Add parameter values to deploy step

   :::code language="yaml" source="code/7-deploy.yml" range="82-92" highlight="9-11" :::

1. Propagate storage and SQL output values to variables

   :::code language="yaml" source="code/7-deploy.yml" range="93-104" highlight="3-6, 9-12" :::

## Add DACPAC deployment step

1. Add step to deploy DACPAC file

   :::code language="yaml" source="code/7-deploy.yml" range="117-129" :::

## Add sample data to test environments

1. Add step to seed database, and condition

   :::code language="yaml" source="code/7-deploy.yml" range="131-143" :::

1. Add step to upload sample images by using the Azure CLI

   :::code language="yaml" source="code/7-deploy.yml" range="145-156" :::

## Verify deploy.yml

:::code language="yaml" source="code/7-deploy.yml" :::

## Commit and push

```cmd
git add .
git commit -m "Add SQL database"
git push
```

## Run pipeline and see smoke test pass

1. Open pipeline and watch

   All test stages complete successfully, including smoke test. The *Preview (Production Environment)* stage pauses - needs permission to variable group

1. Select View > Permit > Permit

   Preview stage completes successfully, then pauses again at *Deploy (Production Environment)* for environment permission

1. Select View > Permit > Permit

   Deployment stage completes successfully, and the production smoke test stage passes

1. Open website for test and see it's showing the sample data

   <!-- TODO screenshots -->

1. Open website for prod and see it doesn't show sample data

   <!-- TODO screenshots -->

## Clean up resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code terminal, run the following commands:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyWebsiteTest --yes --no-wait
az group delete --resource-group ToyWebsiteProduction --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyWebsiteTest -Force
Remove-AzResourceGroup -Name ToyWebsiteProduction -Force
```

::: zone-end
