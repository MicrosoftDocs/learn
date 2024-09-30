## Introduction

In this module, you will:

- Deploy an Azure Blob Storage account using a Bicep template.
- Create a Blob Storage container and upload a file.
- Connect to the Azure Virtual Machine using the Azure CLI.
- Download the file from the storage account.
- Connect to the PostgreSQL server using `psql` and import a SQL file.
- Migrate images to the Azure Blob Storage account.
- Run the application interactively via the command line.
- Confirm the application runs correctly.

## Deploy a storage account using deploy/vm-postgres.bicep

```bash
az deployment group create \
    --resource-group 240900-linux-postgres \
    --template-file deploy/vm-postgres.bicep \
    --parameters \
        deployVm=false \
        deployPostgres=false \
        deployStorage=true
```

## Add the current user to the 'Storage Blob Data Owner' role

```bash
STORAGE_ACCOUNT_ID=$(az storage account list \
    --resource-group 240900-linux-postgres \
    --query '[0].id' \
    -o tsv)

USER_ID=$(az ad signed-in-user show \
    --query id \
    -o tsv)

az role assignment create \
    --role "Storage Blob Data Owner" \
    --assignee $USER_ID \
    --scope $STORAGE_ACCOUNT_ID
```

## Create a container called 'container1' in the storage account

```bash
STORAGE_ACCOUNT_NAME=$(az storage account list \
    --resource-group 240900-linux-postgres \
    --query '[0].name' \
    -o tsv)

echo "STORAGE_ACCOUNT_NAME: $STORAGE_ACCOUNT_NAME"

az storage container create \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --name container1
```

## Upload app/data/postgres/tailwind.sql to the storage account

```bash
az storage blob upload \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --container-name container1 \
    --file app/data/postgres/tailwind.sql \
    --name tailwind.sql
```

## Connect to azure virtual machine using the az ssh command

```bash
az ssh vm \
    --resource-group 240900-linux-postgres \
    --name vm-1
```

## Download the tailwind.sql file from the storage account

```bash
az storage blob download \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --container-name container1 \
    --file tailwind.sql \
    --name tailwind.sql
```

### Run the following commands on your local machine

```bash
MANAGED_IDENTITY_NAME=240900-linux-postgres-identity
export AZURE_CLIENT_ID=$(az identity show --resource-group 240900-linux-postgres --name $MANAGED_IDENTITY_NAME --query "clientId" -o tsv)
PG_NAME=$(az postgres flexible-server list --resource-group 240900-linux-postgres --query "[0].name" -o tsv)

# set psql environment variables
export PGHOST="${PG_NAME}.privatelink.postgres.database.azure.com"
export PGPASSWORD=$(curl -s "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fossrdbms-aad.database.windows.net&client_id=${AZURE_CLIENT_ID}" -H Metadata:true | jq -r .access_token)
export PGUSER=$MANAGED_IDENTITY_NAME
export PGDATABASE=postgres
```

## Import tailwind.sql using psql

```bash
psql -f tailwind.sql
```

## Connect to the postgres server to confirm our import was successful

```
psql
```

## List the tables
```bash
\dt
```

the output should be as follows:

```
postgres=> \dt
                           List of relations
 Schema |         Name         | Type  |             Owner              
--------+----------------------+-------+--------------------------------
 public | cart_items           | table | 240900-linux-postgres-identity
 public | checkouts            | table | 240900-linux-postgres-identity
 public | collections          | table | 240900-linux-postgres-identity
 public | collections_products | table | 240900-linux-postgres-identity
 public | customers            | table | 240900-linux-postgres-identity
 public | delivery_methods     | table | 240900-linux-postgres-identity
 public | product_types        | table | 240900-linux-postgres-identity
 public | products             | table | 240900-linux-postgres-identity
 public | shipment_items       | table | 240900-linux-postgres-identity
 public | shipments            | table | 240900-linux-postgres-identity
 public | store_inventory      | table | 240900-linux-postgres-identity
 public | stores               | table | 240900-linux-postgres-identity
 public | suppliers            | table | 240900-linux-postgres-identity
 public | supply_orders        | table | 240900-linux-postgres-identity
(14 rows)
```

## Run a sql query listing the tables
```
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';
```

output should be as follows:

```
postgres=> SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';
      table_name      
----------------------
 collections
 stores
 customers
 cart_items
 product_types
 products
 suppliers
 collections_products
 checkouts
 shipments
 delivery_methods
 shipment_items
 store_inventory
 supply_orders
(14 rows)
```

## Set expanded mode to on and select from the products table

```
postgres=> \x
Expanded display is on.
postgres=> select * from products;
```

You should see a listing of products:


```
id                 | 1
product_type_id    | 1
supplier_id        | 2
sku                | brush_cleaner
name               | Meltdown Brush Cleaner
price              | 12.99
description        | We all leave our brushes sitting around, full of old dry paint. Don't worry! The Meltdown Brush Cleaner can remove just about anything.
image              | brush_cleaner.jpg
digital            | f
unit_description   | 1 - 10oz Jar
package_dimensions | 4x8x2
weight_in_pounds   | 3.2
reorder_amount     | 10
status             | in-stock
requires_shipping  | t
warehouse_location | Zone 1, Shelf 12, Slot 6
created_at         | ...
updated_at         | ...
...
```

## Exit psql

```
\q
```

## Migrate images to the storage account into a subfolder images/

```bash
az storage blob upload-batch \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --overwrite \
    --destination container1/images \
    --source app/data/images
```

output should be as follows:

```
[
  {
    "Blob": "https://storageji2dbe.blob.core.windows.net/container1/images/wrench_set.jpg",
    "Last Modified": "...",
    "Type": "image/jpeg",
    "eTag": "\"0x8DCE0CA938AF41B\""
  },
  {
    "Blob": "https://storageji2dbe.blob.core.windows.net/container1/images/planer.jpg",
    "Last Modified": "...",
    "Type": "image/jpeg",
    "eTag": "\"0x8DCE0CA939DF18B\""
  },
  ...
]
```

## Run our application interactively via the command line

change to the directory that contains our application

```bash
cd tt-go/app/local
```

run the application interactively from the command line

```bash
go run main.go app:serve
```

## Resources
- [Azure Blob Storage Documentation](/azure/storage/blobs/)
- [Azure Role-Based Access Control (RBAC) Documentation](/azure/role-based-access-control/overview)
