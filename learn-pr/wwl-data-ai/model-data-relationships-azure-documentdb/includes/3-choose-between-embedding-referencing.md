The most critical decision in document database modeling is whether to embed related data inside a document or store it in a separate collection with a reference. This unit gives you a decision framework to make that choice consistently.

## Understand embedding

Embedding means storing related data directly inside a parent document. When your application reads the parent, it gets the related data in the same operation with no second query needed. A customer document, for example, can embed shipping addresses so a single query returns the customer and all their addresses together:

```javascript
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com",
  addresses: [
    {
      label: "home",
      street: "137 Oak Avenue",
      city: "Redmond",
      state: "WA",
      country: "US",
      zipCode: "10001"
    }
  ]
});

// Single query returns customer + addresses
const customer = db.customers.findOne({ _id: ObjectId("ddd100010000000000000000") });
```

Embedding provides several advantages:

- **Single query performance:** One read operation retrieves all related data.
- **Atomicity:** Updates to the parent and embedded data happen in a single write operation.
- **Data locality:** Related data is stored together on disk, which improves read performance.

Embedding also has trade-offs:

- **Document size growth:** Each embedded array element increases the document size, up to the 16-MB BSON (binary JSON) limit.
- **Data duplication:** If the same data is embedded in multiple documents, you need to update every copy when it changes.
- **No independent queries:** You can't easily query or paginate just the embedded data without retrieving the parent.

The next section covers referencing, which trades single-query convenience for flexibility.

## Understand referencing

Referencing means storing related data in a separate collection and linking it by ID. Your application runs a second query (or uses `$lookup`) to retrieve the related data. For example, in an e-commerce application, orders live in their own collection, each linked to a customer by `customerId`. Loading a customer's order history requires two separate queries (one for the customer, one for their orders):

```javascript
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com"
});

db.orders.insertMany([
  {
    _id: ObjectId("eee120000000000000000000"),
    customerId: ObjectId("ddd100010000000000000000"),
    customerName: "Haladhar Keot",
    status: "delivered",
    total: 1258.54
  },
  {
    _id: ObjectId("eee120010000000000000000"),
    customerId: ObjectId("ddd100010000000000000000"),
    customerName: "Haladhar Keot",
    status: "shipped",
    total: 174.03
  }
]);

// Two queries needed
const customer = db.customers.findOne({ _id: ObjectId("ddd100010000000000000000") });
const orders = db.orders.find({ customerId: customer._id }).toArray();
```

Referencing provides these advantages:

- **No duplication:** Each piece of data exists once, so updates are simple.
- **Independent queries:** You can query, filter, sort, and paginate the related collection directly.
- **Scalability:** Documents stay small regardless of how many related items exist.

The trade-offs of referencing include:

- **Multiple queries:** Your application makes multiple round trips to retrieve related data.
- **No atomicity:** Updates to the parent and referenced data are separate operations.
- **Application-managed joins:** Your code must handle joining data from multiple collections.

In practice, most applications use a mix of both approaches depending on the relationship.

## Apply the decision framework

Use these five criteria to decide whether to embed or reference:

| Criteria | Embed | Reference |
|---|---|---|
| **Access pattern** | Data accessed together 80%+ of the time | Data accessed independently |
| **Cardinality** | Bounded and small (less than 100) | Unbounded or large (over 100) |
| **Update frequency** | Related data changes rarely | Related data changes frequently |
| **Data size** | Combined size stays well within the 16-MB document limit | Combined size would push the document toward the 16-MB BSON limit |
| **Lifecycle** | Child depends on parent (strong ownership) | Entities exist independently |

When evaluating a relationship, check each criterion. If three or more criteria point to embedding, embed. If there are three or more points to referencing, reference. When the results are mixed, consider a hybrid approach.

