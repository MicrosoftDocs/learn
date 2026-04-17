The `JsonSerializer.Deserialize` method is used to convert a JavaScript Object Notation (JSON) string back into a C# object. Deserialization is used when reading JSON files, receiving JSON data from APIs, or general processing of JSON data. The `Deserialize` method takes a JSON string and the type of the object to be created as input and returns an instance of that object.

The following code demonstrates how to convert a JSON string back into an object using `JsonSerializer.Deserialize`:

```csharp

string jsonString = """{"Name":"Anette Thomsen","Age":30,"Address":"123 Main St"}""";
var customer = JsonSerializer.Deserialize<Employee>(jsonString);

```

## Deserialization behavior

Like serialization, deserialization follows some default behaviors. The following behaviors apply when deserializing JSON:

- By default, property name matching is case-sensitive. You can specify case-insensitivity.
- Non-public constructors are ignored by the serializer.
- Deserialization to immutable objects or properties that don't have public set accessors is supported but not enabled by default. See Immutable types and records.
- By default, enums are supported as numbers. You can deserialize string enum fields.
- By default, fields are ignored. You can include fields.
- By default, comments or trailing commas in the JSON throw exceptions. You can allow comments and trailing commas.
- The default maximum depth is 64.

## Customize deserialization behavior using JsonSerializerOptions

The `JsonSerializerOptions` class allows you to customize the deserialization behavior of the `JsonSerializer.Deerialize` method.

The following properties are demonstrated during this unit:

- `RespectRequiredConstructorParameters`: This property specifies whether all non-optional constructor parameters are required for JSON deserialization.
- `PreferredObjectCreationHandling`: This property specifies the preferred object creation handling behavior during deserialization.

Other properties that are commonly used to customize deserialization include:

- `Converters`: This property allows you to add custom converters to handle specific types or complex objects. For example, you can create a custom converter for a class that contains nested objects or complex properties.
- `DefaultBufferSize`: This property sets the default buffer size in bytes, which can improve performance when deserializing large JSON strings or UTF-8 byte arrays.
- `AllowTrailingCommas`: This property allows trailing commas in JSON arrays and objects, which can be helpful when dealing with JSON data that may have trailing commas.
- `AllowOutOfOrderMetadataProperties`: This property removes the requirement that JSON metadata properties, such as `$id` and `$type`, be specified at the very start of the deserialized JSON object.
- `NumberHandling`: This property specifies how number types should be handled when serializing or deserializing, which can be useful for ensuring accurate representation of numeric values.

## Deserialize required properties

You can mark certain properties to signify that they must be present in the JSON payload for deserialization to succeed. Similarly, you can set an option to specify that all non-optional constructor parameters are present in the JSON payload. If one or more of these required properties isn't present, the `JsonSerializer.Deserialize` methods throw a `JsonException`.

There are three ways to mark a property or field as required for JSON deserialization:

- By adding the `required` modifier.
- By annotating it with `JsonRequiredAttribute`.
- By modifying the `JsonPropertyInfo.IsRequired` property of the contract model.

To specify that all non-optional constructor parameters are required for JSON deserialization, set the `JsonSerializerOptions.RespectRequiredConstructorParameters` option to `true`.

From the serializer's perspective, the C# `required` modifier and `[JsonRequired]` attribute are equivalent, and both map to the same piece of metadata, which is `JsonPropertyInfo.IsRequired`. In most cases, you'd use the built-in C# keyword. However, in the following cases, you should use `JsonRequiredAttribute` instead:

- If you're using a programming language other than C# or a down-level version of C#.
- If you only want the requirement to apply to JSON deserialization.
- If you're using `System.Text.Json` serialization in source generation mode. In this case, your code won't compile if you use the required modifier, as source generation occurs at compile time.

The following code snippet shows an example of a property modified with the `required` keyword. This property must be present in the JSON payload for deserialization to succeed.

```csharp

public static void RunIt()
{
    // The following line throws a JsonException at run time.
    Console.WriteLine(JsonSerializer.Deserialize<Person>("""{"Age": 42}"""));
}

public class Person
{
    public required string Name { get; set; }
    public int Age { get; set; }
}

```

Alternatively, you can use `JsonRequiredAttribute`:

```csharp

public static void RunIt()
{
    // The following line throws a JsonException at run time.
    Console.WriteLine(JsonSerializer.Deserialize<Person>("""{"Age": 42}"""));
}

public class Person
{
    [JsonRequired]
    public string Name { get; set; }
    public int Age { get; set; }
}

```

It's also possible to control whether a property is required via the contract model using the `JsonPropertyInfo.IsRequired` property:

```csharp

public static void RunIt()
{
    var options = new JsonSerializerOptions
    {
        TypeInfoResolver = new DefaultJsonTypeInfoResolver
        {
            Modifiers =
            {
                static typeInfo =>
                {
                    if (typeInfo.Kind != JsonTypeInfoKind.Object)
                        return;

                    foreach (JsonPropertyInfo propertyInfo in typeInfo.Properties)
                    {
                        // Strip IsRequired constraint from every property.
                        propertyInfo.IsRequired = false;
                    }
                }
            }
        }
    };

    // Deserialization succeeds even though
    // the Name property isn't in the JSON payload.
    JsonSerializer.Deserialize<Person>("""{"Age": 42}""", options);
}

public class Person
{
    public required string Name { get; set; }
    public int Age { get; set; }
}

```

