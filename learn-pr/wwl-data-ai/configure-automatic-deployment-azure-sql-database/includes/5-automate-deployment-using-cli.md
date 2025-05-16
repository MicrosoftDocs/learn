Database automation is no longer just for large enterprises; it's now essential for businesses of all sizes to stay competitive. As a database administrator, automating database tasks is crucial for several reasons:

- Granular control over applications and databases
- Easy scalability, enhancing efficiency when managing numerous assets
- Reusability of scripts for automating routine tasks
- Simplified troubleshooting when GUI tools are unavailable

The Azure Command-Line Interface (CLI) is a cross-platform tool that helps you create and manage Azure resources. You can run commands through the terminal using interactive prompts or scripts.

Azure CLI can be installed on Linux, Mac, or Windows computers. You can also run it from a browser using the Cloud Shell terminal on the Azure portal or inside a Docker container.

The Azure CLI syntax follows the `reference name` - `command` - `parameter` - `parameter value` pattern. For example, switching between subscriptions is a common task. Here's the syntax:

```azurecli
az account set --subscription "my subscription name"
```

## PowerShell vs. Azure CLI

Azure PowerShell and Azure CLI are both cross-platform command-line tools that allow you to create and manage Azure resources on Windows, macOS, and Linux. The primary difference between them lies in the shell environments they support.

| **Shell Environment** | **Azure CLI** | **Azure Powershell** |
|:---------------------:|:-------------:|:--------------------:|
| Cmd                   |      Yes      |                      |
| Bash                  |      Yes      |                      |
| Windows PowerShell    |      Yes      |          Yes         |
| PowerShell            |      Yes      |          Yes         |

To choose the right tool, consider your experience and your work environment.

Azure CLI is similar to bash scripting, making it intuitive for those who typically work with Linux systems. On the other hand, Azure PowerShell includes modules that help manage Azure resources from PowerShell. PowerShell commands follow the standard verb-noun syntax, making it a natural fit for those familiar with Windows systems.

Here's a quick comparison of some commonly used commands in both their CLI and PowerShell forms:

|         **Command**         |         **Azure CLI**        |     **Azure PowerShell**    |
|:---------------------------:|:----------------------------:|:---------------------------:|
| Sign in with Web Browser    | az login                     | Connect-AzAccount           |
| Get available subscriptions | az account list              | Get-AzSubscription          |
| Set Subscription            | az account set –subscription | Set-AzContext -Subscription |
| List all virtual machines   | az vm list                   | Get-AzVM                    |
| Create a new SQL server     | az sql server create         | New-AzSqlServer             |

## Deploying SQL Database using Azure CLI

Here's an example of how to deploy an SQL Database and create a firewall rule to allow access from Azure services using Azure CLI:

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

With PowerShell, you have multiple options for the scope of your deployment. You can deploy to a resource group, a subscription, a management group, which is a collection of subscriptions under the same Azure template and commonly used in large enterprise deployments, or a tenant. Azure Resource Manager templates are parameterized, requiring you to pass in parameters either inline or through a parameter file, as shown in the following example.

```powershell
New-AzResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup `
 -TemplateFile c:\MyTemplates\azuredeploy.json `
 -TemplateParameterFile c:\MyTemplates\storage.parameters.json
```

The parameter and template files can be stored in a Git repository, Azure Blob Storage, or any other accessible location from the deploying machine.

Azure CLI offers the same deployment scope options as PowerShell. You can use local or remote parameter files and templates, just as you would with PowerShell, as shown in the following example.

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
> Currently, Azure CLI doesn't support deploying remote Bicep files directly. Instead, you can use the Bicep CLI to convert the Bicep file into a JSON template, and then deploy the JSON template from a remote location.
