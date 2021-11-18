az cosmosdb create \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus'

az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus' failoverPriority=0 isZoneRedundant=False \
    --locations regionName='westus2' failoverPriority=1 isZoneRedundant=False \
    --locations regionName='centralus' failoverPriority=2 isZoneRedundant=False

az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --enable-automatic-failover 'true'

az cosmosdb failover-priority-change \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --failover-policies 'eastus=0' 'centralus=1' 'westus2=2'

az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --enable-multiple-write-locations 'true'

az cosmosdb update \
    --name '<account-name>' \
    --resource-group '<resource-group>' \
    --locations regionName='eastus' failoverPriority=0 isZoneRedundant=False \
    --locations regionName='westus2' failoverPriority=1 isZoneRedundant=False