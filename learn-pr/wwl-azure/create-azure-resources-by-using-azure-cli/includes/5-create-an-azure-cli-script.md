Just about every task you can complete in the **Azure portal**, you can complete using **Azure CLI** reference commands. Using the **Azure portal** to learn about **Azure** is a great place to begin. However, we recommend using **Azure CLI** or **Azure PowerShell** to manage **Azure resources** at scale.

Consider the scenario where you manage **Azure** for a worldwide corporation. You receive multiple requests daily for new **resource groups**, **Azure Logic Apps**, **storage accounts**, **Azure Data Factory pipelines**, and **Azure SQL databases**. All of your teams work in development, staging, and production environments. For every request, you need to create three similar **Azure resources** that follow your corporation's naming standards and security policies. It's time to use **Azure CLI** scripting!

## Understanding Azure CLI scripts

**Azure CLI** scripts enable automation of repetitive tasks and infrastructure deployment at scale. Scripts provide consistency, reduce human error, and enable Infrastructure as Code (IaC) practices. Whether managing development, staging, or production environments, **Azure CLI** scripting streamlines resource provisioning and management.

### Script structure basics

A well-structured **Azure CLI** script typically includes:

- **Shebang (`#!/bin/bash` or `#!/usr/bin/env bash`):** Specifies the interpreter for executing the script.
- **Variables:** Store reusable values like resource names, locations, and SKU configurations.
- **Comments:** Document script logic and parameters for maintainability.
- **Error handling:** Implement checks to handle failures gracefully.
- **Loops and conditionals:** Create multiple resources or apply logic based on conditions.
- **Output formatting:** Display results in readable formats for validation.

## Create a resource deployment script

Let's examine a practical **Bash** script that creates multiple **Azure storage accounts** in a consistent, repeatable manner.

```bash
#!/bin/bash

# Script: Create multiple Azure storage accounts
# Description: Automates storage account creation with consistent naming and configuration

# Define deployment parameters
resourceGroupName="rg-storage-prod-eastus"
saCount=3
saLocation="eastus"
saNamePrefix="stprod"
saSku="Standard_GRS"
saKind="StorageV2"

# Validate Azure CLI is installed and authenticated
if ! command -v az &> /dev/null; then
    echo "Error: Azure CLI is not installed. Please install Azure CLI first."
    exit 1
fi

if ! az account show &> /dev/null; then
    echo "Error: Not authenticated to Azure. Please run 'az login' first."
    exit 1
fi

echo "Starting storage account deployment..."
echo "Resource Group: $resourceGroupName"
echo "Location: $saLocation"
echo "Count: $saCount"
echo ""

# Create resource group if it doesn't exist
if ! az group show --name $resourceGroupName &> /dev/null; then
    echo "Creating resource group $resourceGroupName..."
    az group create --name $resourceGroupName --location $saLocation
else
    echo "Resource group $resourceGroupName already exists."
fi

# Loop to create multiple storage accounts
for i in $(seq 1 $saCount)
do
    # Generate unique identifier using timestamp and random number
    timestamp=$(date +%s)
    let "randomIdentifier=$RANDOM"
    saName="${saNamePrefix}${timestamp}${randomIdentifier}"

    # Ensure name is lowercase and within 24 character limit
    saName=$(echo $saName | tr '[:upper:]' '[:lower:]' | cut -c1-24)

    echo "Creating storage account $saName..."

    # Create storage account with error handling
    if az storage account create \
        --name $saName \
        --resource-group $resourceGroupName \
        --location $saLocation \
        --sku $saSku \
        --kind $saKind \
        --tags Environment=Production ManagedBy=AzureCLI \
        --output none; then
        echo "✓ Successfully created storage account $saName"
    else
        echo "✗ Failed to create storage account $saName"
    fi
done

echo ""
echo "Deployment complete. Verifying results..."
echo ""

# Verify results with formatted output
az storage account list \
    --resource-group $resourceGroupName \
    --query "[].{Name:name, Location:location, SKU:sku.name, Status:statusOfPrimary}" \
    --output table
```

### Script breakdown

Let's examine the key components:

**Authentication validation:**

```bash
if ! az account show &> /dev/null; then
    echo "Error: Not authenticated to Azure. Please run 'az login' first."
    exit 1
fi
```

Ensures the user is authenticated before executing resource operations, preventing script failures.

**Resource group creation with existence check:**

```bash
if ! az group show --name $resourceGroupName &> /dev/null; then
    az group create --name $resourceGroupName --location $saLocation
fi
```

Creates the resource group only if it doesn't already exist, making the script idempotent.

