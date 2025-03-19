Authoring a template for an Azure Cosmos DB for NoSQL account is much like building one from scratch using the portal or from the CLI. There are three primary resources to define in a specific relationship order.

## Empty template

An Azure Resource Manager template is, at its core, a JSON file with a specific syntax you must follow. The default minimal empty template is a JSON document with a **schema** property set to ``https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#``, a **contentVersion** property set to ``1.0.0.0``, and an empty **resources** array. This example illustrates a minimal empty template.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
  ]
}
```

> [!NOTE]
> All resources we place in this template will be JSON objects within the **resources** array.

## Account resource

The first resource type to define is **Microsoft.DocumentDB/databaseAccounts**. This represents an account that is not specific to any API. If the API is not specified, it is inferred to be a NoSQL API account.

An object for this resource must contain, at a minimum, the following properties:

- name
- location
- properties.databaseAccountOfferType
- properties.locations[].locationName

Here is an example of an account that has a unique name with a prefix of **csmsarm** and is deployed to **West US**.

```json
{
  "type": "Microsoft.DocumentDB/databaseAccounts",
  "apiVersion": "2024-04-15",
  "name": "[concat('csmsarm', uniqueString(resourceGroup().id))]",
  "location": "[resourceGroup().location]",
  "properties": {
    "databaseAccountOfferType": "Standard",
    "locations": [
      {
        "locationName": "westus"
      }
    ]
  }
}
```

> [!NOTE]
> You can define more than one location using the locations array.

## Database resource

The next resource is of type **Microsoft.DocumentDB/databaseAccounts/sqlDatabases** and is a child resource of the account. This relationship is defined using the **dependsOn** property.

An object for this resource must contain, at a minimum, the following properties:

- name
- properties.resources.id

Here is an example of a database that is named **cosmicworks**.

```json
{
  "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases",
  "apiVersion": "2024-04-15",
  "name": "[concat('csmsarm', uniqueString(resourceGroup().id), '/cosmicworks')]",
  "dependsOn": [
    "[resourceId('Microsoft.DocumentDB/databaseAccounts', concat('csmsarm', uniqueString(resourceGroup().id)))]"
  ],
  "properties": {
    "resource": {
      "id": "cosmicworks"
    }
  }
}
```

## Container resource

Within a database, you can define multiple child **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** resources. Here, you can allocate throughput, configure indexing policy, and set a partition key path.

A container object must contain, at a minimum, the following properties:

- name
- properties.resource.id
- properties.resource.partitionkey.paths[]

A container can also optionally contain the following properties:

- properties.options.throughput
- properties.options.autoscaleSettings.maxThroughput
- properties.resource.indexingPolicy

Here is an example of a container that is named **products**, has **1000 RU/s** autoscale, and a partition key path of **/categoryId**.

```json
{
  "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers",
  "apiVersion": "2024-04-15",
  "name": "[concat('csmsarm', uniqueString(resourceGroup().id), '/cosmicworks/products')]",
  "dependsOn": [
    "[resourceId('Microsoft.DocumentDB/databaseAccounts', concat('csmsarm', uniqueString(resourceGroup().id)))]",
    "[resourceId('Microsoft.DocumentDB/databaseAccounts/sqlDatabases', concat('csmsarm', uniqueString(resourceGroup().id)), 'cosmicworks')]"
  ],
  "properties": {
    "resource": {
      "id": "products",
      "partitionKey": {
        "paths": [
          "/categoryId"
        ]
      }
    },
    "options": {
      "autoscaleSettings": {
        "maxThroughput": 1000
      }
    }
  }
}
```

> [!NOTE]
> Throughput is itself a child resource of a container and can be provisioned by creating a **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/throughputSettings** child resource of the container. However, it is less verbose to set throughput values using the `options` of the container properties. This is the recommended means for both creating and updating throughput for a container.

## Final template

Now that all resources are in place, the template file should now contain the following code.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.DocumentDB/databaseAccounts",
      "apiVersion": "2024-04-15",
      "name": "[concat('csmsarm', uniqueString(resourceGroup().id))]",
      "location": "[resourceGroup().location]",
      "properties": {
        "databaseAccountOfferType": "Standard",
        "locations": [
          {
            "locationName": "westus"
          }
        ]
      }
    },
    {
      "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases",
      "apiVersion": "2024-04-15",
      "name": "[concat('csmsarm', uniqueString(resourceGroup().id), '/cosmicworks')]",
      "dependsOn": [
        "[resourceId('Microsoft.DocumentDB/databaseAccounts', concat('csmsarm', uniqueString(resourceGroup().id)))]"
      ],
      "properties": {
        "resource": {
          "id": "cosmicworks"
        }
      }
    },
    {
      "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers",
      "apiVersion": "2021-05-15",
      "name": "[concat('csmsarm', uniqueString(resourceGroup().id), '/cosmicworks/products')]",
      "dependsOn": [
        "[resourceId('Microsoft.DocumentDB/databaseAccounts', concat('csmsarm', uniqueString(resourceGroup().id)))]",
        "[resourceId('Microsoft.DocumentDB/databaseAccounts/sqlDatabases', concat('csmsarm', uniqueString(resourceGroup().id)), 'cosmicworks')]"
      ],
      "properties": {
        "resource": {
          "id": "products",
          "partitionKey": {
            "paths": [
              "/categoryId"
            ]
          }
        },
        "options": {
          "autoscaleSettings": {
            "maxThroughput": 1000
          }
        }
      }
    }
  ]
}
```
