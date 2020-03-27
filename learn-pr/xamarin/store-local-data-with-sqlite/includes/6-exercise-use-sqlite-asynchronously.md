In this unit, you're going to convert your person repository application from the synchronous SQLite.NET API to the asynchronous version. This way, your application will always be responsive no matter how many queries you make to your database.

## Create an Async connection

Start by changing the **PersonRepository** to use the asynchronous version of **SQLiteConnection**.  Now you can interact with your database asynchronously.

1. Open the **PersonRepository.cs** file in the **People** .NET Standard project.

1. Change the **SQLiteConnection** conn property to a **SQLiteAsyncConnection**. To make this change, you have to update the property and the instantiation.

1. In the constructor, notice that the call to **CreateTable** isn't valid anymore. Replace this call with **CreateTableAsync**.

   ```csharp
   private SQLiteAsyncConnection conn;

   public PersonRepository(string dbPath)
   {
      conn = new SQLiteAsyncConnection(dbPath);
      conn.CreateTableAsync<Person>().Wait();
   }
   ```

## Insert an item into a table asynchronously

Now that you're using **SQLiteAsyncConnection**, you can interact with the database asynchronously. Let's look at how you can asynchronously insert a new item.

Modify the **AddNewPerson** method to insert a new **Person** by using an asynchronous insert.

   ```csharp
   using System.Threading.Tasks;
   ...
   public async Task AddNewPersonAsync(string name)
   {
      int result = 0;
      try
      {
         //basic validation to ensure a name was entered
         if (string.IsNullOrEmpty(name))
               throw new Exception("Valid name required");

         // TODO: insert a new person into the Person table
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

Finally, retrieve your **People** from the database asynchronously.

1. Modify the **GetAllPeople** method to return the results by using an asynchronous call.

   ```csharp
   public async Task<List<Person>> GetAllPeopleAsync()
   {
      try
      {
         return await conn.Table<Person>().ToListAsync();
      }
      catch (Exception ex)
      {
         StatusMessage = string.Format("Failed to retrieve data. {0}", ex.Message);
      }

      return new List<Person>();
   }
   ```

1. In the **MainPage.xaml.cs** file, modify both of the **Button.Click** event handlers to use the asynchronous methods from the **PersonRepository** class. Make use of the `async` and `await` keywords.

1. Run the program to verify it still functions correctly.
