Before you model data in Azure DocumentDB, you need to understand the relationships between entities in your application. This analysis drives every modeling decision you make, from whether to embed data inside a document to whether to store it in a separate collection with a reference.

## Identify entities and map relationships

Start by listing the core entities in your application. For example, for an e-commerce platform, the main entities are customers, products, orders, reviews, and categories. Each entity has attributes (fields) and connects to other entities through relationships.

Three types of relationships appear in document databases:

- **One-to-one (1:1):** One entity relates to exactly one other entity. A customer has one account (sign in credentials, authorization settings). An order has one shipping address.
- **One-to-many (1:N):** One entity relates to multiple instances of another. A customer has many orders. A product has many reviews.
- **Many-to-many (M:N):** Multiple instances of one entity relate to multiple instances of another. Products belong to many categories, and categories contain many products.

After you identify entities, map the relationships between them:

Example relationship map
- Customer → Orders:      one-to-many
- Customer → Addresses:   one-to-many (bounded: typically 1-2)
- Customer → Reviews:     one-to-many
- Order → Items:          one-to-many (bounded: typically 1-5)
- Order → ShippingAddress: one-to-one (snapshot at order time)
- Product → Reviews:      one-to-many (potentially unbounded)
- Product ↔ Categories:   many-to-many

Relationships determine how you structure your documents and collections.

## Analyze cardinality

The relationship type alone doesn't tell you enough. You also need to determine cardinality, which is the expected number of items on each side of the relationship. A one-to-many relationship where "many" means three addresses is different from one where "many" means 100,000 reviews.

Estimate the minimum, maximum, and typical counts for each relationship:

| Relationship | Min | Typical | Max | Growth |
|---|---|---|---|---|
| Customer → Addresses | 0 | 2 | 5 | Bounded |
| Customer → Orders | 0 | 16 | 50+ | Unbounded |
| Order → Items | 1 | 3 | 5 | Bounded |
| Product → Reviews | 0 | 25 | 100,000+ | Unbounded |

Cardinality breaks down into three practical categories:

- **One-to-few** (less than 100): Addresses per customer, items per order
- **One-to-many** (100 to 10,000): Reviews per product, orders per customer
- **One-to-millions** (10,000+): Event logs, sensor readings

Cardinality directly influences your document structure: one-to-few relationships often embed well, while one-to-many or one-to-millions relationships usually need referencing or a hybrid approach.

## Analyze access patterns

Cardinality tells you how much data exists. Access patterns tell you how your application uses that data. For each relationship, answer these questions:

**How often is the data accessed together?** When your application loads a product page, does it always need the reviews? When it loads an order, does it always need the customer's full profile?

Access pattern analysis
- Display Product Page (high frequency):
    - Needs: product details, category info, top three reviews, review stats
    - Strategy: embed category + top reviews with product

- Display Customer Dashboard (high frequency):
    - Needs: customer info, recent five orders
    - Strategy: embed recent orders subset with customer, or query separately

- Process Order (high frequency):
    - Needs: order details, all items, shipping address
    - Strategy: embed items and address with order

**What's the read-to-write ratio?** Data that's read frequently but written rarely is a good candidate for embedding, because duplicated data stays consistent. Data that changes often is better stored separately.

| Data | Reads/day | Writes/day | Ratio | Implication |
|---|---|---|---|---|
| Product reviews | 10,000 | 10 | 1,000:1 | Read-heavy; embed a subset |
| Product inventory | 5,000 | 500 | 10:1 | Frequent writes; reference separately |
| Customer address | 1,000 | 5 | 200:1 | Rarely changes; embed with customer |

A high read-to-write ratio (100:1 or more) favors embedding because stale copies are rare. A low ratio (under 10:1) favors referencing to avoid frequent multi-document updates.

## Evaluate ownership and lifecycle

The relationship between parent and child entities affects your modeling strategy:

- **Strong ownership:** The child doesn't exist without the parent. Order items belong to a specific order. If you delete the order, the items have no meaning. Embed. For example, embed:
  - Order → Items: items are part of the order
  - Customer → Addresses: addresses belong to the customer

- **Weak ownership:** Entities exist independently. A customer exists whether or not they have orders. A product exists whether or not it has reviews. Reference. For example, reference:
    - Order → Customer: customer exists independently
    - Review → Product: product exists without reviews


If the child can't exist without the parent, embedding keeps the data together and simplifies deletes. If both entities have independent lifecycles, referencing avoids tightly coupling them.

## Put it all together

Combine your analysis into a relationship summary that guides your modeling decisions. For each relationship, record the type, cardinality, access frequency, read/write ratio, and ownership:

E-commerce relationship analysis summary
- Customer
  - → Profile:     1:1, always together, rarely changes → embed
  - → Addresses:   1:few (1-2), usually together → embed
  - → Orders:      1:many (unbounded), recent needed → subset or reference
- Order 
  - → Items:      1:few (1-5), always together, strong ownership → embed
  - → Address:    1:1, snapshot at order time → embed
- Product 
  - → Reviews:  1:many (unbounded), top N needed → subset + reference
  - ↔ Categories: M:N, display needed → denormalize + reference

This analysis forms the foundation for the decision framework you apply in the next unit. It's not about one single factor, it's about considering cardinality, access patterns, read/write ratios, and ownership together to make informed modeling decisions.
