We've now seen some of the main principles for building responsible bots. Let's apply these concepts as we deploy a basic customer service bot. The easiest way to start is with a Microsoft Bot Framework sample.

Microsoft supports bot operation tasks in Bot Framework. This set of core libraries standardizes bot development. Bot Framework also helps structure bot logic by offering useful developer abstractions like dialogs and form filling. Complex conversations are difficult to program in basic request–response patterns. You can use the Bot Framework abstractions to support complex conversational behavior from the building blocks.

## Create your bot

The Bot Framework samples include code for different levels of bots. You can use them to build basic bots. But you can also use them for advanced conversational-AI bots that use language understanding.

We'll use the **Echo bot** sample. The bot that we'll create can receive messages from a user. As its name suggests, the bot processes those messages by echoing them back to the user.

Follow these steps to create your bot:

1. Go to the [Bot Framework samples][Bot Framework Samples] repository.

1. Download the [Echo bot sample for .NET Core][Echo bot sample].

   :::image type="content" source="../media/download-echo-bot-sample.png" alt-text="Screenshot of the GitHub repository that contains sample bots. The Echo bot download link is called out.":::

1. Save the **Echo bot** files in a project folder on your local machine. Make a note of the folder name.

The **Echo bot** sample provides code for a basic bot that echoes user input. We don't need any additional code to run the bot. But before we deploy the bot, we'll add some features that a responsible customer service bot should offer.

## Explore your bot code

We'll use Visual Studio to develop and test our bot in a local environment. Programming and debugging locally on your machine is faster than rebuilding in the cloud. Visual Studio is a flexible editor with autocomplete and many other useful features.

Let's take a look at our bot's code. Within Visual Studio, we'll use a tool called Solution Explorer.

1. Start Visual Studio.

1. From the Visual Studio start window, select **Open a project or solution**.

1. Navigate to the project folder that contains the sample bot code. Open the `EchoBot.csproj` project file that you downloaded.

1. In **Solution Explorer**, expand your bot's project node. Expand the `Bots` folder next, and then select your bot code file, `EchoBot.cs`:

:::image type="content" source="../media/visual-studio-open-bot-code.png" alt-text="Screenshot that shows how to open your bot code in the Visual Studio Solution Explorer tool window.":::

The code in this file determines the bot's behavior. As you can see, the file contains two functions:

- The `OnMessageActivityAsync` function is the bot's primary function. Each time the bot receives a message from the user, this function is called.
- The `OnMembersAddedAsync` function is called when a new user enters the chat.

Let's edit these functions to change our bot's behavior.

## Edit the code to greet users by name

To improve the experience that customers have while interacting with our bot, we'll start by modifying the `OnMessageActivityAsync` function.

Locate this function in the `EchoBot.cs` file. Currently, the code echoes the user's message:

```csharp
protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity> turnContext, CancellationToken cancellationToken)
{
    var replyText = $"Echo: {turnContext.Activity.Text}";
    await turnContext.SendActivityAsync(MessageFactory.Text(replyText, replyText), cancellationToken);
}
```

The `turnContext.Activity` function contains all the information related to input messages, including message text, `turnContext.Activity.Text`. The function also contains other information like attachments, the sender address, and so on. To send the reply to the user, we use the `SendActivityAsync` function.

Let's change our bot behavior in a small way to make it greet a user by name. When the user types their name, we want our bot to respond with "Hello, name!" To add this feature, we'll make a slight change to the `OnMessageActivityAsync` function. We'll also simplify the code a bit for the sake of clarity.

To make this change:

1. Open the `Bots\EchoBot.cs` file in Visual Studio.

1. In the code editor, locate the `OnMessageActivityAsync` function on line 14.

1. Replace the existing code with the following statements:

   ```csharp
   protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity> turnContext, CancellationToken cancellationToken)
   {
       var name = turnContext.Activity.Text;
       var replyText = $"Hello, {name}!";
       await turnContext.SendActivityAsync(replyText);
   }
   ```

1. Save your changes.

We've now programmed our bot to greet users by name. In the next unit, we'll make one more code change. Then we'll test this functionality.

<!-- Links -->

[Bot Framework Samples]: https://github.com/Microsoft/BotBuilder-Samples/blob/main/README.md
[Echo bot sample]: https://github.com/microsoft/BotBuilder-Samples/tree/main/samples/csharp_dotnetcore/02.echo-bot