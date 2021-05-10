So far, the joins we've used have involved different tables. There may be scenarios in which you need to retrieve and compare rows from a table with other rows from the same table. For example, in a human resources application, an **Employee** table might include information about the manager of each employee, and store the manager's ID in the employee's own row. Each manager is also listed as an employee.

:::row:::
  :::column:::
    EmployeeID
  :::column-end:::
  :::column:::
    FirstName
  :::column-end:::
  :::column:::
    ManagerID
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Dan
  :::column-end:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    Aisha
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    Rosie
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    Naomi
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::


To retrieve the employee information and match it to the related manager, you can use the table twice in your query, joining it to itself for the purposes of the query.

```sql
SELECT emp.FirstName AS Employee, 
       mgr.FirstName AS Manager
FROM HR.Employee AS emp
LEFT OUTER JOIN HR.Employee AS mgr
  ON emp.ManagerID = mgr.EmployeeID;
```

The results of this query include a row for each employee with the name of their manager. The CEO of the company has no manager. To include the CEO in the results, an outer join is used, and the manager name is returned as NULL for rows where the **ManagerID** field has no matching **EmployeeID** field.

:::row:::
  :::column:::
    Employee
  :::column-end:::
  :::column:::
    Manager
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dan
  :::column-end:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Aisha
  :::column-end:::
  :::column:::
    Dan
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Rosie
  :::column-end:::
  :::column:::
    Dan
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Naomi
  :::column-end:::
  :::column:::
    Rosie
  :::column-end:::
:::row-end:::

There are other scenarios in which you'll want to compare rows in a table with different rows in the same table. As you've seen, it's fairly easy to compare columns in the same row using T-SQL, but the method to compare values from different rows (such as a row that stores a starting time, and another row in the same table that stores a corresponding stop time) is less obvious. Self-joins are a useful technique for these types of queries.

To accomplish tasks like this, you should consider the following guidelines:

 *  Define two instances of the same table in the FROM clause, and join them as needed, using inner or outer joins.
 *  Use table aliases to differentiate the two instances of the same table.
 *  Use the ON clause to provide a filter comparing columns of one instance of the table with columns from the other instance of the table.
