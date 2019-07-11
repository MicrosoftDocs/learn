There are two query composition styles used with EF Core: Language-Integrated Query (**LINQ**) and **fluent**. [LINQ](https://docs.microsoft.com/dotnet/csharp/linq/) uses a declarative SQL-like query syntax. At compile time, the LINQ statements are translated into method calls for the .NET Common Language Runtime (CLR). Fluent uses method chaining and lambda expressions. Instructions for both styles have been provided. Select your preference using the toggle above.

A business requirement for the web API is to provide limited order information to protect customer privacy from unauthorized users. The details are as follows:

* The most recent orders should be shown first when retrieving all orders.
* The customer name should be formatted as *Last Name, First Name*.
* The dates should be formatted as short dates without timestamps.
* If an order has been fulfilled, the fulfillment date is displayed. Otherwise, no fulfillment date should be displayed.
* Each order's unique ID should be displayed.
* Each line item on the order should display the product name and the quantity.
* The client needs to retrieve individual orders by unique ID.

Your team decides to implement these requirements in the *:::no-loc text="ContosoPets.DataAccess":::* project.

1. In the *:::no-loc text="Services/OrderService.cs":::* file of the *:::no-loc text="ContosoPets.DataAccess":::* project, replace the comment `// Add the ContosoPets.Domain.Models using statement` with the following code. Save your changes.

    ```csharp
    using ContosoPets.Domain.Models;
    ```

1. In the same *:::no-loc text="OrderService.cs":::* file, replace the comment `// Add the constructor code` with the following code. Save your changes.

    ```csharp
    private readonly ContosoPetsContext _context;

    public OrderService(ContosoPetsContext context)
    {
        _context = context;
    }
    ```

    In the preceding code:

    * [Constructor injection](https://docs.microsoft.com/aspnet/core/mvc/controllers/dependency-injection#constructor-injection) provides an instance of `ContosoPetsContext` to the service.
    * A read-only field is defined. Don't confuse the C# `readonly` keyword with any read/write capabilities of `ContosoPetsContext`. See [readonly (C# Reference)](https://docs.microsoft.com/dotnet/csharp/language-reference/keywords/readonly#readonly-field-example).

1. Replace the comment `// Add the GetAll code` with the following code. Save your changes.

    ::: zone pivot="linq"

    ```csharp
    public async Task<List<CustomerOrder>> GetAll()
    {
        List<CustomerOrder> orders = await (
            from o in _context.Orders.AsNoTracking()
            orderby o.OrderPlaced descending
            select new CustomerOrder
            {
                OrderId = o.Id,
                CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
                OrderFulfilled = o.OrderFulfilled.HasValue ? 
                    o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
                OrderPlaced = o.OrderPlaced.ToShortDateString(),
                OrderLineItems = (from po in o.ProductOrders
                                  select new OrderLineItem
                                  {
                                      ProductQuantity = po.Quantity,
                                      ProductName = po.Product.Name
                                  })
            })
            .ToListAsync();

        return orders;
    }
    ```

    The preceding code retrieves a list of all orders. The following actions occur:

    * An asynchronous method returns a `Task<List<CustomerOrder>>`.
    * The target entity, `_context.Orders`, is referenced in the `from` clause.
    * Change tracking of entities is disabled, via `AsNoTracking`, to denote a read-only query to EF Core. The result is reduced overhead and improved performance.
    * The `select` clause projects the result set into a `CustomerOrder` object. This practice allows us to shape the result set to satisfy the business requirements. In some cases, it may be appropriate to use the domain model without projection, however. [See this tutorial for an example](https://docs.microsoft.com/aspnet/core/tutorials/razor-pages/).
    * The `orderby` clause sorts the result set in a descending manner, by the order placed date.
    * Each `CustomerOrder` object's `OrderLineItems` property in the result set is populated by a nested LINQ query.

    ::: zone-end

    ::: zone pivot="fluent"

    ```csharp
    public async Task<List<CustomerOrder>> GetAll()
    {
        List<CustomerOrder> orders = await (_context.Orders.AsNoTracking()
            .OrderByDescending(o => o.OrderPlaced)
            .Select(o => new CustomerOrder
            {
                OrderId = o.Id,
                CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
                OrderFulfilled = o.OrderFulfilled.HasValue ? 
                    o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
                OrderPlaced = o.OrderPlaced.ToShortDateString(),
                OrderLineItems = (o.ProductOrders.Select(po => new OrderLineItem
                {
                    ProductQuantity = po.Quantity,
                    ProductName = po.Product.Name
                }))
            })).ToListAsync();

        return orders;
    }
    ```

    The preceding code retrieves a list of all orders. The following actions occur:

    * An asynchronous method returns a `Task<List<CustomerOrder>>`.
    * The target entity, `_context.Orders`, represents all `Order` entities in the context.
    * Change tracking of entities is disabled, via `AsNoTracking`, to denote a read-only query to EF Core. The result is reduced overhead and improved performance.
    * The `OrderByDescending` method sorts the results in a descending manner, by the order placed date.
    * The `Select` method projects the result set into a `CustomerOrder` object. This practice allows us to shape the result set to satisfy the business requirements. In some cases, it may be appropriate to use the domain model without projection, however. [See this tutorial for an example](https://docs.microsoft.com/aspnet/core/tutorials/razor-pages/).
    * Each `CustomerOrder` object's `OrderLineItems` property in the result set is populated by a nested query.

    ::: zone-end

1. Replace the comment `// Add the GetById code` with the following code. Save your changes.

    ::: zone pivot="linq"

    ```csharp
    private IQueryable<Order> GetOrderById(int id) =>
        from o in _context.Orders.AsNoTracking()
        where o.Id == id
        select o;

    public async Task<CustomerOrder> GetById(int id)
    {
        CustomerOrder order = await (
            from o in GetOrderById(id)
            select new CustomerOrder
            {
                OrderId = o.Id,
                CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
                OrderFulfilled = o.OrderFulfilled.HasValue ? 
                    o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
                OrderPlaced = o.OrderPlaced.ToShortDateString(),
                OrderLineItems = (from po in o.ProductOrders
                                  select new OrderLineItem
                                  {
                                      ProductQuantity = po.Quantity,
                                      ProductName = po.Product.Name
                                  })
            })
            .FirstOrDefaultAsync();

        return order;
    }
    ```

    ::: zone-end

    ::: zone pivot="fluent"

    ```csharp
    private IQueryable<Order> GetOrderById(int id) =>
        _context.Orders.AsNoTracking().Where(o => o.Id == id);

    public async Task<CustomerOrder> GetById(int id)
    {
        CustomerOrder order = await GetOrderById(id)
            .Select(o => new CustomerOrder
            {
                OrderId = o.Id,
                CustomerName = $"{o.Customer.LastName}, {o.Customer.FirstName}",
                OrderFulfilled = o.OrderFulfilled.HasValue ? 
                    o.OrderFulfilled.Value.ToShortDateString() : string.Empty,
                OrderPlaced = o.OrderPlaced.ToShortDateString(),
                OrderLineItems = (o.ProductOrders.Select(po => new OrderLineItem
                {
                    ProductQuantity = po.Quantity,
                    ProductName = po.Product.Name
                }))
            }).FirstOrDefaultAsync();

        return order;
    }
    ```

    ::: zone-end

    The preceding code allows the client to retrieve an individual order by ID. The following actions occur:

    * A `GetOrderById` method defines how to retrieve an order by ID. The `IQueryable<T>` return type indicates the query's intent. Query execution is deferred.
    * A `GetById` method composes on top of the query defined in `GetOrderById`. The result set is projected into a `CustomerOrder` object. The query defined in `GetOrderById` is finally executed by the call to `FirstOrDefaultAsync`.

1. Replace the comment `// Add the Create code` with the following code. Save your changes.

    ```csharp
    public async Task<Order> Create(Order newOrder)
    {
        newOrder.OrderPlaced = DateTime.UtcNow;

        _context.Orders.Add(newOrder);
        await _context.SaveChangesAsync();

        return newOrder;
    }
    ```

    The preceding code adds an order to the database. The following actions occur:

    * Sets the order placed date to the current timestamp in UTC format.
    * Asynchronously saves the modified `Order` object to the database by calling `SaveChangesAsync`. The `Order` object modifications exist only in memory. When `SaveChangesAsync` is called, the in-memory object changes are persisted to the database. For most Database Providers, calling `SaveChanges` or `SaveChangesAsync` creates a database transaction. All operations within the transaction either succeed or fail as an atomic unit.
    * Returns the completed `Order` object as represented in the `Orders` table.

1. Replace the comment `// Add the SetFulfilled code` with the following code. Save your changes.

    ```csharp
    public async Task<bool> SetFulfilled(int id)
    {
        bool isFulfilled = false;
        Order order = await GetOrderById(id).FirstOrDefaultAsync();

        if (order != null)
        {
            order.OrderFulfilled = DateTime.UtcNow;
            _context.Entry(order).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            isFulfilled = true;
        }

        return isFulfilled;
    }
    ```

    The preceding code sets the timestamp at which an order was fulfilled. One of the following two actions occurs:

    * If the order is found, the `OrderFulfilled` property is set to the current UTC timestamp. The modified object is saved to the database, and a value of `true` is returned.
    * If the order isn't found, `false` is returned.

    > [!IMPORTANT]
    > When modifying an entity returned by a query with change tracking disabled, it is essential to explicitly set the entity state. Otherwise, a call to `SaveChanges` or `SaveChangesAsync` doesn't modify the underlying table data. In the preceding example, the `Order` entity is returned in a detached state. Removing the `AsNoTracking` call in the `GetOrderById` method's query would make explicitly setting the state unnecessary.

1. Replace the comment `// Add the Delete code` with the following code. Save your changes.

    ```csharp
    public async Task<bool> Delete(int id)
    {
        bool isDeleted = false;
        Order order = await GetOrderById(id).FirstOrDefaultAsync();

        if (order != null)
        {
            _context.Remove(order);
            await _context.SaveChangesAsync();
            isDeleted = true;
        }

        return isDeleted;
    }
    ```

    The preceding code attempts to delete the `Order` specified by the `id` parameter. One of the following two actions occurs:

    * If the order is found, the parent record in the `Orders` table and all children in `ProductOrders` are deleted from the database. A value of `true` is returned.
    * If order isn't found, `false` is returned.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]
