Entities are the core building blocks of Data API Builder. Each entity maps to a database object and defines how that object appears through your REST and GraphQL APIs. When you define entities properly, you control what data clients can access, what operations they can perform, and how the data appears in API responses.

Building on the configuration file you created, the `entities` section is where you specify the tables, views, and other database objects that DAB exposes. You configure each entity with source mappings, field customizations, and relationship definitions that shape your API surface.

The examples throughout this unit use the following sample database tables. Keep these definitions in mind as you work through each configuration:

```sql
CREATE TABLE dbo.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitsInStock INT NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES dbo.Categories(CategoryID)
);
```

## Map database objects to entities

An entity definition starts with a name and a source reference. The entity name becomes the identifier used in API endpoints and GraphQL queries, while the source points to the actual database object.

```json
"entities": {
  "Product": {
    "source": {
      "object": "dbo.Products",
      "type": "table"
    },
    "permissions": [
      {
        "role": "anonymous",
        "actions": ["read"]
      }
    ]
  }
}
```

This configuration exposes the `dbo.Products` table as a `Product` entity. REST clients access it at `/api/Product`, while GraphQL clients query it as `product` (singular) or `products` (plural). DAB automatically generates these naming conventions based on your entity name.

The `type` property specifies the database object type: `table`, `view`, or `stored-procedure`. Each type has different capabilities. Tables support full CRUD operations (create, read, update, delete), views typically support read operations, and stored procedures execute custom logic.

## Configure field mappings and aliases

Sometimes your database column names don't match the naming conventions you want in your API. Field mappings let you rename columns and control which fields appear in API responses.

```json
"Product": {
  "source": {
    "object": "dbo.Products",
    "type": "table"
  },
  "mappings": {
    "ProductID": "id",
    "ProductName": "name",
    "UnitPrice": "price",
    "UnitsInStock": "stockQuantity"
  },
  "permissions": [
    {
      "role": "anonymous",
      "actions": ["read"]
    }
  ]
}
```

With these mappings, clients see `id`, `name`, `price`, and `stockQuantity` in their API responses instead of the original database column names. This approach lets you present a clean, consistent API while keeping your existing database schema unchanged.

> [!NOTE]
> When you use field mappings, clients must use the mapped names in their queries and mutations. The original database column names become internal implementation details.

## Enable caching for improved performance

[Data API Builder caching](/azure/data-api-builder/caching?azure-portal=true) reduces database load by storing query results temporarily. You can configure caching at both the global level (in the runtime section) and per-entity for fine-grained control.

```json
"Product": {
  "source": {
    "object": "dbo.Products",
    "type": "table"
  },
  "rest": {
    "enabled": true
  },
  "graphql": {
    "enabled": true,
    "cache": {
      "enabled": true,
      "ttl-seconds": 60
    }
  },
  "permissions": [...]
}
```

The `ttl-seconds` property (time-to-live) determines how long cached data remains valid. For product catalogs that change infrequently, longer cache durations improve performance. For rapidly changing data like inventory counts, use shorter durations or disable caching.

Caching works differently for REST and GraphQL. REST caching considers the complete URL including query parameters, while GraphQL caching examines the query structure. Both respect the TTL you configure.

## Implement pagination for large datasets

When entities contain many records, returning all of them in a single response creates performance and usability problems. Data API Builder provides built-in pagination support that you can customize per entity.

```json
"Product": {
  "source": {
    "object": "dbo.Products",
    "type": "table"
  },
  "rest": {
    "enabled": true,
    "path": "/products"
  },
  "graphql": {
    "enabled": true,
    "type": {
      "singular": "product",
      "plural": "products"
    }
  },
  "permissions": [...]
}
```

REST clients use query parameters like `$first` and `$after` to navigate through pages:

```http
GET /api/products?$first=10
GET /api/products?$first=10&$after=eyJQcm9kdWN0SUQiOjEwfQ==
```

The `$after` parameter contains a cursor that points to the last item from the previous page. DAB generates these cursors automatically based on your entity's primary key.

GraphQL clients use similar pagination through the `first` and `after` arguments in their queries:

```graphql
query {
  products(first: 10, after: "eyJQcm9kdWN0SUQiOjEwfQ==") {
    items {
      id
      name
      price
    }
    hasNextPage
    endCursor
  }
}
```

The response includes `hasNextPage` and `endCursor` fields that clients use to determine if more data exists and how to fetch it.

## Configure filtering and searching

Data API Builder generates filtering capabilities automatically based on your entity's fields. Clients can filter results using standard comparison operators.

For REST endpoints, filtering uses OData-style query syntax:

```http
GET /api/products?$filter=price gt 100 and stockQuantity gt 0
```

For GraphQL, filtering uses typed input objects:

```graphql
query {
  products(filter: { price: { gt: 100 }, stockQuantity: { gt: 0 } }) {
    items {
      id
      name
      price
    }
  }
}
```

