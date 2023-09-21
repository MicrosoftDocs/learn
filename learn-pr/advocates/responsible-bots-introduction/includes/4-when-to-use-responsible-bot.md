In this unit, you'll learn when it's appropriate to add responsible features to your bot. Specifically, we'll look at factors that influence which features you add to your bot. The features that you choose determine how responsible your bot becomes.

## Factors to consider

As a previous unit discussed, it's in your best interest to make every bot responsible. Bots interact with users. The first impression users receive from your business often comes from your bot. By making your bot transparent, bias-free, accessible, and easy to use, you improve each customer's experience. You also help users build trust in your company.

However, making your bot responsible takes time and effort. Consider these factors when deciding which responsible features to add to your bot:

### Developer resources

Some features require significant development effort. Consider the cost of this work. Also determine whether developers with the required expertise are available for the task.

### Services

Implementing functionality like speech input and language diversity makes bots responsible. But you need access to resources like Azure AI services. Look into the availability and cost of these services when deciding which ones to use.

### Scheduling constraints

Adding responsible features to bots takes time. Take into account your rollout targets and deadlines before starting potentially lengthy development projects.

## Available alternatives

The availability of resources in each area determines the approach you can take toward making your bot responsible. The following table lists options for different scenarios:

| Feature | Fully responsible implementation | Alternate implementation |
|---|---|---|
| Conversational style | Determine the best conversational style to use by detecting user sentiment. Select an appropriate response from multiple alternatives. | Add chit-chat capabilities so that your bot can greet users and end conversations gracefully. |
| Help feature | In your bot's help feature, fully document all your bot's functionality and provide examples and resources with more information. | Provide usage examples that help users get started with your bot by demonstrating basic interactions. |
| Language diversity | Use Azure AI services to determine the user's language. Then provide output messages in that language. You could use a translation service. Or you could implement responses in multiple languages. | Program the bot to hand off to a human operator when it comes across phrases that it can't understand. |
| User input | Support different formats for user input, including speech from a microphone. | Support input from a keypad, mouse, or touch-screen. |

## Geography bot options

With our geography bot, a previous unit discussed the challenge of providing accurate and unbiased information on capital/major cities.

If resources like time, money, and expertise aren't available, a streamlined approach might be appropriate:

- To get around the fairness issue, cite the data source. This approach shifts the responsibility of providing culturally appropriate information to that source.
- Concerning the accuracy of the data, regularly refresh the capital/major city data source. But if frequent updates aren't an option, the bot might tell users when it last updated its capital/major city data.

It's helpful for users to see how current information is. Knowing where data comes from is also useful. But users can get frustrated when they see data that's out of date or biased. A fully responsible bot might take a different approach:

- Update the data source frequently, if not continuously, to ensure accuracy.
- Use language services to increase responsibility. For instance, the bot might identify each user's language. Then it could return a result that takes into account that user's language and culture.
