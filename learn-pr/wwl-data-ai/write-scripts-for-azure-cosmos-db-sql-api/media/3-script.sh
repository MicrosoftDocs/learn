az cosmosdb sql container create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --partition-key-path '<partition-key-path-string>'
    --idx '@.\policy.json'
    --throughput '400'

az cosmosdb sql container create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --partition-key-path '<partition-key-path-string>'
    --idx '{\"indexingMode\":\"consistent\",\"automatic\":true,\"includedPaths\":[{\"path\":\"/*\"}],\"excludedPaths\":[{\"path\":\"/headquarters/*\"},{\"path\":\"/\\\"_etag\\\"/?\"}]}' 