DAB generates filter types for each field based on its data type. Numeric fields support `gt`, `gte`, `lt`, `lte`, `eq`, and `neq`. String fields add `contains`, `startsWith`, and `endsWith`. You don't need to configure these capabilities explicitly; they're available automatically for all exposed fields.

> [!TIP]
> For complex filtering scenarios that can't be expressed through standard operators, consider creating a view or stored procedure that encapsulates the filtering logic, then expose that as a separate entity.

## Define entity relationships for GraphQL

GraphQL's strength lies in traversing relationships between entities in a single query. Data API Builder supports defining relationships that map to your database's foreign key relationships.

```json
"entities": {
  "Product": {
    "source": { "object": "dbo.Products", "type": "table" },
    "relationships": {
      "category": {
        "cardinality": "one",
        "target.entity": "Category",
        "source.fields": ["CategoryID"],
        "target.fields": ["CategoryID"]
      }
    },
    "permissions": [...]
  },
  "Category": {
    "source": { "object": "dbo.Categories", "type": "table" },
    "relationships": {
      "products": {
        "cardinality": "many",
        "target.entity": "Product",
        "source.fields": ["CategoryID"],
        "target.fields": ["CategoryID"]
      }
    },
    "permissions": [...]
  }
}
```

With these relationships configured, GraphQL clients can query across entities:

```graphql
query {
  products {
    items {
      name
      price
      category {
        name
      }
    }
  }
}
```

The `cardinality` property indicates whether the relationship returns one item or many. Use `one` for many-to-one relationships (product to category) and `many` for one-to-many relationships (category to products).

## Understand REST endpoint generation

When you define an entity, DAB automatically creates REST endpoints following standard conventions. Each entity gets a base URL path, and HTTP verbs map to CRUD operations.

For an entity named `Product` with the default configuration:

| HTTP Method | URL Pattern | Operation |
|-------------|-------------|-----------|
| GET | `/api/Product` | List all products (paginated) |
| GET | `/api/Product/id/123` | Get product with ID 123 |
| POST | `/api/Product` | Create a new product |
| PUT | `/api/Product/id/123` | Update or create product 123 |
| PATCH | `/api/Product/id/123` | Partially update product 123 |
| DELETE | `/api/Product/id/123` | Delete product 123 |

The `/id/` segment in URLs indicates a primary key lookup. For composite keys, chain multiple key segments: `/api/OrderDetail/orderId/100/productId/50`.

## Customize REST endpoint paths

You can modify the default URL patterns through entity configuration. The `rest` section controls REST-specific behavior:

```json
"Product": {
  "source": { "object": "dbo.Products", "type": "table" },
  "rest": {
    "enabled": true,
    "path": "/products",
    "methods": {
      "get": true,
      "post": true,
      "put": false,
      "patch": true,
      "delete": true
    }
  },
  "permissions": [...]
}
```

The `path` property changes the URL from `/api/Product` to `/api/products`. This setting is useful when you want lowercase, plural endpoint names that differ from your entity names.

The `methods` object lets you enable or disable specific HTTP verbs. In this example, `PUT` is disabled, which prevents full record replacement while still allowing `PATCH` for partial updates. This configuration pattern protects against accidental data loss from clients that might send incomplete records.

> [!TIP]
> Disabling methods at the endpoint level provides defense in depth. Even if permissions allow an action, disabling the method prevents it entirely.

## Set up GraphQL endpoint configuration

GraphQL operates through a single endpoint, typically at `/graphql`. All queries, mutations, and subscriptions go through this endpoint, with the request body specifying the operation.

```json
"runtime": {
  "graphql": {
    "enabled": true,
    "path": "/graphql",
    "allow-introspection": true,
    "depth-limit": 8,
    "multiple-mutations": {
      "create": { "enabled": true }
    }
  }
}
```

The `allow-introspection` setting controls whether clients can query the GraphQL schema itself. During development, introspection helps tools like GraphiQL and Apollo Studio understand your API. In production, consider disabling it to hide implementation details.

The `depth-limit` setting prevents overly complex nested queries that could strain your database. A depth of 8 allows reasonable relationship traversal while blocking potential abuse through deeply nested queries.

## Configure GraphQL-specific entity settings

Each entity can have GraphQL-specific configuration that differs from REST:

```json
"Product": {
  "source": { "object": "dbo.Products", "type": "table" },
  "graphql": {
    "enabled": true,
    "type": {
      "singular": "product",
      "plural": "products"
    },
    "operation": "query"
  },
  "rest": {
    "enabled": true
  },
  "permissions": [...]
}
```

The `type` property customizes the GraphQL type names. By default, DAB uses the entity name, but you can specify different singular and plural forms.

The `operation` property determines where mutations appear. Use `query` for read-only entities (like views) or `mutation` for entities that support write operations.
