az cosmosdb create \
    --name '<account-name>' \
    --resource-group '<resource-group>'

az cosmosdb create \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --default-consistency-level 'eventual' \
    --enable-free-tier 'true'

az cosmosdb create \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus'

az cosmosdb sql database create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --name '<database-name>' 

az cosmosdb sql container create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --throughput '400' \
    --partition-key-path '<partition-key-path-string>'