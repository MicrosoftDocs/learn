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

1. Add build.yml file

1. Add step to build and publish the Visual Studio database project

   :::code language="yaml" source="code/7-build.yml" highlight="31-50" :::

## Add values to variable group

1. Add to ToyWebsiteProduction

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | TestToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | TODO |

   Make password a secret

1. Add to ToyWebsiteTest

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | ToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | TODO |

   Make password a secret

## Add parameter values to validate and preview stages

1. Open deploy.yml

<!-- TODO the below don't include the reviewApiUrl etc -->
1. Add parameter values to validate step

   :::code language="yaml" source="code/7-deploy.yml" range="23-29" highlight="5-7" :::

1. Add parameter values to what-if step

   :::code language="yaml" source="code/7-deploy.yml" range="47-53" highlight="5-7" :::

## Update deploy stage

1. Add parameter values to deploy step

   :::code language="yaml" source="code/7-deploy.yml" range="78-86" highlight="7-9" :::

1. Propagate storage and SQL output values to variables

   :::code language="yaml" source="code/7-deploy.yml" range="87-98" highlight="3-6, 9-12" :::

## Add DACPAC deployment step

1. Add step to deploy DACPAC file

   :::code language="yaml" source="code/7-deploy.yml" range="111-123" :::

## Add sample data to test environments

1. Add step to seed database, and condition

   :::code language="yaml" source="code/7-deploy.yml" range="125-137" :::

1. Add step to upload sample images by using the Azure CLI

   :::code language="yaml" source="code/7-deploy.yml" range="139-150" :::

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

   All test stages complete successfully, including smoke test

1. The *Preview (Production Environment)* stage pauses - needs permission to variable group

   Preview stage completes successfully

1. Then pauses again at *Deploy (Production Environment)* for environment permission

   Deployment stage completes successfully

1. The production smoke test passes

1. Open website and see it's showing data for test, but not for prod

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

<!-- TODO can we avoid the approvals for var groups/environments somehow? -->