**Unique name generation:**

```bash
timestamp=$(date +%s)
let "randomIdentifier=$RANDOM"
saName="${saNamePrefix}${timestamp}${randomIdentifier}"
saName=$(echo $saName | tr '[:upper:]' '[:lower:]' | cut -c1-24)
```

Combines timestamp and random number to generate unique storage account names, converting to lowercase and limiting to 24 characters per Azure naming requirements.

**Error handling:**

```bash
if az storage account create ...; then
    echo "✓ Successfully created storage account $saName"
else
    echo "✗ Failed to create storage account $saName"
fi
```

Validates each storage account creation and provides clear success/failure feedback.

## Create a parameterized script

Production scripts should accept parameters for flexibility across environments:

```bash
#!/bin/bash

# Script: create-storage-accounts.sh
# Usage: ./create-storage-accounts.sh <resource-group> <location> <count> <environment>

# Accept command-line parameters
resourceGroupName=$1
saLocation=$2
saCount=$3
environment=$4

# Validate parameters
if [ -z "$resourceGroupName" ] || [ -z "$saLocation" ] || [ -z "$saCount" ] || [ -z "$environment" ]; then
    echo "Usage: $0 <resource-group> <location> <count> <environment>"
    echo "Example: $0 rg-storage-dev eastus 3 Development"
    exit 1
fi

# Validate count is a number
if ! [[ "$saCount" =~ ^[0-9]+$ ]]; then
    echo "Error: Count must be a number"
    exit 1
fi

echo "Parameters received:"
echo "  Resource Group: $resourceGroupName"
echo "  Location: $saLocation"
echo "  Count: $saCount"
echo "  Environment: $environment"
echo ""

# Set environment-specific configurations
case $environment in
    Development)
        saSku="Standard_LRS"
        saKind="StorageV2"
        ;;
    Staging)
        saSku="Standard_GRS"
        saKind="StorageV2"
        ;;
    Production)
        saSku="Standard_RAGRS"
        saKind="StorageV2"
        ;;
    *)
        echo "Error: Environment must be Development, Staging, or Production"
        exit 1
        ;;
esac

echo "Using SKU: $saSku for $environment environment"
echo ""

# Continue with resource creation...
```

### Execute the parameterized script

```bash
# Make script executable
chmod +x create-storage-accounts.sh

# Execute with parameters
./create-storage-accounts.sh rg-storage-dev eastus 3 Development
```

## Create a configuration-driven script

For complex deployments, use external configuration files:

**config.json:**

```json
{
  "resourceGroup": {
    "name": "rg-app-prod-eastus",
    "location": "eastus"
  },
  "storageAccounts": [
    {
      "namePrefix": "stappdata",
      "sku": "Standard_RAGRS",
      "kind": "StorageV2",
      "count": 2
    },
    {
      "namePrefix": "stappbackup",
      "sku": "Standard_GRS",
      "kind": "StorageV2",
      "count": 1
    }
  ],
  "tags": {
    "Environment": "Production",
    "CostCenter": "Engineering",
    "ManagedBy": "AzureCLI"
  }
}
```

**deploy-from-config.sh:**

```bash
#!/bin/bash

# Load configuration file
configFile="config.json"

if [ ! -f "$configFile" ]; then
    echo "Error: Configuration file $configFile not found"
    exit 1
fi

# Parse configuration using jq (JSON processor)
resourceGroupName=$(jq -r '.resourceGroup.name' $configFile)
resourceGroupLocation=$(jq -r '.resourceGroup.location' $configFile)
tagsJson=$(jq -r '.tags | to_entries | map("\(.key)=\(.value)") | join(" ")' $configFile)

echo "Deploying resources from configuration file..."
echo "Resource Group: $resourceGroupName"
echo "Location: $resourceGroupLocation"
echo ""

# Create resource group
az group create --name $resourceGroupName --location $resourceGroupLocation

# Read storage account configurations
storageConfigCount=$(jq '.storageAccounts | length' $configFile)

for i in $(seq 0 $(($storageConfigCount - 1)))
do
    namePrefix=$(jq -r ".storageAccounts[$i].namePrefix" $configFile)
    sku=$(jq -r ".storageAccounts[$i].sku" $configFile)
    kind=$(jq -r ".storageAccounts[$i].kind" $configFile)
    count=$(jq -r ".storageAccounts[$i].count" $configFile)

    echo "Creating $count storage account(s) with prefix: $namePrefix"

    for j in $(seq 1 $count)
    do
        timestamp=$(date +%s)
        saName="${namePrefix}${timestamp}${RANDOM}"
        saName=$(echo $saName | tr '[:upper:]' '[:lower:]' | cut -c1-24)

        az storage account create \
            --name $saName \
            --resource-group $resourceGroupName \
            --location $resourceGroupLocation \
            --sku $sku \
            --kind $kind \
            --tags $tagsJson \
            --output none

        echo "  ✓ Created: $saName"
    done
done

echo ""
echo "Deployment complete."
```

