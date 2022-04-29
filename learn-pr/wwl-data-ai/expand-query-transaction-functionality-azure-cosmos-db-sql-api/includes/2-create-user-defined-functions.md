User-defined functions (UDFs) are used to extend the Azure Cosmos DB SQL API’s query language grammar and implement custom business logic. UDFs can only be called from inside queries as they enhance and extend the SQL query language.

> [!NOTE]
> UDFs do not have access to the context object and are meant to be used as compute-only code

Here is an example JSON document for a product with a **name** and a **price** property.

```javascript
{
  "name": "Black Bib Shorts (Small)",
  "price": 80.00
}
```

A simple SQL query to get the data from a container with many items like this one, would be constructed to include both fields.

```sql
SELECT 
    p.name,
    p.price
FROM
    products p
```

UDFs extend the SQL query language by giving you small areas where you can inject simple business logic into a query. Let's take this example, and create a user-defined function to apply business tax. In our example scenario, we want to apply a 15% tax and end up with an ideal result set that includes a third **priceWithTax** property.

```json
[
  {
    "name": "Black Bib Shorts (Small)",
    "price": 80.00,
    "priceWithTax": 92.00
  }
]
```

A user-defined function is defined as a JavaScript function that takes in one or more scalar input\[s\] and then returns a scalar value as the output.

```javascript
function name(input) {
    return output;
}
```

In this example function, the scalar input is assumed to be a number that is then multipled by **1.15** to add 15% tax.

```javascript
function addTax(preTax) {
    return preTax * 1.15;
}
```

The updated query includes a third projected field that references the udf function by using the ``udf.addTax()`` syntax passing in the **p.price** field as an input parameter and aliasing the output of that field to the name **priceWithTax**.

```sql
SELECT 
    p.name,
    p.price,
    udf.addTax(p.price) AS priceWithTax
FROM
    products p
```
