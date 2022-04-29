The **QueryRequestOptions** class is also helpful in measuring the cost of a query in request units per second (or RU/s).

To start, set the **MaxItemCount** property of the **QueryRequestOptions** class to the number of items you would like to return in each result page. Invoke the **GetItemQueryIterator\<\>** method passing in the SQL query and the options variable.

```csharp
QueryRequestOptions options = new()
{
    MaxItemCount = 25
};

FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);
```

Next, iterate over your results as usual with two minor changes:

1. Within each iteration of the while loop. Print the current RU/s charge for the result page to the console.
1. Aggregate all of the RU/s charges for each page of results, and then print the total RU/s consumed outside of the while loop.

```csharp
double totalRUs = 0;
while(iterator.HasMoreResults)
{
    FeedResponse<Product> response = await iterator.ReadNextAsync();
    foreach(Product product in response)
    {
        // Do something with each product
    }

    Console.WriteLine($"RUs:\t\t{response.RequestCharge:0.00}");

    totalRUs += response.RequestCharge;
}

Console.WriteLine($"Total RUs:\t{totalRUs:0.00}");
```

The console output should render a RU/s charge for each page of results and then a final RU/s charge that is an aggregate (sum) of all previous values.

```bash
RUs:            2.82
RUs:            2.82
RUs:            2.83
RUs:            2.84
RUs:            2.25
Total RUs:      13.56
```

> [!NOTE]
> This sample is using a ``SELECT * FROM products`` query against a demo database generated using the **cosmicworks** command-line tool.
