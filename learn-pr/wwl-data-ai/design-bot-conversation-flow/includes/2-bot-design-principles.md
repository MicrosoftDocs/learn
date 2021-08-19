Before embarking on the development of a bot, it's worth spending some time considering some principles for effective bot design.

## Factors influencing a bot's success

Ultimately, factors that lead to a successful bot all revolve around creating a great user experience.

- **Is the bot discoverable?** If users are not able to discover the bot, they will be unable to use it. Discoverability can be achieved through integration with the proper channels. As an example, an organization may make use of Microsoft Teams for collaboration. Integrating with the Teams channel will make your bot available in the Teams app.

    In some cases, making your bot discoverable is as simple as integrating it directly into a web site. For example, your company's support web site could make a question and answer bot the primary mechanism that customers interact with on the initial support page.

- **Is the bot intuitive and easy to use?**  The more difficult or frustrating a bot interaction is, the less use it will receive.  Users will not return to a bad user experience.
- **Is the bot available on the devices and platforms that users care about?** Knowing your customer-base is a good start to address this consideration.  If you only make your bot available on Microsoft Teams but most of your target audience is using Slack, the bot will not be successful.  It would require users to install a new and unfamiliar software application.
- **Can users solve their problems with minimal use and bot interaction?** Although it may seem counter-intuitive, success doesn't equate to how long a user interacts with the bot. Users want answers to their issues or problems as quickly as possible. If the bot can solve the user's issue in the minimal number of steps, the user experience will be a pleasant one and users are more likely to come back to the bot again, or even help to promote the use of the bot on your behalf.
- **Does the bot solve the user issues better than alternative experiences?** If a user can reach an answer with minimal effort through other means, they are less likely to use the bot.  For example, most company switchboards use an automated system of messages and options to choose when you call.  Many users continue to press 0 or some other key on the keypad in an attempt to bypass the options. The rational is to go directly to an operator or support technician.

## Factors that do not guarantee success

When designing a bot, you might want to create the smartest bot in the market. Perhaps you want to ensure you have support for speech so that users don't have to type text for the interaction. Demonstrating factors such as these, may impress fellow developers, but are less likely to impress users.  They could lead to user experience issues as well.

Consider the concept of simplicity.  The more complex your bot is, in terms of AI or machine learning features, the more open it may be to issues and problems. Consider adding advanced machine learning features to the bot if they are necessary to solve the problems the bot is designed to address.

Adding natural language features may not always make the bot experience great. Again, the conversation returns to whether the bot is addressing the problems the user needs solved. A simple bot, that solves the user's problem without any conversational aspects, is still a successful bot.

You might also believe that using speech for bot interactions would make the bot more successful.  There are many areas where it can be problematic. The ability to support every language and dialect is not possible at this time. Speaker pronunciation and speed can greatly impact the accuracy. A user interacting with the bot in language that is not their native language can create issues in recognition. Other factors where speech enabled bots can be problematic are in noisy environments.  Background noise will impact the accuracy of speech recognition and could create issues for the user in hearing the bot responses.  Use voice only where it truly makes sense for bot user interaction.

## Considerations for responsible AI

In addition to optimizing the user experience with the bot, you should consider how your bot's implementation relates to principles for responsible AI development. Microsoft provides guidance for responsible bot development at [https://www.microsoft.com/research/publication/responsible-bots](https://www.microsoft.com/research/publication/responsible-bots), describing ten guidelines for developers of conversational AI solutions. These guidelines include:

- Articulate the purpose of your bot and take special care if your bot will support consequential use
cases.
- Be transparent about the fact that you use bots as part of your product or service.
- Ensure a seamless hand-off to a human where the human-bot exchange leads to interactions that
exceed the bot's competence.
- Design your bot so that it respects relevant cultural norms and guards against misuse.
- Ensure your bot is reliable.
- Ensure your bot treats people fairly.
- Ensure your bot respects user privacy.
- Ensure your bot handles data securely.
- Ensure your bot is accessible.
- Accept responsibility for your bots operation and how it affects people.
