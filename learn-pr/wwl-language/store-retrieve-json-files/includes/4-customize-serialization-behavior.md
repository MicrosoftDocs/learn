The `JsonSerializer.Serialize` method is used to convert a C# object into a JavaScript Object Notation (JSON) string. Serialization is used when you want to store or transmit data in a lightweight format that can be easily read and processed by other systems. The `JsonSerializer` class is part of the `System.Text.Json` namespace, which provides functionality for working with JSON data in C#.

The following code demonstrates how to convert an object to a JSON string using `JsonSerializer.Serialize`:

```csharp

var customer = new Employee { Name = "Anette Thomsen", Age = 30, Address = "123 Main St" };
string jsonString = JsonSerializer.Serialize(customer);

```

## Default serialization behavior

The following default behaviors apply when serializing JSON:

- By default, all public properties are serialized. You can specify properties to ignore. You can also include private members.
- The default encoder escapes non-ASCII characters, HTML-sensitive characters within the ASCII-range, and characters that must be escaped according to the RFC 8259 JSON spec.
- By default, JSON is minified. You can pretty-print the JSON.
- By default, casing of JSON names matches the .NET names. You can customize JSON name casing.
- By default, circular references are detected and exceptions thrown. You can preserve references and handle circular references.
- By default, fields are ignored. You can include fields.

The `JsonSerializer` class provides various options and configurations to customize the serialization behavior, including the ability to ignore properties, include fields, and control the formatting of the JSON output.

## Customize serialization behavior using JsonSerializerOptions

The `JsonSerializerOptions` class allows you to customize the serialization behavior of the `JsonSerializer.Serialize` method. For exaple, you can specify options such as whether to ignore null values, include fields, and control the formatting of the JSON output.

The following properties are demonstrated during this unit:

- DefaultIgnoreCondition: This property specifies the condition under which properties with default values are ignored during serialization. It can help reduce the size of the serialized JSON by excluding properties with default values.
- WriteIndented: This property enables pretty-printing of the JSON output, making it more human-readable by adding indentation and line breaks.
- IncludeFields: This property specifies whether fields should be included in the serialization process. By default, only properties are serialized.

Other commonly used properties include:

- PropertyNameCaseInsensitive: This property enables case-insensitive matching of property names during deserialization. It can be useful when the JSON data has property names with different casing than the class definition.
- AllowTrailingCommas: This property allows trailing commas in JSON arrays and objects, which can be helpful when dealing with JSON data that may have trailing commas.
- IgnoreNullValues: This property specifies whether null values should be ignored during serialization. It can help reduce the size of the serialized JSON by excluding properties with null values.
- Encoder: This property allows you to specify a custom encoder for escaping characters in JSON strings. It can be useful when dealing with special characters in property names or values.

## Ignore properties during serialization

The `JsonSerializer` class provides options to ignore properties during serialization. This is useful when you want to exclude certain properties from the JSON output, such as sensitive information or properties that aren't relevant for serialization.

You can ignore properties based on the following criteria:

- Individual properties
- All read-only properties
- All null-value properties
- All default-value properties

### Ignore individual properties

To ignore individual properties, use the [JsonIgnore] attribute.

The following example shows a type to serialize. It also shows the JSON output:

```csharp

public class WeatherForecastWithIgnoreAttribute
{
    public DateTimeOffset Date { get; set; }
    public int TemperatureCelsius { get; set; }
    [JsonIgnore]
    public string? Summary { get; set; }
}

class Program
{
    static void Main()
    {
        var forecast = new WeatherForecastWithIgnoreAttribute
        {
            Date = DateTimeOffset.Now,
            TemperatureCelsius = 25,
            Summary = "Warm"
        };

        string jsonString = JsonSerializer.Serialize(forecast);
        Console.WriteLine(jsonString);
    }
}

// Output: {"Date":"2023-10-01T12:00:00Z","TemperatureCelsius":25}

```

You can specify conditional exclusion by setting the `[JsonIgnore]` attribute's `Condition` property. The `JsonIgnoreCondition` enum provides the following options:

- **Always** - The property is always ignored. If no Condition is specified, this option is assumed.
- **Never** - The property is always serialized and deserialized, regardless of the DefaultIgnoreCondition, IgnoreReadOnlyProperties, and IgnoreReadOnlyFields global settings.
- **WhenWritingDefault** - The property is ignored on serialization if it's a reference type null, a nullable value type null, or a value type default.
- **WhenWritingNull** - The property is ignored on serialization if it's a reference type null, or a nullable value type null.

The following example illustrates the use of the [JsonIgnore] attribute's Condition property:

```csharp

using System.Text.Json;
using System.Text.Json.Serialization;

namespace JsonIgnoreAttributeExample
{
    public class Forecast
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public DateTime Date { get; set; }

        [JsonIgnore(Condition = JsonIgnoreCondition.Never)]
        public int TemperatureC { get; set; }

        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? Summary { get; set; }
    };

    public class Program
    {
        public static void Main()
        {
            Forecast forecast = new()
            {
                Date = default,
                Summary = null,
                TemperatureC = default
            };

            JsonSerializerOptions options = new()
            {
                DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingDefault
            };

            string forecastJson =
                JsonSerializer.Serialize<Forecast>(forecast,options);

            Console.WriteLine(forecastJson);
        }
    }
}

// Produces output like the following example:
//
//{"TemperatureC":0}

```

### Ignore all read-only properties

A property is read-only if it contains a public getter but not a public setter. To ignore all read-only properties when serializing, set the `JsonSerializerOptions.IgnoreReadOnlyProperties` to `true`, as shown in the following example:

```csharp

var options = new JsonSerializerOptions
{
    IgnoreReadOnlyProperties = true,
    WriteIndented = true
};

jsonString = JsonSerializer.Serialize(weatherForecast, options);

```

The following example shows a type to serialize. It also shows the JSON output:

```csharp

public class WeatherForecastWithROProperty
{
    public DateTimeOffset Date { get; set; }
    public int TemperatureCelsius { get; set; }
    public string? Summary { get; set; }
    public int WindSpeedReadOnly { get; private set; } = 35;
}

// {
//   "Date": "2019-08-01T00:00:00-07:00",
//   "TemperatureCelsius": 25,
//   "Summary": "Hot",
// }

```

> [!NOTE]
> This option applies only to properties. To ignore read-only fields when serializing fields, use the `JsonSerializerOptions.IgnoreReadOnlyFields` global setting.

### Ignore all null-value properties

To ignore all null-value properties, set the `DefaultIgnoreCondition` property to `WhenWritingNull`, as shown in the following example:

```csharp

using System.Text.Json;
using System.Text.Json.Serialization;

namespace IgnoreNullOnSerialize
{
    public class Forecast
    {
        public DateTime Date { get; set; }
        public int TemperatureC { get; set; }
        public string? Summary { get; set; }
    };

    public class Program
    {
        public static void Main()
        {
            Forecast forecast = new()
            {
                Date = DateTime.Now,
                Summary = null,
                TemperatureC = default
            };

            JsonSerializerOptions options = new()
            {
                DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
            };

            string forecastJson =
                JsonSerializer.Serialize<Forecast>(forecast, options);
            
            Console.WriteLine(forecastJson);
        }
    }
}

// Produces output like the following example:
//
//{"Date":"2020-10-30T10:11:40.2359135-07:00","TemperatureC":0}

```

### Ignore all default-value properties

To prevent serialization of default values in value type properties, set the `DefaultIgnoreCondition` property to `WhenWritingDefault`, as shown in the following example:

```csharp

using System.Text.Json;
using System.Text.Json.Serialization;

namespace IgnoreValueDefaultOnSerialize
{
    public class Forecast
    {
        public DateTime Date { get; set; }
        public int TemperatureC { get; set; }
        public string? Summary { get; set; }
    };

    public class Program
    {
        public static void Main()
        {
            Forecast forecast = new()
            {
                Date = DateTime.Now,
                Summary = null,
                TemperatureC = default
            };

            JsonSerializerOptions options = new()
            {
                DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingDefault
            };

            string forecastJson =
                JsonSerializer.Serialize<Forecast>(forecast, options);

            Console.WriteLine(forecastJson);
        }
    }
}

// Produces output like the following example:
//
//{ "Date":"2020-10-21T15:40:06.8920138-07:00"}

```

