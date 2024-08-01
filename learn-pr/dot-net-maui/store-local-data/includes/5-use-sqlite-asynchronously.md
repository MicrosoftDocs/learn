If you run queries on a database in a synchronous way, it can lead to performance problems and unresponsive apps. SQLite-net has an asynchronous API that you can use to keep your application responsive.

In this unit, you'll learn how to use the SQLite-net asynchronous API to ensure that your application remains highly responsive.

## Understand asynchronous queries

Up until this point, everything you've done has been executed on the UI thread. However, to build a highly responsive mobile application, you want to do things a little differently. If you run database operations on the UI thread, it might cause the UI to freeze if the operation takes a long time to complete.

To solve this problem, SQLite-net includes an asynchronous API through the `SQLiteAsyncConnection` class. For example, to create a table asynchronously, you could use the `CreateTableAsync` method:

```csharp
var conn = new SQLiteAsyncConnection(dbPath);
await conn.CreateTableAsync<User>();
```

## Perform async operations with SQLite-net

The `SQLiteAsyncConnection` class exposes similar operations as its synchronous counterpart. However, the operations are all task-based for background usage.

The common available asynchronous operations include:

- **`CreateTableAsync`**: Creates a table based on the indicated class

- **`DropTableAsync`**: Drops the table that correlates to the indicated class

- **`GetAsync`**: Gets the record in the table that correlates to the indicated class, and matches the primary key that's passed into the constructor

- **`InsertAsync`**: Inserts a new record by using the item that's passed into the constructor

- **`UpdateAsync`**: Updates an existing record by using the item that's passed into the constructor

- **`DeleteAsync`**: Deletes the record in the table that maps to the indicated class, and matches the primary key that's passed into the constructor

- **`QueryAsync`**: Runs a direct SQL query and returns an object

- **`ExecuteAsync`**: Runs a direct SQL query and returns the number of affected rows

- **`ExecuteScalarAsync`**: Runs a direct SQL query and returns the single result

- **`ToListAsync`**: Executes the Table method asynchronously

The following code shows an example of how to use the `ToListAsync` method to retrieve records asynchronously:

```csharp
SQLiteAsyncConnection conn;
ObservableCollection<User> userList;  // Bound to UI
...
public async Task AddAllUsersAsync()
{
    List<User> users = await conn.Table<User>().ToListAsync();
    // Must be on UI thread here!
    foreach (var u in users)
        userList.Add(u);
}
```

In this example, the `ToListAsync` method fetches all the users from the database asynchronously. If you use this method, your UI remains responsive even if there's a large set of users in the database.
