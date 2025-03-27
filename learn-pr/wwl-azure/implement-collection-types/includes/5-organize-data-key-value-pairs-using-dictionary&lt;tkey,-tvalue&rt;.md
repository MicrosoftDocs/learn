A `Dictionary<TKey, TValue>` is a generic collection in C# that stores data as key-value pairs, where each key is unique and maps to a specific value. It's ideal for scenarios requiring fast lookups based on unique identifiers, such as creating a phonebook or mapping product IDs to prices.

## Define and explain the purpose of Dictionary<TKey, TValue> for organizing key-value pairs

A `Dictionary<TKey, TValue>` is part of the `System.Collections.Generic` namespace in C#. It stores data as key-value pairs, where each key is unique and maps to a specific value. This structure is ideal for scenarios where quick lookups are required based on unique identifiers.

- Keys must be unique within the dictionary.
- Values can be of any type, including custom objects.

The `Dictionary<TKey, TValue>` class provides methods like `Add` for inserting new pairs and an indexer for accessing values by their keys.

> [!NOTE]
> If you attempt to add a duplicate key using the `Add` method, an `ArgumentException` is thrown. However, using the indexer overwrites the existing value associated with the key.

## Add, retrieve, and iterate through key-value pairs in a Dictionary<TKey, TValue>

Adding key-value pairs to a dictionary can be done using the `Add` method or the index initializer. Retrieving values is straightforward using the key, and iteration is possible using loops.

### Adding key-value pairs

You can initialize a dictionary using collection initializers or the `Add` method:

```csharp
var students = new Dictionary<int, string>
{
    { 101, "Ji-min Jo" },
    { 102, "Catalina Blaga" }
};

students.Add(103, "Milan Golob"); // Add a new key-value pair

foreach (var kvp in students)
{
    Console.WriteLine($"Key: {kvp.Key}, Value: {kvp.Value}");
}

// Expected output:
// Key: 101, Value: Ji-min Jo
// Key: 102, Value: Catalina Blaga
// Key: 103, Value: Milan Golob
```

This code initializes a dictionary with student IDs and names, adds a new student, and iterates through the dictionary to display all key-value pairs.

### Retrieving values

Access values using the key:

```csharp
var students = new Dictionary<int, string>
{
    { 101, "Ji-min Jo" },
    { 102, "Catalina Blaga" }
};

var student = students[101];
Console.WriteLine(student); // Outputs "Ji-min Jo"

// Expected output:
// Ji-min Jo
```

This code retrieves the value associated with the key `101` and displays the student's name.

### Iterating through key-value pairs

Use a `foreach` loop to iterate through the dictionary:

```csharp
var students = new Dictionary<int, string>
{
    { 101, "Ji-min Jo" },
    { 102, "Catalina Blaga" },
    { 103, "Milan Golob" }
};

foreach (var kvp in students)
{
    Console.WriteLine($"Key: {kvp.Key}, Value: {kvp.Value}");
}

// Expected output:
// Key: 101, Value: Ji-min Jo
// Key: 102, Value: Catalina Blaga
// Key: 103, Value: Milan Golob
```

This code iterates through all key-value pairs in the dictionary and displays each key and its corresponding value.

## Create practical applications like a phonebook or product ID-to-price mapping using Dictionary<TKey, TValue>

The versatility of `Dictionary<TKey, TValue>` makes it suitable for real-world applications such as:

### Phonebook

Store contact names and phone numbers:

```csharp
var phonebook = new Dictionary<string, string>
{
    { "Ji-min Jo", "312-555-0100" },
    { "Catalina Blaga", "251-555-0101" }
};

Console.WriteLine(phonebook["Ji-min Jo"]); // Access Ji-min's phone number

// Expected output:
// 312-555-0100
```

This code demonstrates how to use a dictionary to store and retrieve phone numbers by name.

### Product ID-to-price mapping

Map product IDs to their prices:

```csharp
var productPrices = new Dictionary<int, decimal>
{
    { 201, 19.99m },
    { 202, 29.99m }
};

Console.WriteLine($"Product 201 costs ${productPrices[201]}");

// Expected output:
// Product 201 costs $19.99
```

This code demonstrates how to use a dictionary to map product IDs to their prices and retrieve the price of a specific product.

These examples demonstrate how `Dictionary<TKey, TValue>` can simplify data management tasks in your applications.
