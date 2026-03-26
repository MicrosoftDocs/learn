Beyond simple table mappings, Data API Builder can expose views and stored procedures as API endpoints. These database objects let you encapsulate complex business logic, aggregate data from multiple tables, or implement operations that go beyond standard CRUD patterns.

Views provide read-only access to computed or joined data, while stored procedures enable custom operations with input parameters and multiple result sets. GraphQL relationships add another dimension, allowing clients to traverse connections between entities in single queries.

## Expose views as read-only entities

Database views aggregate and transform data without duplicating storage. When you expose a view through Data API Builder, clients access the computed results through familiar REST and GraphQL patterns.

Consider a view that combines product information with inventory status:

```sql
CREATE VIEW dbo.ProductInventory AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    p.UnitsInStock,
    c.CategoryName,
    CASE 
        WHEN p.UnitsInStock = 0 THEN 'Out of Stock'
        WHEN p.UnitsInStock < 10 THEN 'Low Stock'
        ELSE 'Available'
    END AS StockStatus
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryID = c.CategoryID;
```

Expose this view in your configuration:

```json
"ProductInventory": {
  "source": {
    "object": "dbo.ProductInventory",
    "type": "view",
    "key-fields": ["ProductID"]
  },
  "rest": {
    "enabled": true,
    "path": "/inventory"
  },
  "graphql": {
    "enabled": true,
    "operation": "query"
  },
  "permissions": [
    {
      "role": "anonymous",
      "actions": ["read"]
    }
  ]
}
```

The `key-fields` property is required for views because DAB can't automatically detect primary keys. Specify the columns that uniquely identify each row.

Setting `operation` to `query` in the GraphQL section indicates this entity supports only read operations. DAB won't generate mutations for this entity.

> [!NOTE]
> Views can be updatable in SQL Server if they meet certain criteria. However, exposing updatable views through DAB requires careful consideration of the underlying table permissions and constraints.

## Configure stored procedures for custom operations

[Stored procedures](/azure/data-api-builder/stored-procedures?azure-portal=true) provide the most flexibility for custom database operations. They can accept parameters, perform complex logic, and return multiple result sets.

```sql
CREATE PROCEDURE dbo.GetProductsByPriceRange
    @MinPrice DECIMAL(10,2),
    @MaxPrice DECIMAL(10,2)
AS
BEGIN
    SELECT ProductID, ProductName, UnitPrice, UnitsInStock
    FROM dbo.Products
    WHERE UnitPrice BETWEEN @MinPrice AND @MaxPrice
    ORDER BY UnitPrice;
END;
```

Configure the stored procedure as an entity:

```json
"GetProductsByPriceRange": {
  "source": {
    "object": "dbo.GetProductsByPriceRange",
    "type": "stored-procedure",
    "parameters": {
      "MinPrice": "minPrice",
      "MaxPrice": "maxPrice"
    }
  },
  "rest": {
    "enabled": true,
    "path": "/products/by-price-range",
    "methods": {
      "get": true,
      "post": true
    }
  },
  "graphql": {
    "enabled": true,
    "operation": "query"
  },
  "permissions": [
    {
      "role": "authenticated",
      "actions": ["execute"]
    }
  ]
}
```

The `parameters` object maps stored procedure parameters to API parameter names. REST clients call the procedure using query parameters or request body:

```http
GET /api/products/by-price-range?minPrice=10&maxPrice=50
```

```http
POST /api/products/by-price-range
Content-Type: application/json

{
  "minPrice": 10,
  "maxPrice": 50
}
```

GraphQL clients use the procedure through a generated query:

```graphql
query {
  executeGetProductsByPriceRange(minPrice: 10, maxPrice: 50) {
    ProductID
    ProductName
    UnitPrice
  }
}
```

## Expose stored procedures that modify data

For stored procedures that insert, update, or delete data, configure them with mutation operations:

