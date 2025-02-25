<!-- markdownlint-disable MD041 -->

In this module you learned to choose an environment, install the Azure CLI, execute Azure CLI commands interactively, and create a Bash script. Let's take our learning one step further and focus on how to use the Azure CLI successfully. This unit teaches you how the Azure CLI works behind the command line, and give you tips for troubleshooting.

> [!TIP]
> This module is an advanced-level course, and this unit is taking you deep into Azure CLI. If you're new to command-line programming, focus on the concepts. The details become easier to understand as you gain experience. Don't give up!

## Understand Azure CLI API calls

Executing behind the Azure portal's graphical user interface and the Azure CLI's command line are API calls. You can expose the Azure CLI's API calls by using the `--debug` parameter. Here's what happens when you create a new resource group:

```azurecli
az group create --location westus1 --name myResourceGroupName --debug
```

Here's the terminal output from Azure Cloud Shell with some lines omitted for brevity. Notice this important output:

- **Command arguments**: It's the scripting language, not the Azure CLI, that parses command arguments (parameters). _This output property is first place to look when a command is resulting in an error._
- **azlogging**: This path is where your log file is stored.
- **Request headers**: These headers are the parameter values passed by the PUT command.
- **Response content**: This output is what is returned to the console without the full `--debug` output.

```output
cli.knack.cli: Command arguments: ['group', 'create', '--location', 'westus2', '--name', 'myResourceGroupName', '--debug']
cli.knack.cli: __init__ debug log:
...
cli.knack.cli: Event: CommandInvoker.OnPreCommandTableCreate []
cli.azure.cli.core: Modules found from index for 'group': ['azure.cli.command_modules.resource']
cli.azure.cli.core: Loading command modules:
...
cli.azure.cli.core: Loaded 53 groups, 233 commands.
cli.azure.cli.core: Found a match in the command table.
cli.azure.cli.core: Raw command  : group create
...
cli.azure.cli.core.azlogging: metadata file logging enabled - writing logs to '/home/myName/.azure/commands/2025-02-17.21-47-27.group_create.5217.log'.
...
cli.azure.cli.core.sdk.policies: Request URL: 'https://management.azure.com/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourcegroups/myResourceGroupName?api-version=2022-09-01'
cli.azure.cli.core.sdk.policies: Request method: 'PUT'
cli.azure.cli.core.sdk.policies: Request headers:
cli.azure.cli.core.sdk.policies:     'Content-Type': 'application/json'
cli.azure.cli.core.sdk.policies:     'Content-Length': '23'
cli.azure.cli.core.sdk.policies:     'Accept': 'application/json'
cli.azure.cli.core.sdk.policies:     'x-ms-client-request-id': 'c79caddc-ed78-11ef-8a83-00155dbc433c'
cli.azure.cli.core.sdk.policies:     'CommandName': 'group create'
cli.azure.cli.core.sdk.policies:     'ParameterSetName': '--location --name --debug'
...
cli.azure.cli.core.sdk.policies: Response content:
...
{
  "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/myResourceGroupName",
  "location": "westus2",
  "managedBy": null,
  "name": "myResourceGroupName",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
cli.knack.cli: Event: Cli.SuccessfulExecute []
cli.knack.cli: Event: Cli.PostExecute [<function AzCliLogging.deinit_cmd_metadata_logging at 0x7f98a6bc7820>]
az_command_data_logger: exit code: 0
...
```

Some Azure CLI commands perform multiple actions. Use `--debug` to see each command Azure CLI is executing. Even more useful, use `--debug` to troubleshoot why an Azure CLI script is producing unexpected results.

## Troubleshooting

How many times as a developer have you thought, "This task should be so simple! Why isn't my script working?" When you receive unexpected results from Azure CLI commands, the `--debug` parameter is your friend! Let's work through an example of a company with 100 Azure storage accounts. You need to find those accounts where blob public access is enabled.

```azurecli
# Bash script
resourceGroup="msdocs-rg-00000000"
az storage account list --resource-group $resourceGroup --query "[?allowBlobPublicAccess == `true`].id"
```

When a parameter value isn't formatted correctly _for the scripting language that is parsing the value_, you receive an `invalid jmespath_type value` error.
 
```output
cli.knack.cli: Command arguments: ['storage', 'account', 'list', '--resource-group', 'msdocs-tutorial-rg-69794242', '--query', '[?allowBlobPublicAccess == ].id', '--debug']
...
cli.azure.cli.core.azclierror: argument --query: invalid jmespath_type value: '[?allowBlobPublicAccess == ].id'
az_command_data_logger: argument --query: invalid jmespath_type value: '[?allowBlobPublicAccess == ].id'
```

Look at the variable value Bash is passing for `allowBlobPublicAccess`? In fact, where is the value? Why is it missing?

