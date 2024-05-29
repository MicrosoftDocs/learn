The application works well, but if the database contains many rows, the UI can become unresponsive while the app performs database queries and other operations. In this exercise, you'll convert the application from the synchronous SQLite API to the asynchronous version. This way, your application will always be responsive no matter how many queries you make to your database.

## Create an Async connection

1. Open the **PersonRepository.cs** file in the **People** project.

1. Modify the `Init` method's definition to be `async`. Change the return type of the method to `Task`.

1. Change the `conn` property to a `SQLiteAsyncConnection` and update the code in the `Init` method that initializes the connection.

1. Replace the call to the synchronous `CreateTable` method with the asynchronous `CreateTableAsync` method.

    The completed code should look like this:

    ```csharp
    private SQLiteAsyncConnection conn;

    private async Task Init()
    {
        if (conn != null)
            return;
        
        conn = new SQLiteAsyncConnection(_dbPath);
    
        await conn.CreateTableAsync<Person>();
    }
    ```

## Insert an item into a table asynchronously

1. Modify the definition of the `AddNewPerson` method to be `async`. Change the return type of the method to `Task`.

1. Add the `await` keyword to the `Init` method call because `Init` is now an `async` method.

1. Update the `AddNewPerson` method to insert a new `Person` by using an asynchronous insert operation.

    The code should look like this:

    ```csharp
    using System.Threading.Tasks;
    ...
    public async Task AddNewPerson(string name)
    {
       int result = 0;
       try
       {
          // Call Init()
          await Init();

          // basic validation to ensure a name was entered
          if (string.IsNullOrEmpty(name))
                throw new Exception("Valid name required");
    
          result = await conn.InsertAsync(new Person { Name = name });
    
          StatusMessage = string.Format("{0} record(s) added [Name: {1})", result, name);
       }
       catch (Exception ex)
       {
          StatusMessage = string.Format("Failed to add {0}. Error: {1}", name, ex.Message);
       }
    }
    ```

## Get all items from a table asynchronously

1. Modify the `GetAllPeople` method definition. This method should be `async` and return a `Task<List<Person>>` object.

1. Add the `await` keyword to the `Init` method call.

1. Update the method to return the results by using an asynchronous call.

    The code should look like this:

    ```csharp
    public async Task<List<Person>> GetAllPeople()
    {
       try
       {
          await Init();
          return await conn.Table<Person>().ToListAsync();
       }
       catch (Exception ex)
       {
          StatusMessage = string.Format("Failed to retrieve data. {0}", ex.Message);
       }
    
       return new List<Person>();
    }
    ```

1. Save the **PersonRepository.cs** file.

## Test the asynchronous functionality

1. Expand **MainPage.xaml** in the Solution Explorer and open the **MainPage.xaml.cs** file.

1. Modify both of the button-click event handlers to use the asynchronous methods from the `PersonRepository` class. Make use of the `async` and `await` keywords:

    ```csharp
      public async void OnNewButtonClicked(object sender, EventArgs args)
      {
         statusMessage.Text = "";

         await App.PersonRepo.AddNewPerson(newPerson.Text);
         statusMessage.Text = App.PersonRepo.StatusMessage;
      }

      public async void OnGetButtonClicked(object sender, EventArgs args)
      {
         statusMessage.Text = "";

         List<Person> people = await App.PersonRepo.GetAllPeople();
         peopleList.ItemsSource = people;
      }
    ```

1. Save the **MainPage.xaml.cs** file.

1. Build and run the program on Windows and Android to verify it still functions as before.
