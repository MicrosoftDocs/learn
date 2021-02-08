In this unit, you use a Xamarin.Forms application to consume a basic REST service and perform CRUD operations.

## Create a book REST service

First, you create the REST service so that you can consume it from your application. The REST service that you use is a basic book service. You use it to get a list of books, add new books, and update existing books. The service is already written and deployed to the following web address:

```
https://something.azurewebsites.net
```

This service is configured to store and return user specific book data based on the authorization token that is used when making REST calls. After 1 hour the data for the user will be deleted for the authorization token.

## Open the starter solution

Now that you have the REST service hosted, the rest of the work is done on your local development machine. Let's download the starter solution that contains the Xamarin.Forms application that you use to consume the service.

1. Download or clone the repo from [GitHub](https://github.com/MicrosoftDocs/mslearn-xamarin-consume-rest-services).

    [!include[](../../../includes/android-windows-path-length-warning.md)]

1. In Visual Studio 2019, open the **BookClient** starter solution that's located in the **src/exercise1/start** folder.

## Add NuGet packages

Now that the solution is open, add the Json.NET NuGet package. We use this package to serialize our book into JSON and deserialize the responses we get from the web service.

1. Add the **Json.NET** (named **Newtonsoft.Json**) NuGet package to the **BookClient** project. Also add it to any platform projects you intend to test with, such as iOS or Android. If you use Visual Studio on Windows, right-click the solution node and select **Manage NuGet Packages for Solution**. On Visual Studio for Mac, you add the packages individually to each project via **Add** > **Add Packages**.

## Sign in to the service

The REST service requires you to sign in first to get a token. There's no user authentication. You call a specific endpoint first to get a token. Then you send the token back to the server on each subsequent request in the HTTP header.

1. In the **Data** folder, open **BookManager.cs**.

1. Add the following field to your code. The value should be the URL that you saved previously followed by `/api/books/`.

    ```csharp
    static readonly string BaseAddress = "{Url from before}";
    static readonly string Url = $"{BaseAddress}/api/books/";
    ```

1. Add the following field to hold the token.

    ```csharp
    private string authorizationKey;
    ```

1. Add the following private method called `GetClient` to return an instance of `HttpClient` that contains an `authorizationKey` in its headers. (Add a using statement for the `Newtonsoft.Json` namespace to access Json.NET functionality.)

    ```csharp
    using Newtonsoft.Json;
    ...
    private async Task<HttpClient> GetClient()
    {
        HttpClient client = new HttpClient();
        if (string.IsNullOrEmpty(authorizationKey))
        {
            authorizationKey = await client.GetStringAsync(Url + "login");
            authorizationKey = JsonConvert.DeserializeObject<string>(authorizationKey);
        }

        client.DefaultRequestHeaders.Add("Authorization", authorizationKey);
        client.DefaultRequestHeaders.Add("Accept", "application/json");
        return client;
    }
    ```

## Perform a GET operation

Now that you can authenticate to the service, let's add the code to retrieve the books from the base `Url`.

1. In the **BookManager.cs** file, find the method called `GetAll` that returns a `Task<IEnumerable<Book>>`.

1. Use the `GetClient` method that we created before to retrieve an `HttpClient` to work with.

1. Use `GetStringAsync` on the base `Url` to retrieve the array of books. Use the C# `async` / `await` feature to make the value easy to consume.

1. Pass the returned `string` into `JsonConvert.DeserializeObject` to turn the JSON data into an object graph and return it back to the caller.

    ```csharp
    public async Task<IEnumerable<Book>> GetAll()
    {
        HttpClient client = await GetClient();
        string result = await client.GetStringAsync(Url);
        return JsonConvert.DeserializeObject<IEnumerable<Book>>(result);
    }
    ```

1. Run the application, and select the **Refresh** icon on the toolbar. (Depending on the platform, the toolbar is located at the top or bottom. The icon looks like a pair of arrows in a circle.)

1. After a few seconds, the app loads a set of existing books and displays them.

## Perform a POST operation

The application can now get a list of books. Let's add the ability to create new books by using the `POST` verb.

1. Open the **BookManager** code, and locate the method called `Add`. It has parameters for a title, author, and genre, and it returns `Task<Book>`.

1. In the method, create a new `Book` object, and populate the fields with the passed-in data:
   - Set the ISBN field to an empty `string`.
   - Make sure to create a new `List` to hold the passed-in author.
   - Set the PublishDate to `DateTime.Now`.

1. Get a client from your `GetClient` method.

1. Use the `PostAsync` method against the base `Url` to add the book:
   - Turn the `Book` object into JSON by using `JsonConvert.SerializeObject()`.
   - Create a new `StringContent` object that contains the book as JSON. Use the constructor, which also takes an encoding and media type.
   - The encoding is `Encoding.UTF8`. The media type is `application/json`.

1. The response from the `POST` is a JSON `string` that represents the returned book. Deserialize it to a `Book` object. Return the `Book` instance from the method.

    ```csharp
    public async Task<Book> Add(string title, string author, string genre)
    {
        Book book = new Book() {
            Title = title,
            Authors = new List<string>(new[] { author }),
            ISBN = string.Empty,
            Genre = genre,
            PublishDate = DateTime.Now.Date,
        };

        HttpClient client = await GetClient();
        var response = await client.PostAsync(Url,
            new StringContent(
                JsonConvert.SerializeObject(book),
                Encoding.UTF8, "application/json"));

        return JsonConvert.DeserializeObject<Book>(
            await response.Content.ReadAsStringAsync());
    }
    ```

1. Build and run the application. Select **Add** ([+]) to add the book and return to the main screen.

1. Select **Refresh** to get all the books from the service. It contains the new book you created.

## Perform a PUT operation

Your application can display all books and add new books. What happens if you create a new book that has a mistake? Let's add the ability to perform a `PUT` operation to update a book.

1. Open the `BookManager` class. Locate the method called `Update`, which takes a `Book` and returns a `Task`.

1. In the method implementation, get a new client. Use the `PutAsync` method to send a JSON-encoded book to the base URL with the ISBN added to it. For example, if the ISBN is **12345678**, then the URL is **api/books/12345678**.

1. Just like you did in the `POST` operation, create an instance of `StringContent` for the second parameter of `PutAsync`. Make sure you serialize the book to JSON by using `JsonConvert.SerializeObject()`. Include the encoding and content type as you did before.

1. In this case, we don't have an explicit return type, but we want to return `Task` so that exceptions are properly returned back to the caller. Then the caller can use the `await` keyword to pause the progress of the method until the asynchronous method is finished.

    ```csharp
    public async Task Update(Book book)
    {
        HttpClient client = await GetClient();
        await client.PutAsync(Url + book.ISBN,
            new StringContent(
                JsonConvert.SerializeObject(book),
                Encoding.UTF8, "application/json"));
    }
    ```

1. To try out the logic, run the application and tap on an existing book to edit it.

## Perform a DELETE operation

The last operation that you need to support is the `DELETE` operation. This way you can remove books from the web service.

1. Open the `BookManager` class. Locate the `Delete` method, which takes a `string` ISBN and returns a `Task`.

1. In the method body, get a new client. Use the `DeleteAsync` method against the **base URL + the ISBN**, just like you did in the UPDATE case.

    ```csharp
    public async Task Delete(string isbn)
    {
        HttpClient client = await GetClient();
        await client.DeleteAsync(Url + isbn);
    }
    ```

1. Run the application to test the delete logic. To get to the delete functionality for a specific book, swipe left on the row in iOS or perform a long press on the row on Android.