### Configuration-driven benefits

- **Separation of concerns:** Configuration separate from deployment logic.
- **Environment promotion:** Same script with different configuration files for dev, staging, production.
- **Version control:** Track configuration changes alongside code.
- **Validation:** Validate configuration structure before deployment.

## Delete Azure resources with scripts

When creating and testing scripts, remember to delete test resources to avoid unnecessary costs. **Azure CLI** scripting enables safe, consistent resource cleanup.

### Delete storage accounts by creation date

Delete all **storage accounts** created on or after a specific date and time:

```bash
#!/bin/bash

# Define cleanup parameters
cutoffDate="2025-10-08T00:00:00.000000+00:00"
resourceGroup="rg-storage-dev-eastus"

echo "Finding storage accounts created on or after $cutoffDate..."

# Get list of storage accounts matching criteria
saList=$(az storage account list \
    --resource-group $resourceGroup \
    --query "[?creationTime >='$cutoffDate'].{Name:name, Created:creationTime}" \
    --output table)

echo "$saList"
echo ""

# Confirm deletion
read -p "Delete these storage accounts? (yes/no): " confirm

if [ "$confirm" == "yes" ]; then
    for saId in $(az storage account list \
        --resource-group $resourceGroup \
        --query "[?creationTime >='$cutoffDate'].id" \
        --output tsv); do
        echo "Deleting storage account: $saId"
        az storage account delete --ids $saId --yes
    done
    echo "Cleanup complete."
else
    echo "Deletion cancelled."
fi
```

### Delete resource groups with logging

Delete **resource groups** matching a naming pattern with comprehensive logging:

```bash
#!/bin/bash

# Define cleanup parameters
namePattern="rg-dev-*"
logFileLocation="cleanup-$(date +%Y%m%d-%H%M%S).log"

echo "Resource Group Cleanup" > $logFileLocation
echo "Started: $(date)" >> $logFileLocation
echo "Pattern: $namePattern" >> $logFileLocation
echo "----------------------------------------" >> $logFileLocation

# Find matching resource groups
echo "Finding resource groups matching pattern: $namePattern"
matchingGroups=$(az group list \
    --query "[?starts_with(name, 'rg-dev-')].name" \
    --output tsv)

if [ -z "$matchingGroups" ]; then
    echo "No resource groups found matching pattern: $namePattern"
    echo "No resource groups found" >> $logFileLocation
    exit 0
fi

# Display matches
echo "Found resource groups:"
echo "$matchingGroups"
echo ""

# Log matches
echo "Resource groups found:" >> $logFileLocation
echo "$matchingGroups" >> $logFileLocation
echo "" >> $logFileLocation

# Confirm deletion
read -p "Delete these resource groups? (yes/no): " confirm

if [ "$confirm" == "yes" ]; then
    echo "Starting deletion..." >> $logFileLocation

    for rgName in $matchingGroups
    do
        echo "Deleting resource group: $rgName"
        echo "$(date): Deleting $rgName" >> $logFileLocation

        # Delete with --no-wait for background execution
        if az group delete --name $rgName --yes --no-wait; then
            echo "  ✓ Deletion initiated for $rgName"
            echo "$(date): ✓ Deletion initiated for $rgName" >> $logFileLocation
        else
            echo "  ✗ Failed to initiate deletion for $rgName"
            echo "$(date): ✗ Failed to delete $rgName" >> $logFileLocation
        fi
    done

    echo ""
    echo "Deletion operations initiated. Resources will be removed in the background."
    echo "Check deletion status with: az group list --query \"[?starts_with(name, 'rg-dev-')].name\""

    echo "" >> $logFileLocation
    echo "Completed: $(date)" >> $logFileLocation
    echo "Log saved to: $logFileLocation"

    # Display log
    echo ""
    echo "=== Cleanup Log ==="
    cat $logFileLocation
else
    echo "Deletion cancelled by user" >> $logFileLocation
    echo "Deletion cancelled."
fi
```

### Safe deletion practices

Implement safety checks before deletion:

