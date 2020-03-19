When it comes to storing data locally on your device, there are multiple storage options you can choose from.

In this unit, you'll look at three different storage options and learn when to use each.

## Data storage options

![Illustration showing the three different types of data storage options: preferences, file system, and database.](../media/2-data-storage-options.png)

In Xamarin.Forms, there are three common options for storing data locally:

- **Preferences**: Stores data in key-value pairs
- **File system**: Stores loose files directly on the device through file system access
- **Database**: Stores data in a full relational database

Each storage option serves a different purpose. Choose the best option for your type of data.

### When to use Preferences

**Preferences** are convenient when you're working with simple bits of data. They're often used to enable users to configure the application. For example, going back to the social media application example, suppose you want to enable users to choose the color scheme of the application. Since this choice is a small bit of data, you can store the user's choice in **Preferences** as a key-value pair.

### When to use the file system

Mobile devices have a real file system with a hierarchical directory structure of folders and files. It's convenient to use the file system when you have loose files such as XML, binary, or text files. For example, suppose you want to store a log file locally on the device. You can create a text file, save it to the file system, and write logs to it as events happen.

### When to use a database

It's a good idea to use a local database when you have relationships between data, or when you want to filter the data over time. For example, in the social media example, each post contains data about the post, such as the time stamp and the contents.

However, each post also has a relationship to a user who made the post. It makes sense to represent this relationship in a database to prevent data duplication between posts, and also to improve the efficiency of searching for data.

## What is the app sandbox?

When you're working with loose files such XML files, or with a local database file like SQLite, you need to find the correct place to store them. The *app sandbox* is a private area your application can work with. By default, no other applications can access this area other than the operating system itself.

The location of the app sandbox changes per platform. However, you can access the file path by using a standard .NET API.

To access the app sandbox on Android, you  use the following code snippet:

```csharp
string path = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
```

After you run the code snippet, *path* contains the file path to the location where you can store files for the application to use.

To access the app sandbox on iOS, you use a slightly different code snippet:

```csharp
string docFolder = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
string libFolder = System.IO.Path.Combine(docFolder, "..", "Library");
```

Apple has iOS guidelines for where files should be stored. By default, there are two main folder locations. The first is the **Documents** folder, which is being referenced by the `docFolder` variable that's shown in the code snippet.

Use the **Documents** folder to store user-generated data only. (This is data that's created in direct response to a user action). For example, if you were creating a text-editing application such as Microsoft Word, you would store the document in the **Documents** folder.

The second location for storing files on iOS is the **Library** folder, which is being referenced by the `libFolder` variable that's shown in the previous code snippet. Use the **Library** folder when you're storing data that's app-generated.

For example, you'd store your SQLite database in this location. The database is helping us manage the application. The user didn't specifically ask the application to create it.

## Access library folder with Xamarin.Essentials

Knowing the platform-specific folder locations is useful for debugging issues. Determining the **Library** folder path on these platforms, though, has been abstracted in Xamarin.Essentials to be a single line of code. This abstraction allows you to avoid the iOS-specific path differences.

You access the library folder location using Xamarin.Essentials through the `FileSystem` class.

```csharp
var libFolder = FileSystem.AppDataDirectory;
```

Whether this code is run on iOS or Android, `libFolder` will contain the appropriate **Library** location for app-generated data such as a SQLite database.