## Deserialize and populate initialized properties

When deserializing a JSON string into an object, you can specify whether certain properties are initialized or not. This is useful for ensuring that the deserialized object has all the necessary data before it can be used.

Starting in .NET 8, you can specify a preference to either replace or populate .NET properties when JSON is deserialized. The `JsonObjectCreationHandling` enum provides the object creation handling choices:

- `JsonObjectCreationHandling.Replace`: The default behavior. Properties are replaced with the values from the JSON payload. This is the same behavior as in previous versions of .NET.
- `JsonObjectCreationHandling.Populate`: Properties are populated with the values from the JSON payload. This means that if a property is already initialized, its value is updated with the value from the JSON payload.

### Default (replace) behavior

The `System.Text.Json` deserializer always creates a new instance of the target type. However, even though a new instance is created, some properties and fields might already be initialized as part of the object's construction. Consider the following type:

```csharp

class A
{
    public List<int> Numbers1 { get; } = [1, 2, 3];
    public List<int> Numbers2 { get; set; } = [1, 2, 3];
}

```

When you create an instance of this class, the two `List` type properties are initialized with three elements (1, 2, and 3). If you deserialize JSON to this type, the default behavior is to replace the property values with data from the JSON payload.

- For `Numbers1`, since it's read-only (no setter), it still has the values 1, 2, and 3 in its list.
- For `Numbers2`, which is read-write, a new list is allocated and the values from the JSON are added.

For example, if you execute the following deserialization code, `Numbers1` contains the values 1, 2, and 3 and `Numbers2` contains the values 4, 5, and 6.

```csharp

var json = """{"Numbers1": [4, 5, 6], "Numbers2": [4, 5, 6]}""";
var a = JsonSerializer.Deserialize<A>(json);

Console.WriteLine(string.Join(", ", a.Numbers1));
Console.WriteLine(string.Join(", ", a.Numbers2));

// Output: 1, 2, 3
// Output: 4, 5, 6

```

### Populate behavior

You can change the deserialization behavior to modify (populate) properties and fields instead of replace them:

- For a collection type property, the object is reused without clearing. If the collection is prepopulated with elements, they'll show in the final deserialized result along with the values from the JSON.
- For a property that's an object with properties, its mutable properties are updated to the JSON values but the object reference itself doesn't change.
- For a struct type property, the effective behavior is that for its mutable properties, any existing values are kept and new values from the JSON are added. However, unlike a reference property, the object itself isn't reused since it's a value type. Instead, a copy of the struct is modified and then reassigned to the property.

A `struct` property must have a setter; otherwise, an `InvalidOperationException` is thrown at run time.

> [!IMPORTANT]
> The `Populate` behavior currently doesn't work for types that have a parameterized constructor.

### How to specify

There are multiple ways to specify a preference for `replace` or `populate`:

- Use the `JsonObjectCreationHandlingAttribute` attribute to annotate at the type or property level. If you set the attribute at the type level and set its `Handling` property to `Populate`, the behavior only applies to those properties where population is possible (for example, value types must have a setter).

    If you want the type-wide preference to be `Populate`, but want to exclude one or more properties from that behavior, you can add the attribute at the type level and again at the property level to override the inherited behavior. That pattern is shown in the following code.

    ```csharp

    // Type-level preference is Populate.
    [JsonObjectCreationHandling(JsonObjectCreationHandling.Populate)]
    class B
    {
        // For this property only, use Replace behavior.
        [JsonObjectCreationHandling(JsonObjectCreationHandling.Replace)]
        public List<int> Numbers1 { get; } = [1, 2, 3];
        public List<int> Numbers2 { get; set; } = [1, 2, 3];
    }

    ```

- Set `JsonSerializerOptions.PreferredObjectCreationHandling` to specify a global preference.

    ```csharp

    var options = new JsonSerializerOptions
    {
        PreferredObjectCreationHandling = JsonObjectCreationHandling.Populate
    };

    ```

## Reading JSON files

How to read JSON files using `File.ReadAllText`.

```csharp

using System;
using System.IO;
using System.Text.Json;

class Program
{
    static void Main()
    {
        string jsonString = File.ReadAllText("customer.json");
        var customer = JsonSerializer.Deserialize<BankCustomer>(jsonString);
        Console.WriteLine($"Name: {customer.Name}, Age: {customer.Age}, Address: {customer.Address}");
    }
}

```

## Summary

In this unit, you learned how to customize the default deserialization behavior when deserializing JSON data into C# objects using the `JsonSerializer.Deserialize` method. You learned about the default behaviors, how to mark properties as required, and how to specify whether properties should be replaced or populated during deserialization. Finally, you learned how to read JSON files using `File.ReadAllText`.