```bash
#!/bin/bash

# Delete resources safely with multiple confirmations
resourceGroup="rg-storage-test-eastus"

# Check if resource group exists
if ! az group show --name $resourceGroup &> /dev/null; then
    echo "Error: Resource group '$resourceGroup' not found"
    exit 1
fi

# Display resources that will be deleted
echo "Resources in resource group '$resourceGroup':"
az resource list --resource-group $resourceGroup \
    --query "[].{Name:name, Type:type, Location:location}" \
    --output table

echo ""
echo "⚠️  WARNING: This will delete ALL resources in '$resourceGroup'"
echo ""

# First confirmation
read -p "Are you sure you want to delete '$resourceGroup'? (yes/no): " confirm1

if [ "$confirm1" != "yes" ]; then
    echo "Deletion cancelled."
    exit 0
fi

# Second confirmation with exact name
read -p "Type the resource group name to confirm: " confirm2

if [ "$confirm2" != "$resourceGroup" ]; then
    echo "Resource group name does not match. Deletion cancelled."
    exit 1
fi

# Final countdown
echo "Deleting in 5 seconds. Press Ctrl+C to cancel."
sleep 5

echo "Deleting resource group '$resourceGroup'..."
az group delete --name $resourceGroup --yes

echo "Resource group deleted successfully."
```

> [!WARNING]
> Always verify resources before deletion. Deleting a **resource group** permanently removes all resources inside it. This action cannot be undone.

## Best practices for production scripts

Production-ready **Azure CLI** scripts require careful planning and implementation. The scripts provided in this unit demonstrate fundamental concepts, but production environments demand additional considerations.

### Essential production script components

A robust **Azure CLI** script for production environments should include:

**1. Authentication and authorization:**

```bash
#!/bin/bash

# Authenticate with service principal (for automation)
if [ -n "$AZURE_CLIENT_ID" ] && [ -n "$AZURE_CLIENT_SECRET" ] && [ -n "$AZURE_TENANT_ID" ]; then
    echo "Authenticating with service principal..."
    az login --service-principal \
        --username $AZURE_CLIENT_ID \
        --password $AZURE_CLIENT_SECRET \
        --tenant $AZURE_TENANT_ID
else
    echo "Error: Service principal credentials not found"
    exit 1
fi

# Set subscription
az account set --subscription $AZURE_SUBSCRIPTION_ID

# Verify authentication
if ! az account show &> /dev/null; then
    echo "Error: Authentication failed"
    exit 1
fi
```

**2. Comprehensive error handling:**

```bash
#!/bin/bash

# Exit immediately if command fails
set -e

# Trap errors and perform cleanup
trap 'cleanup_on_error' ERR

cleanup_on_error() {
    echo "Error occurred on line $1"
    echo "Performing cleanup..."
    # Add cleanup logic here
    exit 1
}

# Enable error trapping with line numbers
trap 'cleanup_on_error $LINENO' ERR
```

**3. Idempotency checks:**

```bash
#!/bin/bash

# Check if resource group exists before creation
create_resource_group() {
    local rgName=$1
    local location=$2

    if az group show --name $rgName &> /dev/null; then
        echo "Resource group $rgName already exists. Skipping creation."
    else
        echo "Creating resource group $rgName..."
        az group create --name $rgName --location $location
    fi
}

# Check if storage account exists
create_storage_account() {
    local saName=$1
    local rgName=$2

    if az storage account show --name $saName --resource-group $rgName &> /dev/null; then
        echo "Storage account $saName already exists. Skipping creation."
        return 0
    else
        echo "Creating storage account $saName..."
        az storage account create --name $saName --resource-group $rgName --location eastus
    fi
}
```

**4. Structured logging:**

```bash
#!/bin/bash

# Define log file with timestamp
logFile="deployment-$(date +%Y%m%d-%H%M%S).log"
errorLog="errors-$(date +%Y%m%d-%H%M%S).log"

# Logging function
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    echo "[$timestamp] [$level] $message" | tee -a $logFile

    if [ "$level" == "ERROR" ]; then
        echo "[$timestamp] $message" >> $errorLog
    fi
}

# Usage
log "INFO" "Starting deployment..."
log "ERROR" "Failed to create resource"
log "SUCCESS" "Deployment complete"
```

**5. Configuration validation:**

