In this unit, you will execute queries against the graph database using the .NET Core application that you created in an earlier unit.

## Modify the application to return detailed results

::: zone pivot="csharp"

1. Add an additional package to your app for JSON parsing.

   ```bash
   dotnet add package Newtonsoft.Json
   dotnet restore
   ```

1. Open your app in the online code editor.

   ```bash
   code .
   ```

1. Open your Program.cs file in the editor, and add the following statement to the list of `using` statements.

   ```csharp
   using Newtonsoft.Json;
   ```

1. Modify `Main()` method by inserting the following lines of code on the line after the `Console.WriteLine("\n{{\"Returned\": \"{0}\"}}", resultSet.Result.Count);`. This code will serialize the JSON returned from the queries and add it to the output.

   ```csharp
   foreach (var result in resultSet.Result)
   {
      string jsonOutput = JsonConvert.SerializeObject(result);
      Console.WriteLine("{0}",jsonOutput);
   }
   ```

1. To save your changes, press **Ctrl-S** to save the file, and then press **Ctrl-Q** to exit the editor.

::: zone-end

::: zone pivot="javascript"

1. Open your app in the online code editor.

   ```bash
   code .
   ```

1. Open your app.js file in the editor and insert the following code after ``console.log(`{"Returned": "${result.length}"}`);``. This code will serialize the JSON returned from the queries and add it to the output.

   ```javascript
   for (const item of result._items) {
     console.log(JSON.stringify(item));
   }
   ```

1. To save your changes, press **Ctrl-S** to save the file, and then press **Ctrl-Q** to exit the editor.

::: zone-end

## Run detailed queries with your app

Now that your app has been updated to display detailed information, try out the following queries to retrieve detailed results from your graph.

::: zone pivot="csharp"

### Return all vertices/nodes from your graph

To retrieve all the vertices/nodes in your graph, run the following command:

```bash
dotnet run "g.V()"
```

Your app should display a message indicating the number of vertices/nodes in your graph, together with all of the information for your vertices/nodes; for example:

```json
{"Returned": "5"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"5d93bfcf-f74c-4fba-81d9-a003964db00d","value":12.99}]}}
{"id":"p2","label":"Product","type":"vertex","properties":{"name":[{"id":"af52b5d4-2723-43c9-a8e9-4ac8478302e9","value":"USB C Cable Charger"}],"price":[{"id":"bb6f1b92-f33d-4a0b-b746-ae7c23f4de9a","value":8.99}]}}
{"id":"p3","label":"Product","type":"vertex","properties":{"name":[{"id":"efbb537b-51f1-4ed0-bc1e-8bd099c06a60","value":"Gardening Gloves"}],"price":[{"id":"be8debaa-c926-4428-acc8-ca328ced926e","value":2.99}]}}
{"id":"c1","label":"Category","type":"vertex","properties":{"name":[{"id":"9f3712d4-ed99-4fc6-b50d-bfe7659ca4fe","value":"Mobile Phones"}]}}
{"id":"c2","label":"Category","type":"vertex","properties":{"name":[{"id":"b9de2a42-d50d-4d1e-bc8e-a88ef9606c69","value":"Gardening"}]}}
```

### Return all edges/relationships from your graph

To retrieve all the edges/relationships in your graph, run the following command:

```bash
dotnet run "g.E()"
```

Your app should display a message indicating the number of edges/relationships in your graph, together with all of the information for your edges/relationships; for example:

```json
{"Returned": "3"}
{"id":"f7a7b8c4-57fb-4960-b1e5-3fe9f4089654","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c1","outV":"p1"}
{"id":"c3e03938-552d-4004-b307-a284149fea91","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c1","outV":"p2"}
{"id":"7d80c7b0-e2d2-46d0-844d-bff7fd60bdd0","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c2","outV":"p3"}
```

### Count the number of vertices/nodes or edges/relationships in the graph

To count the vertices/nodes in your graph, run the following command:

```bash
dotnet run "g.V().count()"
```

Your app should display a message indicating that one item was returned, (the count itself), followed by the number of vertices/nodes in your graph; for example:

```json
{"Returned": "1"}
5
```

Similar to the above example, to count the edges/relationships in your graph, run the following command:

```bash
dotnet run "g.E().count()"
```

