Despite the rise of declarative IaC tools like Bicep, command line tools such as Azure CLI and Azure PowerShell, remain essential for cloud engineers. Some tasks don't fit neatly into a template: predeployment checks, data migrations, operational runbooks, unplanned troubleshooting, and automation that involves conditional logic or loops.

CommandLine (CLI) scripts are also often the first thing a team reaches for, when something needs to happen quickly. The speed at which you can write and run a script matters. Exactly where GitHub Copilot adds immediate value. Instead of searching documentation for the right command and its parameters, you describe what you want in plain language and Copilot generates the script.

## Azure CLI vs. Azure PowerShell

It helps to understand which tool to reach for, before generating scripts.

**Azure CLI (`az`)** is a cross-platform command-line tool that runs on Windows, macOS, and Linux. Its output is JSON by default, making it easy to pipe into other tools. Azure CLI is widely used in bash scripts, Linux-based CI/CD agents, and by teams with a Linux or DevOps background.

**Azure PowerShell (`Az` module)** uses the PowerShell language and runs on Windows, macOS, and Linux via PowerShell 7+. Its output is structured .NET objects, which makes it powerful for complex logic, filtering, and integration with other Microsoft services. PowerShell seems preferred by Windows-heavy teams and system administrators.

Both tools cover the same Azure operations. Choosing between them is largely a question of which language your team is most comfortable with and which environment your scripts run in. GitHub Copilot handles both fluently and can translate between them.

## Generate Azure CLI scripts with Copilot

### Start simple

For straightforward resource creation, a direct prompt works well. Copilot knows the `az` command structure and can generate correct syntax for common operations.

A sample prompt could look like this:

```
Generate an Azure CLI command to create a resource group called "rg-webapp-prod" in the West Europe region, tagged with Environment=Production and Owner=platform-team.
```

Where GitHub Copilot's response might be similar to:

```bash
az group create \
  --name rg-webapp-prod \
  --location westeurope \
  --tags Environment=Production Owner=platform-team
```

For a single command, the syntax is straightforward. The real value appears when you ask GitHub Copilot to build a complete script with multiple steps, variables, and error handling.

### Build a full provisioning script

In this more advanced approach, your prompt might contain more details, like the example here:

```
Generate an Azure CLI bash script that provisions the following resources:
- Resource group: rg-iaclab in East US
- VNet: vnet-iaclab with address space 10.0.0.0/16
- Subnet: snet-app at 10.0.1.0/24
- NSG: nsg-app with a rule denying all inbound internet traffic
  except HTTPS (port 443)
- Associate the NSG with snet-app

Requirements:
- Use variables at the top for all configurable values
- Check if the resource group already exists before creating it
- Print a status message after each successful resource creation
- Exit immediately if any command fails (set -e)
- Tag all resources with Environment=Training and Owner=lab-user
```

Copilot generates a script with a clean variable block, idempotency checks, and status messages. The key prompting techniques here are:

- **Variables at the top**: prevents hardcoded values scattered through the script
- **Existence check before creation**: makes the script idempotent (safe to rerun)
- **Exit on failure (`set -e`)**: prevents silent failures from propagating

### Add idempotency

Idempotency means the script produces the same result, whether run once or 10 times. Which is critical for automation scripts that may run on a schedule or as part of CI/CD pipelines.

Here's an example of using a prompt to add idempotency to your script generation:

```
Refactor this script so that each resource creation command first checks whether the resource already exists. If it exists, print "already exists — skipping" and continue. If it does not exist, create it.
Use az [resource] show with a 2>/dev/null check to test for existence.
```

Copilot wraps each `az ... create` command in an existence check pattern:

```bash
if ! az network vnet show --name "$VNET_NAME" --resource-group "$RG_NAME" \
     --query id -o tsv 2>/dev/null; then
  echo "Creating VNet: $VNET_NAME..."
  az network vnet create \
    --name "$VNET_NAME" \
    --resource-group "$RG_NAME" \
    --address-prefix "$VNET_PREFIX"
  echo "VNet created successfully."
else
  echo "VNet $VNET_NAME already exists — skipping."
fi
```

### Add parameter validation

Another useful use case is using parameter validation, as part of your prompt. See the example here:

```
Add a validation block at the top of the script that:
- Checks that the az CLI is installed and the user is logged in
- Verifies the target subscription is set correctly
- Accepts RESOURCE_GROUP, LOCATION, and OWNER as command-line arguments
  and exits with a usage message if they are not provided
```

This pattern makes scripts suitable for use in automation pipelines where inputs come from environment variables or CI/CD parameters rather than hardcoded values.

## Generate Azure PowerShell scripts with GitHub Copilot

The same natural language approach works for (Azure) PowerShell. Copilot understands Az module cmdlets and generates idiomatic PowerShell rather than translating CLI syntax verbatim.

By including the required scripting language in a prompt, you narrow the GitHub Copilot scope:

