In C# applications, text files are often used to store and exchange data. The `System.IO` namespace provides classes for reading and writing text files, allowing developers to easily manipulate text data. Two commonly used classes for this purpose are `StreamReader` and `StreamWriter`.

The `StreamReader` class is used to read characters from a byte stream in a particular encoding, while the `StreamWriter` class is used to write characters to a stream in a specific encoding. The `StreamReader` and `StreamWriter` classes are useful for working with text files, such as comma-separated values (CSV) files, where data is organized in rows and columns.

## What are streams?

In .NET, streams are used to represent a sequence of bytes that can be read from or written to. Streams provide a way to work with data in a flexible and efficient manner, allowing you to read and write data in various formats, including text, binary, and network streams. The `Stream` class is the base class for all streams in .NET, and it provides methods for reading and writing data, as well as for seeking to specific positions within the stream.

The `Stream` class is abstract, meaning it can't be instantiated directly. Instead, you use derived classes such as `FileStream`, `MemoryStream`, `NetworkStream`, and others to work with specific types of data sources.

The `StreamReader` and `StreamWriter` classes are built on top of the `Stream` class, providing additional functionality for reading and writing text data.

## Read and write text files using the StreamReader and StreamWriter classes

The `StreamReader` and `StreamWriter` classes are designed to work with text data, which is typically represented as a sequence of characters. They handle the encoding and decoding of characters to and from bytes, allowing you to work with text files in various of formats, including UTF-8, ASCII, and Unicode.

The `StreamReader` class is used to read text from a stream, while the `StreamWriter` class is used to write text to a stream.

> [!NOTE]
> The `StreamReader` and `StreamWriter` classes implement the `IDisposable` interface, which means they should be used within a `using` statement to ensure that resources are properly released when the operations are complete.

### Use StreamWriter to write text files

The `StreamWriter` class is used to write characters to a stream in a specific encoding. It provides methods for writing text files line by line or character by character. The `StreamWriter` class is useful for writing large files, as it allows you to write data in a memory-efficient manner.

The `StreamWriter` class includes the following methods:

- `Write()`: Writes the specified string to the current stream.
- `WriteLine()`: Writes the specified string followed by a line terminator to the current stream.
- `Flush()`: Clears all buffers for the current writer and causes any buffered data to be written to the underlying device.

The following example demonstrates how to use the `StreamWriter` class to write data to a CSV file:

```csharp

using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        string filePath = "data.csv";

        using (StreamWriter writer = new StreamWriter(filePath, false, Encoding.UTF8))
        {
            // Write some data
            writer.WriteLine("Name,Age,Occupation");
            writer.WriteLine("Elize Harmsen,30,Engineer");
            writer.WriteLine("Peter Zammit,25,Designer");
            writer.WriteLine("Niki Demetriou,35,Manager");
        }

        Console.WriteLine($"CSV file created at: {filePath}");
    }
}

```

This code creates a CSV file and writes some sample data to it. The `StreamWriter` class automatically handles the encoding, making it easy to write text files in various formats.

The `using` statement ensures that the `StreamWriter` is properly disposed of after use, releasing any resources associated with it. This is important for managing system resources and preventing memory leaks. If you don't use a `using` statement, you should call the `Close()` method on the `StreamWriter` to ensure that the file is properly closed and resources are released. You can also call the `Dispose()` method directly, but using a `using` statement is the recommended approach.

### Use StreamReader to read text files

The `StreamReader` class is used to read characters from a byte stream in a specific encoding. It provides methods for reading text files line by line or character by character. The `StreamReader` class is useful for reading large files, as it allows you to read data in a memory-efficient manner.

The `StreamReader` class includes the following methods:

- `Read()`: Reads the next character from the input stream and advances the position of the reader by one character.
- `ReadLine()`: Reads a line of characters from the current stream and returns it as a string.
- `ReadToEnd()`: Reads all characters from the current position to the end of the stream and returns them as a string.
- `Peek()`: Returns the next available character without advancing the position of the reader.

The following example demonstrates how to use the `StreamReader` class to read a CSV file line by line:

```csharp

using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        string filePath = "data.csv";

        using (StreamReader reader = new StreamReader(filePath, Encoding.UTF8))
        {
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }
        }
    }
}

```

This code reads a CSV file line by line and prints each line to the console. The `StreamReader` class automatically handles the encoding, making it easy to read text files in various formats.

The `using` statement ensures that the `StreamReader` is properly disposed of after use, releasing any resources associated with it. Like `StreamWriter`, the `StreamReader` class provides `Close()` and `Dispose()` methods, but using a `using` statement is the recommended approach.

## Use CSV files in an object-oriented application

CSV files are widely used to store and exchange data, and they can be easily read and written using the `StreamReader` and `StreamWriter` classes. However, when working with CSV files, it may be necessary to convert data between CSV format and object-oriented representations. For example, if your application uses CSV files to store or exchange `Employee` class information, you need to convert between CSV strings and `Employee` objects.

There are lots of ways to write code that covert between CSV strings and objects. Using the `StringBuilder` class and the `String.Split` method is one of the most common approaches. The `StringBuilder` class is used to efficiently build strings, while the `String.Split` method is used to parse CSV strings into their individual components.

