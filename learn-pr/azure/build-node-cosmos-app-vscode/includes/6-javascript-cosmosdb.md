In this unit, you'll learn how to use SQL keywords such as LIKE, JOIN, and WHERE to query data with the Cosmos SDK.

## Query operations on the container

Query operations are specific to the container. Because the query is executed on the container itself, it isn't necessary to use the correct name of the container, such as `products`. In the SDK reference documentation or portal, you may see the container name such as `root` or `c` to indicate the container. 

## Query for all documents

To find documents in a Cosmos DB Core (SQL) database's container, use the SDK **query** method on the container object, with a query specification. The query specification requires the `query` property and an option `parameters` property. 

|Property|Purpose|
|--|--|
|**query** (required)|The SQL query text. A simple query  is `select * from products`. |
|**parameters** (optional)|Variable substitution into the query. The name corresponds to the name used in the query, and the value is the actual substitution. You can provide up to 10 parameters.|

```javascript
const querySpecification = {
    query: `select * from products`,
    parameters: undefined
};
```

This query returns all documents in the container.  

## Query for documents by name using LIKE in a container

To refine the search but still provide some flexibility, use the LIKE keyword to allow for any matches on the document's property where the document's name property includes the value Blue. The name can start with Blue, end with Blue, or have Blue in the middle because the value is wrapped with the percent signs, `%`.

```javascript
// SQL Query specification
const querySpec = {
    // SQL query text using LIKE keyword and parameter
    query: `select * from products p where p.name LIKE @propertyValue`,
    // Optional SQL parameters, to be used in query
    parameters: [
        {
            // name of property to find in query text
            name: "@propertyValue",
            // value to insert in place of property
            value: `%Blue%`,
        }
    ]
};
```

Using the LIKE keyword

Execute the query on the container to fetch the documents. The query's results are fetched with `fetchAll` and returned in the destructured property, `resources`. 

```javascript
// Execute query
const { resources } = await container.items.query(querySpec).fetchAll();
```

It iterates over the entire collection, use the for/of loop. 

```javascript
let i = 0;

// Show results of query
for (const item of resources) {
    console.log(`${++i}: ${item.id}: ${item.name}, ${item.sku}`);
}
```

The output looks something like:

```text
1: 08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2: Touring-1000 Blue, 50, BK-T79U-50      
2: 2C981511-AC73-4A65-9DA3-A0577E386394: Touring-1000 Blue, 46, BK-T79U-46      
3: 44873725-7B3B-4B28-804D-963D2D62E761: Touring-1000 Blue, 60, BK-T79U-60      
4: 4E4B38CB-0D82-43E5-89AF-20270CD28A04: Touring-2000 Blue, 60, BK-T44U-60      
5: 5308BAE7-B0CB-4883-9A93-192CB10DC94F: Touring-3000 Blue, 44, BK-T18U-44 
```

## Query for documents by string property using LIKE in a container

To make the query more flexible, wrap it in a function that takes a document's property, and its value to find. 

```javascript
// Find all products that match a property with a value like `value`
async function executeSqlFind(property, value) {
  // Build query
  const querySpec = {
    query: `select * from products p where p.${property} LIKE @propertyValue`,
    parameters: [
      {
        name: "@propertyValue",
        value: `${value}`,
      },
    ],
  };

  // Show query
  console.log(querySpec);

  // Get results
  const { resources } = await container.items.query(querySpec).fetchAll();

  let i = 0;

  // Show results of query
  for (const item of resources) {
    console.log(`${++i}: ${item.id}: ${item.name}, ${item.sku}`);
  }
}
```

The property and value are passed into the function and used in the query for string values.

## Query for documents and return inventory subproperty using JOIN keyword in a container

The document shape includes two subproperties, tags and inventory. To access these subproperties, use the JOIN keyword. The following SQL query has been formatted for readability only and doesn't need to be used with the Cosmos DB SDK.

```sql
SELECT
    p.id, 
    p.name, 
    i.location, 
    i.inventory
FROM 
    products p 
JOIN 
    inventory i IN p.inventory 
WHERE 
    p.name LIKE '%Blue%'
AND 
    i.location='Dallas'
```

The inventory variable, `i`:

* Is named in the JOIN clause to access the subproperty data.
* Is used in the WHERE clause to reduce the dataset.
* Is used in the SELECT clause to return the inventory properties. 

To find all inventory for a specific property in a specific location, use the following function. It uses parameter substitution to provide a document's top-level property and the subproperty value to match for a location.

```javascript
async function executeSqlInventory(propertyName, propertyValue, locationPropertyName, locationPropertyValue) {
  // Build query
  const querySpec = {
    query: `select p.id, p.name, i.location, i.inventory from products p JOIN i IN p.inventory where p.${propertyName} LIKE @propertyValue AND i.${locationPropertyName}=@locationPropertyValue`,

    parameters: [
      {
        name: "@propertyValue",
        value: `${propertyValue}`,
      },
      { 
        name: "@locationPropertyValue", 
        value: `${locationPropertyValue}` },
    ],
  };

  // Show query
  console.log(querySpec);

  // Get results
  const { resources } = await container.items.query(querySpec).fetchAll();

  let i = 0;

  // Show results of query
  console.log(`Looking for ${propertyName}=${propertyValue}, ${locationPropertyName}=${locationPropertyValue}`);
  for (const item of resources) {
    console.log(
      `${++i}: ${item.id}: '${item.name}': current inventory = ${
        item.inventory
      }`
    );
  }
}
```

This function returns output like:

```
Looking for name=%Blue%, location=Dallas
1: 08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2: 'Touring-1000 Blue, 50': current inventory = 42
2: 2C981511-AC73-4A65-9DA3-A0577E386394: 'Touring-1000 Blue, 46': current inventory = 12
3: 44873725-7B3B-4B28-804D-963D2D62E761: 'Touring-1000 Blue, 60': current inventory = 83
4: 4E4B38CB-0D82-43E5-89AF-20270CD28A04: 'Touring-2000 Blue, 60': current inventory = 90
5: 5308BAE7-B0CB-4883-9A93-192CB10DC94F: 'Touring-3000 Blue, 44': current inventory = 97
```

## Upsert to insert or update data

Using an upsert helps you ensure your data is added if it doesn't exist, and updated if the data does exist. The JavaScript SDK returns **statusCode** which signifies which action was taken:

|Upsert statusCode|Meaning| 
|--|--|
|201|**Insert**|
|200|**Update**|

The following JavaScript uses a single function and the use of container.items().upsert(). 

```javascript
// Either insert or update item
async function upsert(item) {

  // Process request
  const result = await container.items.upsert(item);

  if(result.statusCode===201){
    console.log("Inserted data");
  } else if (result.statusCode===200){
    console.log("Updated data");
  } else {
    console.log(`unexpected statusCode ${result.statusCode}`);
  }
}
```