Your app should display a message indicating that one item was returned, (the count itself), followed by the number of edges/relationships in your graph; for example:

```json
{"Returned": "1"}
3
```

### Applying filters to queries

You can perform filters using Gremlin's `has` and `hasLabel` steps. You can also combine them using `and`, `or`, and `not` to build more complex filters. Azure Cosmos DB provides schema-agnostic indexing of all properties within your vertices and degrees for fast queries.

First, let's display all of the vertices/nodes in your graph with a particular label:

```bash
dotnet run "g.V().hasLabel('Category')"
```

Your app should display a message indicating the number of vertices/nodes in your graph with *Category* as a label, followed by the detailed vertices/nodes; for example:

```json
{"Returned": "2"}
{"id":"c1","label":"Category","type":"vertex","properties":{"name":[{"id":"9f3712d4-ed99-4fc6-b50d-bfe7659ca4fe","value":"Mobile Phones"}]}}
{"id":"c2","label":"Category","type":"vertex","properties":{"name":[{"id":"b9de2a42-d50d-4d1e-bc8e-a88ef9606c69","value":"Gardening"}]}}
```

Next, Let's filter results for a particular label with a specific property:

```bash
dotnet run "g.V().hasLabel('Product').has('id','p1')"
```

Your app should display a message indicating the number of vertices/nodes in your graph with *Product* as a label and a *name* property of *p1*, followed by the detailed vertice/node; for example:

```json
{"Returned": "1"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"5d93bfcf-f74c-4fba-81d9-a003964db00d","value":12.99}]}}
```

### Projection from your query results

You can project specific properties in your query results by specifying which value to return; for example:

```bash
dotnet run "g.V().hasLabel('Category').values('name')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "2"}
"Mobile Phones"
"Gardening"
```

You can project multiple properties in your query results by specifying a list of values to return; for example:

```bash
dotnet run "g.V().hasLabel('Product').values('name','price')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "6"}
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
"Gardening Gloves"
2.99
```

## Sorting queries

To return a list of products sorted by name in ascending order, use the following command:

```bash
dotnet run "g.V().hasLabel('Product').order().by('name', incr).values('name','price')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "6"}
"Gardening Gloves"
2.99
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
```

To return a list of products sorted by price in descending order, use the following command:

```bash
dotnet run "g.V().hasLabel('Product').order().by('price', decr).values('name','price')"
```

Your app should display a list of results like the following example:

```json
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
"Gardening Gloves"
2.99
```

### Update properties of vertices

You can update the properties of a specific vertice/node by applying a filter and then assigning the property a new value; for example

```bash
dotnet run "g.V('p1').property('price', 15.99)"
```

Your app should display a list of results like the following example:

```json
{"Returned": "1"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"05184a58-d0d9-4866-9539-511389ca355c","value":15.99}]}}
```

::: zone-end

::: zone pivot="javascript"

### Return all vertices/nodes from your graph

To retrieve all the vertices/nodes in your graph, run the following command:

```bash
cd gremlinapp
node app.js "g.V()"
```

Your app should display a message indicating the number of vertices/nodes in your graph, together with all of the information for your vertices/nodes; for example:

```json
{"Returned": "5"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"5d93bfcf-f74c-4fba-81d9-a003964db00d","value":12.99}]}}
{"id":"p2","label":"Product","type":"vertex","properties":{"name":[{"id":"af52b5d4-2723-43c9-a8e9-4ac8478302e9","value":"USB C Cable Charger"}],"price":[{"id":"bb6f1b92-f33d-4a0b-b746-ae7c23f4de9a","value":8.99}]}}
{"id":"p3","label":"Product","type":"vertex","properties":{"name":[{"id":"efbb537b-51f1-4ed0-bc1e-8bd099c06a60","value":"Gardening Gloves"}],"price":[{"id":"be8debaa-c926-4428-acc8-ca328ced926e","value":2.99}]}}
{"id":"c1","label":"Category","type":"vertex","properties":{"name":[{"id":"9f3712d4-ed99-4fc6-b50d-bfe7659ca4fe","value":"Mobile Phones"}]}}
{"id":"c2","label":"Category","type":"vertex","properties":{"name":[{"id":"b9de2a42-d50d-4d1e-bc8e-a88ef9606c69","value":"Gardening"}]}}
```

### Return all edges/relationships from your graph

