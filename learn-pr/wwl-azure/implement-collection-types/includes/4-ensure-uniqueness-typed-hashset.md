The `HashSet<T>` class offers developers an efficient way to handle collections of unique elements, ensuring no duplicates are present. For instance, a `HashSet<T>` is useful in maintaining lists of unique email addresses, where verifying and adding items without repetition is crucial.

## Manage unique collections with HashSet&#60;T&#62;

The `HashSet<T>` class is designed for high-performance set operations. It ensures that all elements in the collection are unique and unordered. Unlike other collections like `List<T>`, which allow duplicates, `HashSet<T>` automatically prevents duplicate entries.

- The capacity of a `HashSet<T>` increases dynamically as elements are added.
- I`HashSet<T>` is based on mathematical set operations, such as union, intersection, and subtraction.
- If your application prioritizes performance over element order or duplication, `HashSet<T>` is an ideal choice.

For applications requiring sorted collections or duplicate elements, consider using `List<T>` with sorting methods instead.

> [!NOTE]
> The `HashSet<T>` class implements the `ISet<T>` interface, providing more set operations like subset and superset comparisons.

## Add, verify, and prevent duplicate items in a HashSet&#60;T&#62; collection

Adding items to a `HashSet<T>` is straightforward and ensures no duplicates are introduced. When you attempt to add an item that already exists, the operation fails silently without throwing an error.

### Adding items

Use the `Add` method to insert elements into the collection. For example:

```csharp
HashSet<string> names = new HashSet<string>();
names.Add("Haneul");
names.Add("Magda");

foreach (string name in names) {
    Console.WriteLine(name);
}

// Output (order may vary):
// Haneul
// Magda
```

This code adds unique names to a `HashSet<T>` and iterates through the collection to display them.

### Verifying items

To check if an item exists in the collection, use the `Contains` method:

```csharp
HashSet<string> names = new HashSet<string>();
names.Add("Haneul");
names.Add("Magda");

if (names.Contains("Haneul")) {
    Console.WriteLine("Haneul is in the collection.");
}

// Output:
// Haneul is in the collection.
```

This code checks if a specific name exists in the `HashSet<T>` and displays a message if it does.

### Preventing duplicates

Since `HashSet<T>` inherently prevents duplicates, you don't need extra logic to handle them. Attempting to add "Mia" again doesn't modify the collection.

```csharp
HashSet<string> names = new HashSet<string>();
names.Add("Haneul");
names.Add("Magda");
names.Add("Mia");
names.Add("Mia"); // Duplicate, won't be added

foreach (string name in names) {
    Console.WriteLine(name);
}

// Output (order may vary):
// Haneul
// Magda
// Mia
```

This code demonstrates that adding duplicate elements to a `HashSet<T>` has no effect, ensuring all elements remain unique.

> [!TIP]
> Use `HashSet<T>` when working with data that must remain unique, such as IDs or usernames.

## Manage unique email addresses efficiently with a HashSet&#60;T&#62; example

A common use case for `HashSet<T>` is managing unique email addresses, ensuring no duplicate emails are stored, simplifying operations like sending notifications or verifying user accounts.

Here’s an example:

```csharp
HashSet<string> emailAddresses = new HashSet<string>();
emailAddresses.Add("user1@example.com");
emailAddresses.Add("user2@example.com");
emailAddresses.Add("user1@example.com"); // Duplicate, won't be added

foreach (string email in emailAddresses) {
    Console.WriteLine(email);
}

// Output:
// user1@example.com
// user2@example.com
```

This code adds email addresses to a `HashSet<T>` and ensures no duplicates are stored.

> [!NOTE]
> Using `HashSet<T>` for email management improves performance compared to manually checking for duplicates in a `List<T>`.

`HashSet<T>` manages collections of unique elements, ensuring no duplicates. Thus, `HashSet<T>` is ideal for applications requiring unique data, such as email addresses or user IDs.
