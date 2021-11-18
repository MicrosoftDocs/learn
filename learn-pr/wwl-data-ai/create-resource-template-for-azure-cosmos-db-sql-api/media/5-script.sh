az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json'

az deployment group create \
    --resource-group '<resource-group>' \
    --name '<deployment-name>' \
    --template-file '.\template.json'

az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json' \
    --parameters name='<value>'

az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json' \
    --parameters '@.\template.json'

az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.bicep'