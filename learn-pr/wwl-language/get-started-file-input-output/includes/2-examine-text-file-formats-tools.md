The ability to manage data is a critical aspect of most applications. One fundamental way to manage application data is through file input/output (I/O) operations. File I/O operations allow applications to read from and write to files, enabling data persistence and retrieval between or within sessions. This capability is essential for a wide range of applications, from simple data logging to complex data backup and recovery systems.

In C#, file I/O operations are facilitated by a variety of classes within the `System.IO` namespace. These classes provide properties and methods to work with directories, paths, and files, as well as reading and writing data in different formats. Understanding how to use the `System.IO` classes effectively is key to implementing file storage solutions in your C# applications.

## Review common file I/O operations

Developers use file I/O operations to manage app data in many ways. For example, applications can:

- Persist data: Store data locally to ensure it's retained between application sessions.
- Exchange data: Facilitate data exchange between different applications or systems using common file formats like CSV and JSON.
- Backup and restore: Implement backup and restore functionalities to safeguard important data.
- Analyze data: Perform data analysis or reporting by reading and processing large datasets stored in files.

## Compare structured and unstructured data types

Data can be categorized into two main types: structured and unstructured. Understanding the differences between these types is important for effective data management and storage.

- Structured Storage: Structured storage refers to data that's organized in a predefined manner, typically in rows and columns. This type of storage is highly organized and follows a specific schema, making it easy to query and analyze. The most common example of structured storage is a relational database. Another example of structured data is the comma-separated values (CSV) format that's used to store structured text files.

- Unstructured Storage: Unstructured storage refers to data that doesn't follow a predefined schema or structure. This type of storage is more flexible and can accommodate various types of data, such as text, images, and videos. The most common example of unstructured storage is a file system, where files can be stored in any format without a specific organization. Unstructured data is often stored in formats like JSON, XML, or plain text files. For example, a JSON file containing user profiles with varying attributes is considered unstructured data. The lack of structure makes unstructured data more challenging to analyze and process. The JSON format is often used for data interchange between applications, making it a popular choice for unstructured data storage.

Data can be stored using a hybrid between structured and unstructured formats. Semi-structured data contains some organizational properties but doesn't conform to a strict schema.

## Examine common text file formats

Text file formats are widely used for storing and exchanging data. They're human-readable and easily created, modified, and processed using various programming languages. Some common text file formats include:

- Text file (TXT).
- Comma-separated value (CSV).
- JavaScript object notation (JSON).
- eXtensible Markup Language (XML).

Each of these file formats has its own characteristics, advantages, and use cases. Understanding when and how to use them will help you implement effective file storage solutions in your applications.

### Review the TXT file format

A TXT file is a standard text document that contains unformatted text. It's one of the simplest and most widely used file formats for storing plain text data.

Example:

```plaintext

Hello, this is a simple text file.
It contains multiple lines of text.

```

### Review the CSV file format

A CSV file is used to store tabular data in plain text. Each line in the file represents a row in the table, and columns are separated by commas. CSV files are commonly used for data exchange between applications.

Example:

```plaintext

Name,Age,Occupation
Elize Harmsen,30,Engineer
Peter Zammit,25,Designer

```

### Review the JSON file format

JSON is a lightweight data interchange format that's easy for humans to read and write, and easy for machines to parse and generate. JSON is commonly used for transmitting data in web applications.

Example:

```json

{
    "people": [
        {
            "name": "Elize Harmsen",
            "age": 30,
            "occupation": "Engineer"
        },
        {
            "name": "Peter Zammit",
            "age": 25,
            "occupation": "Designer"
        }
    ]
}

```

JSON supports nested structures, making it suitable for representing complex data. It uses a key-value pair format, where keys are strings and values can be strings, numbers, Booleans, arrays, or other JSON objects. There's a separate Learn module that examines using JSON files: "Store and retrieve JSON files".

### Review the XML file format

XML is a markup language that defines a set of rules for encoding documents in a format that is both human-readable and machine-readable. It's often used for data exchange and configuration files.

Example:

```xml

<?xml version="1.0" encoding="UTF-8"?>
<People>
  <Person>
    <Name>Elize Harmsen</Name>
    <Age>30</Age>
    <Occupation>Engineer</Occupation>
  </Person>
  <Person>
    <Name>Peter Zammit</Name>
    <Age>25</Age>
    <Occupation>Designer</Occupation>
  </Person>
</People>

```

XML uses a tree structure with elements and attributes, allowing for complex data representation. It's widely used in web services and configuration files.

## Examine local, network, and cloud storage options

Data files can be stored in various locations, depending on the application's requirements and the data's accessibility needs. Here are some common storage options:

- Local Storage: Data is stored on the local device, such as a hard drive or SSD. This option is suitable for applications that require fast access to data and don't need to share it with other devices.

- Network Storage: Data is stored on a network-attached storage (NAS) device, allowing multiple devices to access the same data. This option is suitable for collaborative applications where data needs to be shared among users.

- Cloud Storage: Data is stored on cloud services, such as Google Drive, Dropbox, or Microsoft OneDrive. This option provides scalability and accessibility from anywhere with an internet connection. It's suitable for applications that require data to be accessible across multiple devices and locations.

## Examine the System.IO classes commonly used in file I/O operations

The `System.IO` namespace provides a rich set of classes for file I/O operations. Here are some commonly used classes:

- `File` class: The `File` class provides static methods for creating, copying, deleting, moving, and opening files, as well as for reading from and writing to files. It's great for quick and simple file operations.

- `Directory` class: The `Directory` class provides static methods for creating, moving, and enumerating through directories and subdirectories. It's useful for managing directories and their contents.

- `Path` class: The `Path` class performs operations on path strings, such as combining, parsing, and retrieving directory and file names. It's useful for manipulating file and directory paths.

- `StreamReader` class: The `StreamReader` class is designed for reading text files. It provides methods for reading text data line by line, making it convenient for processing text files.

- `StreamWriter` class: The `StreamWriter` class is designed for writing text files. It provides methods for writing text data, making it easy to create and modify text files.

- `FileStream` class: The `FileStream` class provides a stream for reading from and writing to files. It offers more control over file operations, such as reading and writing bytes, handling large files, and performing asynchronous operations.

- `BinaryReader` class: The `BinaryReader` class reads primitive data types as binary values in a specific encoding. It's useful for reading binary files.

- `BinaryWriter` class: The `BinaryWriter` class writes primitive types in binary to a stream and supports writing strings in a specific encoding. It's useful for writing binary files.

- `DirectoryInfo` class: The `DirectoryInfo` class provides instance methods for creating, moving, and enumerating through directories and subdirectories. It offers more detailed information and control compared to the `Directory` class.

- `FileInfo` class: The `FileInfo` class provides instance methods for creating, copying, deleting, moving, and opening files. It offers more detailed information and control compared to the `File` class.

## Summary

In this unit, you learned about file I/O operations and their importance in managing application data. You explored the differences between structured and unstructured data types, examined common text file formats, and reviewed local, network, and cloud storage options. You also learned about the `System.IO` classes commonly used in file I/O operations, including the `File`, `Directory`, `Path`, `StreamReader`, `StreamWriter`, `FileStream`, `BinaryReader`, `BinaryWriter`, `DirectoryInfo`, and `FileInfo` classes. Understanding these concepts is essential for implementing effective file storage solutions in your C# applications.