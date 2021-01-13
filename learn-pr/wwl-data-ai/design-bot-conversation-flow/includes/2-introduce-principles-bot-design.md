Developing a bot is similar to developing other software applications from the perspective of a lifecycle. Your bot application should follow a general lifecycle model for creation and improvement. One recommended model is depicted in figure 1-1.

:::image type="content" source="../media/bot-lifecycle.png" alt-text="bot lifecycle":::
*Figure 1-1*

The first segment focuses on the bot design. Good design techniques are discussed in this article. The next segment focuses on building your bot.  There are different ways to build the bot itself using the aspects of the bot framework and service. Testing is an important part of the lifecycle because it helps to ensure your designs are creating the interactions that you designed into the bot.

After successfully building and testing, your next step in the lifecycle is to publish the bot for consumption.  Publishing makes the bot available for consumption by users and applications. Once the bot is published, users connect to the bot through the channels that you designed into the bot (Skype, email, Slack, etc.).

Finally, you perform evaluation of the bot as it is used in its published form. Your evaluation should consist of user interactions, issues connecting to the bot, service-level insights, and performance. Use this data to improve your bot over time. Evaluations may also determine that a bot is not offering the experience you anticipated and you may need to revisit the design phase again.

## Core design principles

We can draw certain parallels between bot development and application development, for the purposes of design. Doing so permits organization of design concepts into two major categories, factors affecting the bot success and factors that do *not* influence the bot success. Design considerations will start with these two categories.

### Factors influencing a bot's success

Microsoft lists key areas that can influence the success of a bot. Ultimately they all revolve around creating a great user experience. Each area is listed with a general description of how it can contribute.

- Is the bot discoverable? If users are not able to discover the bot, they will be unable to use it. Discoverability can be achieved through integration with the proper channels. As an example, an organization may make use of Microsoft Teams for collaboration. Integrating with the Teams channel will make your bot available in the Teams app. You might also create a chatbot experience for mobile devices.  You can ensure that your bot is visible on app stores by describing and categorizing it appropriately in the app store catalog.  

Some bots don't require discoverability.  For example, your company's support web site could make a question and answer bot the primary mechanism that customers interact with on the initial support page.

- Is the bot intuitive and easy to use?  The more difficult or frustrating a bot interaction is, the less use it will receive.  Users will not return to a bad user experience.
- Is the bot available on the devices and platforms that users care about? Knowing your customer-base is a good start to address this consideration.  If you only make your bot available on Microsoft Teams but most of your target audience is using Slack, the bot will not be successful.  It would require users to install a new and unfamiliar software application.
- Can users solve their problems with minimal use and bot interaction? Perhaps it sounds a bit counter-intuitive to success of a bot. Success doesn't equate to how long a user interacts with the bot. Users want answers to their issues or problems as quickly as possible. If the bot can solve the user's issue in the minimal number of steps, the user experience will be a pleasant one and users are more likely to come back to the bot again, or even help to promote the use of the bot on your behalf.
- Does the bot solve the user issues better than alternative experiences? If a user can reach an answer with minimal effort through other means, they are less likely to use the bot.  For example, most company switchboards use an automated system of messages and options to choose when you call.  Many users continue to press 0 or some other key on the keypad in an attempt to bypass the options. The rational is to go directly to an operator or support technician.

> [!Note]
> The listed items relate to user experience.  No item listed relates to the logic of your bot, directly, or which AI services it might use. You might argue that language detection would be a key aspect, and you would be correct, but language detection can be categorized as a user experience element. It may rely on natural language processing, an Azure Cognitive Service, but it ultimately relates to the user experience.

### Factors that do not guarantee success

When designing a bot, we may want to create the smartest bot in the market. Perhaps you want to ensure you have support for speech so that users don't have to type text for the interaction. Demonstrating factors such as these, may impress fellow developers but are less likely to impress users.  They could lead to user experience issues as well.

Consider the concept of simplicity.  The more complex your bot is, in terms of AI or machine learning features, the more open it may be to issues and problems. Consider adding advanced machine learning features to the bot if they are necessary to solve the problems the bot is designed to address.

Adding natural language features may not always make the bot experience great. Again, the conversation returns to whether the bot is addressing the problems the user needs solved. A simple bot, that solves the user's problem without any conversational aspects, is still a successful bot.

You might also believe that using speech for bot interactions would make the bot more successful.  There are many areas where it can be problematic. The ability to support every language and dialect is not possible at this time. Speaker pronunciation and speed can greatly impact the accuracy. A user interacting with the bot in language that is not their native language can create issues in recognition. Other factors where speech enabled bots can be problematic are in noisy environments.  Background noise will impact the accuracy of speech recognition and could create issues for the user in hearing the bot responses.  Use voice only where it truly makes sense for bot user interaction.