Remember, it's the environment, also referred to as "scripting language," that parses Azure CLI variable values. Each scripting language, _and even versions of the same scripting language_, can produce different results. Here's the correct way to pass a boolean parameter value in Bash:

```azurecli
# Bash script
resourceGroup="msdocs-rg-00000000"
az storage account list --resource-group $resourceGroup --query "[?allowBlobPublicAccess == \`true\`].id" --debug
```

```output
cli.knack.cli: Command arguments: ['storage', 'account', 'list', '--resource-group', 'msdocs-rg-00000000', '--query', '[?allowBlobPublicAccess == `true`].id', '--debug']
...
[
  "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/msdocs-rg-00000000/providers/Microsoft.Storage/storageAccounts/msdocssa00000000"
]
```

Grasp the important concept of `--debug` and you are on your way to using the Azure CLI successfully in your environment of choice.

## Scripting language syntax differences

As we just finished talking about `--debug`, the next step is to be aware of what causes most scripting errors A script written in Bash will need to be modified to execute successfully in PowerShell or cmd.exe if your script contains one of these constructs:

- Line continuation characters
- Variables
- Random identifiers
- Quotes
- Programming language constructs

Here are some examples:

| Syntax | Bash | PowerShell | cmd.exe |
|-|-|-|-|
| **Line continuation characters** | Backslash (`\`) | Backtick (`` ` ``) | Carrot (`^`) |
| **Variable naming** | variableName=varValue | $variableName="varValue" | set variableName=varValue |
| **Number as string** | \\\`50\\\` | \`\`50\`\` | \`50\` |
| **Boolean as string** |\\\`true\\\` | \`\`false\`\` | \'true\' |
| **Random ID** | let "randomIdentifier=\$RANDOM*$RANDOM" | $randomIdentifier = (New-Guid).ToString().Substring(0,8) | set randomIdentifier=%RANDOM% |
| **Looping** | `until`, `while`, or `for` | `for`, `Foreach`, `while`, `do-while`, `do-until` | `for-[...]` |
| **Write to console** | echo | write-host (preferred) or echo | echo |

This example table isn't all-inclusive. What's important to understand when receiving an Azure CLI error, consider first that there might be a syntax problem for your environment. Test this possibility by **copying and pasting your script into another scripting language**, like Azure Cloud Shell. Use `--debug` in both environments and note the differences in the `command arguments` property of the output.

> [!IMPORTANT]
> When copying code blocks from Microsoft articles, be aware that most Azure CLI documentation at Microsoft is written for Bash and tested in Azure Cloud Shell.

## More ways to get help

### `az find` command

Take a quick tour of Azure CLI commands by following these examples:

- Find the most popular commands related to the word **blob**:

   ```azurecli
   az find blob
   ```

- Show the most popular commands for an Azure CLI command group, such as `az storage`:

   ```azurecli
   az find "az storage"
   ```

- Show the most popular parameters and subcommands for an Azure CLI command:

   ```azurecli
   az find "az storage account create"
   ```

### `--help` parameter

If you already know the name of the command you want, the `--help` argument for that command gets you more detailed information on the command and a list of the available subcommands for a command group. Continuing with our Azure storage examples, here's how you can get a list of the subgroups and commands for managing a storage account's blob service:

```azurecli
az account blob-service-properties --help
```

### A to Z indexes

To find examples for Azure CLI reference commands, use one of several A to Z indexes.

- The [Reference index](/cli/azure/reference-index) for Azure CLI provides and A to Z list of all reference groups. Expand the left navigation bar for subgroups.

- The [Azure CLI conceptual article list](/cli/azure/reference-docs-index) provides an A to Z list of quickstarts, how to guides, tutorials and learn modules that explain how to use Azure CLI reference commands in real world scenarios. The article list groups articles by Azure CLI command group, like `az account`, then `az acr` etc.  Use **CTRL + F** in Windows (**Command + F** in macOS) to quickly jump to the command group of your choice.

- The [Azure CLI sample scripts](/cli/azure/samples-index) index has three tabs:
  - [List by subject area](/cli/azure/samples-index?tabs=service): Use this tab to find samples for an Azure service.
  - [List by reference group](/cli/azure/samples-index?tabs=command): Use this tab to find samples for a reference command group.
  - [Azure CLI samples GitHub repository](/cli/azure/samples-index?tabs=github): Use this tab to find samples in the Azure CLI samples GitHub repository.

### Copilot

Both the Azure portal and Microsoft Edge offer Copilot experiences that return information on Azure CLI reference commands, samples and published articles. Copilot also provides links to related Stack Overflow questions. When you have a difficult job to be done with multiple scripting steps, Copilot is helpful in compiling multiple sources of information to answer your question.