The `WhenWritingDefault` setting also prevents serialization of null-value reference type and nullable value type properties.

## Include fields during serialization

By default, only properties are serialized, but you can configure the serializer to include fields as well. Use the `JsonSerializerOptions.IncludeFields` global setting or the `[JsonInclude]` attribute to include fields when serializing or deserializing, as shown in the following example:

```csharp

using System.Text.Json;
using System.Text.Json.Serialization;

namespace Fields
{
    public class Forecast
    {
        public DateTime Date;
        public int TemperatureC;
        public string? Summary;
    }

    public class Forecast2
    {
        [JsonInclude]
        public DateTime Date;
        [JsonInclude]
        public int TemperatureC;
        [JsonInclude]
        public string? Summary;
    }

    public class Program
    {
        public static void Main()
        {
            string json = """
                {
                    "Date":"2020-09-06T11:31:01.923395",
                    "TemperatureC":-1,
                    "Summary":"Cold"
                }
                """;
            Console.WriteLine($"Input JSON: {json}");

            var options = new JsonSerializerOptions
            {
                IncludeFields = true,
            };
            Forecast forecast = JsonSerializer.Deserialize<Forecast>(json, options)!;

            Console.WriteLine($"forecast.Date: {forecast.Date}");
            Console.WriteLine($"forecast.TemperatureC: {forecast.TemperatureC}");
            Console.WriteLine($"forecast.Summary: {forecast.Summary}");

            string roundTrippedJson =
                JsonSerializer.Serialize<Forecast>(forecast, options);

            Console.WriteLine($"Output JSON: {roundTrippedJson}");

            Forecast2 forecast2 = JsonSerializer.Deserialize<Forecast2>(json)!;

            Console.WriteLine($"forecast2.Date: {forecast2.Date}");
            Console.WriteLine($"forecast2.TemperatureC: {forecast2.TemperatureC}");
            Console.WriteLine($"forecast2.Summary: {forecast2.Summary}");

            roundTrippedJson = JsonSerializer.Serialize<Forecast2>(forecast2);
            
            Console.WriteLine($"Output JSON: {roundTrippedJson}");
        }
    }
}

// Produces output like the following example:
//
//Input JSON: { "Date":"2020-09-06T11:31:01.923395","TemperatureC":-1,"Summary":"Cold"}
//forecast.Date: 9/6/2020 11:31:01 AM
//forecast.TemperatureC: -1
//forecast.Summary: Cold
//Output JSON: { "Date":"2020-09-06T11:31:01.923395","TemperatureC":-1,"Summary":"Cold"}
//forecast2.Date: 9/6/2020 11:31:01 AM
//forecast2.TemperatureC: -1
//forecast2.Summary: Cold
//Output JSON: { "Date":"2020-09-06T11:31:01.923395","TemperatureC":-1,"Summary":"Cold"}

```

To ignore read-only fields, use the JsonSerializerOptions.IgnoreReadOnlyFields global setting.

## Writing JSON files

Writing JSON files is a common task when working with JSON data. The `JsonSerializer` class provides methods to serialize objects to JSON strings, which can then be saved to files. The `File.WriteAllText` method can be used to write the JSON string to a file.

The following example demonstrates how to serialize an object to JSON and save it to a file:

```csharp

using System;
using System.IO;
using System.Text.Json;

class Program
{
      static void Main()
      {
          var customer = new BankCustomer {  };
          string jsonString = JsonSerializer.Serialize(customer);
          File.WriteAllText("customer.json", jsonString);
          Console.WriteLine("JSON file created and saved.");
      }
}

```

## Summary

In this unit, you learned how to customize serialization behavior when serializing C# objects using the `JsonSerializer.Serialize` method. You learned how to ignore properties and fields during serialization and how to write JSON data to files. This knowledge is essential for working with JSON data in C# applications.
