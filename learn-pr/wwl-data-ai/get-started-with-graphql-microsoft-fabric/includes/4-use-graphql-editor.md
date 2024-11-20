---
ms.custom:
  - ignite-2024
---
You can access the editor by navigating to the API for GraphQL item in Fabric. Once there, look for the **Query** option located at the lower left corner of your portal screen and select it. This opens the editor, where you can start building and testing your GraphQL queries and mutations.

## Explore the query editor components 

The GraphQL API interface in Fabric provides a set of capabilities to facilitate your development process. It includes a schema explorer, a run panel, a query variables Panel, and a results panel.

:::image type="content" source="../media/4-editor.png" alt-text="Screenshot of the query editor for GraphQL in Microsoft Fabric." lightbox="../media/4-editor.png":::

1. **Schema explorer:** It allows users to quickly visualize the available types and fields, as well as queries and mutations defined in the API.
1. **Run panel:** It provides an interface to run the code and see the results in real-time. You can also test and debug your GraphQL operations.
1. **Query variables panel:** Use this panel to pass parameters as variables to your queries or mutations. Just like in any programming language, declare each variable with a name to access its value.
1. **Results panel:** This panel displays the output of your executed queries or mutations. It allows you to verify and analyze the results of your operations.

## Query data using the editor

You can retrieve data using queries like `productModels`. For example:

```jspn
query {
  productModels (filter: {Name: {eq: "Mountain-100"}}) {
    items {
      ProductModelID
      Name
      ModifiedDate
    }
  }
}
```

In this query, we're filtering the `productModels` to find items where the `Name` is equal to **Mountain-100**. The query returns the `ProductModelID`, `Name`, and `ModifiedDate` for the matching items.

When you execute this query, you receive the following result:

```json
{
  "data": {
    "productModels": {
      "items": [
        {
          "ProductModelID": 19,
          "Name": "Mountain-100",
          "rowguid": "fca0665b-b956-489a-a5ec-6f0b4aa14d02",
          "ModifiedDate": "2005-06-01T00:00:00.000Z"
        }
      ]
    }
  }
}
```

## Use mutations in the editor

Write data using mutations like `createProduct` to insert a product with the required data.

```json
mutation MyMutation {
  createProduct(name: "Mountain Bike", productNumber: "BK-M68B-38", color: "Black", standardCost: 500.00, listPrice: 800.00) {
    productID
    name
    productNumber
    color
    standardCost
    listPrice
  }
```

In this mutation, we're creating a new product with the name **Mountain Bike**, product number **BK-M68B-38**, color **Black**, standard cost **500.00**, and list price **800.00**. The mutation returns the `productID`, `name`, `productNumber`, `color`, `standardCost`, and `listPrice` of the newly created product.

When you execute this mutation, you receive the following result:

```json
{
  "data": {
    "createProduct": {
      "productID": "1234",
      "name": "Mountain Bike",
      "productNumber": "BK-M68B-38",
      "color": "Black",
      "standardCost": 500.00,
      "listPrice": 800.00
    }
  }
}
```

To learn more about other queries and mutation examples, see [Host GraphQL endpoints in Data API builder](/azure/data-api-builder/graphql?azure-portal=true).

## Connect to multiple data sources

One of the main benefits of GraphQL in Fabric is the ability to easily connect to and expose multiple data sources.

This means you can integrate various types of data, whether they come from SQL databases, warehouses, or other data storage systems, into a single, unified API. 

This flexibility allows developers to create more comprehensive and powerful applications by using diverse data sets without the need for complex data integration processes.

:::image type="content" source="../media/4-multiple-data-source.png" alt-text="Screenshot showing how to run a multi-data source query for GraphQL in Microsoft Fabric." lightbox="../media/4-multiple-data-source.png":::

In this example, data from two different sources is exposed. The results panel displays information from both tables.

## Connect an application to GraphQL API

To connect an application to a GraphQL API, you need the **Client ID**, **Tenant ID**, and the **GraphQL endpoint address** in Fabric. 

For example, imagine we create a GraphQL API to expose sample data from the `AdventureWorksLT` sample SQL Database in Fabric. To perform GraphQL API calls against Fabric, ensure that your [application is properly registered and configured](/rest/api/fabric/articles/get-started/create-entra-app?azure-portal=true).

Then, you can use the copy endpoint option from the API item's toolbar. This option allows you to easily copy the endpoint URI for later use in your application.

Additionally, you can automatically [generate code](/fabric/data-engineering/api-graphql-editor#generate-code) for your application by selecting **Generate code** from the API item's toolbar in the GraphQL designer. This capability is helpful to verify that the API calls are working as expected and that the data is being correctly retrieved and processed.

```python
from azure.identity import InteractiveBrowserCredential
import requests
import json

app = InteractiveBrowserCredential()
scp = 'https://analysis.windows.net/powerbi/api/user_impersonation'
result = app.get_token(scp)

if not result.token:
    print('Error:', "Could not get access token")

# Prepare headers
headers = {
    'Authorization': f'Bearer {result.token}',
    'Content-Type': 'application/json'
}

endpoint = 'https://00001111-aaaa-2222-bbbb-3333cccc4444.z55.dailygraphql.fabric.microsoft.com/v1/workspaces/a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1/graphqlapis/aaaaaaaa-bbbb-cccc-1111-222222222222/graphql'
query = """
    query {
  products {
    items {
      ProductID
      Name      
    }
  }
  salesOrderDetails {
    items {
      SalesOrderID
      OrderQty
      UnitPrice
    }
  }
}
"""

# Issue GraphQL request
try:
    response = requests.post(endpoint, json={'query': query}, headers=headers)
    response.raise_for_status()
    data = response.json()
    print(json.dumps(data, indent=4))
except Exception as error:
    print(f"Query failed with error: {error}")

```
