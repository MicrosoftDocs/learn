In this exercise, you'll use SQLite to store information locally with an application. In the sample scenario, you decided to cache data for the social media app to improve responsiveness. This exercise creates and uses a local SQLite database for storing information about people. You'll save the physical database file in local storage.

## Open the starter solution

1. Clone or download the [exercise repo](https://repo.address.to.go.here). THIS WILL BE ADDED AS WE GET CLOSER TO BUILD CONFERENCE AND BEFORE FINAL PR to MAIN.

    > [!NOTE]
    > It is best to clone or download the exercise content to a short folder path, such as C:\dev\, to avoid build-generated files exceeding the maximum path length.

1. Go to the **exercise1** folder, and then move to the **start** folder.

1. Use Visual Studio to open the **People.sln** solution.

    > [!NOTE]
    > Don't try and build the solution just yet. The code is incomplete and won't compile until you added the missing elements later in this exercise.

## Define a SQLite entity

1. Add a new folder called **Models** to the **People** project.

1. In the **Models** folder, create a new class called **Person**.

1. Modify the class and mark it as `public`.

    ```csharp
    namespace People.Models
    {
       public class Person
       {
       }
    }
    ```

1. Add an `int` property called **Id** to the **Person** class.

1. Add a `string` property called **Name**. The class should look like this:

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

## Add SQLite attributes

1. Add a `using` directive for the **SQLite** namespace to the file for the **Person** class. This directive enables you to use the SQLite attributes.

    ```csharp
    using SQLite;

    namespace People.Models
    {
        public class Person
        {
            ...
        }
    }
    ```

1. Annotate the **Person** class with the [Table] attribute, and specify the table name as **people**.

1. Specify the **Id** property as the primary key. Annotate it with the [PrimaryKey] and [AutoIncrement] attributes.

1. Add annotations to the **Name** property. Specify its **MaxLength** as 250. Specify that each value in the column should be **Unique**.

    The completed class should look like this:

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

## Connect to the database

1. Open the **PersonRepository.cs** file.

1. Examine the **PersonRepository** class. This class contains incomplete skeleton code with `TODO` markers where you'll add the functionality to access the database.

1. Add a private **SQLiteConnection** field named **conn** to the class, above the constructor.

1. In the constructor, initialize the **conn** field to connect to the database using the path provided as the parameters to the constructor.

1. Use the **conn.CreateTable** method to create a table to store **Person** data. The completed constructor should look like this:

    ```csharp
    private SQLiteConnection conn;
    ...
    public PersonRepository(string dbPath)
    {
       conn = new SQLiteConnection(dbPath);
       conn.CreateTable<Person>();
    }

## Insert a row into the database

1. In **PersonRepository** class, find the **AddNewPerson** method.

1. Replace the **TODO** comment in this method with code to insert a new **Person** object. Use the **Insert** method of the **SQLiteConnection** object. Set the **result** variable to the value returned by the **Insert** method, as shown in the following code.

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

## Retrieve rows from the database

1. In the **PersonRepository** class, find the **GetAllPeople** method.

1. Use the generic **Table\<T>** method to retrieve all of the rows in the table. Specify **Person** as the type parameter.

1. Use the **ToList()** extension method to turn the result into a **List\<Person>** collection and return this collection.

1. Add error handling by wrapping your code in a `try-catch` block. If there's an error, set the **StatusMessage** property to the exception's **Message** property and return an empty collection. The completed method should look like this:

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

## Integrate the repository into the UI

1. Open the MauiProgram.cs file.

1. In the **CreateMauiApp** function, after the statements that add the MainPage page as a singleton service to the app, add code to perform the following tasks:

    - Create a string variable named **dbPath**. Initialize this string with the expression `FileAccessHelper.GetLocalFilePath("people.db3")`. The database file used by the app will be called **people.db3**, and the app will save this file in local storage on the device.

    - Use dependency injection to add the `PersonRepository` class as a singleton service to the app. The `PersonRepository` class exposes a constructor that takes the path to the database file as a string parameter.

    The completed code for the **CreateMauiApp** function should look like this:

    ```csharp
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .UseMauiApp<App>()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
            });
        
        builder.Services.AddSingleton<MainPage>();

        string dbPath = FileAccessHelper.GetLocalFilePath("people.db3");
        builder.Services.AddSingleton<PersonRepository>(s => ActivatorUtilities.CreateInstance<PersonRepository>(s, dbPath));

        return builder.Build();
    }
    ```

1. Open the App.xaml.cs file.

1. Add a `public`, `static` property called **PersonRepo** to hold a **PersonRepository** object to the **App** class.

1. Initialize the **PersonRepo** property in the constructor by adding a **PersonRepository** parameter to the constructor, and setting the **PersonRepo** property to the value in this parameter. The completed **App** class should look like this:

    ```csharp
    public partial class App : Application
    {
        public static PersonRepository PersonRepo { get; private set; }

        public App(MainPage page, PersonRepository repo)
        {
            InitializeComponent();

            MainPage = page;
            PersonRepo = repo;
        }
    }
    ```

> [!NOTE]
> The **repo** parameter to the constructor will be populated automatically by the dependency injection process.

## Test the application

1. Build the solution and start debugging the application on Windows. When the UI appears, enter your name and tap **Add Person**.

1. Tap **Get All People**, and verify that your name appears.

    :::image type="content" source="../media/6-add-person-windows.png" alt-text="The Windows app. The user has added a new person to the database.":::

1. Experiment by adding more names and retrieving the list of stored people.

1. Return to Visual Studio and stop debugging.

1. Restart the app and tap **Get All People**. Verify that the names you stored previously are still stored in the database.

1. Return to Visual Studio and stop the app.

1. Start the app again, this time on an Android device (you may need to create a virtual Android device first).

1. Verify that the app works successfully on Android. If you have time and an available Mac, you can also verify the app on iOS using the simulator.

    :::image type="content" source="../media/6-add-person-android.png" alt-text="The Android app. The user has added a new person to the database.":::
