In this unit, you're going to build a person repository application by using SQLite. You can use this application to insert new people into a database and retrieve them later, even after an application restart.

## Open the starter solution

Begin by opening the provided starter solution.

1. Clone or download the [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. Go to the **exercise1** > **start** folder.
1. Open the **People.sln** solution.

## Define a SQLite.NET entity

First, create a model class that's used to define the database schema.

1. Add a new folder called **Models** to the **People** .NET Standard Library.

1. In the **Models** folder, create a new class called **Person**. Make sure that it's marked as *public*.

   ```csharp
   namespace People.Models
   {
      public class Person
      {
      }
   }
   ```

1. Add an *int* property called **Id**.

1. Add a *string* property called **Name**.

   ```csharp
   namespace People.Models
   {
      public class Person
      {
         public int Id { get; set; }
         public string Name { get; set; }
      }
   }
   ```

## Add SQLite.NET attributes

Now that you've created the model, add some attributes to help SQLite.NET map out a class to a table.

1. Add a using directive for the SQLite namespace. The directive enables you to use the SQLite.NET attributes.

1. Annotate the **Person** class with the [Table] attribute, and specify the name as "people".

1. Specify the **Id** property as your primary key. Annotate it with the [PrimaryKey] and [AutoIncrement] attributes.

1. To add some constraints to the data, add annotations to the **Name** property. Specify its [MaxLength] as 250. Specify that each value in the column should be [Unique].

   ```csharp
   using SQLite;

   namespace People.Models
   {
      [Table("people")]
      public class Person
      {
         [PrimaryKey, AutoIncrement]
         public int Id { get; set; }

         [MaxLength(250), Unique]
         public string Name { get; set; }
      }
   }
   ```

1. Build your application and make sure it compiles.

## Add the repository class

Next, you need to add some pre-built code to the cross-platform project. This code has been provided. You can find it in the folder within your cloned or downloaded copy of the exercise repo.

1. Go to the **exercise1** > **start** folder.
1. Open the **People.sln** solution.
1. Add the **PersonRepository.cs** C# source file from the **assets** folder to the shared **People** project. You can drag and drop it from the folder onto the project's root node in the Solution Explorer.
1. Examine the repository class. It has some pre-supplied methods and a few TODO markers where you'll add some functionality to access the database.

## Connect to the database

Now you'll create an instance on **SQLiteConnection**, and then create a **Person** table.

1. Open the **PersonRepository.cs** source file.

1. In the constructor, initialize a new **SQLiteConnection**. Assign it to a field named *conn*.

1. Use the **conn.CreateTable** method to create a table to store **Person** data.

   ```csharp
   private SQLiteConnection conn;
   ...
   public PersonRepository(string dbPath)
   {
      conn = new SQLiteConnection(dbPath);
      conn.CreateTable<Person>();
   }
   ```

## Insert a row into the database

After you create  the **Person** table, you can start inserting data. Implement the **AddNewPerson** method to enable users to insert new people.

1. In **PersonRepository.cs**, find the **AddNewPerson** method.

1. Add code to insert a new **Person** object. Use the **Insert** method on the **SQLiteConnection** object. Assign the return value to the *result* variable that's already defined in the method.

   ```csharp
   public void AddNewPerson(string name)
   {
      int result = 0;
      try
      {
         //basic validation to ensure a name was entered
         if (string.IsNullOrEmpty(name))
               throw new Exception("Valid name required");

         result = conn.Insert(new Person { Name = name });
         ...
      }
      ...
   }
   ```

## Read from the database

At this point, you can add new rows to the **Person** table. Try to read them out by using the **Table** method.

1. In **PersonRepository.cs**, find the **GetAllPeople** method.

1. Use the `Table<T>` method to retrieve all of the records.

1. You can't return the enumerator directly because a `List<Person>` is expected. Use the **ToList()** extension method to turn it into a valid type.

1. Optionally, you can include error handling by wrapping your code into a try-catch block. If there's an error, set the **StatusMessage** property to the exception's **Message**, and return an empty `List<Person>`.

   ```csharp
   public List<Person> GetAllPeople()
   {
      try
      {
         return conn.Table<Person>().ToList();
      }
      catch (Exception ex)
      {
         StatusMessage = string.Format("Failed to retrieve data. {0}", ex.Message);
      }

      return new List<Person>();
   }
   ```

## Connect to the UI

The final step is to add UI to call the methods that you implemented in the previous step. Use a pre-built UI that's included with the exercise **Assets** folder.

1. Replace the **MainPage.xaml** and **MainPage.xaml.cs** in the shared **People** project with the copies you have in the assets. Copy these directly into the folder structure and replace the existing files.

1. Open the **App.xaml.cs** file in the .NET Standard project, and then locate the constructor.

1. Rename the passed-in parameter to `dbPath`, if it's something different.

1. Remove the **Text** property setter on the **MainPage** object. You don't have that property anymore, since you just replaced the UI.

1. Add a public, static property called **PersonRepo** to hold a **PersonRepository** object.

1. Initialize the **PersonRepo** property in the constructor by creating an instance of **PersonRepository** and passing in the **dbPath** parameter to the repository constructor.

## Run the application

Build the solution and run the application. Add some people to your database by typing a name into the text box, and selecting **Add Person**.

After that, you can select  **Get All People** to pull the names out of the database and display them in a list. Also try restarting the application to see if the data persisted across application launches.
