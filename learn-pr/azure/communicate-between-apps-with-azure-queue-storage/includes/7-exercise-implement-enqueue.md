Now that all the requirements are in place, you can write code that creates a new storage queue and adds a message. We would typically place this code in our front-end apps that generate the data.

## Add code to send a message

The sample program contains a `SendMessageAsync` method. In this step, you'll write code to implement this method.

1. Locate the `SendMessageAsync` method.

1. Remove the line that throws a `NotImplementedException`.

1. Add the following code at the start of the `SendMessageAsync` to get the details of the new article from the user.

    ```csharp
    // Get input from user
    Console.WriteLine("Enter headline: ");
    string headline = Console.ReadLine();
    Console.WriteLine("Enter location: ");
    string location = Console.ReadLine();
    NewsArticle article = new NewsArticle() { Headline = headline, Location = location };
    ```

1. This code creates a NewsArticle object that we want to store in our queue.  To do so, we'll first serialize the object to JSON and then use the `SendMessageAsync` method to send the message to our queue. Add this code into the `SendMessageAsyc` method after the line that instantiates a `NewsArticle` object.

    ```csharp
    // Build and send the message to the queue
    string message = JsonSerializer.Serialize(article);
    Response<SendReceipt> response = await queueClient.SendMessageAsync(message);
    SendReceipt sendReceipt = response.Value;
    ```

1. Finally, we're going to print out to the console some information about the `SendReceipt` that was included in the response from sending the message. For our application, these fields purely informational, but could be used in an actual application to log or track data about the message submitted to the queue.

    ```csharp
    Console.WriteLine($"Message sent.  Message id={sendReceipt.MessageId}  Expiration time={sendReceipt.ExpirationTime}");
    Console.WriteLine();
    ```

    The  `SendMessageAsync` method should look as follows when complete.

    ```csharp
    static async Task SendMessageAsync(QueueClient queueClient)
    {
        // Get input from user
        Console.WriteLine("Enter headline: ");
        string headline = Console.ReadLine();
        Console.WriteLine("Enter location: ");
        string location = Console.ReadLine();
        NewsArticle article = new NewsArticle() { Headline = headline, Location = location };

        // Build and send the message to the queue
        string message = JsonSerializer.Serialize(article);
        Response<SendReceipt> response = await queueClient.SendMessageAsync(message);
        SendReceipt sendReceipt = response.Value;

        // Print out the send receipt
        Console.WriteLine($"Message sent.  Message id={sendReceipt.MessageId}  Expiration time={sendReceipt.ExpirationTime}");
        Console.WriteLine();
    }
    ```

## Execute the application

You are now ready to build and run the program to send your first message to the queue.

1. Make sure you've saved the file in the code editor and then use the `dotnet build` command in the Cloud Shell to build the application.

    ```dotnetcli
    dotnet build
    ```

1. Run the application

    ```dotnetcli
    dotnet run
    ```

1. When the application runs, choose option 1 to send a message and then input a headline and location of your choice to send a message to the queue. When the menu appears again, you can use 'X' to exit the program.

    You should see output on your screen that looks similar to this.

    ```bash
    What operation would you like to perform?
      1 - Send message
      2 - Peek at the next message
      3 - Receive message
      X - Exit program
    1
    
    Enter headline:
    World leaders to meet at economic summit
    Enter location:
    Paris, France
    Message sent.  Message id=638160c9-f136-49b3-a06c-d2a45739fc4e  Expiration time=10/14/2021 3:49:42 PM +00:00
    
    What operation would you like to perform?
      1 - Send message
      2 - Peek at the next message
      3 - Receive message
      X - Exit program
    X    
    ```

## Check your results

You can check queues in the Azure portal using the Azure CLI, or using Azure PowerShell.  For this example, we'll use the Azure CLI to check the state of our queue.

Run the following command in the Cloud Shell environment.\

```azurecli
az storage message peek --queue-name newsqueue --connection-string $MY_STORAGE_CONNECTION_STRING 
```

This should dump the information for your message, which will look something like this:

```json
[
  {
    "content": "{\"Headline\":\"World leaders to meet at economic summit\",\"Location\":\"Paris, France\"}",
    "dequeueCount": 0,
    "expirationTime": "2021-10-14T15:49:42+00:00",
    "id": "638160c9-f136-49b3-a06c-d2a45739fc4e",
    "insertionTime": "2021-10-07T15:49:42+00:00",
    "popReceipt": null,
    "timeNextVisible": null
  }
]
```
