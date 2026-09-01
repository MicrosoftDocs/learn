Now that you have the embed-vs-reference decision framework, apply it to one-to-one and one-to-many relationships, the two most common patterns in Azure DocumentDB.

## Model one-to-one relationships

One-to-one relationships, where one entity maps to exactly one other entity, are the simplest to model. In most cases, you embed the related data directly in the parent document.

### Full embedding (recommended default)

When related data is always accessed with the parent and the combined size stays reasonable, embed the related entity as a nested object. For example, adding the specs of a product with the product itself.

```javascript
// Product with embedded specifications (one-to-one)
db.products.insertOne({
  _id: ObjectId("ccc100030000000000000000"),
  name: "Mountain-100 Silver, 44",
  sku: "BK-M100S-44",
  price: 3399.99,
  productType: "bike",
  specs: {
    frameSize: 44,
    frameMaterial: "Aluminum",
    color: "Silver",
    weight_kg: 10.8,
    gears: 27,
    brakeType: "Hydraulic Disc",
    suspensionType: "Front",
    suspensionTravel_mm: 100,
    wheelSize_inches: 29
  }
});

// Single query returns product with all details
const product = db.products.findOne({ sku: "BK-M100S-44" });
```

Common one-to-one embedding scenarios in e-commerce:

- **Customer → Addresses:** Home and work addresses, always accessed with the customer
- **Product → Specifications:** Technical attributes specific to the product type
- **Order → Shipping address:** Address snapshot at order time
- **Order → Items:** Line items with SKU, name, price, and quantity

You query and update nested fields using dot notation:

```javascript
// Query by nested field
db.products.find({ "specs.frameMaterial": "Aluminum" });

// Update a nested field
db.products.updateOne(
  { sku: "BK-M100S-44" },
  { $set: { "specs.weight_kg": 10.9 } }
);

// Project specific nested fields
db.products.findOne(
  { sku: "BK-M100S-44" },
  { name: 1, price: 1, "specs.frameMaterial": 1, "specs.gears": 1 }
);
```

### Separate document (rare cases)

Consider storing one-to-one related data in a separate collection only when:

- The related data is very large (over 1 MB) and rarely needed
- Access frequency differs significantly (profile viewed 10 times more than detailed biography)
- Different access controls are needed (sensitive data in a separate collection)

```javascript
// Customer document (accessed frequently)
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com"
});

// Extended profile (accessed infrequently, large data)
db.customerProfiles.insertOne({
  _id: ObjectId("ddd200010000000000000000"),
  customerId: ObjectId("ddd100010000000000000000"),
  purchaseHistory: [ /* large array of past transactions */ ],
  supportTickets: [ /* array of support interactions */ ]
});
```

> [!NOTE]
> If you're unsure whether a one-to-one relationship needs a separate collection, start with embedding. Separate only when you have a concrete performance or size reason.

A good rule of thumb: if the related data is under 1 MB and always accessed together, keep it embedded.

## Model one-to-many relationships

One-to-many relationships are the most common pattern in document databases. The right modeling strategy depends on how many children exist and how they're accessed.

### Embed children (one-to-few)

When the child count is bounded and small (typically less than 100), and you access the children with the parent, embed them as an array. For example, embedding addresses within a customer document.

```javascript
// Customer with embedded addresses (one-to-few: typically 1-2)
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
    },
    {
      label: "work",
      street: "522 Maple Boulevard",
      city: "Austin",
      state: "TX",
      country: "US",
      zipCode: "10004"
    }
  ]
});
```

Manage embedded array elements with array update operators:

```javascript
// Add a new address
db.customers.updateOne(
  { _id: ObjectId("ddd100010000000000000000") },
  {
    $push: {
      addresses: {
        label: "vacation",
        street: "789 Beach Road",
        city: "Miami",
        state: "FL",
        country: "US",
        zipCode: "33139"
      }
    }
  }
);

// Update a specific address using the positional operator
db.customers.updateOne(
  { _id: ObjectId("ddd100010000000000000000"), "addresses.label": "home" },
  { $set: { "addresses.$.street": "138 Oak Avenue" } }
);

// Remove an address
db.customers.updateOne(
  { _id: ObjectId("ddd100010000000000000000") },
  { $pull: { addresses: { label: "vacation" } } }
);
```