The `StringBuilder` class is part of the `System.Text` namespace and provides a mutable string representation that can be modified without creating new string instances. This is useful when constructing CSV strings from objects, as it allows for efficient concatenation and manipulation of string data.

The `String.Split` method is used to split a string into an array of substrings based on a specified delimiter. In the case of CSV files, the delimiter is typically a comma (`,`). The `Split` method can be used to parse CSV strings into their individual components, allowing you to create objects from the parsed data.

The following example demonstrates how to create an `Employee` class, write employee data to a CSV file, and read the data back into `Employee` objects:

```csharp
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

class Employee
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Occupation { get; set; }

    public override string ToString()
    {
        return $"{Name},{Age},{Occupation}";
    }
}

class Program
{
    static void Main()
    {
        string filePath = "data_with_header.csv";

        // Create a list of employees
        List<Employee> employees = new List<Employee>
        {
            new Employee { Name = "Elize Harmsen", Age = 30, Occupation = "Engineer" },
            new Employee { Name = "Peter Zammit", Age = 25, Occupation = "Designer" },
            new Employee { Name = "Niki Demetriou", Age = 35, Occupation = "Manager" }
        };

        // Write employees to a CSV file with a header
        using (StreamWriter writer = new StreamWriter(filePath))
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("Name,Age,Occupation"); // Write the header

            foreach (var employee in employees)
            {
                sb.AppendLine(employee.ToString()); // Write each employee as a CSV row
            }

            writer.Write(sb.ToString());
        }

        // Append additional employees to the CSV file without a header
        List<Employee> additionalEmployees = new List<Employee>
        {
            new Employee { Name = "Hannah Haynes", Age = 28, Occupation = "Developer" },
            new Employee { Name = "Conrad Nuber", Age = 32, Occupation = "Analyst" }
        };

        using (StreamWriter writer = new StreamWriter(filePath, true))
        {
            StringBuilder sb = new StringBuilder();

            foreach (var employee in additionalEmployees)
            {
                sb.AppendLine(employee.ToString()); // Append each employee as a CSV row
            }

            writer.Write(sb.ToString());
        }

        // Create a list to hold employees read from the CSV file
        List<Employee> readEmployees = new List<Employee>();

        // Read the CSV file and create Employee objects
        using (StreamReader reader = new StreamReader(filePath))
        {
            string headerLine = reader.ReadLine(); // Read the header line
            Console.WriteLine($"Header: {headerLine}");


            string line;
            while ((line = reader.ReadLine()) != null)
            {
                string[] data = line.Split(',');
                Employee employee = new Employee
                {
                    Name = data[0],
                    Age = int.Parse(data[1]),
                    Occupation = data[2]
                };
                readEmployees.Add(employee);
            }
        }

        // Display the list of employees
        foreach (var employee in readEmployees)
        {
            Console.WriteLine($"Name: {employee.Name}, Age: {employee.Age}, Occupation: {employee.Occupation}");
        }

    }
}
```

In this example, we create an `Employee` class with properties for `Name`, `Age`, and `Occupation`. We then create a list of employees and write their data to a CSV file with a header row. After that, we append additional employees to the same CSV file without writing the header again. Finally, we read the CSV file back into `Employee` objects and display their information.
The `ToString()` method of the `Employee` class is overridden to provide a string representation of the object in CSV format. This allows us to easily convert `Employee` objects to CSV strings when writing to the file.

## Should you include a header in a CSV file?

Including a header in a CSV file is a common practice, but whether or not to include one depends on the specific use case and requirements of the data being represented. A header row typically contains the names of the columns, providing context for the data that follows. It can be beneficial for both human readability and programmatic access to the data.

There are several reasons why you might want to include a header in a CSV file:

- **Readability**: A header row provides context for the data, making it easier for users to understand the meaning of each column. This is especially important when sharing files with others who may not be familiar with the data structure.

- **Data integrity**: Including a header row can help prevent data entry errors by clearly defining the expected format and content of each column. This can be useful when importing data into databases or other systems.

- **Interoperability**: Many applications and libraries that work with CSV files expect a header row. Including a header can improve compatibility with these tools and make it easier to import or export data between different systems.

- **Documentation**: A header row serves as a form of documentation for the data, providing information about the structure and meaning of the data without requiring additional documentation or comments.

There are also scenarios where you might not want to include a header in a CSV file:

- **Machine-readable files**: If the CSV file is intended to be consumed by a program or system that already knows the structure of the data (e.g., the order and meaning of the columns), a header may not be necessary. This can reduce file size slightly and simplify parsing.

- **Performance optimization**: In cases where performance is critical and the file is very large, omitting the header can save processing time and storage space, especially if the header would be redundant for the intended use.

- **Legacy systems**: Some legacy systems or tools may not support headers in CSV files and expect raw data without any descriptive row at the top.

- **Minimalist data sharing**: If the file is being shared in a context where the structure is well-documented or agreed upon (e.g., between collaborators who already know the schema), a header might not be necessary.

However, in most cases, including a header is recommended because it improves the readability and usability of the file, especially for human users or when the file's structure isn't predefined. Headers provide context for the data and make it easier to interpret, debug, and integrate with other systems.

## Summary

In this unit, you learned how to read and write text files using the `StreamReader` and `StreamWriter` classes in C#. You also learned how to convert between CSV strings and objects using the `StringBuilder` class and the `String.Split` method.
