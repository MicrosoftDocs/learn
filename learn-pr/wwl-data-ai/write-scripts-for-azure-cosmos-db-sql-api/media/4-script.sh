az cosmosdb sql container throughput update \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --throughput '1000'

az cosmosdb sql database throughput update \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --name '<database-name>' \
    --throughput '4000'