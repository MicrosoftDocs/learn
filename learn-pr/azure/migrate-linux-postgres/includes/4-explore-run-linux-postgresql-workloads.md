In this unit, you will:

- Deploy an Azure Blob Storage account by using a Bicep template.
- Create a Blob Storage container.
- Migrate images to the Blob Storage account.
- Upload `tailwind.sql` to the Blob Storage account.
- Connect to the Azure virtual machine by using the Azure CLI.
- Download the file from the storage account.
- Connect to the PostgreSQL server by using `psql` and import a SQL file.
- Run the application interactively via the command line.
- Confirm that the application runs correctly.

## Deploy a storage account by using deploy/vm-postgres.bicep

Run the following command on your local machine:

```bash
az deployment group create \
    --resource-group 240900-linux-postgres \
    --template-file deploy/vm-postgres.bicep \
    --parameters \
        deployVm=false \
        deployPostgres=false \
        deployStorage=true
```

## Add the current user to the Storage Blob Data Owner role

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

## Create a container called container1 in the storage account

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

## Migrate images to the storage account into a subfolder

```bash
az storage blob upload-batch \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --overwrite \
    --destination container1/images \
    --source app/data/images
```

The following output appears:

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

## Upload app/data/postgres/tailwind.sql to the storage account

```bash
az storage blob upload \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --container-name container1 \
    --file app/data/postgres/tailwind.sql \
    --name tailwind.sql
```

## Connect to the Azure virtual machine by using the az ssh command

```bash
az ssh vm \
    --resource-group 240900-linux-postgres \
    --name vm-1
```

## Download the tailwind.sql file from the storage account

Set the Bash variable `STORAGE_ACCOUNT_NAME` to the storage account name:

```bash
STORAGE_ACCOUNT_NAME=$(az storage account list \
    --resource-group 240900-linux-postgres \
    --query '[0].name' \
    -o tsv)

echo "STORAGE_ACCOUNT_NAME: $STORAGE_ACCOUNT_NAME"
```

Download `tailwind.sql` to the Azure virtual machine by using the `az storage blob download` command:

```bash
az storage blob download \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login \
    --container-name container1 \
    --file tailwind.sql \
    --name tailwind.sql
```

## Set the environment variables for psql on the remote machine

```bash
MANAGED_IDENTITY_NAME=240900-linux-postgres-identity
export AZURE_CLIENT_ID=$(az identity show --resource-group 240900-linux-postgres --name $MANAGED_IDENTITY_NAME --query "clientId" -o tsv)
PG_NAME=$(az postgres flexible-server list --resource-group 240900-linux-postgres --query "[0].name" -o tsv)

# Set psql environment variables
export PGHOST="${PG_NAME}.privatelink.postgres.database.azure.com"
export PGPASSWORD=$(curl -s "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fossrdbms-aad.database.windows.net&client_id=${AZURE_CLIENT_ID}" -H Metadata:true | jq -r .access_token)
export PGUSER=$MANAGED_IDENTITY_NAME
export PGDATABASE=postgres
```

## Import tailwind.sql by using psql

```bash
psql -f tailwind.sql
```

## Connect to the Postgres server to confirm that the import was successful

```bash
psql
```

## List the tables

```bash
\dt
```

The following output appears:

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

## Run a SQL query that lists the tables

```
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';
```

The following output appears:

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

## Turn on expanded mode and select from the products table

At the `postgres=>` prompt, turn on expanded mode:

```
\x
```

Select from the products table:

```
select * from products;
```

The following prompt appears:

```
postgres=> \x
Expanded display is on.
postgres=> select * from products;
```

A listing of products appears:

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

Select the Spacebar to page through the results. Enter `q` to exit the pager.

## Exit psql

```
\q
```

## Run the application interactively via the command line

On the remote machine, change to the directory that contains the application:

```bash
cd tailwind-traders-go/app
```

Run the application interactively from the command line:

```bash
go run main.go app:serve
```

The following output appears:

```
$ go run main.go app:serve
Listening on :8080
```

## Find the public IP address of the VM

Get the public IP address of the virtual machine:

```bash
IP_ADDRESS=$(az network public-ip show \
    --resource-group 240900-linux-postgres \
    --name vm-1-ip \
    --query ipAddress \
    --out tsv)
```

Output the URL to the terminal:

```bash
echo "Your URL is: http://${IP_ADDRESS}:8080"
```

This unit uses port 8080 for interactive dev/test purposes. In production, you would use port 443 and require a TLS certificate to help secure traffic to the endpoint.

## Browse the public API endpoint

Open the URL in a web browser. The following output appears:

```
{
  "id": 5,
  "product_type_id": 1,
  "supplier_id": 2,
  "sku": "drafting_tools",
  "name": "Bespoke Drafting Set",
  "price": 45,
  "description": "Build your next bridge (or tunnel) using our Bespoke Drafting Set. Everyone drives across *regular* bridges everyday - but they'll rememeber yours - because it's _bespoke_.",
  "image": "drafting_tools.jpg",
  "digital": false,
  "unit_description": "Tools and carrying case",
  "package_dimensions": "5x10x3",
  "weight_in_pounds": "1.2",
  "reorder_amount": 10,
  "status": "in-stock",
  "requires_shipping": true,
  "warehouse_location": "Zone 1, Shelf 4, Slot 1",
  "created_at": "...",
  "updated_at": "..."
}
```

Alternatively, you can make a request to the API endpoint by using `curl`:

```bash
curl "http://${IP_ADDRESS}:8080"
```

This endpoint displays a random product from the database.

## View requests logged to the terminal

Return to the terminal where you're running the application interactively. The output shows the request to the API endpoint:

```
{"time":"...","level":"INFO","msg":"httpLog","remoteAddr":"[::1]:58592","method":"GET","url":"/"}
{"time":"...","level":"INFO","msg":"httpLog","remoteAddr":"[::1]:59414","method":"GET","url":"/"}
{"time":"...","level":"INFO","msg":"httpLog","remoteAddr":"[::1]:59414","method":"GET","url":"/favicon.ico"}
```

If these requests are successful, you successfully migrated the application workload to an Azure virtual machine and Azure Database for PostgreSQL (Flexible Server).

## Clean up Azure resources

After you finish exploring the Linux and PostgreSQL workloads, clean up the resources to save costs.

You can delete the resource group `240900-linux-postgres` manually via the Azure portal, or run the following Azure CLI command:

```bash
az group delete \
    --name 240900-linux-postgres \
    --yes \
    --no-wait
```

Another option is to use the `empty.bicep` template to delete the resources that the `vm-postgres.bicep` file created. Running `az deployment group create` with `--mode Complete` removes any resources that the template doesn't define. Because `empty.json` has no resources, the command deletes every resource.

```bash
az deployment group create \
    --resource-group 240900-linux-postgres \
    --template-file deploy/empty.bicep \
    --mode Complete
```

Deploying `empty.json` leaves the `240900-linux-postgres` resource group intact, so you can deploy the resources again by using a single command.

## Resources

- [Azure Blob Storage documentation](/azure/storage/blobs/)
- [Azure RBAC documentation](/azure/role-based-access-control/overview)
