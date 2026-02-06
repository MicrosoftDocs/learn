Entities are the core building blocks of Data API Builder. Each entity maps to a database object and defines how that object appears through your REST and GraphQL APIs. When you define entities properly, you control what data clients can access, what operations they can perform, and how the data appears in API responses.

Building on the configuration file you created, the `entities` section is where you specify the tables, views, and other database objects that DAB exposes. You configure each entity with source mappings, field customizations, and relationship definitions that shape your API surface.

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
