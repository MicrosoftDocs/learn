Now that we have implemented much of the bot's logic, we need to publish it back to the cloud. This can be easily done from within Visual Studio in the same manner, as we did in **unit 3**. It would be even simpler, because publishing profile is already defined for our project, and the whole process would just take one click of a button.

There is one thing we must not forget to do - to make sure files `worldcities.csv` and `countryflags.csv` are copied together with our project. In order to do that, we need to find those files in Visual Studio **Solution Explorer**, and set their properties:

- Build Action = Content
- Copy to Output Directory = Copy if newer

![Solution Explorer](../media/visual-studio-solution-express.png)

Once we publish the bot, there is one more thing we need to do before it works. We have defined additional configuration parameters in `appsettings.json`. Parameters inside the JSON file are used when running the bot locally, but for cloud deployment parameters are defined inside the Azure Portal.

To provide all required parameters for our bot, let's go to the Bot page on the Portal, and click on **Configuration**. You will see the page that lists settings for **MicrosoftAppId** and **MicrosoftAppPassword**:

![Bot Configuration](../media/azure-bot-configuration.png)

Click on **New Application Setting**, and enter all the settings from `appsettings.json` file that are missing, namely `LuisAppId`, `LuisAPIKey`, `LuisEndpointUrl`,`QnAKbId`,`QnAEndpointKey` and `QnAHostname`.

Alternatively, if you prefer to do less clicks but more text editing, you can click on **Advanced edit** and alter JSON file directly. Note that format of this JSON file differs from the format used in `appsettings.json`, and you would need to do some manual conversion.

Once you do that, you should be able to enjoy the chat with the bot through the Web Chat:

![Final Web Chat](../media/final-web-chat.png)

## Connecting the Bot to Communication Channels 

Once you have finished the bot, you probably want to share it with your friends through some common communication channels, such as Skype or Telegram. This can be easily configures through Bot page on Azure Portal, by selecting **Channels** from the left menu:

![Bot Add Channels](../media/add-channel.png)

For example, to add the Bot to Telegram, you can do the following:

- Select **Telegram** from the list of Channels

  ![Add Telegram Channel](../media/add-channel-telegram.png)
  
- Go to Telegram application and create a new bot by talking to **@BotFather** bot. This process is well described in the instruction that is provided inside the link **Step-by-step instructions...** in the setup page.
- Copy the **Access Token** you receive from **@BotFather** into the corresponding text box
- Click **Save**

 After that the bot would be functional in Telegram, and you can share the link with your friends and potential students.
 