:::image type="content" source="../media/embed-reference-decision.png" alt-text="Flowchart for deciding whether to embed or reference data. Questions cover access pattern, cardinality, update frequency, and data size, leading to an embed, reference, or hybrid recommendation." lightbox="../media/embed-reference-decision.png":::

## Use the hybrid approach

Many real-world relationships don't fit neatly into embed or reference. Two hybrid patterns bridge the gap:

### Extended reference pattern

Store the full data in a separate collection, but embed the most frequently displayed fields in the parent document. This embedding eliminates extra queries for common display scenarios while keeping the full data normalized. The following order document embeds `customerName` and `customerEmail`, enough for the order confirmation page. The full customer profile (addresses, membership tier, recent orders) stays in the customer's collection and isn't duplicated here:

```javascript
db.orders.insertOne({
  _id: ObjectId("eee120000000000000000000"),
  customerId: ObjectId("ddd100010000000000000000"),
  customerName: "Haladhar Keot",
  customerEmail: "haladhar@contoso.com",
  // Full profile (addresses, membershipTier, recentOrders) stays in customers
  items: [
    { sku: "BK-M100S-44", name: "Mountain-100 Silver, 44", price: 3399.99, quantity: 1 }
  ],
  total: 3721.39
});
```

Use extended references when you need a few fields from a related entity for display, but the full entity changes independently or is too large to embed entirely. The main drawback is that you need to keep the embedded fields in sync with the source collection, but embedding reduces related reads.

### Subset pattern

Embed a small, fixed-size subset of related items in the parent document. Store the complete set in a separate collection. The Mountain-100 Silver, 44 has 110 reviews. The product document embeds the top three for fast initial page loads. All 110 reviews are also stored in the reviews collection so the "Show all reviews" feature can paginate the full set without reading the product document:

```javascript
db.products.insertOne({
  _id: ObjectId("ccc100030000000000000000"),
  name: "Mountain-100 Silver, 44",
  price: 3399.99,
  isOutlier: true,
  reviewSummary: {
    averageRating: 3.9,
    totalCount: 110,
    topReviews: [
      { customerName: "Nikhil Barot", rating: 5, title: "Mountain-100 Silver 44 fit during packed dirt with sizing notes" },
      { customerName: "Dusan Sykora", rating: 5, title: "Mountain-100 Silver 44 drivetrain on rolling pavement with sizing notes" },
      { customerName: "Gitte Olsen", rating: 5, title: "Mountain-100 Silver 44 fit during mixed route after adjustment" }
    ]
  },
  reviewsLocation: "reviews"
});

// All 110 reviews in a separate collection
db.reviews.insertOne({
  _id: ObjectId("fff100060000000000000000"),
  productId: ObjectId("ccc100030000000000000000"),
  customerName: "Moina Potongia",
  rating: 5,
  title: "Mountain-100 Silver 44 rack mounts on 72 kilometer ride",
  helpful: 237,
  createdAt: ISODate("2026-04-10T20:34:00Z")
});
```

Use the subset pattern when a one-to-many relationship has too many items to embed entirely, but your initial page load only needs the most recent or highest-rated items.

## Compare the approaches

The following table summarizes when to use each approach:

| Factor | Embed | Reference | Hybrid |
|---|---|---|---|
| **Query count** | 1 | 2+ | 1 for common reads, 2+ for full data |
| **Best for** | 1:1 or 1:few | 1:many or M:N | 1:many with display needs |
| **Data freshness** | Always current | Always current | Might need periodic sync |
| **Document growth** | Increases | Stays small | Controlled growth |
| **Example** | Order → items | Customer → orders | Product → top reviews |

> [!TIP]
> When you're unsure, start with embedding and refactor to referencing when you hit documented pain points like slow writes, large document sizes, or the need for independent queries. It's easier to split a document than to denormalize one later.

With the embed-vs-reference framework in hand, the next step is to apply it to specific relationship types. The following units walk through one-to-one, one-to-many, and many-to-many patterns with concrete examples.

