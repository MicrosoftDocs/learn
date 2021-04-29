Using the Bot Framework Composer presents some advantages when compared to creating a bot with the SDK and coding.

- Use of Adaptive Dialogs allow for Language Generation (LG), which can simplify interruption handling and give bots character.
- Visual design surface in Composer eliminates the need for boilerplate code and makes bot development more accessible.
- Time saved with fewer steps to set up your environment.
- The Composer bot projects contain reusable assets in the form of JSON and Markdown files that can be bundled and packaged with a bot's source code. The files can be checked into source control systems and deployed along with code updates, such as dialogs, language understanding (LU) training data, and message templates.

You can download and install the Bot Framework Composer from [https://docs.microsoft.com/composer/install-composer](https://docs.microsoft.com/composer/install-composer). The tool is under active development, and updates are available frequently.

> [!NOTE]
> The Bot Framework Composer is pre-installed in the lab environment provided for the exercise later in this module - you will update it to the latest available version in the exercise.

## Explore the Bot Framework Composer

When you first start the Composer, you will see the Home screen where you begin creating your bot.

[![Bot Framework Composer Home screen](../media/home-new-create.png)](../media/home-new-create.png#lightbox)

On the Home screen, you can create a new bot, open an existing bot on your computer, view some tutorial videos, and also examine some example bots created using the Composer. The Home screen can be accessed at any time by selecting **Home** from the **&#9776;** menu.

The **&#9776;** menu provides options for designing and working on your bot. The **Design** option opens up the visual designer where you will lay out the conversation and navigation flow of your bot. If you have a bot project open, selecting *Navigation** will open the designer for that bot.

**Bot Responses** is the option where you can view and select the various options that the Composer provides for responding to users.  Here you will find common response types such as single or multi-line text options as well as some language generation options that allow you to integrate variables in the response.

**User Input** provides options for prompting and accepting input from the user as they interact with your bot.

**Notifications**  you can manage the notifications for the bot here.

**Publish** allows you to manage publishing profiles. Currently, the Composer supports publishing to Azure Functions or Azure Web Apps, both in Preview at this time.

**Skills** you configure any skills that you want your bot to use.  Skills require a Microsoft App ID and a host endpoint.

**Settings**  an editor for the **Bot settings**, **Application settings**, and **Runtime config** options. For example, under **Bot settings**, you would configure the necessary authoring key and endpoint information for LUIS integration. Perhaps you want to log your bot conversations to a CosmosDB instance on Azure so you would edit the CosmosDB section to include the password, app ID, CosmosDB authKey, collectionId, endpoint, and database ID.

The Application settings portion allows you to configure Composer-specific behaviors. You can select a custom runtime option as well in the **Settings** for the Composer. We will not cover custom runtime configs.