To retrieve all the edges/relationships in your graph, run the following command:

```bash
node app.js "g.E()"
```

Your app should display a message indicating the number of edges/relationships in your graph, together with all of the information for your edges/relationships; for example:

```json
{"Returned": "3"}
{"id":"f7a7b8c4-57fb-4960-b1e5-3fe9f4089654","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c1","outV":"p1"}
{"id":"c3e03938-552d-4004-b307-a284149fea91","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c1","outV":"p2"}
{"id":"7d80c7b0-e2d2-46d0-844d-bff7fd60bdd0","label":"belongsto","type":"edge","inVLabel":"Category","outVLabel":"Product","inV":"c2","outV":"p3"}
```

### Count the number of vertices/nodes or edges/relationships in the graph

To count the vertices/nodes in your graph, run the following command:

```bash
node app.js "g.V().count()"
```

Your app should display a message indicating that one item was returned, (the count itself), followed by the number of vertices/nodes in your graph; for example:

```json
{"Returned": "1"}
5
```

Similar to the above example, to count the edges/relationships in your graph, run the following command:

```bash
node app.js "g.E().count()"
```

Your app should display a message indicating that one item was returned, (the count itself), followed by the number of edges/relationships in your graph; for example:

```json
{"Returned": "1"}
3
```

### Applying filters to queries

You can perform filters using Gremlin's `has` and `hasLabel` steps. You can also combine them using `and`, `or`, and `not` to build more complex filters. Azure Cosmos DB provides schema-agnostic indexing of all properties within your vertices and degrees for fast queries.

First, let's display all of the vertices/nodes in your graph with a particular label:

```bash
node app.js "g.V().hasLabel('Category')"
```

Your app should display a message indicating the number of vertices/nodes in your graph with *Category* as a label, followed by the detailed vertices/nodes; for example:

```json
{"Returned": "2"}
{"id":"c1","label":"Category","type":"vertex","properties":{"name":[{"id":"9f3712d4-ed99-4fc6-b50d-bfe7659ca4fe","value":"Mobile Phones"}]}}
{"id":"c2","label":"Category","type":"vertex","properties":{"name":[{"id":"b9de2a42-d50d-4d1e-bc8e-a88ef9606c69","value":"Gardening"}]}}
```

Next, Let's filter results for a particular label with a specific property:

```bash
node app.js "g.V().hasLabel('Product').has('id','p1')"
```

Your app should display a message indicating the number of vertices/nodes in your graph with *Product* as a label and a *name* property of *p1*, followed by the detailed vertice/node; for example:

```json
{"Returned": "1"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"5d93bfcf-f74c-4fba-81d9-a003964db00d","value":12.99}]}}
```

### Projection from your query results

You can project specific properties in your query results by specifying which value to return; for example:

```bash
node app.js "g.V().hasLabel('Category').values('name')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "2"}
"Mobile Phones"
"Gardening"
```

You can project multiple properties in your query results by specifying a list of values to return; for example:

```bash
node app.js "g.V().hasLabel('Product').values('name','price')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "6"}
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
"Gardening Gloves"
2.99
```

## Sorting queries

To return a list of products sorted by name in ascending order, use the following command:

```bash
node app.js "g.V().hasLabel('Product').order().by('name', incr).values('name','price')"
```

Your app should display a list of results like the following example:

```json
{"Returned": "6"}
"Gardening Gloves"
2.99
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
```

To return a list of products sorted by price in descending order, use the following command:

```bash
node app.js "g.V().hasLabel('Product').order().by('price', decr).values('name','price')"
```

Your app should display a list of results like the following example:

```json
"Phone Charger"
12.99
"USB C Cable Charger"
8.99
"Gardening Gloves"
2.99
```

### Update properties of vertices

You can update the properties of a specific vertice/node by applying a filter and then assigning the property a new value; for example

```bash
node app.js "g.V('p1').property('price', 15.99)"
```

Your app should display a list of results like the following example:

```json
{"Returned": "1"}
{"id":"p1","label":"Product","type":"vertex","properties":{"name":[{"id":"7f10b6bb-0a8a-4cf2-b2ac-8d8e4888c007","value":"Phone Charger"}],"price":[{"id":"05184a58-d0d9-4866-9539-511389ca355c","value":15.99}]}}
```

::: zone-end