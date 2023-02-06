Before we learn how to make a bot responsible, let's quickly review the basics of how bots work.

## Review basic bot operation

A conversational experience with a bot involves two basic actions:

- A user sends messages to the bot.
- The bot responds to the user.

The Microsoft Bot Framework provides a set of core libraries that standardize bot development. You can develop a bot as a web API function. When users call that function over the internet, they provide the input. The Bot Framework then figures out the necessary output for the bot.

## What makes a bot responsible?

Bots are part of the broader category of conversational UIs. When you make a bot's conversation responsible, you make the bot responsible.

To help you create responsible bots, Microsoft has outlined [10 guidelines for developers of conversational AI][Guidelines10]. The following sections summarize the major principles of those guidelines. You can learn more about all the principles in [this interactive demo][InteractiveDemo].

### Clear goal

A responsible bot has a clear goal. For instance, our geography bot might have the goal of assisting students by providing information about capital/major cities. Before developers start working on the bot, they carefully consider how to communicate that purpose to users. When a bot expresses its purpose and limitations in a responsible way, you can reduce frustration and unmet expectations for your users.

Careful planning is required for bots that have *consequential outcomes*. When a bot has a conversation with the user, it can have a significant impact on the user's life. Bots used in healthcare or education need to be carefully designed for this consideration.

When the bot clearly communicates its goal, the user is discouraged from engaging in conversation about unrelated issues. Building a bot to solve specific tasks is also easier than providing support for general conversation.

### Reasonable expectations

Telling users what to expect is another hallmark of a responsible bot. At the outset, the bot makes it clear what problems it solves and what type of tasks it handles. This approach helps the user focus on solving a specific task. The user is less likely to expect emotional support.

### Diversity and accessibility

A complex problem in AI is how to ensure fair and unbiased treatment for your users. This issue is addressed by [responsible AI][ResponsibleAI] principles.

Responsible bots should meet these goals:

- Avoid bias. To keep from alienating users, your bot should treat all people fairly. If interactions with your bot leave people feeling affronted, they'll be less cooperative. They may withhold information and support. Besides offending customers and losing business, your company may develop a reputation as discriminating.
- Be accessible. When bots deliver services and products that people of all abilities can access, your organization reaches a wider audience. By being inclusive and embracing diversity, bots come across as respectful. They also help fulfill the Microsoft mission of empowering every person to achieve more.
- Be sensitive to cultural differences. Users can perceive bots as having human-like personas. As a result, bots need to act respectfully. A bot shouldn't offend users by conflicting with their values and cultural norms. And a bot shouldn't appear bullying or threatening.

### Trustworthiness

A responsible bot is one that users trust. A bot can prove its trustworthiness in many ways:

- **Clear introduction**: When a bot is transparent about its capabilities, it can more easily gain users' trust than when it hides its limitations.
- **Human hand-off**: A responsible bot is competent. But it also supports *handoff to a human operator*. Without this transition, users can become frustrated. They can lose trust in the bot, its technology, and the company it represents.
- **Respect for privacy**: To maintain trust in a bot, users need to know that the bot respects their privacy. Responsible bots handle user personal information in a safe way.

## Why should a bot be responsible?

Bots communicate directly with your customers. The first impression that a customer receives of your company often comes through a bot. As a result, it's vitally important to your business to ensure the quality of user-bot interactions.

Customer satisfaction increases when experiences with bots are positive:

- People feel welcome, not alienated, when bots are bias-free and accessible.
- When bots are sensitive to cultural differences, users feel appreciated.
- Customers don't get frustrated when bots are easy to use.
- Task-focused, efficient bots give people the message that their time is respected.
- When users appreciate your bot's behavior, their trust in your company and services grows.

By developing responsible bots, you can improve each customer's experience. When customers value and trust your company, your business benefits. Customer loyalty increases, and business grows.

<!-- Links -->

[Guidelines10]: https://www.microsoft.com/research/publication/responsible-bots/?azure-portal=true
[InteractiveDemo]: https://aidemos.microsoft.com/responsible-conversational-ai/building-a-trustworthy-bot?azure-portal=true
[ResponsibleAI]: https://www.microsoft.com/ai/responsible-ai?azure-portal=true
