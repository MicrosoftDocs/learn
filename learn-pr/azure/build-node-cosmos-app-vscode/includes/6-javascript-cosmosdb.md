In this unit, you'll learn how to use the JavaScript API for Azure Cosmos DB to query and upsert documents and containers.

## Query for documents by name using LIKE in a container

To find documents in a Cosmos DB Core (SQL) database's container, use the container's **query** with a query specification. 

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

Execute the query on the container to fetch the documents. The query's results are fetched with `fetchAll` and returned in the destructured property, `resources`. 

```javascript
// Execute query
const { resources } = await container.items.query(querySpec).fetchAll();
```

It iterate over the entire collection, use the for/of loop. 

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

Let's make query more flexible by wrapping it in a function take takes a document's property, and its value to find. This allows for partial matches to any string property. 

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

## Query for documents and return inventory subproperty using JOIN keyword in a container

Let's report on the inventory of products by using the JOIN keyword to access this subproperty of the product document.

The product shape has two subproperties, tags and inventory. To query and/or return subproperty values, use the JOIN keyword. The following SQL query has been formatted for readability only.

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
    p.${property} LIKE @propertyValue 
AND 
    i.location=@location
```