.NET MAUI provides multiple storage options for caching data locally on a device, depending on the nature, structure, and size of the data. The three most commonly used options for storing data locally in a .NET MAUI app are:

- **Preferences**: Stores data in key-value pairs
- **File system**: Stores loose files directly on the device through file-system access
- **Database**: Stores data in a relational database

:::image type="content" source="../media/2-data-storage-options.svg" alt-text="Diagram of the common local storage options available to a .NET MAUI app.":::

In this unit, you'll look at these storage options and the situations for which each option is most appropriate.

## When to use Preferences

**Preferences** are convenient when you're working with simple pieces of data such as user selections. They're often used to allow users to configure the application. You store this data as a set of key/value pairs. For example, suppose you wanted the user to be able to specify whether the app should save their username and password between session. You can store the user's choice in **Preferences**.

The following code shows how to store a Boolean value recorded in the `saveLoginDetails` variable to a preference named `SaveLogin`, and then later read this data back. Notice that the `Get` method expects you to provide a default value if the specified preference isn't found:

```csharp
bool saveLoginDetails = ...;
...
Preferences.Set("SaveLogin", saveLoginDetails);
...
var savedPreference = Preferences.Get("SaveLogin", false);
```

The `Preferences` class also contains methods for determining whether a named preference exists (`ContainsKey`), deleting a preference (`Remove`), and removing all preference data (`Clear`).

> [!NOTE]
> You should only store simple data types as preferences. You cannot store references to large objects such as lists, collections, and arrays. For this type of data, use the file system or a database.

## When to use the file system

Mobile and desktop devices have a file system with a hierarchical directory structure of folders and files. It's convenient to use the file system when you have loose files such as XML, binary, or text files. For example, suppose you want to store log data locally on the device. You can create a text file, save this file to the file system, and write logs to it as events happen. You can also serialize large data structures to a file, and cache it locally on the file system if you need to save when the app shuts down. When the app restarts, you can re-read this data back into memory. The following code shows examples of serializing data to a file and saving this file, and then reading the data back and deserializing it back into memory later. Here, we use JSON for the serialization format, but you can save the data in whatever format you feel is most appropriate to the nature of the data and the app's security requirements.

```csharp
using System.Text.Json;
using System.IO;

// Data to be written to the file system, and read back later
List<Customer> customers = ...;

// Serialize and save
string fileName = ...;
var serializedData = JsonSerializer.Serialize(customers);
File.WriteAllText(fileName, serializedData);
...

// Read and deserialize
var rawData = File.ReadAllText(fileName);
customers = JsonSerializer.Deserialize<List<Customer>>(rawData);
```

### Access the app sandbox

When you're working with loose files such XML files, you need to store them in a suitable location in the file system. Some of this data might be sensitive, and you don't want to save it to a location where other apps or users could easily access it. .NET MAUI apps provide the **app sandbox**. The app sandbox is a private area with which your application can work. By default, no other applications can access this area other than the operating system. You can access the sandbox by using the `AppDataDirectory` static property of the `FileSystem` class:

```csharp
string path = FileSystem.AppDataDirectory;
```

In this code, the `path` variable contains the file path to the location where you can store files for the application to use. You can read and write data to files in this folder using the techniques shown in the *When to use the file system* section.

> [!NOTE]
> The `FileSystem.AppDataDirectory` property is an abstraction of a device-specific path; it evaluates to different folders on Android, iOS, and WinUI3. This abstraction allows you to write code that references the sandbox in a manner that's independent of the platform on which it runs. Use this abstraction rather than referencing a device-specific path explicitly in your code.

### Guidelines for saving data in iOS apps

Apple has iOS guidelines for where files should be stored. There are two main folder locations:

- **The *Library* folder**: This folder is returned by the `FileSystem.AppDataDirectory` property, as described previously. Use the Library folder when you're storing data that's app-generated.

- **The *Documents* folder**: The following code snippet shows how to reference this folder in the `docFolder` variable. Use the Documents folder to store user-generated data only. This data is created in direct response to a user action. For example, if you were creating a text-editing application such as Microsoft Word, you'd store the document in the Documents folder.

    ```csharp
    string docFolder = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
    ```

## When to use a database

It's a good idea to use a local database when you have relationships between data, or when you want to filter the data over time. For example: in the social-media scenario, each post contains data about the post, such as the timestamp and the contents. However, each post also has a relationship to a user who made the post. It makes sense to represent this relationship in a database to prevent data duplication between posts, and also to improve the efficiency of searching for data.

A SQLite database is a file, and you need to store it in an appropriate place. Ideally, you should create a folder under the `AppDataDirectory` folder in the sandbox and create the database in this folder.
