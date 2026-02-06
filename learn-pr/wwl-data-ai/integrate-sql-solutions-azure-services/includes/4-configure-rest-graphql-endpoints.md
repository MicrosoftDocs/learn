Data API Builder generates both REST and GraphQL endpoints from your entity definitions. Each protocol serves different client needs and offers distinct advantages. REST provides familiar HTTP semantics with predictable URLs, while GraphQL offers flexible querying and efficient data fetching through a single endpoint.

Understanding how to configure these endpoints gives you control over your API's behavior, URL structure, and client experience. You can enable both protocols simultaneously or choose one based on your application requirements.

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

## Configure REST query parameters

REST clients use query parameters to filter, sort, and paginate results. DAB supports OData-inspired query syntax out of the box.

```http
GET /api/products?$filter=price gt 50&$orderby=name asc&$first=20&$select=id,name,price
```

Key query parameters include:

- **$filter** - Apply conditions to limit results
- **$orderby** - Sort by one or more fields
- **$first** - Limit the number of returned items
- **$after** - Cursor for pagination continuation
- **$select** - Choose specific fields to return

You can control which parameters clients can use through the `request-body-strict` setting in the runtime configuration. When set to `true`, DAB rejects requests with unexpected properties in POST and PATCH bodies.

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

## Understand GraphQL type generation

Data API Builder generates GraphQL types from your entity definitions. Each entity becomes a GraphQL type with fields matching your database columns (or mapped names).

For a `Product` entity, DAB generates:

```graphql
type Product {
  id: Int!
  name: String!
  price: Decimal!
  stockQuantity: Int
  category: Category
}

type Query {
  product_by_pk(id: Int!): Product
  products(
    filter: ProductFilterInput
    orderBy: ProductOrderByInput
    first: Int
    after: String
  ): ProductConnection!
}

type Mutation {
  createProduct(item: CreateProductInput!): Product
  updateProduct(id: Int!, item: UpdateProductInput!): Product
  deleteProduct(id: Int!): Product
}
```

Notice how DAB creates both singular (`product_by_pk`) and plural (`products`) query types automatically. It also generates input types for filtering, ordering, and mutations.

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

## Handle API versioning considerations

Data API Builder doesn't have built-in versioning, but you can implement versioning strategies through configuration management.

One approach uses separate configuration files for each API version:

- `dab-config.v1.json` - Original API entities and mappings
- `dab-config.v2.json` - Updated entities with new fields or changed mappings

Deploy different versions to separate endpoints or use a reverse proxy to route versioned requests.

Another approach uses field mappings to maintain backward compatibility. When adding new database columns, keep existing mapped names unchanged while exposing new columns under new mapped names:

```json
"mappings": {
  "ProductID": "id",
  "ProductName": "name",
  "UnitPrice": "price",
  "NewPriceField": "extendedPrice"
}
```

This pattern allows existing clients to continue working while new clients access extra fields.

> [!IMPORTANT]
> Plan your entity names and field mappings carefully during initial design. Changing them later can break existing client applications.