```sql
CREATE PROCEDURE dbo.CreateOrder
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    DECLARE @OrderID INT;
    
    INSERT INTO dbo.Orders (CustomerID, OrderDate, Status)
    VALUES (@CustomerID, GETDATE(), 'Pending');
    
    SET @OrderID = SCOPE_IDENTITY();
    
    INSERT INTO dbo.OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
    SELECT @OrderID, @ProductID, @Quantity, UnitPrice
    FROM dbo.Products
    WHERE ProductID = @ProductID;
    
    UPDATE dbo.Products
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductID;
    
    SELECT @OrderID AS OrderID;
END;
```

```json
"CreateOrder": {
  "source": {
    "object": "dbo.CreateOrder",
    "type": "stored-procedure",
    "parameters": {
      "CustomerID": "customerId",
      "ProductID": "productId",
      "Quantity": "quantity"
    }
  },
  "rest": {
    "enabled": true,
    "methods": {
      "post": true
    }
  },
  "graphql": {
    "enabled": true,
    "operation": "mutation"
  },
  "permissions": [
    {
      "role": "authenticated",
      "actions": ["execute"]
    }
  ]
}
```

Setting `operation` to `mutation` places this procedure under GraphQL mutations rather than queries, indicating it modifies data.

> [!IMPORTANT]
> Stored procedures execute with the permissions of the database connection, not the calling user. Implement appropriate validation and authorization logic within the procedure or use session context for row-level security.

## Define GraphQL relationships between entities

GraphQL relationships enable clients to traverse connections between entities without multiple round trips. DAB supports both one-to-one and one-to-many relationships.

```json
"entities": {
  "Order": {
    "source": { "object": "dbo.Orders", "type": "table" },
    "relationships": {
      "customer": {
        "cardinality": "one",
        "target.entity": "Customer",
        "source.fields": ["CustomerID"],
        "target.fields": ["CustomerID"]
      },
      "orderDetails": {
        "cardinality": "many",
        "target.entity": "OrderDetail",
        "source.fields": ["OrderID"],
        "target.fields": ["OrderID"]
      }
    },
    "permissions": [...]
  },
  "OrderDetail": {
    "source": { "object": "dbo.OrderDetails", "type": "table" },
    "relationships": {
      "order": {
        "cardinality": "one",
        "target.entity": "Order",
        "source.fields": ["OrderID"],
        "target.fields": ["OrderID"]
      },
      "product": {
        "cardinality": "one",
        "target.entity": "Product",
        "source.fields": ["ProductID"],
        "target.fields": ["ProductID"]
      }
    },
    "permissions": [...]
  }
}
```

With these relationships, GraphQL clients can build rich queries:

```graphql
query {
  orders(first: 10) {
    items {
      orderDate
      customer {
        companyName
        contactName
      }
      orderDetails {
        items {
          quantity
          product {
            productName
            unitPrice
          }
        }
      }
    }
  }
}
```

This single query retrieves orders with customer information and line items including product details. Without relationships, clients would need multiple separate requests.

## Handle complex relationship scenarios

Some database designs use junction tables for many-to-many relationships. DAB handles these through explicit relationship chains.

For a products-to-suppliers many-to-many relationship through a `ProductSuppliers` junction table:

```json
"Product": {
  "relationships": {
    "productSuppliers": {
      "cardinality": "many",
      "target.entity": "ProductSupplier",
      "source.fields": ["ProductID"],
      "target.fields": ["ProductID"]
    }
  }
},
"ProductSupplier": {
  "source": { "object": "dbo.ProductSuppliers", "type": "table" },
  "relationships": {
    "supplier": {
      "cardinality": "one",
      "target.entity": "Supplier",
      "source.fields": ["SupplierID"],
      "target.fields": ["SupplierID"]
    }
  }
}
```

Clients traverse the relationship chain: Product → ProductSupplier → Supplier. While this requires one extra level in queries, it accurately represents the database structure and maintains referential integrity.