Other common one-to-few embedding scenarios:

- **Order → Line items:** Typically 1-5 items, always accessed with the order, strong ownership
- **Product → Tags:** Typically 3-6 tags, always needed on the product page
- **Customer → Addresses:** Typically 1-2 saved addresses

When the array is bounded and small, embedding avoids the overhead of a second collection and keeps writes atomic.

### Reference children (one-to-many or unbounded)

When the child count is large, unbounded, or children are accessed independently, store them in a separate collection with a reference to the parent.

> [!WARNING]
> Embedding an unbounded array is a common anti-pattern. As the array grows toward the 16-MB BSON (binary JSON) document limit, write operations begin to fail with a document-too-large error. If you can't put a fixed upper bound on how many children a parent can have, use referencing or the subset pattern instead. This topic is discussed further in the next module.

For example, commercial customers create a large number of orders, making embedding impractical.

```javascript
// Customer document (parent)
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com",
  orderCount: 38
});

// Orders in separate collection (children)
db.orders.insertMany([
  {
    _id: ObjectId("eee120000000000000000000"),
    customerId: ObjectId("ddd100010000000000000000"),
    customerName: "Haladhar Keot",
    orderDate: ISODate("2026-03-15T10:30:00Z"),
    status: "delivered",
    total: 1258.54
  },
  {
    _id: ObjectId("eee120010000000000000000"),
    customerId: ObjectId("ddd100010000000000000000"),
    customerName: "Haladhar Keot",
    orderDate: ISODate("2026-04-01T14:00:00Z"),
    status: "shipped",
    total: 174.03
  }
]);

// Query orders for a customer
db.orders.find({ customerId: ObjectId("ddd100010000000000000000") })
  .sort({ orderDate: -1 });
```

> [!IMPORTANT]
> Always create an index on the reference field in the child collection. Without an index on `customerId` in the `orders` collection, finding a customer's orders requires a full collection scan. Indexing is covered more in depth in a later module.

Referencing also makes it straightforward to paginate, sort, and filter children independently of the parent.

### Use the subset pattern (hybrid)

When the child count is large but the page only needs a few items upfront, embed a fixed-size subset in the parent and store everything in a separate collection.

For example, in an e-commerce web application, many of your products have hundreds or thousands of reviews. Embedding the latest reviews with the product reduces the number of queries needed for the initial product page load.

```javascript
// Product with top 3 reviews embedded (outlier product)
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
      { customerName: "Dusan Sykora", rating: 5, title: "Mountain-100 Silver 44 drivetrain on rolling pavement" },
      { customerName: "Gitte Olsen", rating: 5, title: "Mountain-100 Silver 44 fit during mixed route after adjustment" }
    ]
  },
  reviewsLocation: "reviews"
});

// ALL reviews in a separate collection
db.reviews.insertMany([
  {
    _id: ObjectId("fff100060000000000000000"),
    productId: ObjectId("ccc100030000000000000000"),
    customerName: "Moina Potongia",
    rating: 5,
    title: "Mountain-100 Silver 44 rack mounts on 72 kilometer ride",
    helpful: 237,
    createdAt: ISODate("2026-04-10T20:34:00Z")
  }
  // ... all 110 reviews
]);
```

The product page loads instantly with the top reviews. The "Show all reviews" button triggers a second query against the `reviews` collection with pagination.



### Choose the right one-to-many pattern

| Child count | Pattern | Example |
|---|---|---|
| 1-5 | Embed | Customer → addresses |
| 5-50 | Embed or reference | Order → line items |
| 50-10,000 | Subset or reference | Product → reviews |
| 10,000+ | Reference only | Product → page view events |

One-to-one and one-to-many are the most common relationships you model, but they aren't the only ones. The next unit covers many-to-many relationships, where both sides of the relationship can have multiple instances.

