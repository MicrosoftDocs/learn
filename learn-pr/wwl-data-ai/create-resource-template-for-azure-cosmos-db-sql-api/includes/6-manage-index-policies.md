It is common to define an indexing policy as part of deploying an Azure Cosmos DB account and its resources in an automated manner. Both the JSON and Bicep syntax for Azure Resource Manager templates supports defining indexing policies natively. However, the syntax can be tricky if you haven't tried it before.

For the examples in this unit, let's assume that we want to deploy the following indexing policy to our **pro

## Defining an indexing policy in JSON templates

Let's assume that we want to deploy the following indexing policy to our **products** container in our account.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/price/*"
    }
  ],
  "excludedPaths": [
    {
      "path": "/*"
    }
  ]
}
```

The **indexingPolicy** object can be lifted with no changes and set to the **properties.resource.indexingPolicy** property of the **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers**.

```json
{
  "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers",
  "apiVersion": "2021-05-15",
  "name": "[concat('csmsarm', uniqueString(resourceGroup().id), '/cosmicworks/products')]",
  "dependsOn": [
    "[resourceId('Microsoft.DocumentDB/databaseAccounts', concat('csmsarm', uniqueString(resourceGroup().id)))]",
    "[resourceId('Microsoft.DocumentDB/databaseAccounts/sqlDatabases', concat('csmsarm', uniqueString(resourceGroup().id)), 'cosmicworks')]"
  ],
  "properties": {
    "options": {
      "throughput": 400
    },
    "resource": {
      "id": "products",
      "partitionKey": {
        "paths": [
          "/categoryId"
        ]
      },
      "indexingPolicy": {
        "indexingMode": "consistent",
        "automatic": true,
        "includedPaths": [
          {
            "path": "/price/*"
          }
        ],
        "excludedPaths": [
          {
            "path": "/*"
          }
        ]
      }
    }
  }
}
```

## Defining an indexing policy in Bicep templates

Let's assume that we want to deploy the following indexing policy to our **customers** container in our account.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/address/*"
    }
  ],
  "excludedPaths": [
    {
      "path": "/*"
    }
  ]
}
```

A few small changes are required to use this indexing policy in Bicep. These changes include:

- Removing the double quotation from property names
- Changing property values from single quotes to double quotes
- Removing commas typically required in JSON

```bicep
resource Container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-05-15' = {
  parent: Database
  name: 'customers'
  properties: {
    resource: {
      id: 'customers'
      partitionKey: {
        paths: [
          '/regionId'
        ]
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/address/*'
          }
        ]
        excludedPaths: [
          {
            path: '/*'
          }
        ]
      }
    }
  }
}
```

## Updating an indexing policy on an existing container

If a resource of type **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** already exists, and all other properties match, you can update the indexing policy by solely changing the values within the **properties.resource.indexingPolicy** property. Azure Resource Manager will only change the indexing policy while keeping the rest of the container intact.

The command for deployment is the same as the initial deployment.

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json' \
    --name 'jsontemplatedeploy'
```

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.bicep' \
    --name 'biceptemplatedeploy'
```
