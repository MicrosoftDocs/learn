Database automation is now no longer reserved for larger businesses, but is becoming a necessity for businesses of all sizes to remain competitive. As a database administrator, it's important to learn how to automate database tasks whenever possible as it will provide you with the following benefits:

- Granular control of an application or database
- Easy to scale, improving efficiency when dealing with large numbers of assets
- Ability to reuse scripts to automate regular tasks
- Facilitates troubleshooting tasks where GUI tools aren't available

The Azure Command-Line Interface (CLI) is a cross-platform command-line tool that helps you to create and manage Azure resources. You can run commands through the terminal using interactive command-line prompts or scripts.

You can install Azure CLI on Linux, Mac, or Windows computers. Run it from a browser using the Cloud Shell terminal on Azure portal or inside a Docker container.

The Azure CLI syntax follows the `reference name` - `command` - `parameter` - `parameter value` pattern. For example, switching between subscriptions is often a common task. Here's the syntax.

```azurecli
az account set --subscription "my subscription name"
```

## PowerShell vs. Azure CLI

Azure PowerShell and Azure CLI are both cross-platform command-line tools that will enable you to create and manage Azure resources on Windows, macOS and Linux. The main difference between the two is the shell environments that they support.

| **Shell Environment** | **Azure CLI** | **Azure Powershell** |
|:---------------------:|:-------------:|:--------------------:|
| Cmd                   |      Yes      |                      |
| Bash                  |      Yes      |                      |
| Windows PowerShell    |      Yes      |          Yes         |
| PowerShell            |      Yes      |          Yes         |

To choose the correct tool, consider your experience and work environment.

The Azure CLI is similar to bash scripting, and it will feel natural to those who typically work with Linux systems. Azure PowerShell contains modules that help manage Azure resources from PowerShell. PowerShell commands follow the standard verb-noun syntax, and working with Windows systems will make it a natural fit.

Here's a quick comparison of some commonly used commands in both their CLI and PowerShell forms:

|         **Command**         |         **Azure CLI**        |     **Azure PowerShell**    |
|:---------------------------:|:----------------------------:|:---------------------------:|
| Sign in with Web Browser    | az login                     | Connect-AzAccount           |
| Get available subscriptions | az account list              | Get-AzSubscription          |
| Set Subscription            | az account set –subscription | Set-AzContext -Subscription |
| List VM                     | az vm list                   | Get-AzVM                    |
| Create a SQL Server         | az sql server create         | New-AzSqlServer             |

## Deploying SQL Database using Azure CLI

Below is an example of how to deploy SQL Database, and create a firewall rule that allows access from Azure services using Azure CLI.

```azurecli
let "randomIdentifier=$RANDOM*$RANDOM"

$resourceGroup = "<your resource group>"
$location = "<your location preference>"
$server = "dp300-sql-server-$randomIdentifier"
$login = "sqladmin"
$password = "Pa$$w0rD-$randomIdentifier"

az sql server create --name $server --resource-group $resourceGroup --location "$location" --admin-user $login --admin-password $password

az sql server firewall-rule create --resource-group $resourceGroup --server $server -n AllowYourIp --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

```

To learn more about all the Azure SQL CLI commands available, see [Azure SQL CLI commands.](/cli/azure/sql)

## Deploying Azure Resource Manager (ARM) template using Azure CLI and PowerShell

With PowerShell, you have several options for the scope of your deployment. You can deploy to a resource group, a subscription, a Management Group (a collection of subscriptions under the same Azure template and commonly used in large enterprise deployments), or a tenant. Azure Resource Manager templates are parameterized, and you will need to pass in parameters, either inline or through the use of a parameter file as shown in the example below.

```powershell
New-AzResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup `
 -TemplateFile c:\MyTemplates\azuredeploy.json `
 -TemplateParameterFile c:\MyTemplates\storage.parameters.json
```

The parameter and template file can also be stored in a Git repo, Azure Blob Storage, or any other place where it is accessible from the deploying machine.

Azure CLI allows the same options for deployment scope as you have with PowerShell. Like with PowerShell, you can use a local or remote parameter file and template, as shown in the example below.

```azurecli
az deployment group create --resource-group ExampleResourceGroup --template-file '\path\template.json'
```

To deploy remote linked templates with relative path that are stored in a storage account, use query-string to specify the SAS token:

```azurecli
az deployment group create \
  --name linkedTemplateWithRelativePath \
  --resource-group myResourceGroup \
  --template-uri "https://stage20210126.blob.core.windows.net/template-staging/mainTemplate.json" \
  --query-string $sasToken
```

> [!NOTE]
> Currently, Azure CLI doesn't support deploying remote Bicep files. You can use Bicep CLI to build the Bicep file to a JSON template, and then load the JSON file to the remote location.

You can review your deployed resources in Azure CLI using the command below:

```azurecli
az resource list --resource-group exampleRG
```
