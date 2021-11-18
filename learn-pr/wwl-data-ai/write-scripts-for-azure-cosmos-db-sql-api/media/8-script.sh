az cosmosdb failover-priority-change \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --failover-policies 'westus2=0' 'eastus=1'