```bash
#!/bin/bash

# Validate required configuration
validate_config() {
    local errors=0

    if [ -z "$RESOURCE_GROUP" ]; then
        echo "Error: RESOURCE_GROUP not defined"
        ((errors++))
    fi

    if [ -z "$LOCATION" ]; then
        echo "Error: LOCATION not defined"
        ((errors++))
    fi

    # Validate location exists
    if ! az account list-locations --query "[?name=='$LOCATION']" | grep -q "$LOCATION"; then
        echo "Error: Invalid location: $LOCATION"
        ((errors++))
    fi

    if [ $errors -gt 0 ]; then
        echo "Configuration validation failed with $errors error(s)"
        exit 1
    fi

    echo "Configuration validation passed"
}
```

**6. Tagging strategy:**

```bash
#!/bin/bash

# Define standard tags
environment=$1  # Development, Staging, Production
costCenter=$2
owner=$3

# Create tags string
tags="Environment=$environment CostCenter=$costCenter Owner=$owner \
      CreatedBy=AzureCLI CreatedDate=$(date +%Y-%m-%d) \
      ManagedBy=Infrastructure-Team Project=WebApp"

# Apply tags to resources
az group create \
    --name $resourceGroup \
    --location $location \
    --tags $tags

az storage account create \
    --name $saName \
    --resource-group $resourceGroup \
    --location $location \
    --tags $tags
```

**7. Rollback capability:**

```bash
#!/bin/bash

# Track created resources for rollback
createdResources=()

create_with_tracking() {
    local resourceType=$1
    local resourceName=$2

    # Attempt resource creation
    if create_resource "$resourceType" "$resourceName"; then
        createdResources+=("$resourceType:$resourceName")
        echo "✓ Created: $resourceType - $resourceName"
        return 0
    else
        echo "✗ Failed: $resourceType - $resourceName"
        return 1
    fi
}

rollback() {
    echo "Rolling back created resources..."

    for resource in "${createdResources[@]}"; do
        IFS=':' read -r type name <<< "$resource"
        echo "Deleting $type: $name"
        delete_resource "$type" "$name"
    done

    echo "Rollback complete"
}

# Use trap to rollback on error
trap rollback ERR
```

### Script organization structure

Organize scripts into logical modules:

```plaintext
azure-infrastructure/
├── config/
│   ├── dev.json
│   ├── staging.json
│   └── prod.json
├── scripts/
│   ├── deploy-infrastructure.sh
│   ├── deploy-storage.sh
│   └── cleanup.sh
├── lib/
│   ├── common-functions.sh
│   ├── logging.sh
│   └── validation.sh
├── logs/
└── README.md
```

### Reusable functions library

**common-functions.sh:**

```bash
#!/bin/bash

# Load this file in other scripts: source ./lib/common-functions.sh

# Check if Azure CLI is installed
check_azure_cli() {
    if ! command -v az &> /dev/null; then
        echo "Error: Azure CLI not installed"
        exit 1
    fi
}

# Wait for resource to be ready
wait_for_resource() {
    local resourceId=$1
    local maxAttempts=30
    local attempt=1

    echo "Waiting for resource to be ready..."

    while [ $attempt -le $maxAttempts ]; do
        if az resource show --ids $resourceId &> /dev/null; then
            echo "Resource is ready"
            return 0
        fi

        echo "Attempt $attempt/$maxAttempts - waiting..."
        sleep 10
        ((attempt++))
    done

    echo "Timeout waiting for resource"
    return 1
}

# Generate unique name
generate_unique_name() {
    local prefix=$1
    local timestamp=$(date +%s)
    local random=$RANDOM
    echo "${prefix}${timestamp}${random}" | tr '[:upper:]' '[:lower:]' | cut -c1-24
}
```

### Testing scripts safely

Test scripts in isolated environments:

```bash
#!/bin/bash

# Test mode flag
TEST_MODE=${TEST_MODE:-false}

execute_command() {
    local command=$1

    if [ "$TEST_MODE" == "true" ]; then
        echo "[TEST MODE] Would execute: $command"
    else
        echo "Executing: $command"
        eval $command
    fi
}

# Usage
execute_command "az group create --name rg-test --location eastus"
```

Run in test mode:

```bash
TEST_MODE=true ./deploy-infrastructure.sh
```

### Additional resources

- **Azure CLI samples repository:** [github.com/Azure-Samples/azure-cli-samples](https://github.com/Azure-Samples/azure-cli-samples).
- **Azure CLI scripting guide:** [learn.microsoft.com/cli/azure/azure-cli-vm-tutorial](/cli/azure/azure-cli-vm-tutorial).
- **Bash scripting best practices:** [www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/).

The scripts in this unit demonstrate **Azure CLI** capabilities when combining variables, loops, conditionals, and error handling with **Azure CLI** commands. These patterns scale from managing a few resources to orchestrating complex enterprise infrastructure deployments.
