When you're working with complex objects, the `JsonSerializerOptions` class and Data Transfer Objects (DTOs) can be used to avoid processing issues. Complex objects often contain nested structures, special data types, or require specific configurations to handle serialization and deserialization effectively. The `JsonSerializerOptions` class provides various properties that can be customized to address these challenges. For example, properties can be used to add custom converters, enable case-insensitive property matching, or handle null values. DTOs, on the other hand, serve as intermediary objects that simplify the transfer of data between different layers of an application, ensuring that the structure and types of the data are consistent and manageable. By leveraging `JsonSerializerOptions` and DTOs, developers can achieve more reliable and efficient serialization and deserialization of complex JavaScript Object Notation (JSON) data, making it easier to work with and integrate into their applications.

## Use the JsonSerializerOptions class to help serialize complex objects

The `JsonSerializerOptions` class is part of the `System.Text.Json` namespace and provides a way to configure the behavior of JSON serialization and deserialization. It allows you to customize various aspects of the serialization process, such as how properties are handled, how references are managed, and how special data types are processed.

The `JsonSerializerOptions` class is useful when dealing with complex objects, as it provides options to handle nested structures, circular references, and other serialization challenges.

The following properties are demonstrated during this unit:

- MaxDepth: This property sets the maximum depth allowed when reading or writing JSON. It can help prevent issues with deeply nested objects that may cause stack overflow or performance problems.
- ReferenceHandler: This property allows you to specify how references to objects are handled during serialization and deserialization. It can be useful when dealing with circular references or complex object graphs.

Another property that helps with serializing and deserializing complex objects is `Converters`. This property allows you to add custom converters to handle specific types or complex objects. For example, you can create a custom converter for a class that contains nested objects or complex properties.

## Use the JsonSerializerOptions.ReferenceHandler property

The `ReferenceHandler` property is used to specify how references to objects are handled during serialization and deserialization. This is particularly useful when dealing with complex object graphs that may contain circular references or shared references.

A circular reference occurs when two or more objects reference each other, creating a loop. For example, if you have an object `A` that references object `B`, and object `B` references object `A`, this creates a circular reference. When you serialize such objects, the serializer may encounter an infinite loop, leading to a stack overflow error.

Consider the following code sample that demonstrates a circular reference between two classes:

```csharp

public class Person
{
    public string Name { get; set; }
    public List<Pet> Pets { get; set; }
}

public class Pet
{
    public string Name { get; set; }
    public Person Owner { get; set; }
}

```

In this example, the `Person` class has a list of `Pet` objects, and each `Pet` object has a reference back to its owner (the `Person`). This creates a circular reference when you're serializing or deserializing the objects.

Serializing the `Person` object with the default settings results in a `JsonException` due to the circular reference. To handle this, you can use the `ReferenceHandler` property of the `JsonSerializerOptions` class.

```csharp

var options = new JsonSerializerOptions
{
    ReferenceHandler = ReferenceHandler.Preserve,
    WriteIndented = true
};

var person = new Person
{
    Name = "John",
    Pets = new List<Pet>
    {
        new Pet { Name = "Fido", Owner = null },
        new Pet { Name = "Whiskers", Owner = null }
    }
};

person.Pets[0].Owner = person;
person.Pets[1].Owner = person;

var json = JsonSerializer.Serialize(person, options);
Console.WriteLine(json);

/*

OUTPUT (with WriteIndented = true):
 
{
  "$id": "1",
  "Name": "John",
  "Pets": {
    "$id": "2",
    "$values": [
      {
        "$id": "3",
        "Name": "Fido",
        "Owner": {
          "$ref": "1"
        }
      },
      {
        "$id": "4",
        "Name": "Whiskers",
        "Owner": {
          "$ref": "1"
        }
      }
    ]
  }
}

*/

```

In this example, the `ReferenceHandler.Preserve` option is used to handle circular references. The serializer includes a `$id` property in the JSON output to represent the reference, allowing it to be deserialized correctly.