```
Generate an Azure PowerShell script that:
- Connects to Azure using a service principal (client ID, client secret,
  tenant ID passed as parameters)
- Creates a resource group "rg-iaclab" in East US if it does not already exist
- Creates a Storage Account with Standard_LRS SKU, HTTPS-only access,
  and blob soft delete enabled (30 days)
- Outputs the storage account's primary connection string at the end
Use proper error handling with try/catch blocks.
```

GitHub Copilot responds with clear PowerShell syntax, understanding the Azure resources and parameters:

```powershell
param(
    [Parameter(Mandatory=$true)][string]$TenantId,
    [Parameter(Mandatory=$true)][string]$ClientId,
    [Parameter(Mandatory=$true)][string]$ClientSecret,
    [string]$Location = "eastus",
    [string]$ResourceGroupName = "rg-iaclab",
    [string]$StorageAccountName = "stiaclab$(Get-Random -Maximum 9999)"
)

# Connect using service principal
$SecureSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($ClientId, $SecureSecret)

try {
    Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantId
    Write-Host "Connected to Azure successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to connect to Azure: $_"
    exit 1
}

# Create resource group if it does not exist
$RG = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if (-not $RG) {
    Write-Host "Creating resource group: $ResourceGroupName..."
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location `
        -Tag @{ Environment = "Training"; Owner = "lab-user" }
}
```

Notice that Copilot naturally produces PowerShell-idiomatic patterns: `param()` blocks, `try/catch`, `-ErrorAction SilentlyContinue`, and the `$(...)` expansion syntax. It doesn't try to replicate bash patterns in PowerShell.

## Translate between CLI and PowerShell

One of the most practical uses of GitHub Copilot for infrastructure work is converting scripts between tools. Common scenarios are:

- A script written by a Linux-centric team and needs to run on Windows
- Documentation examples are in CLI but your team uses PowerShell
- You want to standardize all automation to one language

An example of such a transformation prompt could be similar to this example:

```
Translate the following Azure CLI bash script to Azure PowerShell.
Use Az module cmdlets throughout. Preserve:
- The same variable/parameter names where possible
- All error handling logic
- The existence check pattern before each resource creation
- Tag application on all resources
Do not add features that are not in the original script.

[paste your CLI script here]
```

The instruction `Do not add features that are not in the original` is important. Without it, Copilot sometimes adds logging, telemetry, or extra functionality that wasn't requested. Making it harder to compare the two scripts and verify equivalence.

### Key CLI-to-PowerShell equivalents

Understanding the mappings helps you verify Copilot's translations:

| Azure CLI | Azure PowerShell |
|---|---|
| `az group create` | `New-AzResourceGroup` |
| `az group show` | `Get-AzResourceGroup` |
| `az network vnet create` | `New-AzVirtualNetwork` |
| `az network nsg create` | `New-AzNetworkSecurityGroup` |
| `az vm create` | `New-AzVM` |
| `az storage account create` | `New-AzStorageAccount` |
| `az keyvault create` | `New-AzKeyVault` |
| `--query` + `--output tsv` | `Select-Object` + `.PropertyName` |
| `$?` (exit code check) | `$?` or `try/catch` |

## Practical patterns for Copilot-Assisted CLI work

### Generate commands for unfamiliar resources

Even experienced Azure engineers encounter Azure Resource types they worked with before. Copilot removes the documentation lookup:

Including a clear reference to the Azure resource type in your prompt is enough for Copilot to generate the correct command:

```
Generate an Azure CLI command to create an Azure Container Registry with
Premium SKU, geo-replication to West Europe, admin account disabled,
and a system-assigned managed identity. Output the login server at the end.
```

Copilot generates the correct `az acr create` command with the right flag names. Including  flags that are easy to forget, such as `--sku`, `--admin-enabled false`, and `--identity [system]`.

### Build cleanup scripts

Cleanup scripts are essential in training environments and development. Copilot generates them quickly. An example of such prompt might look like this:

```
Generate an Azure CLI script that:
- Lists all resource groups with the tag Environment=Training
- Prints each group name and asks for confirmation before deleting
- Deletes confirmed groups with --no-wait for speed
- Reports how many groups were deleted at the end
```

### Generate cross-subscription scripts

Enterprise environments often rely on multiple Azure subscriptions. With GitHub Copilot, this added complexity is easy to handle. Include that specification as part of your prompt, as shown here:

```
Generate an Azure CLI script that iterates over all subscriptions in my tenant,
checks each one for storage accounts that have public blob access enabled,
and outputs a CSV report with: SubscriptionName, ResourceGroup, StorageAccountName, Location.
```

Copilot generates the loop structure using `az account list` and `az account set` correctly, handling the subscription context switch that trips up many engineers writing from scratch.

## Key takeaways

- Azure CLI and PowerShell are essential for operational and conditional automation that doesn't fit a declarative template.
- Effective CLI prompts include variable blocks, existence checks, error handling, and tag requirements.
- Copilot produces idiomatic output in both CLI and PowerShell; Not a mechanical translation of one to the other.
- Use the translation pattern ("Translate this CLI script to PowerShell, preserve all logic, don't add features") for reliable cross-tool conversion.
- Use CLI for operational and conditional tasks; use Bicep for managing long-lived infrastructure state.
