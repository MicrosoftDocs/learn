Let's complete the application by writing code to read the next message in the queue, process it, and then delete it from the queue. 

We're going to place the code into the application and run it when a user selects the appropriate menu items.  In a real-world scenario, this code should be put in its own application dedicated to receiving and processing messages.

## Peeking at the next message

Let's add a new method that peeks at the next message from the queue.

1. Open `Program.cs` source file in your editor.

1. Find the `PeekMessageAsync` method in the application and delete the line throwing a `NotImplementedException`.

1. Add the following code to the method.  This code peeks at the next message on the queue and prints some information about the message.

    ```csharp
            Response<PeekedMessage> response = await queueClient.PeekMessageAsync();
            PeekedMessage message = response.Value;
            
            Console.WriteLine($"Message id  : {message.MessageId}");
            Console.WriteLine($"Inserted on : {message.InsertedOn}");
            Console.WriteLine("We are only peeking at the message, so another consumer could dequeue this message");
    ```

## Receiving and processing messages

Add code to receive and process a message in the application.

1. Find the `ReceiveMessageAsync` method in the application and delete the line throwing a `NotImplementedException`.

1. At the top of the `ReceiveMessageAsync` method, add the following lines of code to get a message from the queue.

    ```csharp
    Response<QueueMessage> response = await queueClient.ReceiveMessageAsync();
    QueueMessage message = response.Value;
    ```

1. Add the following lines of code below the two lines you just added to the method. This code prints some properties about the received message, including the body of the raw message in JSON format.

    ```csharp
    Console.WriteLine($"Message id    : {message.MessageId}");
    Console.WriteLine($"Inserted on   : {message.InsertedOn}");
    Console.WriteLine($"Message (raw) : {message.Body}");
    ```

1. To deserialize the message content into an object that we can work with in our code, add the `ToObjectFromJson` method on the `Body` property of the `QueueMessage` object.  Add the following lines to the method.

    ```csharp
    NewsArticle article = message.Body.ToObjectFromJson<NewsArticle>();
    Console.WriteLine("News Article");
    Console.WriteLine($"-  Headline : {article.Headline}");
    Console.WriteLine($"-  Location : {article.Location}");
    ```

1. Finally, when we've processed the message, we need to delete the message from the queue so no other consumers process it.  Add the following code to the end of the `ReceiveMessageAsync` method.

    ```csharp
    Console.WriteLine("The processing for this message is just printing it out, so now it will be deleted");
    await queueClient.DeleteMessageAsync(message.MessageId, message.PopReceipt);
    Console.WriteLine($"Message deleted");
    ```

    The complete method should look like this:

    ```csharp
    static async Task ReceiveMessageAsync(QueueClient queueClient)
    {
        Response<QueueMessage> response = await queueClient.ReceiveMessageAsync();
        QueueMessage message = response.Value;

        Console.WriteLine($"Message id    : {message.MessageId}");
        Console.WriteLine($"Inserted on   : {message.InsertedOn}");
        Console.WriteLine($"Message (raw) : {message.Body}");

        NewsArticle article = message.Body.ToObjectFromJson<NewsArticle>();
        Console.WriteLine("News Article");
        Console.WriteLine($"-  Headline : {article.Headline}");
        Console.WriteLine($"-  Location : {article.Location}");

        Console.WriteLine("The processing for this message is just printing it out, so now it will be deleted");
        await queueClient.DeleteMessageAsync(message.MessageId, message.PopReceipt);
        Console.WriteLine($"Message deleted");
    }
    ```

## Execute the application

The code is now complete. It can now send and retrieve messages.

1. First, build the application.

    ```dotnetcli
    dotnet build
    ```

1. Run the application

    ```dotnetcli
    dotnet run
    ```

1. Use the menu to experiment with adding messages to, peeking at, and receiving messages on the queue.  Your sample output should look similar to the following.

    ```console
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
    Message sent.  Message id=8f5b9bc7-3e7f-448b-9787-508636963938  Expiration time=10/14/2021 9:01:58 PM +00:00
    
    What operation would you like to perform?
      1 - Send message
      2 - Peek at the next message
      3 - Receive message
      X - Exit program
    2
    
    Message id  : 8f5b9bc7-3e7f-448b-9787-508636963938
    Inserted on : 10/7/2021 9:01:58 PM +00:00
    We are only peeking at the message, so another consumer could dequeue this message
    What operation would you like to perform?
      1 - Send message
      2 - Peek at the next message
      3 - Receive message
      X - Exit program
    3
    
    Message id    : 8f5b9bc7-3e7f-448b-9787-508636963938
    Inserted on   : 10/7/2021 9:01:58 PM +00:00
    Message (raw) : {"Headline":"World leaders to meet at economic summit","Location":"Paris, France"}
    News Article
    -  Headline : World leaders to meet at economic summit
    -  Location : Paris, France
    The processing for this message is just printing it out, so now it will be deleted
    Message deleted
    What operation would you like to perform?
      1 - Send message
      2 - Peek at the next message
      3 - Receive message
      X - Exit program
    X
    ```