When deserializing, the `ReferenceHandler.Preserve` option also ensures that the references are restored correctly, preventing duplicate objects from being created.

```csharp

var deserializedPerson = JsonSerializer.Deserialize<Person>(json, options);
Console.WriteLine($"Name: {deserializedPerson.Name}");

foreach (var pet in deserializedPerson.Pets)
{
    Console.WriteLine($"Pet Name: {pet.Name}, Owner: {pet.Owner.Name}");
}

/*

OUTPUT:
 
Name: John
Pet Name: Fido, Owner: John
Pet Name: Whiskers, Owner: John

*/

```

In this example, the deserialized `Person` object has the same references as the original object, preserving the relationships between the `Person` and `Pet` objects.

## Use Data Transfer Objects to help serialize and deserialize complex objects

Data Transfer Objects are often used in scenarios where you need to serialize and deserialize complex objects.

DTOs provide the following benefits:

- Simplified data structure: DTOs can simplify the data structure by flattening nested objects or removing unnecessary properties. This makes it easier to serialize and deserialize the data without dealing with complex object graphs.
- Selective serialization: DTOs allow you to control which properties are included in the serialized output. This can help reduce the size of the serialized data and improve performance.
- Decoupling: DTOs decouple the data structure from the business logic, making it easier to manage and maintain the code. This separation of concerns also makes it easier to change the serialization format without affecting the rest of the application.
- Data contracts: DTOs act as data contracts, defining the structure of the data that's serialized and deserialized. This makes it easier to ensure consistency and compatibility between different parts of the application or between different applications.
- Interoperability: DTOs can help ensure that the data structure is compatible with other systems or services, making it easier to integrate with external APIs or services.
- Versioning: DTOs can help manage versioning of data structures, allowing you to evolve the data model without breaking existing clients or services.
- Security: DTOs can help improve security by limiting the exposure of internal data structures. By using DTOs, you can control which properties are serialized and deserialized, reducing the risk of exposing sensitive information.
- Performance: DTOs can help improve performance by reducing the amount of data transferred over the network. By using DTOs, you can serialize only the properties that are needed, reducing the size of the serialized data and improving performance.

You can selectively serialize portions of an object by creating a custom DTO that includes only the properties you want to serialize. This approach allows you to control exactly what gets serialized without including nested objects.

### Creating and using DTOs for serialization

Here's a step-by-step guide on how to create and use DTOs for serialization in C#:

- Define the DTO: Create a class that contains only the properties and method results that you want to serialize.
- Map the original object to the DTO: Create a method to map the original object to the DTO. This method extracts the necessary data from the original object and populates the DTO.
- Serialize the DTO: Use the `JsonSerializer` class to serialize the DTO to a JSON string.
- Deserialize the DTO: Use the `JsonSerializer` class to deserialize the JSON string back to the DTO.
- Map the DTO back to the original object: Create a method to map the DTO back to the original object. This method extracts the data from the DTO and populates the original object.

The following example demonstrates how to create and use DTOs for serialization and deserialization of complex objects:

```csharp

using System;
using System.Text.Json;
using System.Text.Json.Serialization;


public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
}

public class Company
{
    public string Name { get; set; }
    public List<Employee> Employees { get; set; }

    // Constructor to initialize the Employees list
    public Company(Employee employee)
    {
        Name = "Contoso Ltd";
        Employees = new List<Employee> { employee };
    }
}

public class Employee
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Gender { get; set; }
    public string Address { get; set; }
    public string Email { get; set; }
    public int EmployeeId { get; set; }
    public double Salary { get; set; }
    public List<Person> Dependents { get; set; }
    public List<Person> EmergencyContacts { get; set; }

    // Constructor to initialize the lists
    public Employee()
    {
        Dependents = new List<Person>();
        EmergencyContacts = new List<Person>();
    }
}

public class EmployeeDTO
{
    public string Name { get; set; }
    public int EmployeeId { get; set; }

}

class Program
{
    static void Main()
    {
        // Create an Employee object
        Employee employee = new Employee
        {
            Name = "Elize Harmsen",
            Age = 35,
            Gender = "Female",
            Address = "123 Main St",
            Email = "elize@example.com",
            EmployeeId = 101,
            Salary = 75000,
            Dependents = new List<Person>
            {
                new Person { Name = "Peter Zammit", Age = 35 }
            },
            EmergencyContacts = new List<Person>
            {
                new Person { Name = "Anette Thomsen", Age = 40 }
            }
        };

        // Create a Company object with the Employee
        Company company = new Company(employee);

        // Map Employee to EmployeeDTO
        EmployeeDTO employeeDTO = new EmployeeDTO
        {
            Name = employee.Name,
            EmployeeId = employee.EmployeeId
        };

        // Serialize EmployeeDTO to JSON
        string json = JsonSerializer.Serialize(employeeDTO);
        Console.WriteLine("Serialized EmployeeDTO:");
        Console.WriteLine(json);

        // Deserialize JSON back to EmployeeDTO
        EmployeeDTO deserializedEmployeeDTO = JsonSerializer.Deserialize<EmployeeDTO>(json);

        // Use the deserialized object to create a new Employee object
        Employee newEmployee = new Employee
        {
            Name = deserializedEmployeeDTO.Name,
            EmployeeId = deserializedEmployeeDTO.EmployeeId
        };

        // Use the newEmployee.EmployeeId to find the original Employee object in the Company
        Employee foundEmployee = company.Employees.Find(e => e.EmployeeId == newEmployee.EmployeeId);
        if (foundEmployee != null)
        {
            Console.WriteLine("Found Employee:");
            Console.WriteLine($"Name: {foundEmployee.Name}");
            Console.WriteLine($"Age: {foundEmployee.Age}");
            Console.WriteLine($"Gender: {foundEmployee.Gender}");
            Console.WriteLine($"Email: {foundEmployee.Email}");
            Console.WriteLine($"EmployeeId: {foundEmployee.EmployeeId}");
            Console.WriteLine($"Salary: {foundEmployee.Salary}");
            Console.WriteLine($"Dependents: {string.Join(", ", foundEmployee.Dependents.Select(d => d.Name))}");
            Console.WriteLine($"Emergency Contacts: {string.Join(", ", foundEmployee.EmergencyContacts.Select(ec => ec.Name))}");
        }
        else
        {
            Console.WriteLine("Employee not found in the company.");
        }
    }
}

```

In this example, the `EmployeeDTO` class is created to represent a simplified version of the `Employee` class. The `EmployeeDTO` class contains only the properties that are needed for serialization. The `Employee` class contains additional properties that aren't included in the DTO. The `Company` class contains a list of `Employee` objects. The `Main` method demonstrates how to create an `Employee` object, map it to the `EmployeeDTO`, serialize the DTO to JSON, and then deserialize it back to the DTO. Finally, it shows how to find the original `Employee` object in the `Company` using the deserialized DTO.

This approach allows you to control the serialization process and avoid issues with complex object graphs. By using DTOs, you can simplify the data structure and ensure that only the necessary properties are included in the serialized output.

## Summary

In this unit, you learned how to manage serialization and deserialization of complex objects using the `JsonSerializerOptions` class and Data Transfer Objects (DTOs). The `JsonSerializerOptions` class provides various properties that can be customized to handle complex objects, such as `MaxDepth`, `ReferenceHandler`, and `Converters`. The `ReferenceHandler` property is particularly useful for handling circular references in complex objects. DTOs are intermediary objects that simplify the transfer of data between different layers of an application, allowing you to control which properties are included in the serialized output. By leveraging these techniques, you can achieve more reliable and efficient serialization and deserialization of complex JSON data, making it easier to work with and integrate into your applications.
