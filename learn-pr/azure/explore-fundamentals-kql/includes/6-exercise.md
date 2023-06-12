You've learned about the structure and use of different types of query statements. Now, let's use that knowledge to write some queries.

## Query with tabular expression statements

Tabular expression statements are fundamental in KQL as they allow us to filter and manipulate tabular data to retrieve desired results.

Let's go through an example. Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

1. Start with a tabular dataset.

    ```Kusto
    StormEvents
    ```

    **Output:** The complete tabular dataset from the `StormEvents` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    ```kusto
    StormEvents
    | where EventType == "Flood"
    ```

    **Output**: A tabular dataset of the "Flood" events from the `StormEvents` table.

1. Use another operator to further manipulate the tabular output.

    ```kusto
    StormEvents
    | where EventType == "Flood"
    | sort by StartTime asc
    ```

    **Output:** A tabular dataset with the "Flood" events sorted in ascending order based on the `StartTime` column from the `StormEvents` table.

You can repeat the process by applying more operators to the tabular output.
Each operator takes the tabular input, performs its operation, and produces a new tabular output.

---

## Introduce a variable with a let statement

Let statements allow us to define variables in Kusto queries, making them more readable and modular.

Suppose you want to investigate Flood events within a specific time window and location. You can create variables to set and manipulate these parameters without modifying the query itself.

Let's go through an example. Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

```kusto
let state = "TEXAS";
let injuryThreshold = 10;
StormEvents
| where State == state and InjuriesDirect + InjuriesIndirect > injuryThreshold
```

In this example, `state` and `injuryThreshold` are variables that can be assigned values according to your specific requirements. These variables are then used within the query to filter the `StormEvents` table based on the defined criteria.

---

## Translate the query into a function

Now, let's explore how to generalize functionality into user-defined and stored functions.

Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

### Create a query-defined function

Query-defined functions are defined within the scope of a single query and can be reused within that query. 

```kusto
let EventsWithInjuries(state: string, injuryThreshold: int) {
    StormEvents
    | where State == state
    | where InjuriesDirect + InjuriesIndirect > injuryThreshold
}
print EventsWithInjuries("CALIFORNIA", 10);
```

In this query, we define a function called `EventsWithInjuries` with two parameters: `state` (string) and `injuryThreshold` (integer). The function filters the `StormEvents` table based on the provided state and injury threshold criteria. Finally, we call the function by passing specific arguments and print the results.

### Create a stored function

Alternatively, stored functions allow us to define reusable functions that can be saved and used across multiple queries without redefining them.

```kusto
.create function
with (docstring = 'Function to find all events with injuries above a certain threshold in a certain state', folder='Demo')
    EventsWithInjuries(state: string, injuryThreshold: int) {
        StormEvents
        | where State == state
        | where InjuriesDirect + InjuriesIndirect > injuryThreshold
    }
```

---
